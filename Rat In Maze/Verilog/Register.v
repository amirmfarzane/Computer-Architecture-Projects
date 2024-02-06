
module Register(load, ldData, clk, rst, out);
    parameter N = 4;

    input load, clk, rst;
    input [N-1:0] ldData;
    output [N-1:0] out;
    reg [N-1:0] out;

    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= 4'b0000;
        else if (load)
            out <= ldData;
    end
endmodule
