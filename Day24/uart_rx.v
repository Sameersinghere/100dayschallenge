module uart_rx (
    input clk,
    input reset,
    input rx,
    output reg [7:0] data_out,
    output reg data_valid
);

    parameter CLOCK_FREQ = 50_000_000; // Clock frequency
    parameter BAUD_RATE = 115200;      // Baud rate
    parameter BAUD_VALUE = CLOCK_FREQ / BAUD_RATE / 16; // Baud rate divisor

    reg [3:0] bit_count;
    reg [7:0] rx_shift_reg;
    reg [15:0] baud_count;
    reg rx_sample;
    reg rx_last;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            baud_count <= 0;
            bit_count <= 0;
            rx_sample <= 1'b1;
            rx_last <= 1'b1;
            data_valid <= 1'b0;
        end else begin
            rx_last <= rx;

            if (!rx && rx_last) begin // Detect start bit
                baud_count <= BAUD_VALUE >> 1; // Start in the middle of start bit
                bit_count <= 0;
            end else if (baud_count == BAUD_VALUE - 1) begin
                baud_count <= 0;
                rx_sample <= rx;

                if (bit_count > 0 && bit_count < 9) begin
                    rx_shift_reg[bit_count - 1] <= rx_sample;
                end

                if (bit_count == 9) begin
                    data_out <= rx_shift_reg;
                    data_valid <= 1'b1;
                end else begin
                    data_valid <= 1'b0;
                end

                bit_count <= bit_count + 1;
            end else begin
                baud_count <= baud_count + 1;
            end
        end
    end
endmodule
