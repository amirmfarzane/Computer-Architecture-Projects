module inst_memTB();
	reg clk=0;
	reg [7:0] adr;
	wire [31:0] dataOut;
	inst_mem inst(adr, dataOut, clk);
	always #7 clk=~clk;
	initial begin
		#13 adr = 8'd12;
		#13 adr = 8'd88;
		#13 $stop;
	end
endmodule
