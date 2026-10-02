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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 25.1std.0 Build 1129 10/21/2025 SC Lite Edition"

-- DATE "03/28/2026 15:57:19"

-- 
-- Device: Altera 5CSEMA5F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for Questa Altera FPGA (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	codificatoreHamming IS
    PORT (
	input : IN std_logic_vector(1 TO 4);
	output : BUFFER std_logic_vector(1 TO 7)
	);
END codificatoreHamming;

-- Design Ports Information
-- output[7]	=>  Location: PIN_AB28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[6]	=>  Location: PIN_AC28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[5]	=>  Location: PIN_AB27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[4]	=>  Location: PIN_AA28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[3]	=>  Location: PIN_W25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[2]	=>  Location: PIN_AA30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[1]	=>  Location: PIN_AE29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- input[4]	=>  Location: PIN_AB30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- input[3]	=>  Location: PIN_AC29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- input[2]	=>  Location: PIN_AA26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- input[1]	=>  Location: PIN_V25,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF codificatoreHamming IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_input : std_logic_vector(1 TO 4);
SIGNAL ww_output : std_logic_vector(1 TO 7);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \input[4]~input_o\ : std_logic;
SIGNAL \input[3]~input_o\ : std_logic;
SIGNAL \input[2]~input_o\ : std_logic;
SIGNAL \p3~0_combout\ : std_logic;
SIGNAL \input[1]~input_o\ : std_logic;
SIGNAL \p2~0_combout\ : std_logic;
SIGNAL \p1~0_combout\ : std_logic;
SIGNAL \ALT_INV_input[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_input[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_input[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_input[1]~input_o\ : std_logic;

BEGIN

ww_input <= input;
output <= ww_output;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_input[3]~input_o\ <= NOT \input[3]~input_o\;
\ALT_INV_input[4]~input_o\ <= NOT \input[4]~input_o\;
\ALT_INV_input[2]~input_o\ <= NOT \input[2]~input_o\;
\ALT_INV_input[1]~input_o\ <= NOT \input[1]~input_o\;

-- Location: IOOBUF_X89_Y21_N39
\output[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \input[4]~input_o\,
	devoe => ww_devoe,
	o => ww_output(7));

-- Location: IOOBUF_X89_Y20_N79
\output[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \input[3]~input_o\,
	devoe => ww_devoe,
	o => ww_output(6));

-- Location: IOOBUF_X89_Y23_N22
\output[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \input[2]~input_o\,
	devoe => ww_devoe,
	o => ww_output(5));

-- Location: IOOBUF_X89_Y21_N56
\output[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \p3~0_combout\,
	devoe => ww_devoe,
	o => ww_output(4));

-- Location: IOOBUF_X89_Y20_N45
\output[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \input[1]~input_o\,
	devoe => ww_devoe,
	o => ww_output(3));

-- Location: IOOBUF_X89_Y21_N22
\output[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \p2~0_combout\,
	devoe => ww_devoe,
	o => ww_output(2));

-- Location: IOOBUF_X89_Y23_N39
\output[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \p1~0_combout\,
	devoe => ww_devoe,
	o => ww_output(1));

-- Location: IOIBUF_X89_Y21_N4
\input[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_input(4),
	o => \input[4]~input_o\);

-- Location: IOIBUF_X89_Y20_N95
\input[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_input(3),
	o => \input[3]~input_o\);

-- Location: IOIBUF_X89_Y23_N4
\input[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_input(2),
	o => \input[2]~input_o\);

-- Location: LABCELL_X88_Y21_N0
\p3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \p3~0_combout\ = ( \input[3]~input_o\ & ( \input[2]~input_o\ & ( \input[4]~input_o\ ) ) ) # ( !\input[3]~input_o\ & ( \input[2]~input_o\ & ( !\input[4]~input_o\ ) ) ) # ( \input[3]~input_o\ & ( !\input[2]~input_o\ & ( !\input[4]~input_o\ ) ) ) # ( 
-- !\input[3]~input_o\ & ( !\input[2]~input_o\ & ( \input[4]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111111100001111000011110000111100000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_input[4]~input_o\,
	datae => \ALT_INV_input[3]~input_o\,
	dataf => \ALT_INV_input[2]~input_o\,
	combout => \p3~0_combout\);

-- Location: IOIBUF_X89_Y20_N61
\input[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_input(1),
	o => \input[1]~input_o\);

-- Location: LABCELL_X88_Y21_N9
\p2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \p2~0_combout\ = ( \input[3]~input_o\ & ( \input[4]~input_o\ & ( \input[1]~input_o\ ) ) ) # ( !\input[3]~input_o\ & ( \input[4]~input_o\ & ( !\input[1]~input_o\ ) ) ) # ( \input[3]~input_o\ & ( !\input[4]~input_o\ & ( !\input[1]~input_o\ ) ) ) # ( 
-- !\input[3]~input_o\ & ( !\input[4]~input_o\ & ( \input[1]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101101010101010101010101010101010100101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_input[1]~input_o\,
	datae => \ALT_INV_input[3]~input_o\,
	dataf => \ALT_INV_input[4]~input_o\,
	combout => \p2~0_combout\);

-- Location: LABCELL_X88_Y21_N42
\p1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \p1~0_combout\ = ( \input[2]~input_o\ & ( !\input[4]~input_o\ $ (\input[1]~input_o\) ) ) # ( !\input[2]~input_o\ & ( !\input[4]~input_o\ $ (!\input[1]~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101101001011010010110100101101010100101101001011010010110100101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_input[4]~input_o\,
	datac => \ALT_INV_input[1]~input_o\,
	dataf => \ALT_INV_input[2]~input_o\,
	combout => \p1~0_combout\);

-- Location: LABCELL_X18_Y11_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


