// Priority Encoder Module
module priority_encoder (
  input [3:0] in_data,  // 4-bit input lines
  output [1:0] out_code  // 2-bit output representing the priority
);

  assign out_code = (in_data[3]) ? 2 :
                   (in_data[2]) ? 1 :
                   (in_data[1]) ? 0 :
                   (in_data[0]) ? 0 : 2'b00;

endmodule
