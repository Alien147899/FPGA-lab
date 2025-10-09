module running_light (
    input  wire       sys_clk,
    input  wire       sys_rst_n,
    output reg  [3:0] led_out
);

    
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    
    reg [1:0] current_state;
    reg [1:0] next_state;

    reg [24:0] counter;

    
    parameter HALF_SECOND_COUNT = 8'd100;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin 
            current_state <= S0;
            counter       <= 25'd0;
        end
        else begin
            if (counter == HALF_SECOND_COUNT - 1) begin
                current_state <= next_state; 
                counter       <= 25'd0;       
            end
            else begin
                current_state <= current_state; 
                counter       <= counter + 1;
            end
        end
    end

    
    always @(*) begin
        
        next_state = S0; 
        led_out = 4'b1110;   

        case (current_state)
            S0: begin
                next_state = S1;
                
                led_out = 4'b1110; 
            end
            S1: begin
                next_state = S2;
                led_out = 4'b1101;
            end
            S2: begin
                next_state = S3;
                led_out = 4'b1011;
            end
            S3: begin
                next_state = S0; 
                led_out = 4'b0111;
            end
            default: begin
                next_state = S0;
                led_out = 4'b1110;
            end
        endcase
    end

endmodule