// File: tb_vga_pic.v
`timescale 1ns / 1ps

module tb_vga_pic;

    // -- Inputs
    reg vga_clk;
    reg sys_rst_n;
    reg [9:0] pix_x;
    reg [9:0] pix_y;

    // -- Output
    wire [15:0] pix_data;
    
    // -- Expected color constants from the design
    localparam C_WHITE = 16'hFFFF;
    localparam C_BLACK = 16'h0000;

    // -- Instantiate the Unit Under Test (UUT)
    vga_pic uut (
        .vga_clk(vga_clk), 
        .sys_rst_n(sys_rst_n), 
        .pix_x(pix_x), 
        .pix_y(pix_y), 
        .pix_data(pix_data)
    );

    // -- Clock for sequential logic inside vga_pic
    initial begin
        vga_clk = 0;
        forever #20 vga_clk = ~vga_clk; // 25MHz clock
    end

    // -- Test sequence
    initial begin
        // 1. Apply reset
        sys_rst_n = 0;
        pix_x = 0;
        pix_y = 0;
        #100;
        
        // 2. Release reset
        sys_rst_n = 1;
        $display("Reset released.");
        #40;
        
        // -- Test Case 1: A point inside letter 'M' (expected WHITE)
        pix_x = 145; // M_X_START is 140, M_X_END is 200
        pix_y = 220; // LETTER_Y_START is 210, LETTER_Y_END is 270
        #40;
        if (pix_data == C_WHITE) 
            $display("PASS: Point(%d, %d) in 'M' is WHITE.", pix_x, pix_y);
        else 
            $display("FAIL: Point(%d, %d) in 'M' is not WHITE, it is %h.", pix_x, pix_y, pix_data);

        // -- Test Case 2: A point on the background (expected BLACK)
        pix_x = 10;
        pix_y = 10;
        #40;
        if (pix_data == C_BLACK)
            $display("PASS: Point(%d, %d) in background is BLACK.", pix_x, pix_y);
        else
            $display("FAIL: Point(%d, %d) in background is not BLACK, it is %h.", pix_x, pix_y, pix_data);
            
        // -- Test Case 3: A point inside letter 'T' (expected WHITE)
        pix_x = 445; // T_X_START is 440, T_X_END is 500
        pix_y = 220; // LETTER_Y_START is 210, LETTER_Y_END is 270
        #40;
        if (pix_data == C_WHITE) 
            $display("PASS: Point(%d, %d) in 'T' is WHITE.", pix_x, pix_y);
        else 
            $display("FAIL: Point(%d, %d) in 'T' is not WHITE, it is %h.", pix_x, pix_y, pix_data);

        // 3. Stop simulation
        #100;
        $display("Simulation finished.");
        $finish;
    end

endmodule