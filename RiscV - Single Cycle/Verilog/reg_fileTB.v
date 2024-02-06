module reg_fileTB();
	reg clk=0,rst=0,WE3=0;
	reg[31:0] A1=5'b0,A2=5'b0,A3=5'b0,WD3=32'b0;
	wire[31:0] RD1,RD2;
	reg_file file(A1,A2,A3,RD1,RD2,WE3,WD3,clk,rst);
	always #7 clk=~clk;
	initial begin
		#11 rst=~rst;
		#11 rst=~rst;
		#11 WE3=1;WD3=32'hABCDABCD;
		#11 WE3=1;A3=5'd1;WD3=32'd1;
		#11 WE3=1;WD3=32'hFFFF0000;A3=5'd5;
		#11 WE3=1;WD3=32'hADAD0000;
		#11 WE3=0;A1=5'd5;A2=5'd1;
		#101 $stop;
	end
endmodule
