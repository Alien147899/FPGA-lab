
module vga_ctrl (
    
    input wire vga_clk,     
    input wire sys_rst_n,   

    output reg        hsync,       
    output reg        vsync,       
    output wire       rgb_valid,   
    output wire [9:0] pix_x,       
    output wire [9:0] pix_y        
);

   
    parameter H_SYNC       = 96;
    parameter H_BACK_PORCH = 48;
    parameter H_VALID      = 640;
    parameter H_FRONT_PORCH= 16;
    parameter H_TOTAL      = 800;

    parameter V_SYNC       = 2;
    parameter V_BACK_PORCH = 33;
    parameter V_VALID      = 480;
    parameter V_FRONT_PORCH= 10;
    parameter V_TOTAL      = 525;
    
   
    parameter H_ACTIVE_START = 350; // H_SYNC + H_BACK_PORCH
    parameter V_ACTIVE_START = 35;  // V_SYNC + V_BACK_PORCH

    
    reg [9:0] cnt_h; 
    reg [9:0] cnt_v; 

    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            cnt_h <= 10'd0;
            cnt_v <= 10'd0;
        end
        else begin
            if (cnt_h == H_TOTAL - 1) begin
                cnt_h <= 10'd0;
                if (cnt_v == V_TOTAL - 1) begin
                    cnt_v <= 10'd0;
                end
                else begin
                    cnt_v <= cnt_v + 1;
                end
            end
            else begin
                cnt_h <= cnt_h + 1;
            end
        end
    end

  
    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin hsync <= 1'b0; end
        else begin
            if (cnt_h < H_SYNC) hsync <= 1'b1;
            else hsync <= 1'b0;
        end
    end

  
    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin vsync <= 1'b0; end
        else begin
            if (cnt_v < V_SYNC) vsync <= 1'b1;
            else vsync <= 1'b0;
        end
    end

    assign rgb_valid = (cnt_h >= H_ACTIVE_START) && (cnt_h < H_ACTIVE_START + H_VALID) &&
                       (cnt_v >= V_ACTIVE_START) && (cnt_v < V_ACTIVE_START + V_VALID);

    assign pix_x = (cnt_h >= H_ACTIVE_START) ? (cnt_h - H_ACTIVE_START) : 10'd0;
    assign pix_y = (cnt_v >= V_ACTIVE_START) ? (cnt_v - V_ACTIVE_START) : 10'd0;

endmodule