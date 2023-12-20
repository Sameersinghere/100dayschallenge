`timescale 1ns / 1ps

module tb_uart_tx();
    reg clk, reset, data_valid;
    reg [7:0] data_in;
    wire tx, tx_busy;

    uart_tx uut (.clk(clk), .reset(reset), .data_in(data_in), .data_valid(data_valid), .tx(tx), .tx_busy(tx_busy));

    initial clk = 0;
    always #5 clk = ~clk; // 100 MHz clock

    initial begin
        reset = 1; #10;
        reset = 0;
        data_valid = 0; #20;

        // Transmit a byte
        data_in = 8'h3F; // Data to send
        data_valid = 1; #10;
        data_valid = 0;

        #1000;
        $finish;
    end
endmodule
