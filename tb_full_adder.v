`timescale 1ns/1ns 

module tb_full_adder();

reg addend;
reg augend;
reg carry_in;

wire sum;
wire carry_out;

full_adder full_adder_instance(

.addend(addend),
.augend(augend),
.carry_in(carry_in),
.sum(sum),
.carry_out(carry_out)

);

initial begin

addend = 0;
augend = 0;
carry_in = 0;

end

 always begin
        
        #10;
        addend   <= $random % 2;
        augend   <= $random % 2;
        carry_in <= $random % 2;
    end

endmodule
