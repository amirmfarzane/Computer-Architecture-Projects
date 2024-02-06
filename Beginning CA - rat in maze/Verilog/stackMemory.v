module stackMemory(dataIn,dataOut,push,pop,empty,clk,rst,rst_adr,dataOut2);
	parameter N = 2 , size=16;

	input push,pop,clk,rst,rst_adr;
	input [N-1:0] dataIn;
	wire [0:size-1] adr;
	//wire [0:size-1] adr2;
	output [N-1:0] dataOut;
	output [N-1:0] dataOut2;//
	output empty;
	wire write,read,aluM,aluCount , start_move , finish;
	stack_dataPath datapath(dataIn,dataOut,write,read,aluM,aluCount,empty,adr,clk,rst, start_move, dataOut2 , finish);
	stack_controller controller(push,pop,write,read,aluM,aluCount,clk,rst_adr,start_move,finish);
endmodule