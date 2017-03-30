//实验1 三极管移动移动输出
module LEDmov(clk1hz, sw0, hex0, hex1, hex2);
    input clk1hz,sw0;
    parameter Value=56'b0001001_0110000_1110001_1110001_0000001_0000000_0000000_0000000;// HELLO___
    output reg[6:0] hex0,hex1,hex2;
    reg[55:0] m=Value;
    always @ (posedge clk1hz)
    begin
        if (sw0)
            m = {m,m[55:49]};
        else
            m = {m[6:0],m[55:7]};

        {hex0,hex1,hex2} = m[55:35];
    end
endmodule


//时钟降频  50m hz --> 1hz
module dicCLK(clk50,clk1);
    input clk50;
    output clk1;
    integer i;
    reg clk1;
    reg cs;
    always @ (posedge clk50)
    begin
        if (i<2500000) 
            i = i+1;
        else
        begin
            i = 0;
            clk1 = ~clk1;
        end
    end
endmodule

//led 数字显示
module displayLed(num, outcode);
    input wire[3:0] num;
    output reg[6:0] outcode;
    always @ (num)
    begin
        case(num)//1灭 0亮 
            4'b0000: outcode=7'b1111111;//0
            4'b0001: outcode=7'b1001111;//1
            4'b0010: outcode=7'b0010010;//2
            4'b0011: outcode=7'b0000110;//3
            4'b0100: outcode=7'b1001100;//4
            4'b0101: outcode=7'b1011011;//5
            4'b0110: outcode=7'b1011111;//6
            4'b0111: outcode=7'b1110000;//7
            4'b1000: outcode=7'b0000000;//8
            4'b1001: outcode=7'b1111011;//9
        endcase
    end
endmodule


module Clock(clk, reset, hour, min, sec);
    input clk,reset;
    output reg[4:0] hour=0, min=0, sec=0;

    //reset
    always @ (reset)
    begin
        hour = 0;
        min = 0;
        sec = 0;
    end

    //count
    always @ (clk)
    begin
        sec = sec + 1;
        if (sec == 60)
            begin
                sec = 0;
                min = min + 1;
            end
    end

endmodule
