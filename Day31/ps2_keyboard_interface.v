module ps2_keyboard_interface (
  input wire clk,
  input wire ps2_data, // PS/2 data line (bidirectional)
  output reg ps2_data_reg, // Registered PS/2 data line
  output reg key_valid, // Key valid signal
  output reg [7:0] key_data // Data from the keyboard
);

  // Internal state machine states
  parameter IDLE = 2'b00;
  parameter START_BIT = 2'b01;
  parameter DATA_BIT = 2'b10;
  
  reg [1:0] state;
  reg [10:0] data_shift; // Shift register for incoming data
  reg start_bit_detected;

  // Clock edge detection
  always @(posedge clk) begin
    // Shift data on each clock edge
    if (state == DATA_BIT)
      data_shift <= {data_shift[9:0], ps2_data};

    // State machine transitions
    case(state)
      IDLE: begin
        if (!ps2_data) begin
          state <= START_BIT;
          start_bit_detected <= 1;
        end
      end
      START_BIT: begin
        if (start_bit_detected) begin
          start_bit_detected <= 0;
          state <= DATA_BIT;
        end
      end
      DATA_BIT: begin
        if (data_shift[0]) begin
          // Start bit of the data
          state <= IDLE;
          key_data <= data_shift[8:1];
          key_valid <= 1;
        end
      end
      default: state <= IDLE;
    endcase
  end

  // Output registered PS/2 data line
  always @(posedge clk) begin
    ps2_data_reg <= ps2_data;
  end

endmodule
