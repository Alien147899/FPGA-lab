module vga_pic (
   
    input wire vga_clk,
    input wire sys_rst_n,
    input wire [9:0] pix_x,   
    input wire [9:0] pix_y,   

    
    output reg [15:0] pix_data
);

   
    parameter C_WHITE = 16'hFFFF;
    parameter C_BLACK = 16'h0000;

    parameter LETTER_Y_START = 10'd210; 
    parameter LETTER_Y_END   = 10'd270; 
    parameter STROKE_WIDTH   = 10'd8;  

	 
	
parameter LETTER_WIDTH = 10'd40;  
parameter GAP          = 10'd30;  
parameter START_X      = 10'd155; 

parameter M_X_START = START_X, 
          M_X_END   = M_X_START + LETTER_WIDTH;  

parameter U_X_START = M_X_END + GAP, 
          U_X_END   = U_X_START + LETTER_WIDTH;  

parameter S_X_START = U_X_END + GAP, 
          S_X_END   = S_X_START + LETTER_WIDTH;  

parameter T_X_START = S_X_END + GAP, 
          T_X_END   = T_X_START + LETTER_WIDTH; 
	 
	 
    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            pix_data <= C_BLACK;
        end
        else begin
            
            pix_data <= C_BLACK;

            if (pix_y >= LETTER_Y_START && pix_y < LETTER_Y_END) begin
                
                

if (pix_x >= M_X_START && pix_x < M_X_END) begin
    parameter M_X_CENTER = M_X_START + (M_X_END - M_X_START) / 2; 

    if ( (pix_x < M_X_START + STROKE_WIDTH) ||                      
         (pix_x >= M_X_END - STROKE_WIDTH) ||                       
         (pix_x >= M_X_CENTER - STROKE_WIDTH / 2 && pix_x < M_X_CENTER + STROKE_WIDTH / 2) || 
         (pix_y < LETTER_Y_START + STROKE_WIDTH) ) begin           
        pix_data <= C_WHITE;
    end
end
               
                else if (pix_x >= U_X_START && pix_x < U_X_END) begin
                    if ( (pix_x < U_X_START + STROKE_WIDTH) ||      
                         (pix_x >= U_X_END - STROKE_WIDTH) ||      
                         (pix_y >= LETTER_Y_END - STROKE_WIDTH) ) begin 
                        pix_data <= C_WHITE;
                    end
                end

                
                else if (pix_x >= S_X_START && pix_x < S_X_END) begin
                    parameter S_Y_CENTER = LETTER_Y_START + (LETTER_Y_END - LETTER_Y_START) / 2;
                    if ( (pix_y < LETTER_Y_START + STROKE_WIDTH) ||                          
                         (pix_y >= LETTER_Y_END - STROKE_WIDTH) ||                          
                         (pix_y >= S_Y_CENTER - STROKE_WIDTH/2 && pix_y < S_Y_CENTER + STROKE_WIDTH/2) || 
                         ((pix_x < S_X_START + STROKE_WIDTH) && (pix_y < S_Y_CENTER)) ||     
                         ((pix_x >= S_X_END - STROKE_WIDTH) && (pix_y > S_Y_CENTER)) ) begin 
                        pix_data <= C_WHITE;
                    end
                end

               
                else if (pix_x >= T_X_START && pix_x < T_X_END) begin
                    parameter T_X_CENTER = T_X_START + (T_X_END - T_X_START) / 2;
                    if ( (pix_y < LETTER_Y_START + STROKE_WIDTH) ||                          
                         (pix_x >= T_X_CENTER - STROKE_WIDTH/2 && pix_x < T_X_CENTER + STROKE_WIDTH/2) ) begin 
                        pix_data <= C_WHITE;
                    end
                end
            end
        end
    end

endmodule