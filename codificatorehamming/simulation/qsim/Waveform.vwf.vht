-- Copyright (C) 2025  Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Altera and sold by Altera or its authorized distributors.  Please
-- refer to the Altera Software License Subscription Agreements 
-- on the Quartus Prime software download page.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "03/28/2026 15:30:52"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          codificatoreHamming
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY codificatoreHamming_vhd_vec_tst IS
END codificatoreHamming_vhd_vec_tst;
ARCHITECTURE codificatoreHamming_arch OF codificatoreHamming_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL input : STD_LOGIC_VECTOR(1 TO 4);
SIGNAL output : STD_LOGIC_VECTOR(1 TO 7);
COMPONENT codificatoreHamming
	PORT (
	input : IN STD_LOGIC_VECTOR(1 TO 4);
	output : OUT STD_LOGIC_VECTOR(1 TO 7)
	);
END COMPONENT;
BEGIN
	i1 : codificatoreHamming
	PORT MAP (
-- list connections between master ports and signals
	input => input,
	output => output
	);

-- input[1]
t_prcs_input_1: PROCESS
BEGIN
LOOP
	input(1) <= '0';
	WAIT FOR 4000000 ps;
	input(1) <= '1';
	WAIT FOR 4000000 ps;
	IF (NOW >= 16000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_input_1;

-- input[2]
t_prcs_input_2: PROCESS
BEGIN
LOOP
	input(2) <= '0';
	WAIT FOR 2000000 ps;
	input(2) <= '1';
	WAIT FOR 2000000 ps;
	IF (NOW >= 16000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_input_2;

-- input[3]
t_prcs_input_3: PROCESS
BEGIN
LOOP
	input(3) <= '0';
	WAIT FOR 1000000 ps;
	input(3) <= '1';
	WAIT FOR 1000000 ps;
	IF (NOW >= 16000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_input_3;

-- input[4]
t_prcs_input_4: PROCESS
BEGIN
LOOP
	input(4) <= '0';
	WAIT FOR 500000 ps;
	input(4) <= '1';
	WAIT FOR 500000 ps;
	IF (NOW >= 16000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_input_4;
END codificatoreHamming_arch;
