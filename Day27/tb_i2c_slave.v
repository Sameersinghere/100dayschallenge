module tb_i2c_slave();

reg clk;
reg reset;
wire sda;
reg scl;
wire [7:0] data_out;

// Instance of I2C Slave
i2c_slave UUT (
    .clk(clk),
    .reset(reset),
    .sda(sda),
    .scl(scl),
    .data_out(data_out)
);

// Clock Generation
always #5 clk = ~clk;

// SDA Line Control (pull-up)
assign sda = (UUT.sda_dir) ? UUT.sda_out : 1'bz;

initial begin
    // Initialize Inputs
    clk = 0;
    reset = 1;
    scl = 1;
    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;
    // Add stimulus here
    // Simulate a start condition, address and read/write bits, etc.
end

endmodule
