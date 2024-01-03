module fft_8_point (
  input wire clk,
  input wire rst,
  input wire [7:0] real_input [0:7], // Real part of input
  input wire [7:0] imag_input [0:7], // Imaginary part of input
  output reg [7:0] real_output [0:7], // Real part of output
  output reg [7:0] imag_output [0:7]  // Imaginary part of output
);

  // Constants
  parameter N = 8;
  parameter LOG2N = 3;

  // Internal variables
  reg [7:0] wr_real [0:N/2-1];
  reg [7:0] wr_imag [0:N/2-1];

  // FFT stages
  reg [7:0] stage_real [0:LOG2N-1][0:N-1];
  reg [7:0] stage_imag [0:LOG2N-1][0:N-1];

  // Bit-reverse indexing
  reg [2:0] index [0:N-1];
  always_comb begin
    for (int i = 0; i < N; i = i + 1) begin
      index[i] = i;
    end
  end

  // Twiddle factors generation
  always_comb begin
    for (int i = 0; i < N/2; i = i + 1) begin
      wr_real[i] = $signed($cos(2 * $real(i) * $pi / N) * 128);
      wr_imag[i] = $signed(-$sin(2 * $real(i) * $pi / N) * 128);
    end
  end

  // FFT computation
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      for (int i = 0; i < LOG2N; i = i + 1) begin
        for (int j = 0; j < N; j = j + 1) begin
          stage_real[i][j] <= 8'b0;
          stage_imag[i][j] <= 8'b0;
        end
      end
    end else begin
      for (int i = 0; i < LOG2N; i = i + 1) begin
        for (int j = 0; j < N; j = j + 1) begin
          stage_real[i][j] <= stage_real[i][j] + (stage_real[i-1][j] * wr_real[j>>i] - stage_imag[i-1][j] * wr_imag[j>>i]) >> 7;
          stage_imag[i][j] <= stage_imag[i][j] + (stage_real[i-1][j] * wr_imag[j>>i] + stage_imag[i-1][j] * wr_real[j>>i]) >> 7;
        end
      end
    end
  end

  // Output assignment
  always_comb begin
    real_output = stage_real[LOG2N-1][index];
    imag_output = stage_imag[LOG2N-1][index];
  end

endmodule
