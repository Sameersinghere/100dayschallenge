module lcd_controller (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in, // 8-bit data to be displayed on the LCD
  output reg lcd_rs,       // Register select signal
  output reg lcd_rw,       // Read/Write signal
  output reg lcd_en,       // Enable signal
  output reg [7:0] lcd_data // Data to be displayed on the LCD
);

  // Internal state machine states
  parameter IDLE = 2'b00;
  parameter WRITE_CMD = 2'b01;
  parameter WRITE_DATA = 2'b10;

  reg [1:0] state;
  reg [7:0] internal_data;

  // Clock edge detection
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      state <= IDLE;
      lcd_rs <= 0;
      lcd_rw <= 0;
      lcd_en <= 0;
      lcd_data <= 8'b0;
      internal_data <= 8'b0;
    end else begin
      // State machine transitions
      case(state)
        IDLE: begin
          if (data_in != internal_data) begin
            state <= WRITE_DATA;
            lcd_data <= data_in;
          end else if (data_in != 8'b0) begin
            state <= WRITE_CMD;
            lcd_data <= data_in;
          end
        end
        WRITE_CMD: begin
          state <= IDLE;
          lcd_rs <= 0;
          lcd_rw <= 0;
          lcd_en <= 1;
        end
        WRITE_DATA: begin
          state <= IDLE;
          lcd_rs <= 1;
          lcd_rw <= 0;
          lcd_en <= 1;
          internal_data <= data_in;
        end
        default: state <= IDLE;
      endcase
    end
  end

endmodule
