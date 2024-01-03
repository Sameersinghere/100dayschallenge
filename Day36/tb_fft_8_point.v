module tb_fft_8_point;
  reg clk;
  reg [7:0] real_input [0:7];
  reg [7:0] imag_input [0:7];
  wire [7:0] real_output [0:7];
  wire [7:0] imag_output [0:7];

  // Instantiate the FFT module
  fft_8_point uut (
    .clk(clk),
    .real_input(real_input),
    .imag_input(imag_input),
    .real_output(real_output),
    .imag_output(imag_output)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    // Provide input values
    real_input = 8'b00000001; // Example input values
    imag_input = 8'b00000000;
    
    // Additional test cases as needed

    // Monitor the outputs
    $monitor("Time=%0t, Real Output: %b, Imag Output: %b", $time, real_output[7:0], imag_output[7:0]);

    // Stop simulation
    #100 $finish;
  end

endmodule
