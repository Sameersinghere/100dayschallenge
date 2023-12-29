module tb_lcd_controller;
  reg clk, rst_n;
  reg [7:0] data_in;
  wire lcd_rs, lcd_rw, lcd_en;
  wire [7:0] lcd_data;

  // Instantiate the LCD controller
  lcd_controller uut (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_in),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_en(lcd_en),
    .lcd_data(lcd_data)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst_n = 0;
    #10 rst_n = 1;
  end

  // Stimulus
  initial begin
    // Write command
    data_in = 8'b11000000; // Example command
    #10;
    // Write data
    data_in = 8'b01010101; // Example data
    #10;
    // Additional test cases as needed

    // Monitor the outputs
    $monitor("Time=%0t, lcd_rs=%b, lcd_rw=%b, lcd_en=%b, lcd_data=%h", $time, lcd_rs, lcd_rw, lcd_en, lcd_data);

    // Stop simulation
    #100 $finish;
  end

endmodule
