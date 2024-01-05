module moving_average_filter (
  input wire clk,
  input wire rst,
  input wire [15:0] data_in, // 16-bit input data
  output reg [15:0] data_out // 16-bit filtered output data
);

  // Parameter for filter length
  parameter N = 4;

  // Internal variables
  reg [15:0] shift_reg [0:N-1];
  reg [15:0] sum;

  // Clock edge detection
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset filter state
      for (int i = 0; i < N; i = i + 1) begin
        shift_reg[i] <= 16'b0;
      end
      sum <= 16'b0;
      data_out <= 16'b0;
    end else begin
      // Shift data through the register
      for (int i = N-1; i > 0; i = i - 1) begin
        shift_reg[i] <= shift_reg[i-1];
      end
      shift_reg[0] <= data_in;

      // Calculate the sum of the register contents
      sum <= shift_reg[0];
      for (int i = 1; i < N; i = i + 1) begin
        sum <= sum + shift_reg[i];
      end

      // Calculate the average and assign to the output
      data_out <= sum >> $clog2(N);
    end
  end

endmodule
