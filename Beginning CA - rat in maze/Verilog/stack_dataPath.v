module stack_dataPath(dataIn,dataOut,push,pop,aluM,aluCount,empty,adr,clk,rst ,start_move ,dataOut2 , finish);
	parameter N = 2,size=16;

	input push,pop,clk,rst,aluM,aluCount,start_move;
	input [0:size-1] adr;
	
	input [N-1:0] dataIn;
	output [N-1:0] dataOut;
	output [N-1 : 0] dataOut2;
	output empty , finish;
	wire [size-1 : 0] adr2;
	Memory stackMemory(.adr(adr),.adr2(adr2),.dataIn(dataIn), .write(push),
						.read(pop), .clk(clk), .rst(rst), .dataOut(dataOut), .dataOut2(dataOut2) , .start_move(start_move));

	Counter0 countStartMove( adr, adr2 , clk , rst , start_move , finish);
	ALU_16bit pointerALU(adr,aluM,aluCount,clk,empty);
	ALU_16bit showALU(adr,aluM,aluCount,clk,empty);
endmodule


module Counter0(adr , adr2 , clk , rst , start_move , finish);
	parameter size=16;
	input clk, rst,start_move;
	output reg finish=0;
	reg Co=0;
	output reg [size -1 : 0] adr2;
	input [size-1:0] adr;
	always @(posedge clk , posedge rst) begin
		if(rst) adr2=0;
		else if (start_move && adr2 > adr)finish=1;
		else if(start_move && Co != 1) {Co ,adr2} = adr2 +1;
		else begin adr2 =0;finish=0; end
	end

endmodule

