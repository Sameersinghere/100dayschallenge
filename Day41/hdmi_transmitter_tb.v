module hdmi_transmitter_tb;

reg pixel_clk;
reg [23:0] pixel_data;
wire tmds_clk_p;
wire tmds_clk_n;
wire [2:0] tmds_data_p;
wire [2:0] tmds_data_n;

// Instantiate the HDMI Transmitter module
hdmi_transmitter uut (
    .pixel_clk(pixel_clk),
    .pixel_data(pixel_data),
    .tmds_clk_p(tmds_clk_p),
    .tmds_clk_n(tmds_clk_n),
    .tmds_data_p(tmds_data_p),
    .tmds_data_n(tmds_data_n)
);

// Generate pixel clock
initial begin
    pixel_clk = 0;
    forever #5 pixel_clk = ~pixel_clk; // Generate a clock with a period of 10 time units
end

// Test sequence
initial begin
    // Apply a reset or initialization if necessary
    // ...

    // Send a series of pixel data to test the transmitter
    pixel_data = 24'hFFFFFF; // White pixel
    #10;
    pixel_data = 24'hFF0000; // Red pixel
    #10;
    pixel_data = 24'h00FF00; // Green pixel
    #10;
    pixel_data = 24'h0000FF; // Blue pixel
    #10;

    // Finish the simulation
    $finish;
end

// Monitor the TMDS outputs
initial begin
    $monitor("Time: %t, TMDS Data: (%h, %h, %h)", $time, tmds_data_p[0], tmds_data_p[1], tmds_data_p[2]);
end

endmodule
