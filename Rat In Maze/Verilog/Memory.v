module Memory(adr, adr2 ,rst_adr, dataIn, write,read, clk, rst, dataOut, dataOut2 , start_move);
    parameter N = 2,size=256;
    input [N-1:0] dataIn;
	input rst_adr , start_move;
	input [0:15] adr;
    input [0:15] adr2;
    input write,read, clk,rst;
    output [N-1:0] dataOut;
    output reg[N-1:0] dataOut2; 
    reg [N-1:0] dataOut2_reg;
    reg [N-1:0] dataOut;
    //assign dataOut2 = dataOut2_reg;
    reg [N-1:0] mem [0:size-1] ;
    always @(dataOut2_reg ) begin
        dataOut2 <= dataOut2_reg;
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin: ClrMem
            integer i;
            for (i = 0; i < size; i = i + 1) begin
                mem[i] <= {size{2'bz}};
            end
        end
        else if (write)
            mem[adr] <= dataIn;
		else if (read)
            dataOut <= mem[adr];
        if(start_move)
            dataOut2_reg = mem[adr2];
		//else if(rst_adr)
			//dataOut<=mem[adrShow];

    end
endmodule


