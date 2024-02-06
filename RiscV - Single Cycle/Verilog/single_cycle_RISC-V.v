module single_cycle_RISCV(input clk ,rst);

	wire [31:0] instr;
	wire zero,reg_write,alu_src,mem_write,pc_src0 ,pc_src1;
	wire [1:0] res_src;
	wire [2:0]  imm_src;
	wire [3:0] alu_control;


	controller riscv_controller(instr, zero,clk, rst, reg_write, alu_src, mem_write, pc_src0 , pc_src1,
					res_src, imm_src, alu_control );
	datapath riscv_datapath(clk, rst, pc_src0, pc_src1, reg_write, alu_src, mem_write, res_src, imm_src, alu_control,
				instr, zero);
endmodule
