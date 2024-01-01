module tb_hamming_code;
  reg [3:0] data_in;
  reg enable;
  wire [6:0] encoded_data;
  reg [3:0] corrected_data;
  reg error_detected;

  // Instantiate the Hamming code module
  hamming_code uut (
    .data_in(data_in),
    .enable(enable),
    .encoded_data(encoded_data),
    .corrected_data(corrected_data),
    .error_detected(error_detected)
  );

  // Stimulus
  initial begin
    // Test case with no error
    data_in = 4'b1010;
    enable = 1;
    #10 $display("Input Data: %b, Encoded Data: %b, Corrected Data: %b, Error Detected: %b", data_in, encoded_data, corrected_data, error_detected);

    // Test case with an error
    data_in = 4'b1101;
    enable = 1;
    #10 $display("Input Data: %b, Encoded Data: %b, Corrected Data: %b, Error Detected: %b", data_in, encoded_data, corrected_data, error_detected);

    // Additional test cases as needed

    // Stop simulation
    #100 $finish;
  end

endmodule
