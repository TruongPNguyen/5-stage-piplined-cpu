/*******************************************************************************
*		Authors:
*		Emraj Sidhu and Nesta Isakovic	
*
*		Description:
*		A 32 by 64 register file constructed for the ARM architecture. Built with
*		a 5x32 decoder used for register selection, 32 64 bit registers (with 
*		register 31 always outputting a 0), and two 64x31x1 MUXs for controlling
*		the output signal. All of which built from gate level. 
*
*	Inputs:
*		ReadRegister1: A 5 bit signal used to select which register to read from.
*                    (i.e. register 0 is selected with 0b00000)
*		ReadRegister2: A 5 bit signal used to select which register to read from.
*		WriteRegister: A 5 bit signal used to select the register to write to.
*							(i.e. register 0 is selected with 0b00000)
*		WriteData: The 64 bit signal to be written to the register of choice.
*		RegWrite: The signal to enable writing of the register.
*		clk: The system clock.
*
*	Outputs:
*		ReadData1: The 64 bit signal read from the specified register.
*		ReadData2: The 64 bit signal read from the specified register.
*
*******************************************************************************/

module regfile (ReadData1, ReadData2, WriteData, 
					 ReadRegister1, ReadRegister2, WriteRegister,
					 RegWrite, clk);
	
	input logic	[4:0] 	ReadRegister1, ReadRegister2, WriteRegister;
	input logic [63:0]	WriteData;
	input logic 			RegWrite, clk;
	output logic [63:0]	ReadData1, ReadData2;
	logic [63:0][31:0]   ffout;
	logic [31:0]         fromDecoder;
	logic [31:0][63:0]   insideReg;
	logic clk_bar;
	
	//Set up inverted clock for forwarding
	not clkinvert (clk_bar, clk);
	
	//Setting up input Decoder from the decode_5_32 submodule
	decode_5_32 Decoder (.in(WriteRegister[4:0]), .out(fromDecoder[31:0]), .en(RegWrite));
	
	//Setting up the two output Muxs for reading data using the mux32_1 submodule
	genvar a;
	
	generate 
		for (a = 0; a < 64; a++) begin : eachMux
			mux32_1 largeMux1 (.in(ffout[a][31:0]), .sel(ReadRegister1[4:0]), .out(ReadData1[a]));
			mux32_1 largeMux2 (.in(ffout[a][31:0]), .sel(ReadRegister2[4:0]), .out(ReadData2[a]));
		end
	endgenerate 

	
	//Setting up registers made up of 64 D_FFs
	genvar i, j;
	
	generate
		for(i=0; i<31; i++) begin : eachReg //This loop creates registers 0-30 needed for the system
			for(j=0; j<64; j++) begin : eachDff //This loop creates a single register of 64 flip flops
				D_FF_enable theReg (.q(insideReg[i][j]), .d(WriteData[j]), .en(fromDecoder[i]), .clk(clk_bar));
		   end
		end
	endgenerate 

	integer m, n, o;
	
	//Sets register 31 to always read zero
	always_comb begin
		for(m=0; m<64; m++) 
			insideReg[31][m] = 0;
			
		for(n=0; n<32; n++)
			for(o=0; o<64; o++)
				 ffout[o][n] = insideReg[n][o];	
	end

endmodule