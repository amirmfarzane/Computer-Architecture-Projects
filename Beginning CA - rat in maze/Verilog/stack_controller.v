module stack_controller(push,pop,write,read,aluM,aluCount,clk , rst_adr , start_move , finish);
	input push,pop, clk , rst_adr , finish;
	output write,read,aluM,aluCount ;
	output reg start_move;
	reg write,read,aluM,aluCount;
	assign write=0;
	assign read=0;
	assign aluM=0;
	assign aluCount=0;
	reg init_show_path =0;
	always @(posedge rst_adr) begin
			
			init_show_path = 1;
				
	end

	always @(finish) begin
		if(finish == 1)
			init_show_path=0;
	end
	always @(posedge clk) begin
		if( push == 1) begin
			assign write  = 1;
			assign read=0;
			assign aluM =1 ;
			if(aluCount==0)
				assign aluCount=1;
			else
				assign aluCount=0;
		end
		else if(pop == 1)begin
			assign read  = 1;
			assign write  = 0;
			assign aluM =0 ;
			if(aluCount==0)
				assign aluCount=1;
			else
				assign aluCount=0;
		end
		else if(init_show_path == 1 && finish != 1) begin
			start_move = 1;
		end
		else begin
			assign read  = 0;
			assign write = 0;
			assign aluCount=0;
			assign aluM=0;
			start_move=0;
		end
	end
endmodule