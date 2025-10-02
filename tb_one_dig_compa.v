`timescale 1ns/1ns 

module tb_one_dig_compa;

    
    reg  A_tb;
    reg  B_tb;

    
    wire led_A_lt_B_tb;
    wire led_A_eq_B_tb;
    wire led_A_gt_B_tb;

    one_dig_compa uut (
        .A(A_tb),
        .B(B_tb),
        .led_A_lt_B(led_A_lt_B_tb),
        .led_A_eq_B(led_A_eq_B_tb),
        .led_A_gt_B(led_A_gt_B_tb)
    );

    
   initial begin
        
        A_tb = 1'b0;
        B_tb = 1'b0;
        
    end
    
    
    always begin
        #10;
        A_tb <= $random % 2;
        B_tb <= $random % 2;
    end

        


endmodule