`timescale 1ns / 1ps

module tb_uart_rx();
    reg clk, reset, rx;
    wire [7:0] data_out;
    wire data_valid;

    uart_rx uut(.clk(clk), .reset(reset), .rx(rx), .data_out(data_out), .data_valid(data_valid));

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        reset = 1; #20;
        reset = 0;

        // Simulate receiving a byte
        rx = 1; #104; // Idle
        rx = 0; #104; // Start bit
        rx = 1; #104; // Bit 0
        rx = 1; #104; // Bit 1
        rx = 0; #104; // Bit 2
        rx = 0; #104; // Bit 3 (Data = 0x3)
        rx = 1; #104; // Stop bit
        #104;

        $finish;
    end
endmodule
