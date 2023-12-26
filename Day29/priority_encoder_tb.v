// Testbench for Priority Encoder
module priority_encoder_tb;

  // Inputs
  reg [3:0] in_data;
  
  // Outputs
  wire [1:0] out_code;

  // Instantiate the Priority Encoder
  priority_encoder uut (
    .in_data(in_data),
    .out_code(out_code)
  );

  // Clock generation
  reg clk = 0;
  always #5 clk = ~clk;

  // Testbench stimulus
  initial begin
    // Initialize inputs
    in_data = 4'b0000;

    // Apply stimulus
    #10 in_data = 4'b1000; // Highest priority
    #10 in_data = 4'b0100;
    #10 in_data = 4'b0010;
    #10 in_data = 4'b0001; // Lowest priority
    #10 in_data = 4'b0000; // No input active

    // Add more test cases as needed

    // Stop simulation
    #10 $finish;
  end

endmodule
