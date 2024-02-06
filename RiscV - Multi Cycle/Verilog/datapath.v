module datapath(output  [31:0] instr,output  zero ,input clk,rst,for_data_mem, reg_write ,mem_write ,adr_src ,IR_write ,pc_write ,
				input [1:0]alu_srca, alu_srcb,wd_sel,
				input [1:0] res_src, input[3:0] alu_control,imm_src );
	
	wire [31:0] pc_plus_4,   pc, imm_ext,RD2;
	wire [31:0] srca, result ,srcb ,alu_result ,fmux_res,adr , reg_file_inp;
	wire [31:0] write_data,read_data,data_reg_out , regA_inp, regB_inp, regA_out, regB_out, old_pc, alu_reg_out;
	
	pc_reg Pc_reg(clk, rst,pc_write, result, pc);

	mux32_2to1 mus_pc(pc ,result ,adr_src , adr);
	
	main_mem Main_mem(adr ,regB_out ,read_data ,mem_write, for_data_mem, clk);

	inst_reg Instr_reg (clk, rst,IR_write, read_data, instr);

	temp_reg data_reg (clk, rst,1'b1, read_data, data_reg_out);

	temp_reg old_pc_reg (clk, rst,1'b1, pc, old_pc);

	mux32_2to1 mus_reg_file(result ,pc ,wd_sel , reg_file_inp);

	reg_file register_file(instr[19:15], instr[24:20], instr[11:7], regA_inp, regB_inp, reg_write, reg_file_inp, clk, rst);
	
	temp_reg A_reg (clk, rst,1'b1, regA_inp, regA_out);

	temp_reg B_reg (clk, rst,1'b1, regB_inp, regB_out);	

	mux32_4to1 alu_muxa(pc, old_pc, regA_out, 32'b0, alu_srca, srca);

	mux32_4to1 alu_muxb(regB_out, imm_ext, 32'd4, 32'b0, alu_srcb, srcb);	

	ALU alu(srca , srcb , alu_control , alu_result , zero);
	
	temp_reg alu_reg (clk, rst,1'b1, alu_result, alu_reg_out);	
	
	mux32_4to1 res_mux(alu_reg_out,  data_reg_out, alu_result, imm_ext, res_src, result);

	imm_extend imm_extender(instr[31:7], imm_src  , imm_ext);
	
	
	assign instr_res = instr;
endmodule
