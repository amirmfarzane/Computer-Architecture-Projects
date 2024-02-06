module upCounter(dataOut,count,clk,rst);
	input count,clk,rst;
	output[1:0] dataOut;
	reg[1:0] dataOut;
	always@(posedge clk)begin
		if(rst)
			dataOut = 2'b00;
		else
			if(count)
				dataOut=dataOut+2'b01;

	end


endmodule
