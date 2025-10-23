module vga_colorbar (
    
    input wire sys_clk,     
    input wire sys_rst_n,   

    
    output wire hsync,      
    output wire vsync,      
    output wire [15:0] rgb  
);

    
    wire vga_clk_25m; 
    
    wire [9:0] pix_x;     
    wire [9:0] pix_y;     
    wire rgb_valid;   

    wire [15:0] pix_data;  

    

    
    clk_divider u_clk_divider (
        .clk_in    (sys_clk),
        .reset_n   (sys_rst_n),
        .clk_out   (vga_clk_25m)
    );

   
    vga_ctrl u_vga_ctrl (
        .vga_clk   (vga_clk_25m),
        .sys_rst_n (sys_rst_n),
        .hsync     (hsync),
        .vsync     (vsync),
        .rgb_valid (rgb_valid),
        .pix_x     (pix_x),
        .pix_y     (pix_y)
    );
    
   
    vga_pic u_vga_pic (
        .vga_clk   (vga_clk_25m),
        .sys_rst_n (sys_rst_n),
        .pix_x     (pix_x),
        .pix_y     (pix_y),
        .pix_data  (pix_data)
    );

   
    assign rgb = rgb_valid ? pix_data : 16'h0000;

endmodule