module tb_sram_memory_controller;
  reg clk, rst_n, write_enable, read_enable;
  reg [7:0] data_in;
  reg [9:0] address;
  wire [7:0] data_out;

  // Instantiate the SRAM memory controller
  sram_memory_controller uut (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_in),
    .address(address),
    .write_enable(write_enable),
    .read_enable(read_enable),
    .data_out(data_out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst_n = 0;
    #10 rst_n = 1;
  end

  // Stimulus
  initial begin
    // Write data to address 32
    write_enable = 1;
    read_enable = 0;
    data_in = 8'b10101010;
    address = 10'b0010000000;
    #10;

    // Read data from address 32
    write_enable = 0;
    read_enable = 1;
    address = 10'b0010000000;
    #10 $display("Data read from address 32: %b", data_out);

    // Additional test cases as needed

    // Stop simulation
    #100 $finish;
  end

endmodule
