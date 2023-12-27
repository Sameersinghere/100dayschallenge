module vga_signal_generator (
  input wire clk,         // System clock
  output wire vga_hsync,  // Horizontal synchronization pulse
  output wire vga_vsync,  // Vertical synchronization pulse
  output wire [9:0] vga_red,   // Red color component (0-1023)
  output wire [9:0] vga_green, // Green color component (0-1023)
  output wire [9:0] vga_blue   // Blue color component (0-1023)
);

  // VGA timing parameters
  parameter H_SYNC_CYCLES = 96;  // Horizontal sync pulse width
  parameter H_BACK_PORCH = 48;  // Horizontal back porch
  parameter H_FRONT_PORCH = 16; // Horizontal front porch
  parameter H_ACTIVE = 640;      // Horizontal active pixels

  parameter V_SYNC_LINES = 2;    // Vertical sync pulse width
  parameter V_BACK_PORCH = 33;   // Vertical back porch
  parameter V_FRONT_PORCH = 10;  // Vertical front porch
  parameter V_ACTIVE = 480;      // Vertical active lines

  // Internal counters
  reg [10:0] h_counter = 11'b0;
  reg [10:0] v_counter = 11'b0;

  // Output color components
  reg [9:0] red = 10'd0;
  reg [9:0] green = 10'd0;
  reg [9:0] blue = 10'd0;

  // Horizontal timing logic
  always @(posedge clk) begin
    if (h_counter == (H_SYNC_CYCLES + H_BACK_PORCH + H_ACTIVE + H_FRONT_PORCH - 1))
      h_counter <= 0;
    else
      h_counter <= h_counter + 1;
  end

  // Vertical timing logic
  always @(posedge clk) begin
    if (v_counter == (V_SYNC_LINES + V_BACK_PORCH + V_ACTIVE + V_FRONT_PORCH - 1)) begin
      v_counter <= 0;
      h_counter <= 0;
    end
    else
      v_counter <= v_counter + 1;
  end

  // Output synchronization signals
  assign vga_hsync = (h_counter >= (H_SYNC_CYCLES + H_BACK_PORCH) && h_counter < (H_SYNC_CYCLES + H_BACK_PORCH + H_ACTIVE));
  assign vga_vsync = (v_counter >= (V_SYNC_LINES + V_BACK_PORCH) && v_counter < (V_SYNC_LINES + V_BACK_PORCH + V_ACTIVE));

  // Output color components (set to constant values for simplicity)
  always @(posedge clk) begin
    red <= 10'd512;
    green <= 10'd512;
    blue <= 10'd512;
  end

  // Assign color components to outputs
  assign vga_red = red;
  assign vga_green = green;
  assign vga_blue = blue;

endmodule
