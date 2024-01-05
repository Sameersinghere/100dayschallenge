module tb_moving_average_filter;
  reg clk, rst;
  reg [15:0] data_in;
  wire [15:0] data_out;

  // Instantiate the moving average filter module
  moving_average_filter uut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Stimulus
  initial begin
    // Provide input values
    data_in = 16'h1234; // Example input value

    // Monitor the output
    $monitor("Time=%0t, Input: %h, Output: %h", $time, data_in, data_out);

    // Stop simulation after 100 time units
    #100 $finish;
  end

endmodule
