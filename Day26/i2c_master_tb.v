// Testbench for I2C Master Interface
module i2c_master_tb;
    reg clk_tb, reset_tb, start_tb;
    reg [7:0] data_in_tb;
    wire scl_tb;
    wire sda_tb;

    // Instantiate the i2c_master
    i2c_master uut(
        .clk(clk_tb),
        .reset(reset_tb),
        .start(start_tb),
        .data_in(data_in_tb),
        .scl(scl_tb),
        .sda(sda_tb)
    );

    // Clock generation
    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb; // 100MHz clock
    end

    // Test sequence
    initial begin
        reset_tb = 1; start_tb = 0; data_in_tb = 8'h00;
        #20 reset_tb = 0;
        #20 start_tb = 1; data_in_tb = 8'hAA; // Start and send 0xAA
        #200 start_tb = 0; // Stop the transaction
        #40 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%g clk=%b reset=%b start=%b data_in=%h scl=%b sda=%b",
                 $time, clk_tb, reset_tb, start_tb, data_in_tb, scl_tb, sda_tb);
    end

endmodule
