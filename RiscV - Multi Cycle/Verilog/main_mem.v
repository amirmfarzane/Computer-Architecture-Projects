module main_mem(adr,data_in ,data_out,mem_write, for_data_mem, clk);
	parameter N = 32,inst_num=50;
	input clk,mem_write ,for_data_mem;
	input [N-1:0] adr,data_in;

	output reg [N-1:0] data_out;


	reg [N-1:0] mem [0:88] ;	
	// from 0 to 50 is for instr . else is for data memory.
	// code to find max arr    head of arr is in adrr 10
	assign mem[0] = 32'b0000000000000000000_01001_0110111; // lui x9 0
	assign mem[1] = 32'b000000111100_01001_000_01001_0010011; // addi x9 x9 60 
	assign mem[2] = 32'b000000001010_00000_000_01011_0010011; // addi x11 x0 10 
	assign mem[3] = 32'b000000000000_01001_010_01010_0000011; // lw x10 0(x9)
	assign mem[4] = 32'b0000000_00000_00000_000_00110_0110011; // add x6 x0 0
	assign mem[5] = 32'b0000000_00110_01001_000_00111_0110011; // add x7 x6 x9
	assign mem[6] = 32'b000000000000_00111_010_00101_0000011; // lw x5  0(x7)
	assign mem[7] = 32'b0000000_01010_00101_100_01000_1100011; // blt x5 x10 mem[9]
	assign mem[8] = 32'b0000000_00101_00000_000_01010_0110011; // add x10  x5 x0
	assign mem[9] = 32'b000000000001_00110_000_00110_0010011; // addi x6 x6 1
	assign mem[10] = 32'b1111111_01011_00110_100_01101_1100011; // blt x6 x11 mem[5]
	/*assign mem[0] =  32'b0000000_00000_00001_000_00001_0100011;
	assign mem[0] = 32'b0000000_00000_00001_000_00011_0110011; //add x3
	assign mem[1] = 32'b0100000_00000_00001_000_00100_0110011; //sub x4
	assign mem[2] = 32'b0000000_00000_00001_111_00101_0110011; // or x5
	assign mem[3] = 32'b0000000_00000_00001_110_00110_0110011; // and x6
	assign mem[4] = 32'b0000000_00001_00000_010_00111_0110011; //slt x7
	assign mem[5] = 32'b000000000011_00101_010_01001_0000011; // lw x9
	assign mem[6] = 32'b000000000011_00001_000_01000_0010011; // addi x8 x5 3 (I_TYPE)
	assign mem[7] = 32'b000000000011_00001_100_01001_0010011; // xori x9 x1 3 (I_TYPE)
	assign mem[8] = 32'b000000110011_00001_110_01000_0010011; // ori x8 x1 3 (I_TYPE)
	assign mem[9] = 32'b000000000000_00001_010_01010_0010011; // slti x10 x1 3 (I_TYPE)
	assign mem[10] = 32'b010000000000_00001_010_01011_0010011; // slti x11 x1 3 (I_TYPE)
	assign mem[11] = 32'b1000000_00001_00000_000_00001_1100011; // beq x0 x1 3 (B_TYPE)
	assign mem[12] = 32'b1000100_00001_00000_101_00001_1100011; // bgt x0 x1 3 (B_TYPE)
	assign mem[13] = 32'b10001000000000001101_10001_0110111; // lui x0 x1 3 (B_TYPE)
	//assign mem[14] = 32'b00000000000000000001_10010_1101111; // jal x0 x1 3 (B_TYPE)
	//assign mem[14] = 32'b000100000011_00001_000_10011_1100111; //jalr
	assign mem[14] =  32'b0011111_01000_00001_000_00111_0100011;*/
	// data
	//assign mem[50] = 32'd10;
	//assign mem[51] = 32'd11;
	assign mem[60] = -32'd5;
	assign mem[61] = 32'd8;
	assign mem[62] = -32'd23;
	assign mem[63] = 32'd67;
	assign mem[64] = -32'd129;
	assign mem[65] = -32'd100;
	assign mem[66] = 32'd45;
	assign mem[67] = -32'd1;
	assign mem[68] = -32'd5;
	assign mem[69] = 32'd7;
	assign data_out =  for_data_mem ? mem[adr]  : mem[adr >> 2];
	always @(posedge mem_write) begin
		if (mem_write == 1) begin
			mem[adr] = data_in;
		end
	end
endmodule