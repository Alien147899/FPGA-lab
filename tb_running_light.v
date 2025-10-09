`timescale 1ns / 1ps


module tb_running_light;

   
    reg        sys_clk;
    reg        sys_rst_n;
    wire [3:0] led_out;

   
    running_light dut (
        .sys_clk     (sys_clk),
        .sys_rst_n   (sys_rst_n),
        .led_out (led_out)
    );


    
    initial begin
        sys_clk = 1'b0;
    end
    always #10 sys_clk = ~sys_clk; 


    
    initial begin
 
        sys_rst_n = 1'b0;
        #30;
        
        sys_rst_n = 1'b1;
       
        #10000;

        sys_rst_n = 1'b0; 
        #40; 
        sys_rst_n = 1'b1; 
      
        #5000;
        $stop; 
    end


    
    initial begin
        $monitor("Time = %3t ns | State = %b | Counter = %3d | LED_Out = %b",
                 $time, dut.current_state, dut.counter, led_out);
    end

endmodule