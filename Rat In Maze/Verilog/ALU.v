module ALU(dataIn,dataOut,aluM,aluCount,clk,empty);
	input aluM,aluCount,clk;
	input [3:0] dataIn;
	output [3:0] dataOut;
	reg [3:0] dataOut;
	output empty;
	reg empty;
	always@(posedge clk)begin
	case(aluCount)
		1: case(aluM)
				0: assign {empty,dataOut} = dataIn + ~1 + 1'b1; 
				1'b1:assign {empty,dataOut} = dataIn + 1'b1; 
			endcase
		0:assign dataOut = dataOut;

	endcase
	end
endmodule
