module testbench;

reg clk;
reg reset;
reg enable;
reg write;
reg [3:0] address;
reg [7:0] data_bus;
wire [7:0] data;

// Instantiate the cache memory
cache_memory cm(
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .write(write),
    .address(address),
    .data(data_bus)
);

// Drive the bidirectional data bus
assign data_bus = (enable && write) ? data : 8'bz;

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = !clk; // Toggle clock every 5 units
end

// Test sequence
initial begin
    reset = 1; // Assert reset
    enable = 0;
    write = 0;
    address = 0;
    data = 0;
    #10;
    
    reset = 0; // Deassert reset
    enable = 1;
    write = 1; // Write operation
    address = 4'b0011; // Select address to write
    data = 8'hAA; // Data to write
    #10;
    
    write = 0; // Read operation
    #10;
    
    // Attempt to read from another address
    address = 4'b0101; // Different address
    #10;
    
    // Write to another address
    write = 1;
    address = 4'b0101; // Different address
    data = 8'h55; // New data to write
    #10;
    
    write = 0; // Read operation
    #10;
    
    $finish; // End simulation
end

// Monitor the outputs and inputs
initial begin
    $monitor("At time %t, address = %h, write = %b, data (written/read) = %h", $time, address, write, data_bus);
end

endmodule
