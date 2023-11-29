module dff(q,d,clk,reset);
  output reg q;
  input d, clk, reset;
  always@(posedge reset or negedge clk)
    if(reset)
      q<=1'b0;
  else
    q<=d;
endmodule
