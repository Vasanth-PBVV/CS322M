module seq_detect_mealy(
    input wire clk,           
    input wire rst,                 //sync active-high
    input wire din,                 //serial input bit per clock
    output wire y                   //1 cycle pulse when pattern ....1101 seen
);
    
    reg [1:0] state, nextstate;
    reg y_comb,y_reg;
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    always@(*)
        case (state)
            S0: if(din==0) begin nextstate = S0; y_comb =0; end
                else       begin nextstate = S1; y_comb =0; end
            S1: if(din==0) begin nextstate = S0; y_comb =0; end
                else       begin nextstate = S2; y_comb =0; end
            S2: if(din==0) begin nextstate = S3; y_comb =0; end
                else       begin nextstate = S2; y_comb =0; end
            S3: if(din==0) begin nextstate = S0; y_comb =0; end
                else       begin nextstate = S1; y_comb =1; end
            default:       begin nextstate = S0; y_comb =0; end
        endcase

    always@(posedge clk)
        if(rst) begin 
                    state <= S0;
                    y_reg <= 0;
                 end
        else    begin 
                    state <= nextstate;
                    y_reg <= y_comb;
                 end

    assign y=y_reg;
endmodule