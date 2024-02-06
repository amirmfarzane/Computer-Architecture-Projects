module controller(input [31:0] instr,input zero,clk,rst,  output reg  for_data_mem, reg_write ,mem_write ,adr_src ,IR_write ,pc_write ,
				output reg[1:0] alu_srca, alu_srcb, wd_sel,
				output reg [1:0] res_src, output reg[3:0] alu_control , output reg[2:0] imm_src);
	reg [4:0] ps, ns;
	parameter [4:0]
	inst_fetch = 0, inst_decode = 1, excution_add= 2,excution_sub = 3,
	excution_or= 5,excution_and = 6,  R_type_comp = 7, excution_slt = 8,
	excution_lw = 9	,ex_lw_mem = 10 , ex_lw_reg = 11 , ex_addi = 12 , ex_i_reg=13,
	ex_xori=14 , ex_ori=15, ex_slti=16 , ex_beq =17 , ex_bne =18 , ex_blt =19 , ex_bgt =20
	, ex_lui =21 , ex_jal =22 , ex_jalr =23 , ex_jalr_reg =24 , ex_sw =25 , ex_sw_mem =26;
	always@(ps)begin
		ns = inst_fetch;
		case(ps)
			inst_fetch:
				ns = inst_decode;
			inst_decode:begin
				case(instr[6:0])
					7'b011_0011 :begin //R-Type
						case(instr[14:12])
					//func3
							3'b000:begin
						
						
								//func7
								case(instr[31:25])
									7'b0: //add
										ns = excution_add;

									7'b0100_000: //sub
										ns = excution_sub;
								endcase
							end
							3'b110: ns = excution_or; //or
								

							3'b111: ns=  excution_and;  //and

	
							3'b010: ns = excution_slt; //slt
					endcase
					end
					7'b000_0011 : ns = excution_lw; //lw

					7'b001_0011: begin    //I-type
						case(instr[14:12])
							3'b000: ns = ex_addi;
							
							3'b100: ns = ex_xori; 

							3'b110: ns = ex_ori;

							3'b010: ns = ex_slti;
						endcase
					end
					7'b110_0011: begin  //Branch-type
						case(instr[14:12])
							3'b000: ns = ex_beq;
							
							3'b001: ns = ex_bne; 

							3'b100: ns = ex_blt;

							3'b101: ns = ex_bgt;
						endcase
						end
					7'b011_0111 : ns = ex_lui; //lui
					
					7'b110_1111 : ns = ex_jal; //jal

					7'b110_0111 : ns = ex_jalr; //jalr

					7'b010_0011 : ns = ex_sw; //sw

				endcase
			
			end
			
			
			excution_add: ns = R_type_comp;
			
			excution_sub: ns = R_type_comp;

			excution_or: ns = R_type_comp;
			
			excution_and: ns = R_type_comp;

			excution_slt: ns = R_type_comp;
			
			excution_lw : ns = ex_lw_mem;
			
			ex_lw_mem : ns = ex_lw_reg; 

			ex_addi : ns = ex_i_reg;

			ex_xori : ns = ex_i_reg;

			ex_ori : ns = ex_i_reg;

			ex_slti : ns = ex_i_reg;

			ex_i_reg : ns = inst_fetch;

			ex_lw_reg : ns = inst_fetch;

			ex_beq : ns = inst_fetch;

			ex_bne : ns = inst_fetch;

			ex_blt : ns = inst_fetch;

			ex_bgt : ns = inst_fetch;
			
			ex_lui : ns = inst_fetch;

			ex_jal : ns = inst_fetch;

			ex_jalr : ns = ex_jalr_reg;

			ex_jalr_reg : ns = inst_fetch;

			ex_sw : ns = ex_sw_mem;

			ex_sw_mem : ns = inst_fetch;

			R_type_comp : ns = inst_fetch;
		
			
		endcase
	end

	always@(ps,zero)begin
		{for_data_mem,reg_write, wd_sel , pc_write, IR_write, adr_src, mem_write,alu_srca,alu_srcb,res_src} = 12'b0;		
		
		imm_src = 3'd5;
		case(ps)
			inst_fetch:begin
				alu_srcb = 2'b10;
				IR_write = 1'b1;
				alu_control = 4'd3;
				res_src = 2'b10;
				pc_write = 1'b1;
			end

			inst_decode:begin
				alu_srca = 2'b01;
				alu_srcb = 2'b01;
				res_src = 2'b10;
				alu_control = 4'd3;
				for_data_mem = 1'b1;
				imm_src = (instr[6:0] == 7'b110_0011) ? 3'd4 : 3'd2;
			end
			excution_add: begin
				alu_srca = 2'b10;
				alu_srcb = 2'b00;
				alu_control = 4'd3;

			end

			excution_sub: begin
				alu_srca = 2'b10;
				alu_srcb = 2'b00;
				alu_control = 4'd6;

			end

			excution_and: begin
				alu_srca = 2'b10;
				alu_srcb = 2'b00;
				alu_control = 4'b0;

			end

			excution_or: begin
				alu_srca = 2'b10;
				alu_srcb = 2'b00;
				alu_control = 4'd1;

			end

			excution_slt: begin
				alu_srca = 2'b10;
				alu_srcb = 2'b00;
				alu_control = 4'd2;

			end

			excution_lw:begin
            	alu_srca = 2'b10;
            	alu_srcb = 2'b01;
            	alu_control = 4'd3;
				imm_src = 3'd0;
     			for_data_mem = 1'b1;
			end

			ex_lw_mem: begin
            	adr_src = 1'b1;
            	res_src = 2'b00;  
				alu_control = 4'd3;      
				for_data_mem = 1'b1;
     	   end

           ex_lw_reg: begin
            	reg_write = 1'b1;
            	res_src = 2'b01;
				alu_control = 4'd3;
				for_data_mem = 1'b0;
           end

			ex_addi: begin
				alu_srca = 2'b10;
            	alu_srcb = 2'b01;
				imm_src = 3'd0;
				alu_control = 4'd3;
			end

			ex_xori: begin
				alu_srca = 2'b10;
            	alu_srcb = 2'b01;
				imm_src = 3'd0;
				alu_control = 4'd5;
			end

			ex_ori: begin
				alu_srca = 2'b10;
            	alu_srcb = 2'b01;
				imm_src = 3'd0;
				alu_control = 4'd1;
			end

			ex_slti: begin
				alu_srca = 2'b10;
            	alu_srcb = 2'b01;
				imm_src = 3'd0;
				alu_control = 4'd2;
			end

			ex_i_reg : begin
				reg_write = 1'b1;
			end

			ex_beq: begin
				pc_write = (zero)? 1'b1:1'b0;
				alu_srca = 2'b10;
            	alu_srcb = 2'b00;
				alu_control = 4'd7;
				imm_src = 3'd4;
			end		
	
			ex_bne: begin
				pc_write = (zero)? 1'b0:1'b1;
				alu_srca = 2'b10;
            	alu_srcb = 2'b00;
				alu_control = 4'd7;
				imm_src = 3'd4;
			end	

			ex_blt: begin
				pc_write = (zero)? 1'b1:1'b0;
				alu_srca = 2'b10;
            	alu_srcb = 2'b00;
				alu_control = 4'd8;
				imm_src = 3'd4;
			end

			ex_bgt: begin
				pc_write = (zero)? 1'b0:1'b1;
				alu_srca = 2'b10;
            	alu_srcb = 2'b00;
				alu_control = 4'd8;
				imm_src = 3'd4;
			end

			ex_lui: begin
				reg_write = 1'b1;
				res_src = 2'b11;
				imm_src = 3'd3;
			end

			ex_jal: begin
				reg_write = 1'b1;
            	pc_write = 1'b1;
            	wd_sel = 1'b1;
				imm_src = 3'd2;
				res_src = 2'b00;
			end

			ex_jalr: begin
				alu_srca = 2'b10;
            	alu_srcb = 2'b01;
				alu_control = 4'd3;
				imm_src = 3'd0;
			end

			ex_jalr_reg: begin
				reg_write = 1'b1;
            	pc_write = 1'b1;
            	wd_sel = 1'b1;
            	res_src = 2'b00;
			end

			ex_sw : begin
				alu_srca = 2'b10;
            	alu_srcb = 2'b01;
				alu_control = 4'd3;
				imm_src = 3'd1;
			end

			ex_sw_mem : begin
				mem_write = 1'b1;
            	adr_src = 1'b1;
            	res_src = 2'b00;
			end


			R_type_comp : begin
				alu_srca = 2'b10;
				alu_srcb = 2'b00;
				alu_control = 4'b011;
				reg_write = 1;
				res_src =2'b0;
				for_data_mem = 1'b0;
			end
		endcase
	end

	always@(posedge clk,posedge rst)begin
		if(rst == 1'b1)
			ps <= inst_fetch;
		else
			ps <= ns;
	end

	
	


endmodule

