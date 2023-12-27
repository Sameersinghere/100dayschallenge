module tb_vga_signal_generator;
  reg clk;
  wire vga_hsync, vga_vsync;
  wire [9:0] vga_red, vga_green, vga_blue;

  // Instantiate VGA signal generator
  vga_signal_generator uut (
    .clk(clk),
    .vga_hsync(vga_hsync),
    .vga_vsync(vga_vsync),
    .vga_red(vga_red),
    .vga_green(vga_green),
    .vga_blue(vga_blue)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Monitor for simulation
  always @(posedge clk) begin
    $display("h_counter=%d, v_counter=%d, HSYNC=%d, VSYNC=%d, RED=%d, GREEN=%d, BLUE=%d",
      uut.h_counter, uut.v_counter, vga_hsync, vga_vsync, vga_red, vga_green, vga_blue);
  end

  // Simulation termination
  initial #500 $finish;

endmodule
