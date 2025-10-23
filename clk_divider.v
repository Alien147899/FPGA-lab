module clk_divider (
    
    input wire clk_in,      
    input wire reset_n,     

    
    output reg clk_out      
);

    always @(posedge clk_in or negedge reset_n) begin
        if (!reset_n)
            clk_out <= 1'b0;
        else
            clk_out <= ~clk_out;
    end

endmodule