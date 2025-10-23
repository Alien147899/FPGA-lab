// File: tb_clk_divider.v
`timescale 1ns / 1ps

module tb_clk_divider;

    // -- Inputs
    reg clk_in;
    reg reset_n;

    // -- Output
    wire clk_out;

    // -- Instantiate the Unit Under Test (UUT)
    clk_divider uut (
        .clk_in(clk_in), 
        .reset_n(reset_n), 
        .clk_out(clk_out)
    );

    // -- Clock generation (e.g., 50MHz, 20ns period)
    initial begin
        clk_in = 0;
        forever #10 clk_in = ~clk_in;
    end

    // -- Test sequence
    initial begin
        // 1. Initialize inputs and apply reset
        reset_n = 0; // Active-low reset
        $display("T=%0t: System is under reset.", $time);
        #50;

        // 2. Release reset
        reset_n = 1;
        $display("T=%0t: Reset released. Clock divider should start.", $time);
        #200;

        // 3. Stop the simulation
        $display("T=%0t: Simulation finished.", $time);
        $finish;
    end
    
    // -- Monitor signals for debugging
    initial begin
        $monitor("T=%0t: clk_in=%b, reset_n=%b, clk_out=%b", $time, clk_in, reset_n, clk_out);
    end

endmodule