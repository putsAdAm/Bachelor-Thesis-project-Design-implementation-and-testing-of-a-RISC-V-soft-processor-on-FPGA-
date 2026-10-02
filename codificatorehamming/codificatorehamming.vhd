library IEEE; use IEEE.STD_LOGIC_1164.all;

entity codificatoreHamming is
	port(input: in STD_LOGIC_VECTOR(1 to 4);
	     output: out STD_LOGIC_VECTOR(1 to 7));
end;

architecture func of codificatoreHamming is
	signal m1, m2, m3, m4, p1, p2, p3: STD_LOGIC;
begin
	-- Slicing del messaggio iniziale
	m1 <= input(1);
	m2 <= input(2);
	m3 <= input(3);
	m4 <= input(4);
	-- Calcolo dei bit di parità
	p1 <= m1 xor m2 xor m4;
	p2 <= m1 xor m3 xor m4;
	p3 <= m2 xor m3 xor m4;
	-- Concatenamento per il messaggio finale
	output <= p1 & p2 & m1 & p3 & m2 & m3 & m4;
end;
