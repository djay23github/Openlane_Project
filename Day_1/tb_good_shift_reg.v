`timescale 1ns / 1ps
module tb_good_shift_reg;
	// Inputs
	reg clk, rst,  d;
	// Outputs
	wire dout;

        // Instantiate the Unit Under Test (UUT)
	good_shift_reg uut (
		.clk(clk),
		.rst(rst),
		.d(d),
		.dout(dout)
	);

	initial begin
	$dumpfile("tb_good_shift_reg.vcd");
	$dumpvars(0,tb_good_shift_reg);
	// Initialize Inputs
	clk = 0;
	rst = 1;
	d = 0;
	#3000 $finish;
	end

always #20 clk = ~clk;
// This does not violate the setup time constraint as the data arrives early for it to be stable before clock egde
//always #214 d = ~d; 
// This violates the setup time constraint as the data is late wrt clock edge
always #223 d = ~d; 
always #147 rst = 0;
endmodule


