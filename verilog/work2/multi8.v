// 由于想不出来， 预习了下课本 
// 8位移位乘法器
parameter size=8, longsize=16
module multi8 (opa,opb,result)
input reg [size:1] opa, opb;
output reg [longsize:1] result;

begin: mult
    reg [longsize:1] shift_opa, shift_opb;
    shift_opa = opa;
    shift_opb = opb;
    result = 0;
    repeat(size)
    begin
        if(shift_opb[1])
            result = result + shift_opa;

        shift_opa = shift_opa << 1;
        shift_opb = shift_opb >> 1;
    end
end
endmodule
