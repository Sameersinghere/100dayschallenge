`timescale 1ns / 1ps

module tb_spi_master();
    reg clk, reset, start, miso;
    wire mosi, sck, ss;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire done;

    spi_master uut(
        .clk(clk),
        .reset(reset),
        .miso(miso),
        .mosi(mosi),
        .sck(sck),
        .ss(ss),
        .data_in(data_in),
        .data_out(data_out),
        .start(start),
        .done(done)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1; #20;
        reset = 0;
        start = 0;
        miso = 0; // Assuming slave sends back 0s
        data_in = 8'hA5; // Example data to send
        #20;

        // Start the SPI transaction
        start = 1; #10;
        start = 0;
        #160; // Enough time for transaction to complete

        $finish;
    end
endmodule


