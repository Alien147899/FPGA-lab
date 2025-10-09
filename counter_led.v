module counter_led (
    
    input wire sys_clk,      
    input wire sys_rst_n,    

    
    output reg led_out      
);

    localparam COUNT_MAX = 8'd100;

    
    reg [7:0] cnt;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        
		  
        
        if (!sys_rst_n) begin
            
            cnt     <= 8'd0;      
            led_out <= 1'b1;      
        end
        
       
        else begin
            
            if (cnt == COUNT_MAX - 1) begin
                cnt     <= 8'd0;      
                led_out <= ~led_out;  
            end
            
            else begin
                cnt <= cnt + 1;       
            end
        end
    end

endmodule 
