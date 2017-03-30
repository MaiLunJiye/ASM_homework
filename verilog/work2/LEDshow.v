// 7 段管显示
module LED_GND(num, outCode);
input [3:0] num;
output reg[6:0] outCode;
always @ (num)
begin
    case(num)
        4'b0000: outCode = 7'b1111110;   //0
        4'b0001: outCode = 7'b0110000;   //1
        4'b0010: outCode = 7'b1101101;   //2
        4'b0011: outCode = 7'b1111001;   //3
        4'b0100: outCode = 7'b0110011;   //4
        4'b0101: outCode = 7'b1011011;   //5
        4'b0110: outCode = 7'b1011111;   //6
        4'b0111: outCode = 7'b1110000;   //7
        4'b1000: outCode = 7'b1111111;   //8
        4'b1001: outCode = 7'b1111011;   //9
        default: outCode = 7'bxxxxxxx;
    endcase
end
endmodule
