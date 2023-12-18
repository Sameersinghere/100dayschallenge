module fifo_basic #(
    parameter DATA_WIDTH = 4,
    parameter FIFO_DEPTH = 4
)(
    input clk,
    input reset,
    input wr_en,
    input rd_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output reg full,
    output reg empty
);

    reg [DATA_WIDTH-1:0] fifo_mem [0:FIFO_DEPTH-1];
    reg [2:0] read_ptr, write_ptr;
    reg [2:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            read_ptr <= 0;
            write_ptr <= 0;
            count <= 0;
            empty <= 1;
            full <= 0;
        end else begin
            if (wr_en && !full) begin
                fifo_mem[write_ptr] <= data_in;
                write_ptr <= write_ptr + 1;
                count <= count + 1;
            end
            if (rd_en && !empty) begin
                data_out <= fifo_mem[read_ptr];
                read_ptr <= read_ptr + 1;
                count <= count - 1;
            end
            empty <= (count == 0);
            full <= (count == FIFO_DEPTH);
        end
    end
endmodule
