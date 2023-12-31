/*******************************************************************************
*	Authors:
*		Emraj Sidhu and Nesta Isakovic	
*
*	Description:
*		A program counter module which is an array of 64 flip flops, which will hold
*     the current pc value until a clock edge.
*
*	Inputs:
*		in: A 64 bit input signal which will be pushed to the output upon a 
*		    positive clock edge.
*		clk: An input clock signal.
*		reset: A 1 bit value which will set the pc to zero when high. 
*			
*	Outputs:
*		out: The 64 bit output signal which is held steady until clock goes high.
*
*******************************************************************************/
`timescale 10ps/1fs

module pcUnit (in, clk, reset, out);
	input logic [63:0] in;
	input logic clk, reset;
	output logic [63:0] out;

	genvar i;
	
	generate 
		for (i = 0; i < 64; i++) begin : holdingDFF
			D_FF holdingDFF1 (.q(out[i]), .d(in[i]), .reset(reset), .clk(clk));
		end
	endgenerate 

endmodule

module pcUnit_testbench();
	logic [63:0] in, out;
	logic clk, reset;
	
	pcUnit dut (.in, .clk, .reset, .out);
	
	initial begin 
		clk = 0; reset = 0; in = 64'hFFFFFFFFFFFFFFFF; #100;
		clk = 0; reset = 0; in = 64'hFFFFFFFFFFFFFFFF; #100;
		clk = 1; reset = 0; in = 64'hFFFFFFFFFFFFFFFF; #100;
		clk = 0; reset = 0; in = 64'hFFFFFFFFFFFFFFFF; #100;
		clk = 0; reset = 0; in = 64'h1111111111111111; #100;
		clk = 0; reset = 0; in = 64'h1111111111111111; #100;
		clk = 0; reset = 0; in = 64'h1111111111111111; #100;
		clk = 1; reset = 1; in = 64'h1111111111111111; #100;
		clk = 0; reset = 0; in = 64'h1111111111111111; #100;
		clk = 0; reset = 0; in = 64'h1111111111111111; #100;
		clk = 1; reset = 0; in = 64'h1111111111111111; #100;
		clk = 0; reset = 0; in = 64'h1111111111111111; #100;
	end

endmodule