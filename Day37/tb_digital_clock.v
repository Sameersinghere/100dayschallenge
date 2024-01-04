module tb_digital_clock;
  reg clk, rst;
  reg [5:0] rtc_hours, rtc_minutes, rtc_seconds;
  wire [3:0] display_hours, display_minutes, display_seconds;

  // Instantiate the digital clock module
  digital_clock uut (
    .clk(clk),
    .rst(rst),
    .rtc_hours(rtc_hours),
    .rtc_minutes(rtc_minutes),
    .rtc_seconds(rtc_seconds),
    .display_hours(display_hours),
    .display_minutes(display_minutes),
    .display_seconds(display_seconds)
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
    // Initialize RTC time to 12:30:45 (12 hours, 30 minutes, 45 seconds)
    rtc_hours = 6'b1100;
    rtc_minutes = 6'b001110;
    rtc_seconds = 6'b010110;

    // Monitor the clock display
    $monitor("Time=%0t, Display: %d:%d:%d", $time, display_hours, display_minutes, display_seconds);

    // Stop simulation after 100 time units
    #100 $finish;
  end

endmodule
