`timescale 1ns / 1ps

module tb_fifo_basic();
    parameter DATA_WIDTH = 4;
    parameter FIFO_DEPTH = 4;

    reg clk, reset;
    reg wr_en, rd_en;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire full, empty;

    fifo_basic #(.DATA_WIDTH(DATA_WIDTH), .FIFO_DEPTH(FIFO_DEPTH)) fifo (
        .clk(clk),
        .reset(reset),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        reset = 1; #20;
        reset = 0;
        wr_en = 0; rd_en = 0;
        
        // Writing data to FIFO
        #20; wr_en = 1; data_in = 4'hA;
        #20; data_in = 4'hB;
        #20; data_in = 4'hC;
        #20; data_in = 4'hD; wr_en = 0;

        // Reading data from FIFO
        #40; rd_en = 1;
        #80; rd_en = 0;

        $finish;
    end
endmodule
