module tb_ps2_keyboard_interface;
  reg clk;
  reg ps2_data;
  wire ps2_data_reg, key_valid;
  wire [7:0] key_data;

  // Instantiate the PS/2 keyboard interface
  ps2_keyboard_interface uut (
    .clk(clk),
    .ps2_data(ps2_data),
    .ps2_data_reg(ps2_data_reg),
    .key_valid(key_valid),
    .key_data(key_data)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    ps2_data = 1; // Initial idle state

    // Simulate key press (start bit + 8 data bits)
    #10 ps2_data = 0; // Start bit
    #10 ps2_data = 1; // Data bit 1
    #10 ps2_data = 1; // Data bit 2
    // ... (continue for 6 more data bits)
    #10 ps2_data = 0; // Data bit 8

    // Monitor the outputs
    $monitor("Time=%0t, ps2_data_reg=%b, key_valid=%b, key_data=%h", $time, ps2_data_reg, key_valid, key_data);

    // Stop simulation
    #100 $finish;
  end

endmodule
