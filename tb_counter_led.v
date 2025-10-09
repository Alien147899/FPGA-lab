`timescale 1ns / 1ps  

module tb_counter_led;

    
    reg     sys_clk;      
    reg     sys_rst_n;   
    wire    led_out;      

    
    counter_led dut (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .led_out(led_out)
    );

    
    initial begin
        sys_clk = 1'b0;
    end
    always #10 sys_clk = ~sys_clk;  

    initial begin
        sys_rst_n = 1'b0;           
        #20;                        
        sys_rst_n = 1'b1;
		  #4000
		  sys_rst_n = 1'b0;
		  #5000
		  sys_rst_n = 1'b1;
			
        
        #20_000;                    
        $stop;                      
    end

    
    initial begin
        $monitor("Time = %t | cnt = %d | led_out = %b", $time, dut.cnt, led_out);
    end

endmodule