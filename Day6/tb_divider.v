module tb_divider;
		reg [3:0]dividend,divisor;
		wire [3:0]quotient,remainder;

divider uut0(.dividend(dividend),.divisor(divisor),.quotient(quotient),.remainder(remainder));
		initial begin
			dividend=4'b0000;
			divisor=4'b0000;
			#10;
		end

		always begin
			dividend=$random;
			divisor=$random;
			#50;
		end
endmodule
