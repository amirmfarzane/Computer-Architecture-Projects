module doneDetector(a,b,dataOut);
	input [3:0] a,b;
	output dataOut;
	reg dataOut;
	reg ao,bo;
	assign ao = &a;
	assign bo = &b;
	assign dataOut = ao&bo;
endmodule
