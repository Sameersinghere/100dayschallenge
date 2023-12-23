// I2C Master Interface (simplified version)
module i2c_master(
    input wire clk, // System clock
    input wire reset, // Active high reset
    input wire start, // Start condition signal
    input wire [7:0] data_in, // Data to be transmitted
    output reg scl, // Serial clock line
    inout wire sda // Serial data line
);

    // State encoding
    localparam [1:0] IDLE = 2'b00,
                     START = 2'b01,
                     DATA = 2'b10,
                     STOP = 2'b11;

    reg [1:0] state, next_state; // FSM state and next state
    reg [7:0] data_reg; // Data register to hold the data to be transmitted
    reg [2:0] bit_cnt; // Bit counter
    reg sda_drv; // Drives SDA line

    // SDA is bidirectional
    assign sda = (sda_drv) ? 1'bz : 0;

    // FSM sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // FSM next state logic
    always @* begin
        case (state)
            IDLE: next_state = start ? START : IDLE;
            START: next_state = DATA;
            DATA: next_state = (bit_cnt == 7) ? STOP : DATA;
            STOP: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // FSM output logic
    always @(posedge clk) begin
        case (state)
            IDLE: begin
                scl <= 1'b1;
                sda_drv <= 1'b1;
                bit_cnt <= 0;
            end
            START: begin
                scl <= 1'b1;
                sda_drv <= 1'b0; // Start condition: SDA goes low while SCL is high
            end
            DATA: begin
                scl <= ~scl; // Toggle SCL to send data
                if (scl == 1'b0) begin
                    sda_drv <= data_reg[7-bit_cnt]; // Send data MSB first
                    bit_cnt <= bit_cnt + 1;
                end
            end
            STOP: begin
                scl <= 1'b1;
                sda_drv <= 1'b0; // Stop condition: SDA goes high while SCL is high
            end
        endcase
    end

    // Load data into data register
    always @(posedge start) begin
        data_reg <= data_in;
    end

endmodule
