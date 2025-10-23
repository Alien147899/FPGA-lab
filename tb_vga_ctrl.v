// File: tb_vga_ctrl.v
// Testbench for the corrected vga_ctrl module

`timescale 1ns / 1ps

module tb_vga_ctrl;

    // -- 1. 信号声明 --
    // Inputs to the UUT
    reg vga_clk;
    reg sys_rst_n;

    // Outputs from the UUT
    wire hsync;
    wire vsync;
    wire rgb_valid;
    wire [9:0] pix_x;
    wire [9:0] pix_y;

    // -- 2. 例化被测模块 (Instantiate the Unit Under Test - UUT) --
    vga_ctrl uut (
        .vga_clk   (vga_clk), 
        .sys_rst_n (sys_rst_n), 
        .hsync     (hsync), 
        .vsync     (vsync), 
        .rgb_valid (rgb_valid), 
        .pix_x     (pix_x), 
        .pix_y     (pix_y)
    );

    // -- 3. 时钟生成 --
    // Generate a 25MHz clock (40ns period)
    initial begin
        vga_clk = 0;
        forever #20 vga_clk = ~vga_clk; // 20ns half-period
    end

    // -- 4. 测试激励序列 --
    initial begin
        // (a) Apply active-low reset
        sys_rst_n = 0;
        $display("T=%0t: System is under reset.", $time);
        #100; // Hold reset for 100ns

        // (b) Release reset
        sys_rst_n = 1;
        $display("T=%0t: Reset released. VGA counters should start.", $time);

        // (c) Run for a meaningful duration
        // One full line takes 800 * 40ns = 32,000 ns (32 us).
        // Let's run for 40,000 ns to observe the hsync pulse and the start of a new line.
        #40000;

        $display("T=%0t: Simulation finished.", $time);
        $finish;
    end
    
    // -- 5. (可选) 信号监控 --
    // This will print the values to the console every time they change.
    // It is very useful for debugging.
    initial begin
        $monitor("T=%0t: cnt_h=%3d, cnt_v=%3d | hsync=%b, vsync=%b | rgb_valid=%b | pix_x=%3d, pix_y=%3d",
                 $time, uut.cnt_h, uut.cnt_v, hsync, vsync, rgb_valid, pix_x, pix_y);
    end

endmodule