module single_cycle_RISCV(input clk ,rst);

	wire [31:0] instr;
	wire zero, reg_write, mem_write, adr_src, IR_write, pc_write, wd_sel, for_data_mem;
	wire [1:0] alu_srca, alu_srcb;
	wire [1:0] res_src;
	wire [2:0]  imm_src;
	wire [3:0] alu_control ;
	controller riscv_controller( instr, zero,clk, rst,  for_data_mem, reg_write , mem_write ,adr_src ,IR_write ,pc_write ,
				alu_srca, alu_srcb,wd_sel,
				 res_src,  alu_control,imm_src );
	datapath riscv_datapath( instr,   zero ,  clk, rst, for_data_mem,  reg_write ,mem_write ,adr_src ,IR_write ,pc_write ,
				alu_srca, alu_srcb, wd_sel,
				 res_src,  alu_control,imm_src );
endmodule
