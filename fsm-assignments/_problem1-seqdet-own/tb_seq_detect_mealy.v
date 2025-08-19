`include "seq_detect_mealy.v"
`timescale 1ns/1ps

module tb_seq_detect_mealy;

reg clk=0,rst,din;
wire y;
reg [15:0] stream;
integer i;

seq_detect_mealy dut( .clk(clk) , .rst(rst) , .din(din) , .y(y));

always
begin
    clk=~clk;
    #5;
end

initial
begin

    $dumpfile("seq_detect_mealy.vcd");
    $dumpvars(0,tb_seq_detect_mealy);

    stream=16'b1101101110100101;
    din=0;
    #20
    for(i=15;i>=1;i=i-1)
        begin
            din=stream[i];
            #10;
        end
    $stop;

end

endmodule