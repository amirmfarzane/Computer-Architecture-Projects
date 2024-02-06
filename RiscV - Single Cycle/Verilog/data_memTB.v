module data_memTB();
	reg clk=0;
	reg write_en = 0;
	reg [7:0] adr;
	reg [31:0] data_in =32'b0;
	wire [31:0] data_out;
	data_mem mem(adr,write_en,data_in ,data_out, clk);
	always #7 clk=~clk;
	initial begin
		#13 adr = 8'd0;
		write_en=1;
		#13 adr = 8'd0;
		write_en=0;
		#13 adr = 8'd1;
		write_en=1;
		data_in =32'd22;
		#13 adr = 8'd1;

		#13 adr = 8'd2;
		write_en=0;
		data_in =32'd23;
		#13 adr = 8'd2;
		#132 $stop;
	end
endmodule
