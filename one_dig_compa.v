module one_dig_compa(

	 input  wire A, 
    input  wire B, 

    
    output wire led_A_lt_B, 
    output wire led_A_eq_B, 
    output wire led_A_gt_B  

);

 

    assign led_A_lt_B = (~A) & B;

    
    assign led_A_eq_B = ~(A ^ B);

    
    assign led_A_gt_B = A & (~B);

endmodule