// File: tb_vga_colorbar.v
// Testbench for the top-level vga_colorbar module

`timescale 1ns / 1ps

module tb_vga_colorbar;

    // -- 1. 信号声明 --
    // Testbench中的输入信号通常声明为 reg
    reg sys_clk;
    reg sys_rst_n;

    // Testbench中的输出信号通常声明为 wire，用来接收被测模块的输出
    wire hsync;
    wire vsync;
    wire [15:0] rgb;

    // -- 2. 例化被测模块 (Instantiate the Unit Under Test - UUT) --
    // 将我们声明的 reg 和 wire 连接到 vga_colorbar 模块的端口
    vga_colorbar uut (
        .sys_clk    (sys_clk), 
        .sys_rst_n  (sys_rst_n), 
        .hsync      (hsync), 
        .vsync      (vsync), 
        .rgb        (rgb)
    );

    // -- 3. 生成时钟信号 --
    // 产生一个周期为20ns的方波，即50MHz系统时钟
    initial begin
        sys_clk = 0;
        forever #10 sys_clk = ~sys_clk; // #10 表示延时10ns, 2*10ns = 20ns 周期
    end

    // -- 4. 生成测试激励序列 --
    initial begin
        // (a) 初始化和复位
        sys_rst_n = 0; // 在仿真开始时，施加低电平复位
        $display("T=%0t: System is under reset.", $time);
        
        #100; // 保持复位100ns，确保所有寄存器都被清零

        // (b) 释放复位
        sys_rst_n = 1; // 释放复位，模块开始正常工作
        $display("T=%0t: Reset released. VGA controller should start working.", $time);

        // (c) 运行一段时间后停止仿真
        // 640x480@60Hz 一帧的时间大约是 16.7ms (1 / 60Hz)
        // 我们让仿真运行 20ms (20,000,000 ns) 来观察超过一帧的完整图像信号
        #20000000;

        $display("T=%0t: Simulation finished after 20ms.", $time);
        $finish; // 结束仿真
    end
    
    // -- 5. (可选) 监控信号变化 --
    // 这个 initial 块会在控制台打印出关键信号的值，方便调试
    // initial begin
    //     $monitor("T=%0t: hsync=%b, vsync=%b, rgb=%h", $time, hsync, vsync, rgb);
    // end

endmodule