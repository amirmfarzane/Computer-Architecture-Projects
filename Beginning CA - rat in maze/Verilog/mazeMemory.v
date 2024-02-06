module mazeMemory(adrX,adrY, start,dataIn, write,read,clk, rst, dataOut);
    parameter size = 16;

    input  [3:0] adrX;
    input  [3:0] adrY;
    input dataIn,start,write,read,clk,rst;
    output dataOut;
    reg dataOut;
	
    reg [0:size-1] mem [0:size-1] ;
    always @(posedge clk or posedge rst) begin
		if(start)
			$readmemh ("E:/MODEL/map.txt",mem);
        else if (rst) begin: ClrMem
            integer i;
            for (i = 0; i < size; i = i + 1) begin
                mem[i] <= {size{1'b0}};
            end
        end
        else if (write)
            mem[adrY][adrX] <= dataIn;
    end

    always @(posedge read) begin
        dataOut <= mem[adrY][adrX];
    end
endmodule

