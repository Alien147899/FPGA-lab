module full_adder(
	
	input addend,
	input augend,
	input carry_in,
	
	output sum,
	output carry_out

);


assign sum = addend ^ augend ^ carry_in;

assign carry_out = (addend & augend) | (augend & carry_in) | (addend & carry_in);

endmodule 