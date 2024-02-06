module doneTB();
	reg clk=1,rst=0,count=1,Start=0;
	wire Run,Fail,Done;
	wire [1:0] Move;
	intelligent_rat rat(clk,rst,Start,Run,Fail,Done,Move);
	initial begin
		#10 rst=1;
		#50 Start=1;
			rst=0;
		#50 Start=0;
	end
	initial begin
		repeat(20000)
			#5 clk=~clk;
	end
endmodule
