module tb_basic_cpu();

reg clk;
reg reset;
wire [7:0] program_counter;
tri [7:0] data_bus;
wire [7:0] address_bus;
wire write_enable;

// Instantiate the Unit Under Test (UUT)
basic_cpu uut (
    .clk(clk),
    .reset(reset),
    .program_counter(program_counter),
    .data_bus(data_bus),
    .address_bus(address_bus),
    .write_enable(write_enable)
);

// Clock generation
always #10 clk = ~clk;

// Data bus handling
reg [7:0] memory [0:255]; // Simple memory for simulation
assign data_bus = write_enable ? 8'bz : memory[address_bus];

initial begin
    // Initialize signals
    clk = 0;
    reset = 1;
    // Initialize memory with instructions
    memory[0] = {LD, 6'd10};  // LD A, 10
    memory[1] = {ADD, 6'd11}; // ADD A, 11
    memory[2] = {ST, 6'd12};  // ST 12, A
    memory[3] = {BZ, 6'd0};   // BZ 0
    memory[10] = 8'd5;        // Data value at address 10
    memory[11] = 8'd10;       // Data value at address 11

    // Release reset
    #20 reset = 0;
end

always @(posedge clk) begin
    if (write_enable) begin
        memory[address_bus] <= data_bus;
    end
end

endmodule
