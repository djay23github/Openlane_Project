module good_shift_reg (
	input clk,
	input rst,
	input d,
	output reg dout
);
	reg q1;

	always @(posedge clk or posedge rst) begin
		if(rst) begin
			q1 <= 1'b0;
			dout <= 1'b0;
		end
		else begin
			dout <= q1;
			q1 <= d;
		end
	end
endmodule
