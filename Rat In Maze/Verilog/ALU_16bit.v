module ALU_16bit(dataOut,aluM,aluCount,clk,empty);
	input aluM,aluCount,clk;
	output [15:0] dataOut;
	reg [15:0] dataOut;
	output empty;
	reg empty;
	always@(posedge clk)begin
		dataOut = 16'b0;
		if(aluCount)begin
		    case(aluM)
				0: assign {empty,dataOut} = dataOut + ~1 + 1'b1; 
				1'b1:assign {empty,dataOut} = dataOut + 1'b1; 
			endcase
		end
	end
endmodule

