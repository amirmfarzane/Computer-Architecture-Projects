`define run 6'd60
`define show_path 6'd61
`define good_state1 6'd62
`define good_state2 6'd63

`define Idle       6'd0
`define Init       6'd1
`define Load       6'd2

`define check_UP  6'd3
`define wait_up  6'd4
`define wait0  6'd5
`define cUP_map    6'd6

`define check_RIGHT 6'd7
`define wait_right 6'd8
`define wait1 6'd9
`define cRI_map    6'd10

`define check_LEFT 6'd11
`define wait_left 6'd12
`define wait2 6'd13
`define cLE_map 6'd14

`define check_DOWN 6'd15
`define wait_down 6'd16
`define wait3 6'd17
`define cDO_map 6'd18

`define back_track 6'd19
`define back_track1 6'd20
`define back_track2 6'd21
`define back_track3 6'd22
`define bt1 6'd23
`define bt2 6'd24
`define bt3 6'd25
`define bt4 6'd26
`define btf1 6'd27
`define btf2 6'd28
`define bt11 6'd29
`define bt12 6'd30
`define bt13 6'd31
`define bt21 6'd32
`define bt22 6'd33
`define bt23 6'd34
`define bt31 6'd35
`define bt32 6'd36
`define bt33 6'd37
`define bt41 6'd38
`define bt42 6'd39
`define bt43 6'd40

module IR_controller(clk,RST,start,Run,Fail,Done,Move,ldi,ldj,mapDataIn,mapDataOut,mapWrite,mapRead,AoRi,AoRj,aluSelec,
					aluM,aluCount,count,fsPush,fsPop,ssPush,ssPop,imp,upConRst,counterRes,fStackRes,sStackRes,rst_adr);
	input clk,RST,start,imp,mapDataOut;
	input [1:0] counterRes,fStackRes,sStackRes;
	output Fail,Done,Run;
	output [1:0] Move;
	output upConRst,ldi,ldj,mapDataIn,mapWrite,mapRead,AoRi,AoRj,aluSelec,aluM,aluCount,count,fsPush,fsPop,ssPush,ssPop,rst_adr;
	reg Run,upConRst,ldi,ldj,mapDataIn,mapWrite,mapRead,AoRi,AoRj,aluSelec,aluM,aluCount,count,fsPush,fsPop,ssPush,ssPop,rst_adr;
    reg [5:0] ps, ns;

    always @(posedge clk) begin
        if (RST)
            ps <= 6'd0;
        else
            ps <= ns;
    end

    always @(ps or start ) begin
        case (ps)	
            `Idle:ns = start ? `Init : `Idle;
            `Init:ns=`Load;
			`Load:ns=`check_UP;

			
			`good_state1:ns=`check_UP;
			`good_state2:ns=`check_UP;
			`run:ns=`show_path;
			`show_path:ns=`show_path;

			`check_UP:ns=Done? `run : `wait_up;
			`wait_up:ns = imp ? `check_RIGHT : `wait0  ;
			`wait0:ns=`cUP_map;
			`cUP_map:ns= mapDataOut ? `check_RIGHT : `good_state1 ;

			`check_RIGHT:ns=`wait_right;
			`wait_right:ns = imp ? `check_LEFT : `wait1 ;
			`wait1:ns=`cRI_map;
			`cRI_map:ns= mapDataOut ? `check_LEFT : `good_state2 ;
			
			`check_LEFT:ns=`wait_left;
			`wait_left:ns = imp ? `check_DOWN : `wait2 ;
			`wait2:ns=`cLE_map;
			`cLE_map:ns= mapDataOut ? `check_DOWN : `good_state2 ;

			`check_DOWN:ns=`wait_down;
			`wait_down:ns = imp ? `back_track : `wait3 ;
			`wait3:ns=`cDO_map;
			`cDO_map:ns= mapDataOut ? `back_track : `good_state1 ;
			`back_track:ns= `back_track1;
			`back_track1:ns= `back_track2;
			`back_track2:ns= `back_track3;
			`back_track3:case(fStackRes)
								2'b00:ns=`bt1;
								2'b01:ns=`bt2;
								2'b10:ns=`bt3;
								2'b11:ns=`bt4;
								default: ns = `Idle;
								endcase
			`bt1:ns=`bt11;
			`bt11:ns=`bt12;
			`bt12:ns=`bt13;
			`bt13:ns=`btf1;

			`bt2:ns=`bt21;
			`bt21:ns=`bt22;
			`bt22:ns=`bt23;
			`bt23:ns=`btf1;

			`bt3:ns=`bt31;
			`bt31:ns=`bt32;
			`bt32:ns=`bt33;
			`bt33:ns=`btf1;
			
			`bt4:ns=`bt41;
			`bt41:ns=`bt42;
			`bt42:ns=`bt43;
			`bt43:ns=`btf1;

			`btf1:ns=`btf2;
			`btf2:ns=`check_UP;
            default: ns = `Idle;
        endcase
    end

    always @(ps) begin
        case (ps)
            `Idle:;
            `Init:aluSelec=0;
			`Load:{ldi,ldj,mapWrite,mapRead,AoRi,AoRj,mapDataIn,aluM,aluCount,count,fsPush,fsPop,ssPush,ssPop}=13'b0;
			`show_path:rst_adr=1;
			`run:Run=1;
			`check_UP:begin aluM=0;aluSelec=1;upConRst=1 ;fsPush=0;aluCount=1;ldi=0;ldj=0;mapWrite=0;count=0; end
			`wait_up:begin aluCount=0; end
			`wait0:begin mapRead=1;AoRi=0;AoRj=1;count=0; end
			`cUP_map:begin mapRead=0;AoRj=0;mapWrite=0;mapDataIn=1;end

			`check_RIGHT:begin aluM=1;aluSelec=0 ;aluCount=1;fsPush=0;count=0; end
			`wait_right: begin aluCount=0;count=1;upConRst=0 ;end
			`wait1:begin mapRead=1;AoRi=1;AoRj=0;count=0; end
			`cRI_map:begin mapRead=0;AoRi=0;mapWrite=0;mapDataIn=1; end
			`good_state2:begin ldi=1;mapWrite=1;fsPush=1;end

			`check_LEFT:begin aluM=0;aluSelec=0 ;aluCount=1;fsPush=0;count=0; end
			`wait_left: begin aluCount=0;count=1;end
			`wait2:begin mapRead=1;AoRi=1;AoRj=0;count=0; end
			`cLE_map:begin mapRead=0;AoRi=0;mapWrite=0;mapDataIn=1; end

			`check_DOWN:begin aluM=1;aluSelec=1 ;aluCount=1;fsPush=0;count=0; end
			`wait_down: begin aluCount=0;count=1;end
			`wait3:begin mapRead=1;AoRi=0;AoRj=1;count=0; end
			`cDO_map:begin mapRead=0;AoRj=0;mapWrite=0;mapDataIn=1; end
			`good_state1:begin ldj=1;mapWrite=1;fsPush=1;end

			`back_track:begin fsPop=1;mapWrite=1;end
			`back_track1:begin mapWrite=0;end
			`back_track2:begin fsPop=0;end
			`bt1:begin aluSelec=1  ;end
			`bt11:begin aluM=1; aluCount=1; end
			`bt12:begin ldj=1; end
			`bt13:begin AoRj=1;ldj=0; end

			`bt2:begin aluSelec=0;end
			`bt21:begin aluM=0; aluCount=1; end
			`bt22:begin ldi=1; end
			`bt23:begin AoRi=1;ldi=0; end

			`bt3:begin aluSelec=0; end
			`bt31:begin aluM=1; aluCount=1; end
			`bt32:begin ldi=1; end
			`bt33:begin AoRi=1;ldi=0; end

			`bt4:begin aluSelec=1; end
			`bt31:begin aluM=0; aluCount=1; end
			`bt32:begin ldj=1; end
			`bt33:begin AoRj=1;ldj=0; end

			`btf2:begin  end
            default:;
        endcase
    end
endmodule



