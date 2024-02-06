module datapath(input clk,rst,pc_src0,pc_src1,reg_write,alu_src,mem_write,input [1:0] res_src,input [2:0] imm_src,input[3:0] alu_control,
				output reg[31:0] instr_res,output zero);
	
	wire [31:0] pc_plus_4, pc_target, pc_next, pc, instr, imm_ext,RD2;
	wire [31:0] srca, result ,srcb ,alu_result ,read_data,fmux_res;

	mux32_2to1 fmux(pc_plus_4, pc_target, pc_src0, fmux_res);
	mux32_2to1 jalr_mux(fmux_res, alu_result, pc_src1, pc_next);
	pc_reg Pc_reg(clk, rst, pc_next, pc);
	inst_mem Inst_mem(pc, instr, clk);
	adder pc_adder0(pc, 32'd4, pc_plus_4);
	adder pc_adder1(pc, imm_ext, pc_target);
	imm_extend imm_extender(instr[31:7], imm_src  , imm_ext);
	reg_file register_file(instr[19:15], instr[24:20], instr[11:7], srca,RD2, reg_write, result, clk, rst);
	mux32_2to1 smux(RD2, imm_ext, alu_src,srcb); 
	ALU alu(srca , srcb , alu_control , alu_result , zero);
	data_mem Data_mem(alu_result, mem_write, RD2, read_data, clk);
	mux32_4to1 res_mux(alu_result, read_data, pc_plus_4, imm_ext, res_src, result);
	assign instr_res = instr;
endmodule
