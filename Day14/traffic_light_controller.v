module traffic_light_controller (
    input clk, reset,
    output reg red, yellow, green
);

    // State encoding
    parameter RED = 3'b001, YELLOW = 3'b010, GREEN = 3'b100;
    reg [2:0] state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= RED;
        else begin
            case (state)
                RED:    state <= GREEN;
                GREEN:  state <= YELLOW;
                YELLOW: state <= RED;
                default: state <= RED;
            endcase
        end
    end

    // Output logic
    always @(*) begin
        red = (state == RED);
        yellow = (state == YELLOW);
        green = (state == GREEN);
    end

endmodule
