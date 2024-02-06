module IR_datapath(CLK,RST,Start,Run,Fail,Done,Move,ldi,ldj,mapDataIn,mapDataOut,mapWrite,mapRead,AoRi,AoRj,aluSelec,
					aluM,aluCount,imp,count,fsPush,fsPop,ssPush,ssPop,sStackEmpty,upConRst,counterRes,fStackRes,sStackRes);
	input CLK,RST,Start,Run,aluM,aluCount,count,fsPush,fsPop,ssPush,ssPop,sStackEmpty,upConRst;
	output Fail,Done,mapDataOut;
	output  [1:0] Move;
	output ldi,ldj,mapDataIn,mapWrite,mapRead,AoRi,AoRj,aluSelec,imp;
	wire [15:0] ssAdr=0;
	wire [15:0] fsAdr;
	wire [3:0] iRegRes,jRegRes,FMMres,SMMres,AluMres;
	input [1:0] counterRes,fStackRes,sStackRes;
	wire [3:0] aluRes ;
	Register iReg(.load(ldi), .ldData(aluRes),  .clk(CLK), .rst(RST), .out(iRegRes));
	Register jReg(.load(ldj), .ldData(aluRes),  .clk(CLK), .rst(RST), .out(jRegRes));
	
	Mux firstMapMUX(.a0(iRegRes), .a1(aluRes), .sel(AoRi), .out(FMMres));
	Mux secMapMUX(.a0(jRegRes), .a1(aluRes), .sel(AoRj), .out(SMMres));
	mazeMemory memory(.adrX(FMMres),.adrY(SMMres),.start(Start), .dataIn(mapDataIn), .write(mapWrite),
						.read(mapRead),  .clk(CLK), .rst(RST), .dataOut(mapDataOut));
	
	Mux aluMUX(.a0(iRegRes), .a1(jRegRes), .sel(aluSelec), .out(AluMres));
	ALU alu(.dataIn(AluMres),.dataOut(aluRes),.aluM(aluM),.aluCount(aluCount),.clk(CLK),.empty(imp));

	upCounter counter(.dataOut(counterRes),.count(count),.clk(CLK),.rst(upConRst));
	stackMemory stack(.dataIn(counterRes),.dataOut(fStackRes),.push(fsPush),
					.pop(fsPop),.empty(Fail),.clk(CLK),.rst(RST) , .rst_adr(Run) , .dataOut2(Move));
	//stackMemory finalStack(.dataIn(fStackRes),.dataOut(Move),.push(ssPush),.pop(ssPop),.empty(sStackEmpty),.clk(Clk),.rst(RST));
	
	doneDetector dd(.a(iRegRes),.b(jRegRes),.dataOut(Done));
endmodule


