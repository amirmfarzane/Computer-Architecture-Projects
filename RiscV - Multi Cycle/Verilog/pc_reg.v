
module pc_reg(input clk,rst,write_en,input [31:0] inp,output reg [31:0] out);
	reg [31:0] temp;
	
	always@(posedge clk)begin
		if(rst)begin
			temp = 32'b0;
			out = 32'b0;
		end
		else if(write_en)begin
			temp = inp;
			assign out = temp;
		end
		
	end
endmodule