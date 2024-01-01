module hamming_code (
  input wire [3:0] data_in,
  input wire enable,
  output wire [6:0] encoded_data,
  output reg [3:0] corrected_data,
  output reg error_detected
);

  // Hamming code matrix for (7,4) code
  reg [6:0] parity_matrix [0:6] = {7'b0000001, 7'b0000010, 7'b0000100, 7'b0001000, 7'b0010000, 7'b0100000, 7'b1000000};

  // Internal signals
  reg [6:0] encoded_data_internal;
  reg [6:0] syndrome;

  // Encode input data
  always_comb begin
    encoded_data_internal = {data_in, 4'b0000} ^ parity_matrix;
  end

  // Syndrome calculation
  always_comb begin
    syndrome = encoded_data_internal ^ parity_matrix;
  end

  // Error detection and correction
  always_ff @(posedge enable) begin
    if (syndrome != 7'b0000000) begin
      // Error detected, correct data
      corrected_data = encoded_data_internal ^ syndrome;
      error_detected = 1;
    end else begin
      // No error detected
      corrected_data = data_in;
      error_detected = 0;
    end
  end

  // Output encoded data when enabled
  assign encoded_data = (enable) ? encoded_data_internal : 7'b0;

endmodule
