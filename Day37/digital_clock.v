module digital_clock (
  input wire clk,
  input wire rst,
  input wire [5:0] rtc_hours,    // RTC input: 0-23
  input wire [5:0] rtc_minutes,  // RTC input: 0-59
  input wire [5:0] rtc_seconds,  // RTC input: 0-59
  output reg [3:0] display_hours, // Digital clock display: 0-9
  output reg [3:0] display_minutes, // Digital clock display: 0-9
  output reg [3:0] display_seconds // Digital clock display: 0-9
);

  // Internal variables
  reg [3:0] current_hours;
  reg [3:0] current_minutes;
  reg [3:0] current_seconds;

  // Clock edge detection
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      current_hours <= 4'b0;
      current_minutes <= 4'b0;
      current_seconds <= 4'b0;
    end else begin
      // Update clock display every second
      if (rtc_seconds == 6'b59) begin
        current_seconds <= (current_seconds == 4'b9) ? 4'b0 : current_seconds + 1;
        // Update minutes every minute
        if (rtc_minutes == 6'b59) begin
          current_minutes <= (current_minutes == 4'b9) ? 4'b0 : current_minutes + 1;
          // Update hours every hour
          if (rtc_hours == 6'b23) begin
            current_hours <= (current_hours == 4'b9) ? 4'b0 : current_hours + 1;
          end
        end
      end
    end
  end

  // Output assignment
  always_comb begin
    display_hours = current_hours;
    display_minutes = current_minutes;
    display_seconds = current_seconds;
  end

endmodule
