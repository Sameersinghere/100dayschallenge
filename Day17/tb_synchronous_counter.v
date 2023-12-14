module tb_synchronous_counter();
    reg clk, reset;
    wire [3:0] count;

    synchronous_counter uut (.clk(clk), .reset(reset), .count(count));

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        reset = 1; #20;
        reset = 0;
        #200;
        $finish;
    end
endmodule
