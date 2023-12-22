module spi_slave(
    input clk,
    input reset,
    input MISO, // Master In Slave Out
    output reg MOSI, // Master Out Slave In
    input SCLK, // Serial Clock
    input SS, // Slave Select
    output reg [7:0] slave_out,
    input [7:0] slave_in
);
    reg [2:0] bit_count;
    reg [7:0] shift_reg;

    always @(posedge SCLK or posedge reset) begin
        if (reset) begin
            bit_count <= 0;
            slave_out <= 0;
            MOSI <= 1;
        end else if (!SS) begin
            if (bit_count < 8) begin
                shift_reg[7-bit_count] <= MISO;
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 0;
                slave_out <= shift_reg; // Capture the received data
            end
        end
    end

    always @(negedge SCLK) begin
        if (!SS) MOSI <= slave_in[7-bit_count]; // Send out next bit
    end
endmodule
