module ddr_memory_controller_tb;

reg sys_clk;
reg reset_n;
reg [15:0] data_in;
wire [15:0] data_out;
reg [12:0] addr_in;
reg we;

// Instantiate the DDR Memory Controller
ddr_memory_controller ddr_ctrl(
    .sys_clk(sys_clk),
    .reset_n(reset_n),
    .data_in(data_in),
    .data_out(data_out),
    .addr_in(addr_in),
    .we(we)
    // ... DDR memory interface signals
);

// Generate system clock
initial begin
    sys_clk = 0;
    forever #5 sys_clk = ~sys_clk; // 100 MHz Clock
end

// Apply reset
initial begin
    reset_n = 0;
    #100;
    reset_n = 1;
end

// Test sequence
initial begin
    // Initialize inputs
    data_in = 0;
    addr_in = 0;
    we = 0;
    
    // Wait for reset to release
    @(posedge reset_n);
    
    // Write to DDR memory
    #10;
    we = 1;
    data_in = 16'hA5A5;
    addr_in = 13'h1FFF;
    #10;
    we = 0;

    // Read from DDR memory
    #10;
    addr_in = 13'h1FFF;
    // ... rest of the test sequence

    // End simulation
    #200;
    $finish;
end

// Monitor signals
initial begin
    $monitor("Time: %t, Addr: %h, Data In: %h, Data Out: %h, WE: %b",
              $time, addr_in, data_in, data_out, we);
end

endmodule
