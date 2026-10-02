library IEEE; use IEEE.STD_LOGIC_1164.all;

entity testbench_coha is
end;

architecture sim of testbench_coha is
	component codificatoreHamming
		port(input: in STD_LOGIC_VECTOR(1 to 4);
		     output: out STD_LOGIC_VECTOR(1 to 7));
	end component;

	signal input: STD_LOGIC_VECTOR(1 to 4);
	signal output: STD_LOGIC_VECTOR(1 to 7);
begin
	dut: codificatoreHamming port map(input, output);

	process begin
		input <= "0000"; wait for 10 ns;
		assert output = "0000000" report "0000 failed.";

		input <= "0001"; wait for 10 ns;
		assert output = "1101001" report "0001 failed.";

		input <= "0010"; wait for 10 ns;
		assert output = "0101010" report "0010 failed.";

		report " Fine della simulazione.";

		wait;
	end process;
end;