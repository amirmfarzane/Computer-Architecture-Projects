module riscvTB();
	reg clk = 0;
	reg rst = 0;
	always #7 clk =~clk ;
	single_cycle_RISCV riscv(clk ,rst);
	initial begin
		#17 rst=~rst;
		#25 rst=~rst;
		#10003
		$stop;

	end

endmodule
