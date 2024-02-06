module intelligent_rat(CLK,RST,Start,Run,Fail,Done,Move);
	input CLK,RST,Start,Run;
	output Fail,Done;
	output [1:0] Move;
	wire ldi,ldj,mapDataIn,mapWrite,mapRead,AoRi,AoRj,aluSelec,aluM,aluCount,imp,count,fsPush,
		fsPop,ssPush,ssPop,sStackEmpty,upConRst,rst_adr;
	wire [1:0] counterRes,fStackRes,sStackRes;
	IR_datapath datapath(CLK,RST,Start,Run,Fail,Done,Move,ldi,ldj,mapDataIn,mapDataOut,mapWrite,mapRead,AoRi,AoRj,aluSelec,
					aluM,aluCount,imp,count,fsPush,fsPop,ssPush,ssPop,sStackEmpty,upConRst,counterRes,fStackRes,sStackRes);
	IR_controller controller(CLK,RST,Start,Run,Fail,Done,Move,ldi,ldj,mapDataIn,mapDataOut,mapWrite,mapRead,AoRi,AoRj,aluSelec,
					aluM,aluCount,count,fsPush,fsPop,ssPush,ssPop,imp,upConRst,counterRes,fStackRes,sStackRes,rst_adr);
endmodule

