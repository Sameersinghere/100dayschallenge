module sram_memory_controller (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  input wire [9:0] address,
  input wire write_enable,
  input wire read_enable,
  output reg [7:0] data_out
);

  reg [7:0] memory [0:1023]; // 1K words of 8-bit SRAM

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      data_out <= 8'b0;
    end else begin
      if (read_enable) begin
        data_out <= memory[address];
      end else if (write_enable) begin
        memory[address] <= data_in;
      end
    end
  end

endmodule
