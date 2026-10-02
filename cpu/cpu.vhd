-- Package per il tipo della memoria
library ieee;
use ieee.std_logic_1164.all;

package memTypes is

    type mem_type is array (0 to 127) of std_logic_vector(31 downto 0);
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);

    -- ROM 0
    constant ROM0_C : mem_type := (
        0  => x"00500113",
        1  => x"00C00193",
        2  => x"FF718393",
        3  => x"0023E233",
        4  => x"0041F2B3",
        5  => x"004282B3",
        6  => x"02728863",
        7  => x"0041A233",
        8  => x"00020463",
        9  => x"00000293",
        10 => x"0023A233",
        11 => x"005203B3",
        12 => x"402383B3",
        13 => x"0471AA23",
        14 => x"06002103",
        15 => x"005104B3",
        16 => x"008001EF",
        17 => x"00100113",
        18 => x"00910133",
        19 => x"0221A023",
        20 => x"00210063",
        others => (others => '0')
    );

    -- ROM 1
    constant ROM1_C : mem_type := (
        0  => x"FFC10113",
        1  => x"0FC00293",
        2  => x"00010337",
        3  => x"FFE30313",
        4  => x"00510023",
        5  => x"006110A3",
        6  => x"00010383",
        7  => x"00014E03",
        8  => x"00111E83",
        9  => x"00115F03",
        10 => x"00F00F93",
        11 => x"004F9F93",
        12 => x"002FDF93",
        13 => x"401FDF93",
        14 => x"12345537",
        15 => x"67850513",
        16 => x"00004597",
        17 => x"10058593",
        18 => x"06400293",
        19 => x"01F2A023",
        20 => x"00410113",
        21 => x"00000513",
        22 => x"05D00893",
        23 => x"00210063",
        others => (others => '0')
    );

    -- ROM 2
    constant ROM2_C : mem_type := (
        0  => x"FFB00293",
        1  => x"0002A313",
        2  => x"00A2B393",
        3  => x"0000BE37",
        4  => x"AAAE0E13",
        5  => x"FFFE4E93",
        6  => x"0FFE6F13",
        7  => x"00001837",
        8  => x"FF080813",
        9  => x"010E7FB3",
        10 => x"06400293",
        11 => x"01C2A023",
        12 => x"00000513",
        13 => x"05D00893",
        14 => x"00210063",
        others => (others => '0')
    );

    -- ROM 3
    constant ROM3_C : mem_type := (
        0  => x"00500293",
        1  => x"00A00313",
        2  => x"00629463",
        3  => x"0280006F",
        4  => x"0062C463",
        5  => x"0200006F",
        6  => x"00F00393",
        7  => x"0063D463",
        8  => x"0140006F",
        9  => x"FFF00E13",
        10 => x"005E6463",
        11 => x"0080006F",
        12 => x"005E7263",
        13 => x"06400293",
        14 => x"01C2A023",
        15 => x"00000513",
        16 => x"05D00893",
        17 => x"00210063",
        others => (others => '0')
    );

    -- ROM 4
    constant ROM4_C : mem_type := (
        0  => x"00100293",
        1  => x"00529333",
        2  => x"005353B3",
        3  => x"40535E33",
        4  => x"FFF00E93",
        5  => x"00100F13",
        6  => x"01EEBFB3",
        7  => x"01EECFB3",
        8  => x"00000297",
        9  => x"01028293",
        10 => x"000280E7",
        11 => x"3E700F93",
        12 => x"06400293",
        13 => x"01F2A023",
        14 => x"00000513",
        15 => x"05D00893",
        16 => x"00210063",
        others => (others => '0')
    );

end package;

----------------------------------------------
------------------ ALU -----------------------
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        SrcA       : in  std_logic_vector(31 downto 0);
        SrcB       : in  std_logic_vector(31 downto 0);
        ALUControl : in  std_logic_vector(3 downto 0);
        ALUResult  : out std_logic_vector(31 downto 0);
        Zero       : out std_logic;
        Cout       : out std_logic  
    );
end;

architecture funcAlu of ALU is
    signal flags, flagu : std_logic := '0';
    signal alu_out      : std_logic_vector(31 downto 0) := (others => '0');
    signal c_out        : std_logic := '0';
    constant ZERO32     : std_logic_vector(31 downto 0) := (others => '0');
begin

    -- Flag per le istruzioni slt
    flags <= '1' when signed(SrcA) < signed(SrcB) else '0';
    flagu <= '1' when unsigned(SrcA) < unsigned(SrcB) else '0';

    -- Selezione dell'operazione con "ALUControl"
    with ALUControl select
        alu_out <=
            std_logic_vector(signed(SrcA) + signed(SrcB))                           when "0000",
            std_logic_vector(signed(SrcA) - signed(SrcB))                           when "0001",
            (SrcA and SrcB)                                                         when "0010",
            (SrcA or SrcB)                                                          when "0011",
            (SrcA xor SrcB)                                                         when "0100",
            std_logic_vector(shift_left(unsigned(SrcA), to_integer(unsigned(SrcB(4 downto 0))))) when "0101",
            std_logic_vector(shift_right(unsigned(SrcA), to_integer(unsigned(SrcB(4 downto 0))))) when "0110",
            std_logic_vector(shift_right(signed(SrcA), to_integer(unsigned(SrcB(4 downto 0))))) when "0111",
            (31 downto 1 => '0') & flags                                            when "1000",
            (31 downto 1 => '0') & flagu                                            when "1001",
            ZERO32                                                                  when others;

    -- Flag per risultato nullo
    Zero <= '1' when alu_out = ZERO32 else '0';

    -- Carry out
    process(SrcA, SrcB, ALUControl)
        variable tmp : unsigned(32 downto 0);
    begin
        case ALUControl is
            when "0000" =>  -- ADD
                tmp := ('0' & unsigned(SrcA)) + ('0' & unsigned(SrcB));
                Cout <= tmp(32);
            when "0001" =>  -- SUB
					 if unsigned(SrcA) >= unsigned(SrcB) then
						  Cout <= '1';
					 else
						  Cout <= '0';
					 end if;
            when others =>
                Cout <= '0';
        end case;
    end process;

    ALUResult <= alu_out;

end;


----------------------------------------------
-------------- Control Unit ------------------
----------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControlUnit is
    Port (
        op        : in  std_logic_vector(6 downto 0); -- Instr(6:0)
        func3     : in  std_logic_vector(2 downto 0); -- Instr(14:12)
        func7     : in  std_logic;                    -- Instr(30)
        RegWrite  : out std_logic;
        MemWrite  : out std_logic;
        JumpType  : out std_logic;
        ResultSrc : out std_logic_vector(1 downto 0);
        ALUSrcA   : out std_logic_vector(1 downto 0);
        ALUSrcB   : out std_logic;
        ImmSrc    : out std_logic_vector(2 downto 0);
        ALUControl: out std_logic_vector(3 downto 0);
        Jump      : out std_logic;
        Branch    : out std_logic
    );
end;

architecture funcCu of ControlUnit is
    signal op_i  : integer := 0;
    signal ALUOp : std_logic_vector(1 downto 0) := "00";

begin

    -- Decodifica op in integer
    op_i <= to_integer(unsigned(op));

    -- JumpType (Main Decoder)
    JumpType <= '1' when op_i = 103 else '0';

    -- ResultSrc
    with op_i select
        ResultSrc <= "01" when 3,
                      "10" when 103 | 111,
                      "00" when others;

    -- RegWrite
    RegWrite <= '1' when 
                 (op_i = 3  or op_i = 19 or op_i = 23 or 
                  op_i = 51 or op_i = 55 or op_i = 103 or op_i = 111)
                else '0';

    -- MemWrite
    MemWrite <= '1' when op_i = 35 else '0';

    -- ALUSrcA
    with op_i select
        ALUSrcA <=  "01" when 23,
                   "10" when 55,
                   "00" when others;
   
   --ALUSrcB
   with op_i select
       ALUSrcB <= '1' when 3|19|23|35|55,
       		  '0' when others;

    -- ImmSrc
    ImmSrc <= "000" when (op_i = 3 or op_i = 103 or (op_i = 19 and (func3 = "000" or func3 = "010" or func3 = "011" or
                           func3 = "100" or func3 = "110" or func3 = "111"))) else
              "001" when (op_i = 19 and (func3 = "001" or func3 = "101")) else
              "010" when op_i = 35 else
              "011" when op_i = 99 else
              "100" when op_i = 111 else
              "101" when (op_i = 23 or op_i = 55) else
              "000";

    -- ALUOp
    with op_i select
        ALUOp <= "00" when 3 | 23 | 35 | 55,
                  "01" when 99,
                  "10" when 19 | 51,
                  "00" when others;

    -- ALUControl (ALU Decoder)
    ALUControl <= "0000" when ALUOp = "00" else
                  "0001" when ALUOp = "01" else
                  "0000" when (ALUOp = "10" and func3 = "000" and op(5) = '0') else
                  "0001" when (ALUOp = "10" and func3 = "000" and op(5) = '1' and func7 = '1') else
                  "0000" when (ALUOp = "10" and func3 = "000" and op(5) = '1' and func7 = '0') else
                  "0101" when (ALUOp = "10" and func3 = "001") else
                  "1000" when (ALUOp = "10" and func3 = "010") else
                  "1001" when (ALUOp = "10" and func3 = "011") else
                  "0100" when (ALUOp = "10" and func3 = "100") else
                  "0110" when (ALUOp = "10" and func3 = "101" and func7 = '0') else
                  "0111" when (ALUOp = "10" and func3 = "101" and func7 = '1') else
                  "0011" when (ALUOp = "10" and func3 = "110") else
                  "0010" when (ALUOp = "10" and func3 = "111") else
                  "0000";

    -- Branch
    Branch <= '1' when op_i = 99 else '0';
    
    --Jump
    Jump <= '1' when (op_i = 103 or op_i = 111) else '0';
end;

----------------------------------------------
---------------- Brancher --------------------
----------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Brancher is
    Port (
        A         : in  std_logic;                
        B         : in  std_logic;
        D         : in  std_logic;
        Zero      : in  std_logic;
        Cout      : in  std_logic;
        Jump      : in  std_logic;
        Branch    : in  std_logic;
        func3     : in  std_logic_vector(2 downto 0);
        PCsrc     : out std_logic
    );
end;

architecture funcBr of Brancher is
    signal tbr   : std_logic := '0';
    signal Bs    : std_logic := '0';
    signal Ov    : std_logic := '0';
begin
    -- Circuito per il segno del branch (blt, bge)
    Ov <= (A and (not B) and (not D)) or ((not A) and B and D);
    Bs <= ((A xor B) and A) or ((not (A xor B)) and (D xor Ov));

    -- Tipo di branch
    tbr <= Zero     when func3 = "000" else	-- beq
           not Zero when func3 = "001" else	-- bneq
           Bs       when func3 = "100" else	-- blt
           not Bs   when func3 = "101" else	-- bge
           not Cout when func3 = "110" else	-- bltu
           Cout     when func3 = "111" else	-- bgeu
           '0';

    -- PCsrc 
    PCsrc <= '1' when (Branch = '1' and tbr = '1') or Jump = '1'
             else '0';
end;


----------------------------------------------
--------------- Data Memory ------------------
----------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.memTypes.all;

entity DataMemory is
    Port (
        CLK : in std_logic;
        rst : in std_logic;  
        A   : in std_logic_vector(31 downto 0);
        WD  : in std_logic_vector(31 downto 0);
        WE  : in std_logic;
        CW  : in std_logic_vector(2 downto 0);
        RD  : out std_logic_vector(31 downto 0);
        outSign : out std_logic_vector(31 downto 0)
    );
end;

architecture funcDm of DataMemory is

    signal MEM  : mem_type := (others => (others => '0'));
    signal addr : integer range 0 to 127 := 0;

begin

    -- Decodifica indice (word addressable)
    addr <= to_integer(unsigned(A(8 downto 2)));

    -- Lettura asincrona
    RD <= MEM(addr);

    outSign <= MEM(25);

    -- Scrittura + reset sincrono
    process(CLK)
    begin
        if rising_edge(CLK) then

            -- Reset sincrono
            if rst = '1' then
                MEM <= (others => (others => '0'));

            elsif WE = '1' then
                case CW is

                    -- sb
                    when "000" =>
                        MEM(addr)(7 downto 0) <= WD(7 downto 0);

                    -- sh
                    when "001" =>
                        MEM(addr)(15 downto 0) <= WD(15 downto 0);

                    -- sw
                    when "010" =>
                        MEM(addr) <= WD;

                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process;

end;


----------------------------------------------
----------- Instruction Memory ---------------
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.memTypes.all;

entity InstructionMemory is
    port(
        A   : in  std_logic_vector(31 downto 0);
		  S   : in  std_logic_vector(2 downto 0);  
        RD  : out std_logic_vector(31 downto 0)  
    );
end;

architecture funcIm of InstructionMemory is

    signal addr : integer range 0 to 127;

begin

    process(addr, A, S)
    begin
        addr <= to_integer(unsigned(A(8 downto 2)));

        case S is
            when "001" => RD <= ROM1_C(addr);
            when "010" => RD <= ROM2_C(addr);
            when "011" => RD <= ROM3_C(addr);
            when "100" => RD <= ROM4_C(addr);
            when others => RD <= ROM0_C(addr);
        end case;
    end process;

end;



----------------------------------------------
----------- Immediate Extender ---------------
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ImmExt is
    port(
        Instr   : in  std_logic_vector(31 downto 7);  
        ImmSrc  : in  std_logic_vector(2 downto 0);
        ImmRes  : out std_logic_vector(31 downto 0)
    );
end;

architecture funcIe of ImmExt is
signal ImmR : std_logic_vector(31 downto 0) := (others => '0');
begin
    -- Implementazione con process (non necessaria poichè circuito combinatorio, ma comoda)
    process(Instr, ImmSrc)
    begin
        case ImmSrc is
            -- 000 : I-type immediato (sign-extend)
            when "000" =>
                ImmR <= (31 downto 12 => Instr(31)) & Instr(31 downto 20);
            -- 001 : Shift-immediate (zero-extend)
            when "001" =>
                ImmR <= (31 downto 5 => '0') & Instr(24 downto 20);
            -- 010 : S-type
            when "010" =>
                ImmR <= (31 downto 12 => Instr(31)) &
                           Instr(31 downto 25) &
                           Instr(11 downto 7);
            -- 011 : B-type
            when "011" =>
                ImmR <= (31 downto 12 => Instr(31)) &
                           Instr(7) &
                           Instr(30 downto 25) &
                           Instr(11 downto 8) &
                           '0';
            -- 100 : J-type 
            when "100" =>
                ImmR <= (31 downto 20 => Instr(31)) &
                           Instr(19 downto 12) &
                           Instr(20) &
                           Instr(30 downto 21) &
                           '0';
            -- 101 : U-type 
            when "101" =>
                ImmR <= Instr(31 downto 12) & (11 downto 0 => '0');
            when others =>
                ImmR <= (others => '0');
        end case;
    end process;
	 ImmRes <= ImmR;
end;



----------------------------------------------
----------- Read-Data Modifier ---------------
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RDext is
    port(
        RDprov  : in  std_logic_vector(31 downto 0);
        RDctrl  : in  std_logic_vector(2 downto 0);
        ReadData: out std_logic_vector(31 downto 0)
    );
end;

architecture funcRd of RDext is
begin
    -- Implementazione con process (non necessaria poichè circuito combinatorio, ma comoda)
    process(RDprov, RDctrl)
    begin
        case RDctrl is
            -- 000 : sign-extend byte
            when "000" =>
                ReadData <= (31 downto 8 => RDprov(7)) & RDprov(7 downto 0);
            -- 001 : sign-extend halfword
            when "001" =>
                ReadData <= (31 downto 16 => RDprov(15)) & RDprov(15 downto 0);
            -- 010 : word intero
            when "010" =>
                ReadData <= RDprov;
            -- 100 : zero-extend byte
            when "100" =>
                ReadData <= (31 downto 8 => '0') & RDprov(7 downto 0);
            -- 101 : zero-extend halfword
            when "101" =>
                ReadData <= (31 downto 16 => '0') & RDprov(15 downto 0);
            when others =>
                ReadData <= (others => '0');
        end case;
    end process;
end;


----------------------------------------------
-------------- Register File -----------------
----------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.memTypes.all;

entity RegisterFile is
    Port (
        CLK : in std_logic;
        rst : in std_logic;  
        A1  : in std_logic_vector(4 downto 0);
        A2  : in std_logic_vector(4 downto 0);
        A3  : in std_logic_vector(4 downto 0);
        WE3 : in std_logic;
        WD3 : in std_logic_vector(31 downto 0);
        RD1 : out std_logic_vector(31 downto 0);
        RD2 : out std_logic_vector(31 downto 0)
    );
end;

architecture funcRf of RegisterFile is

    signal R : reg_array := (others => (others => '0'));

begin

    -- Lettura asincrona
    RD1 <= R(to_integer(unsigned(A1)));
    RD2 <= R(to_integer(unsigned(A2)));

    -- Scrittura + reset sincrono
    process(CLK)
    begin
        if falling_edge(CLK) then

            -- Reset sincrono
            if rst = '1' then
                R <= (others => (others => '0'));

            elsif (WE3 = '1' and A3 /= "00000") then
                R(to_integer(unsigned(A3))) <= WD3;
            end if;
        end if;
    end process;

end;



----------------------------------------------
------------- Registro del PC ----------------
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PcReg is
    port (
        clk    : in  std_logic;
        PcNext : in  std_logic_vector(31 downto 0);
        en     : in std_logic;
        clr    : in std_logic; 
        Pc     : out std_logic_vector(31 downto 0)
    );
end;

architecture funcPc of PcReg is
    signal pc_reg : std_logic_vector(31 downto 0) := (others => '0');
begin
    process(clk, clr)
    begin
        if rising_edge(clk) then
            if clr = '1' then
                pc_reg <= (others => '0');
            elsif en = '1' then
                pc_reg <= PcNext;
				else
				    null;
            end if;
        end if;
    end process;

    Pc <= pc_reg;
end;

----------------------------------------------
--------------- Registro F-D -----------------
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FDRegister is
    port(
        clk      : in std_logic;
        en       : in std_logic;
        clr      : in std_logic;  -- flush D
        InstrF   : in std_logic_vector(31 downto 0);
        PCF      : in std_logic_vector(31 downto 0);
        PCPlus4F : in std_logic_vector(31 downto 0);
        InstrD   : out std_logic_vector(31 downto 0);
        PCD      : out std_logic_vector(31 downto 0);
        PCPlus4D : out std_logic_vector(31 downto 0)
    );
end;

architecture FDR of FDRegister is
      signal instr_reg : std_logic_vector(31 downto 0) := (others => '0');
		signal pc_reg    : std_logic_vector(31 downto 0) := (others => '0');
		signal pcp4_reg  : std_logic_vector(31 downto 0) := (others => '0');
begin
    process(clk, clr)
    begin
        if rising_edge(clk) then
            if clr = '1' then  -- flush D
                instr_reg <= (others => '0');
                pc_reg    <= (others => '0');
                pcp4_reg  <= (others => '0');
            elsif en = '1' then
                instr_reg <= InstrF;
                pc_reg    <= PCF;
                pcp4_reg  <= PCPlus4F;
				else
				    null;
            end if;
        end if;
    end process;

    InstrD   <= instr_reg;
    PCD      <= pc_reg;
    PCPlus4D <= pcp4_reg;
end FDR;

----------------------------------------------
--------------- Registro D-E -----------------
----------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DERegister is
    port(
        clk      : in std_logic;
        clr      : in std_logic;  -- flush E
        
        -- ingressi
        RegWriteD : in std_logic;
        ResultSrcD : in std_logic_vector(1 downto 0);
        MemWriteD  : in std_logic;
        JumpD : in std_logic;
        BranchD : in std_logic;
        ALUControlD: in std_logic_vector(3 downto 0);
        ALUSrcAD : in std_logic_vector(1 downto 0);
        ALUSrcBD : in std_logic;
        jumpTypeD : in std_logic;
        Rd1D : in std_logic_vector(31 downto 0);
        Rd2D: in std_logic_vector(31 downto 0);
        PCD : in std_logic_vector(31 downto 0);
        Rs1D : in std_logic_vector(4 downto 0);
        Rs2D : in std_logic_vector(4 downto 0);
        RdD  : in std_logic_vector(4 downto 0);
        ImmExtD : in std_logic_vector(31 downto 0);
        func3D : in std_logic_vector(2 downto 0);
        PCPlus4D : in std_logic_vector(31 downto 0);
        
        -- uscite
        RegWriteE : out std_logic;
        ResultSrcE : out std_logic_vector(1 downto 0);
        MemWriteE  : out std_logic;
        JumpE : out std_logic;
        BranchE : out std_logic;
        ALUControlE: out std_logic_vector(3 downto 0);
        ALUSrcAE : out std_logic_vector(1 downto 0);
        ALUSrcBE : out std_logic;
        jumpTypeE : out std_logic;
        Rd1E : out std_logic_vector(31 downto 0);
        Rd2E: out std_logic_vector(31 downto 0);
        PCE : out std_logic_vector(31 downto 0);
        Rs1E : out std_logic_vector(4 downto 0);
        Rs2E : out std_logic_vector(4 downto 0);
        RdE  : out std_logic_vector(4 downto 0);
        ImmExtE : out std_logic_vector(31 downto 0);
        func3E : out std_logic_vector(2 downto 0);
        PCPlus4E : out std_logic_vector(31 downto 0)
    );
end DERegister;

architecture DER of DERegister is
    -- segnali interni
   signal RegWrite_reg    : std_logic := '0';
	signal ResultSrc_reg   : std_logic_vector(1 downto 0) := (others => '0');
	signal MemWrite_reg    : std_logic := '0';
	signal Jump_reg        : std_logic := '0';
	signal Branch_reg      : std_logic := '0';
	signal ALUControl_reg  : std_logic_vector(3 downto 0) := (others => '0');
	signal ALUSrcA_reg     : std_logic_vector(1 downto 0) := (others => '0');
	signal ALUSrcB_reg     : std_logic := '0';
	signal jumpType_reg    : std_logic := '0';
	signal Rd1_reg         : std_logic_vector(31 downto 0) := (others => '0');
	signal Rd2_reg         : std_logic_vector(31 downto 0) := (others => '0');
	signal PC_reg          : std_logic_vector(31 downto 0) := (others => '0');
	signal Rs1_reg         : std_logic_vector(4 downto 0) := (others => '0');
	signal Rs2_reg         : std_logic_vector(4 downto 0) := (others => '0');
	signal Rd_reg          : std_logic_vector(4 downto 0) := (others => '0');
	signal ImmExt_reg      : std_logic_vector(31 downto 0) := (others => '0');
	signal func3_reg       : std_logic_vector(2 downto 0) := (others => '0');
	signal PCPlus4_reg     : std_logic_vector(31 downto 0) := (others => '0');
begin
    process(clk, clr)
    begin
        if rising_edge(clk) then
            if clr = '1' then  -- flush E
                RegWrite_reg <= '0';
                ResultSrc_reg <= (others => '0');
                MemWrite_reg <= '0';
                Jump_reg <= '0';
                Branch_reg <= '0';
                ALUControl_reg <= (others => '0');
                ALUSrcA_reg <= (others => '0');
                ALUSrcB_reg <= '0';
                jumpType_reg <= '0';
                Rd1_reg <= (others => '0');
                Rd2_reg <= (others => '0');
                PC_reg  <= (others => '0');
                Rs1_reg <= (others => '0');
                Rs2_reg <= (others => '0');
                Rd_reg  <= (others => '0');
                ImmExt_reg <= (others => '0');
                func3_reg <= (others => '0');
                PCPlus4_reg <= (others => '0');
            else
                RegWrite_reg <= RegWriteD;
                ResultSrc_reg <= ResultSrcD;
                MemWrite_reg <= MemWriteD;
                Jump_reg <= JumpD;
                Branch_reg <= BranchD;
                ALUControl_reg <= ALUControlD;
                ALUSrcA_reg <= ALUSrcAD;
                ALUSrcB_reg <= ALUSrcBD;
                jumpType_reg <= jumpTypeD;
                Rd1_reg <= Rd1D;
                Rd2_reg <= Rd2D;
                PC_reg  <= PCD;
                Rs1_reg <= Rs1D;
                Rs2_reg <= Rs2D;
                Rd_reg  <= RdD;
                ImmExt_reg <= ImmExtD;
                func3_reg <= func3D;
                PCPlus4_reg <= PCPlus4D;
            end if;
        end if;
    end process;

    -- Uscite
    RegWriteE <= RegWrite_reg;
    ResultSrcE <= ResultSrc_reg;
    MemWriteE <= MemWrite_reg;
    JumpE <= Jump_reg;
    BranchE <= Branch_reg;
    ALUControlE <= ALUControl_reg;
    ALUSrcAE <= ALUSrcA_reg;
    ALUSrcBE <= ALUSrcB_reg;
    jumpTypeE <= jumpType_reg;
    Rd1E <= Rd1_reg;
    Rd2E <= Rd2_reg;
    PCE <= PC_reg;
    Rs1E <= Rs1_reg;
    Rs2E <= Rs2_reg;
    RdE <= Rd_reg;
    ImmExtE <= ImmExt_reg;
    func3E <= func3_reg;
    PCPlus4E <= PCPlus4_reg;
end DER;


----------------------------------------------
--------------- Registro E-M -----------------
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EMRegister is
	port(
		clk : in std_logic;
		clr : in std_logic;  

		RegWriteE : in std_logic;
		ResultSrcE : in std_logic_vector(1 downto 0);
		MemWriteE  : in std_logic;
		ALUResultE : in std_logic_vector(31 downto 0);
		WriteDataE : in std_logic_vector(31 downto 0);
		RdE  : in std_logic_vector(4 downto 0);
		func3E : in std_logic_vector(2 downto 0);
		PCPlus4E : in std_logic_vector(31 downto 0);

		RegWriteM : out std_logic;
		ResultSrcM : out std_logic_vector(1 downto 0);
		MemWriteM  : out std_logic;
		ALUResultM : out std_logic_vector(31 downto 0);
		WriteDataM : out std_logic_vector(31 downto 0);
		RdM  : out std_logic_vector(4 downto 0);
		func3M : out std_logic_vector(2 downto 0);
		PCPlus4M : out std_logic_vector(31 downto 0)
	);
end EMRegister;

architecture EMR of EMRegister is

	signal RegWrite_reg : std_logic := '0';
	signal ResultSrc_reg : std_logic_vector(1 downto 0) := (others => '0');
	signal MemWrite_reg : std_logic := '0';
	signal ALUResult_reg : std_logic_vector(31 downto 0) := (others => '0');
	signal WriteData_reg : std_logic_vector(31 downto 0) := (others => '0');
	signal Rd_reg  : std_logic_vector(4 downto 0) := (others => '0');
	signal func3_reg : std_logic_vector(2 downto 0) := (others => '0');
	signal PCPlus4_reg : std_logic_vector(31 downto 0) := (others => '0');

begin

	process(clk, clr)
	begin
		if rising_edge(clk) then
			if clr = '1' then
				RegWrite_reg <= '0';
				ResultSrc_reg <= (others => '0');
				MemWrite_reg <= '0';
				ALUResult_reg <= (others => '0');
				WriteData_reg <= (others => '0');
				Rd_reg <= (others => '0');
				func3_reg <= (others => '0');
				PCPlus4_reg <= (others => '0');
			else
				RegWrite_reg <= RegWriteE;
				ResultSrc_reg <= ResultSrcE;
				MemWrite_reg <= MemWriteE;
				ALUResult_reg <= ALUResultE;
				WriteData_reg <= WriteDataE;
				Rd_reg <= RdE;
				func3_reg <= func3E;
				PCPlus4_reg <= PCPlus4E;
			end if;
		end if;
	end process;

	RegWriteM <= RegWrite_reg;
	ResultSrcM <= ResultSrc_reg;
	MemWriteM <= MemWrite_reg;
	ALUResultM <= ALUResult_reg;
	WriteDataM <= WriteData_reg;
	RdM <= Rd_reg;
	func3M <= func3_reg;
	PCPlus4M <= PCPlus4_reg;

end EMR;

----------------------------------------------
--------------- Registro M-W -----------------
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MWRegister is
	port(
		clk : in std_logic;
		clr : in std_logic; 

		RegWriteM : in std_logic;
		ResultSrcM : in std_logic_vector(1 downto 0);
		ALUResultM : in std_logic_vector(31 downto 0);
		ReadDataM : in std_logic_vector(31 downto 0);
		RdM : in std_logic_vector(4 downto 0);
		PCPlus4M : in std_logic_vector(31 downto 0);

		RegWriteW : out std_logic;
		ResultSrcW : out std_logic_vector(1 downto 0);
		ALUResultW : out std_logic_vector(31 downto 0);
		ReadDataW : out std_logic_vector(31 downto 0);
		RdW : out std_logic_vector(4 downto 0);
		PCPlus4W : out std_logic_vector(31 downto 0)
	);
end MWRegister;

architecture MWR of MWRegister is

	signal RegWrite_reg : std_logic := '0';
	signal ALUResult_reg : std_logic_vector(31 downto 0) := (others => '0');
	signal ResultSrc_reg : std_logic_vector(1 downto 0) := (others => '0');
	signal ReadData_reg : std_logic_vector(31 downto 0) := (others => '0');
	signal Rd_reg : std_logic_vector(4 downto 0) := (others => '0');
	signal PCPlus4_reg : std_logic_vector(31 downto 0) := (others => '0');

begin

	process(clk, clr)
	begin
		if rising_edge(clk) then
			if clr = '1' then
				RegWrite_reg <= '0';
				ALUResult_reg <= (others => '0');
				ResultSrc_reg <= (others => '0');
				ReadData_reg <= (others => '0');
				Rd_reg <= (others => '0');
				PCPlus4_reg <= (others => '0');
			else
				RegWrite_reg <= RegWriteM;
				ALUResult_reg <= ALUResultM;
				ResultSrc_reg <= ResultSrcM;
				ReadData_reg <= ReadDataM;
				Rd_reg <= RdM;
				PCPlus4_reg <= PCPlus4M;
			end if;
		end if;
	end process;

	RegWriteW <= RegWrite_reg;
	ALUResultW <= ALUResult_reg;
	ResultSrcW <= ResultSrc_reg;
	ReadDataW <= ReadData_reg;
	RdW <= Rd_reg;
	PCPlus4W <= PCPlus4_reg;

end MWR;


----------------------------------------------
--------------- Hazard Unit ------------------
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HazardUnit is
	port(
	   rst  : in std_logic;
		Rs1D : in std_logic_vector(4 downto 0);
		Rs2D : in std_logic_vector(4 downto 0);
		Rs1E : in std_logic_vector(4 downto 0);
		Rs2E : in std_logic_vector(4 downto 0);
		RdE : in std_logic_vector(4 downto 0);
		RdM : in std_logic_vector(4 downto 0);
		RdW : in std_logic_vector(4 downto 0);
		RegWriteM : in std_logic;
		RegWriteW : in std_logic;
		ResultSrcE : in std_logic_vector(1 downto 0);
		PCSrcE : in std_logic;
		ForwardAE : out std_logic_vector(1 downto 0);
		ForwardBE : out std_logic_vector(1 downto 0);
		StallF : out std_logic;
		StallD : out std_logic;
		FlushD : out std_logic;
		FlushE : out std_logic
	);
end HazardUnit;

architecture HU of HazardUnit is
	signal lwStall : std_logic := '0';
	signal rsMatch : std_logic := '0';
begin
	-- FORWARD A 
	process(Rs1E, RdM, RdW, RegWriteM, RegWriteW)
	begin
		if ((Rs1E = RdM) and (RegWriteM = '1')) and (Rs1E /= "00000") then
			ForwardAE <= "10";

		elsif ((Rs1E = RdW) and (RegWriteW = '1')) and (Rs1E /= "00000") then
			ForwardAE <= "01";

		else
			ForwardAE <= "00";
		end if;
	end process;
	-- FORWARD B 
	process(Rs2E, RdM, RdW, RegWriteM, RegWriteW)
	begin
		if ((Rs2E = RdM) and (RegWriteM = '1')) and (Rs2E /= "00000") then
			ForwardBE <= "10";

		elsif ((Rs2E = RdW) and (RegWriteW = '1')) and (Rs2E /= "00000") then
			ForwardBE <= "01";

		else
			ForwardBE <= "00";
		end if;
	end process;
	-- lwStall
	rsMatch <= '1' when (Rs1D = RdE) or (Rs2D = RdE) else '0';
	lwStall <= ResultSrcE(0) and rsMatch;
	-- STALL
	StallF <= lwStall;
	StallD <= lwStall;
	-- FLUSH
	FlushD <= PCSrcE or rst;
	FlushE <= lwStall or PCSrcE or rst;
end HU;

----------------------------------------------
------------------ CPU -----------------------
----------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.memTypes.all;

entity CPU is
port(
-- Input
clk      : in std_logic;
switchon : in std_logic;
ctrl     : in std_logic;
-- Segnali per il display hex
num0     : out std_logic_vector(6 downto 0);
num1     : out std_logic_vector(6 downto 0);
num2     : out std_logic_vector(6 downto 0);
num3     : out std_logic_vector(6 downto 0);
num4     : out std_logic_vector(6 downto 0);
num5     : out std_logic_vector(6 downto 0)
);
end;

architecture funcCpu of CPU is

-- COMPONENTI
component ALU
port (
SrcA       : in  std_logic_vector(31 downto 0);
SrcB       : in  std_logic_vector(31 downto 0);
ALUControl : in  std_logic_vector(3 downto 0);
ALUResult  : out std_logic_vector(31 downto 0);
Zero       : out std_logic;
Cout       : out std_logic
);
end component;

component ControlUnit
port (
op         : in  std_logic_vector(6 downto 0);
func3      : in  std_logic_vector(2 downto 0);
func7      : in  std_logic;
RegWrite   : out std_logic;
MemWrite   : out std_logic;
JumpType   : out std_logic;
ResultSrc  : out std_logic_vector(1 downto 0);
ALUSrcA    : out std_logic_vector(1 downto 0);
ALUSrcB    : out std_logic;
ImmSrc     : out std_logic_vector(2 downto 0);
ALUControl : out std_logic_vector(3 downto 0);
Jump       : out std_logic;
Branch     : out std_logic
);
end component;

component DataMemory
port (
CLK : in std_logic;
rst : in std_logic;
A   : in std_logic_vector(31 downto 0);
WD  : in std_logic_vector(31 downto 0);
WE  : in std_logic;
CW  : in std_logic_vector(2 downto 0);
RD  : out std_logic_vector(31 downto 0);
outSign : out std_logic_vector(31 downto 0)
);
end component;

component InstructionMemory
port(
A   : in  std_logic_vector(31 downto 0);
S   : in  std_logic_vector(2 downto 0);
RD  : out std_logic_vector(31 downto 0)
);
end component;

component ImmExt
port(
Instr   : in  std_logic_vector(31 downto 7);
ImmSrc  : in  std_logic_vector(2 downto 0);
ImmRes  : out std_logic_vector(31 downto 0)
);
end component;

component RDext
port(
RDprov   : in  std_logic_vector(31 downto 0);
RDctrl   : in  std_logic_vector(2 downto 0);
ReadData : out std_logic_vector(31 downto 0)
);
end component;

component RegisterFile
port(
CLK : in std_logic;
rst : in std_logic;
A1  : in std_logic_vector(4 downto 0);
A2  : in std_logic_vector(4 downto 0);
A3  : in std_logic_vector(4 downto 0);
WE3 : in std_logic;
WD3 : in std_logic_vector(31 downto 0);
RD1 : out std_logic_vector(31 downto 0);
RD2 : out std_logic_vector(31 downto 0)
);
end component;

component PcReg
port(
clk    : in  std_logic;
PcNext : in  std_logic_vector(31 downto 0);
en     : in  std_logic;
clr    : in  std_logic;
Pc     : out std_logic_vector(31 downto 0)
);
end component;

component FDRegister
port(
clk      : in std_logic;
en       : in std_logic;
clr      : in std_logic;
InstrF   : in std_logic_vector(31 downto 0);
PCF      : in std_logic_vector(31 downto 0);
PCPlus4F : in std_logic_vector(31 downto 0);
InstrD   : out std_logic_vector(31 downto 0);
PCD      : out std_logic_vector(31 downto 0);
PCPlus4D : out std_logic_vector(31 downto 0)
);
end component;

component DERegister
port(
clk      : in std_logic;
clr      : in std_logic;
RegWriteD : in std_logic;
ResultSrcD : in std_logic_vector(1 downto 0);
MemWriteD  : in std_logic;
JumpD : in std_logic;
BranchD : in std_logic;
ALUControlD: in std_logic_vector(3 downto 0);
ALUSrcAD : in std_logic_vector(1 downto 0);
ALUSrcBD : in std_logic;
jumpTypeD : in std_logic;
Rd1D : in std_logic_vector(31 downto 0);
Rd2D: in std_logic_vector(31 downto 0);
PCD : in std_logic_vector(31 downto 0);
Rs1D : in std_logic_vector(4 downto 0);
Rs2D : in std_logic_vector(4 downto 0);
RdD  : in std_logic_vector(4 downto 0);
ImmExtD : in std_logic_vector(31 downto 0);
func3D : in std_logic_vector(2 downto 0);
PCPlus4D : in std_logic_vector(31 downto 0);
RegWriteE : out std_logic;
ResultSrcE : out std_logic_vector(1 downto 0);
MemWriteE  : out std_logic;
JumpE : out std_logic;
BranchE : out std_logic;
ALUControlE: out std_logic_vector(3 downto 0);
ALUSrcAE : out std_logic_vector(1 downto 0);
ALUSrcBE : out std_logic;
jumpTypeE : out std_logic;
Rd1E : out std_logic_vector(31 downto 0);
Rd2E: out std_logic_vector(31 downto 0);
PCE : out std_logic_vector(31 downto 0);
Rs1E : out std_logic_vector(4 downto 0);
Rs2E : out std_logic_vector(4 downto 0);
RdE  : out std_logic_vector(4 downto 0);
ImmExtE : out std_logic_vector(31 downto 0);
func3E : out std_logic_vector(2 downto 0);
PCPlus4E : out std_logic_vector(31 downto 0)
);
end component;

component EMRegister
port(
clk : in std_logic;
clr : in std_logic;
RegWriteE : in std_logic;
ResultSrcE : in std_logic_vector(1 downto 0);
MemWriteE  : in std_logic;
ALUResultE : in std_logic_vector(31 downto 0);
WriteDataE : in std_logic_vector(31 downto 0);
RdE  : in std_logic_vector(4 downto 0);
func3E : in std_logic_vector(2 downto 0);
PCPlus4E : in std_logic_vector(31 downto 0);
RegWriteM : out std_logic;
ResultSrcM : out std_logic_vector(1 downto 0);
MemWriteM  : out std_logic;
ALUResultM : out std_logic_vector(31 downto 0);
WriteDataM : out std_logic_vector(31 downto 0);
RdM  : out std_logic_vector(4 downto 0);
func3M : out std_logic_vector(2 downto 0);
PCPlus4M : out std_logic_vector(31 downto 0)
);
end component;

component MWRegister
port(
clk : in std_logic;
clr : in std_logic;
RegWriteM : in std_logic;
ResultSrcM : in std_logic_vector(1 downto 0);
ALUResultM : in std_logic_vector(31 downto 0);
ReadDataM : in std_logic_vector(31 downto 0);
RdM : in std_logic_vector(4 downto 0);
PCPlus4M : in std_logic_vector(31 downto 0);
RegWriteW : out std_logic;
ResultSrcW : out std_logic_vector(1 downto 0);
ALUResultW : out std_logic_vector(31 downto 0);
ReadDataW : out std_logic_vector(31 downto 0);
RdW : out std_logic_vector(4 downto 0);
PCPlus4W : out std_logic_vector(31 downto 0)
);
end component;

component Brancher
port(
A         : in  std_logic;
B         : in  std_logic;
D         : in  std_logic;
Zero      : in  std_logic;
Cout      : in  std_logic;
Jump      : in  std_logic;
Branch    : in  std_logic;
func3     : in  std_logic_vector(2 downto 0);
PCsrc     : out std_logic
);
end component;

component HazardUnit
port(
rst  : in std_logic;
Rs1D : in std_logic_vector(4 downto 0);
Rs2D : in std_logic_vector(4 downto 0);
Rs1E : in std_logic_vector(4 downto 0);
Rs2E : in std_logic_vector(4 downto 0);
RdE : in std_logic_vector(4 downto 0);
RdM : in std_logic_vector(4 downto 0);
RdW : in std_logic_vector(4 downto 0);
RegWriteM : in std_logic;
RegWriteW : in std_logic;
ResultSrcE : in std_logic_vector(1 downto 0);
PCSrcE : in std_logic;
ForwardAE : out std_logic_vector(1 downto 0);
ForwardBE : out std_logic_vector(1 downto 0);
StallF : out std_logic;
StallD : out std_logic;
FlushD : out std_logic;
FlushE : out std_logic
);
end component;

-- SEGNALI INTERNI
-- Fetch
signal PCNextF    : std_logic_vector(31 downto 0) := (others => '0');
signal StallF     : std_logic := '0';
signal PCF        : std_logic_vector(31 downto 0) := (others => '0');
signal PCPlus4F   : std_logic_vector(31 downto 0) := (others => '0');
signal InstrF     : std_logic_vector(31 downto 0) := (others => '0');
signal notStallF  : std_logic := '0';
-- Decode
signal InstrD       : std_logic_vector(31 downto 0) := (others => '0');
signal PCD          : std_logic_vector(31 downto 0) := (others => '0');
signal PCPlus4D     : std_logic_vector(31 downto 0) := (others => '0');
signal ImmExtD      : std_logic_vector(31 downto 0) := (others => '0');
signal RD1D         : std_logic_vector(31 downto 0) := (others => '0');
signal RD2D         : std_logic_vector(31 downto 0) := (others => '0');
signal StallD       : std_logic := '0';
signal FlushD       : std_logic := '0';
signal RegWriteD    : std_logic := '0';
signal ResultSrcD   : std_logic_vector(1 downto 0) := (others => '0');
signal MemWriteD    : std_logic := '0';
signal JumpD        : std_logic := '0';
signal BranchD      : std_logic := '0';
signal ALUControlD  : std_logic_vector(3 downto 0) := (others => '0');
signal ALUSrcAD     : std_logic_vector(1 downto 0) := (others => '0');
signal ALUSrcBD     : std_logic := '0';
signal jumpTypeD    : std_logic := '0';
signal ImmSrcD      : std_logic_vector(2 downto 0) := (others => '0');
signal notStallD    : std_logic := '0';
-- Execute
signal RegWriteE    : std_logic := '0';
signal ResultSrcE   : std_logic_vector(1 downto 0) := (others => '0');
signal MemWriteE    : std_logic := '0';
signal JumpE        : std_logic := '0';
signal BranchE      : std_logic := '0';
signal ALUControlE  : std_logic_vector(3 downto 0) := (others => '0');
signal ALUSrcAE     : std_logic_vector(1 downto 0) := (others => '0');
signal ALUSrcBE     : std_logic := '0';
signal jumpTypeE    : std_logic := '0';
signal PCSrcE       : std_logic := '0';
signal ZeroE        : std_logic := '0';
signal CoutE        : std_logic := '0';
signal RD1E         : std_logic_vector(31 downto 0) := (others => '0');
signal RD2E         : std_logic_vector(31 downto 0) := (others => '0');
signal PCE          : std_logic_vector(31 downto 0) := (others => '0');
signal RS1E         : std_logic_vector(4 downto 0) := (others => '0');
signal RS2E         : std_logic_vector(4 downto 0) := (others => '0');
signal RdE          : std_logic_vector(4 downto 0) := (others => '0');
signal ImmExtE      : std_logic_vector(31 downto 0) := (others => '0');
signal func3E       : std_logic_vector(2 downto 0) := (others => '0');
signal PCPlus4E     : std_logic_vector(31 downto 0) := (others => '0');
signal FlushE       : std_logic := '0';
signal ForwardAE    : std_logic_vector(1 downto 0) := (others => '0');
signal ForwardBE    : std_logic_vector(1 downto 0) := (others => '0');
signal SrcAE        : std_logic_vector(31 downto 0) := (others => '0');
signal SrcBE        : std_logic_vector(31 downto 0) := (others => '0');
signal WriteDataE   : std_logic_vector(31 downto 0) := (others => '0');
signal ALUResultE   : std_logic_vector(31 downto 0) := (others => '0');
signal PCTargetE    : std_logic_vector(31 downto 0) := (others => '0');
signal sumPCE       : std_logic_vector(31 downto 0) := (others => '0');
signal ImmPCE       : std_logic_vector(31 downto 0) := (others => '0');
signal ReadFirE     : std_logic_vector(31 downto 0) := (others => '0');
-- Memory
signal RegWriteM    : std_logic := '0';
signal ResultSrcM   : std_logic_vector(1 downto 0) := (others => '0');
signal MemWriteM    : std_logic := '0';
signal ALUResultM   : std_logic_vector(31 downto 0) := (others => '0');
signal WriteDataM   : std_logic_vector(31 downto 0) := (others => '0');
signal ReadDataM    : std_logic_vector(31 downto 0) := (others => '0');
signal RDProvM      : std_logic_vector(31 downto 0) := (others => '0');
signal func3M       : std_logic_vector(2 downto 0) := (others => '0');
signal RdM          : std_logic_vector(4 downto 0) := (others => '0');
signal PCPlus4M     : std_logic_vector(31 downto 0) := (others => '0');
-- Writeback
signal RegWriteW    : std_logic := '0';
signal ResultSrcW   : std_logic_vector(1 downto 0) := (others => '0');
signal ReadDataW    : std_logic_vector(31 downto 0) := (others => '0');
signal RdW          : std_logic_vector(4 downto 0) := (others => '0');
signal PCPlus4W     : std_logic_vector(31 downto 0) := (others => '0');
signal ResultW      : std_logic_vector(31 downto 0) := (others => '0');
signal ALUResultW   : std_logic_vector(31 downto 0) := (others => '0');
-- Altro   
signal outSig     : std_logic_vector(31 downto 0) := (others => '0');
signal rst        : std_logic := '0';
signal sel        : std_logic_vector(2 downto 0) := (others => '0');



begin
-- Generazione dei segnali di selezione e reset
process(ctrl)
begin
    if falling_edge(ctrl) then
        if sel = "100" then
            sel <= "000";
        else
            sel <= std_logic_vector(unsigned(sel) + 1);
        end if;
    end if;
end process;

rst <= not ctrl;
-- IMPLEMENTAZIONE DATAPATH E CONNESSIONE CON LA CONTROL UNIT
	-- ALU
	AU: ALU port map(SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE, CoutE);
	-- Control Unit
	CU: ControlUnit port map(InstrD(6 downto 0), InstrD(14 downto 12), InstrD(30), RegWriteD, MemWriteD, jumpTypeD, ResultSrcD, ALUSrcAD, ALUSrcBD, ImmSrcD, ALUControlD, JumpD, BranchD);
	-- Data Memory
	DM: DataMemory port map(clk, rst, AluResultM, WriteDataM, MemWriteM, func3M, RDprovM, outSig);
	-- Instruction memory
	IM: InstructionMemory port map(PCF, sel, InstrF);
	-- Immediate Extender
	IE: ImmExt port map(InstrD(31 downto 7), ImmSrcD, ImmExtD);
	-- Read Data Extender
	RE: RDext port map(RDprovM, func3M, ReadDataM);
	-- Register File
	RF: RegisterFile port map(clk, rst, InstrD(19 downto 15), InstrD(24 downto 20), RdW, RegWriteW, ResultW, RD1D, RD2D);
	-- PC Register
	notStallF <= not(StallF);
	PR: PcReg port map(clk, PCNextF, notStallF, rst, PCF);
	-- FD Register
	notStallD <= not(StallD);
	FD: FDRegister port map(clk, notStallD, FlushD, InstrF, PCF, PCPlus4F, InstrD, PCD, PCPlus4D);
	-- DE Register
	DE: DERegister port map(clk, FlushE, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcAD, ALUSrcBD, jumpTypeD, RD1D, RD2D, PCD, InstrD(19 downto 15), InstrD(24 downto 20), InstrD(11 downto 7), ImmExtD, InstrD(14 downto 12), PCPlus4D, RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcAE, ALUSrcBE, jumpTypeE, RD1E, RD2E, PCE, RS1E, RS2E, RdE, ImmExtE, func3E, PCPlus4E);
	-- EM Register
	EM: EMRegister port map(clk, rst, RegWriteE, ResultSrcE, MemWriteE, ALUResultE, WriteDataE, RdE, func3E, PCPlus4E, RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM, func3M, PCPlus4M);
	-- MW Register
	MW: MWRegister port map(clk, rst, RegWriteM, ResultSrcM, ALUResultM, ReadDataM, RdM, PCPlus4M, RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W);
	-- Hazard unit
	HU: HazardUnit port map(rst, InstrD(19 downto 15), InstrD(24 downto 20), RS1E, RS2E, RdE, RdM, RdW, RegWriteM, RegWriteW, ResultSrcE, PCSrcE, ForwardAE, ForwardBE, StallF, StallD, FlushD, FlushE);
	-- Brancher
	BR: Brancher port map(SrcAE(31), SrcBE(31), ALUResultE(31), ZeroE, CoutE, JumpE, BranchE, func3E, PCSrcE);
	--Multiplexer per il PC
	PCNextF <= PCTargetE when PCSrcE = '1' else PCPlus4F;
	-- Incremento di 4 per il PC
	PCplus4F <= std_logic_vector(unsigned(PCF) + 4);
	-- Multiplexer per il forwarding del primo registro
	ReadFirE <= ResultW when ForwardAE = "01" else
		 ALUResultM when ForwardAE = "10" else RD1E;
	-- Multiplexer per il forwarding del secondo registro
	WriteDataE <= ResultW when ForwardBE = "01" else
		 ALUResultM when ForwardBE = "10" else RD2E;
	-- Multiplexer per la SrcA della ALU
	SrcAE <= ReadFirE when ALUSrcAE = "00" else
	        PCE when ALUSrcAE = "01" else
	        (others => '0');
	-- Multiplexer per la SrcB della ALU
	SrcBE <= ImmExtE when ALUSrcbE = '1' else WriteDataE;
	-- Multiplexer per la somma del PC
	sumPCE <= ReadFirE when jumpTypeE = '1' else (others => '0');    
        -- Quantità da sommare al PC
        ImmPCE <= std_logic_vector(unsigned(sumPCE) + unsigned(ImmExtE));     
        -- Target eventuale per il PC
        PCTargetE <= ImmPcE when jumpTypeE = '1' else
        	     std_logic_vector(unsigned(ImmPCE) + unsigned(PCE));
        -- Multiplexer per il risultat finale
        ResultW <= ReadDataW when ResultSrcW = "01" else
                  PCPlus4W when ResultSrcW = "10" else ALUResultW; 
						
-- Process per il display su scheda
process(clk, switchon, outSig)
begin
	if (rising_edge(clk)) then
	if (switchon = '1') then 

		-- Prima cifra 
		case outSig(3 downto 0) is
			 when "0000" => num0 <= not "0111111";
			 when "0001" => num0 <= not "0000110";
			 when "0010" => num0 <= not "1011011";
			 when "0011" => num0 <= not "1001111";
			 when "0100" => num0 <= not "1100110";
			 when "0101" => num0 <= not "1101101";
			 when "0110" => num0 <= not "1111101";
			 when "0111" => num0 <= not "0000111";
			 when "1000" => num0 <= not "1111111";
			 when "1001" => num0 <= not "1101111";
			 when "1010" => num0 <= not "1110111";
			 when "1011" => num0 <= not "1111111";
			 when "1100" => num0 <= not "0111001";
			 when "1101" => num0 <= not "0111111";
			 when "1110" => num0 <= not "1111001";
			 when "1111" => num0 <= not "1110001";
			 when others => num0 <= (others => '1');
		end case;

		-- Seconda cifra 
		case outSig(7 downto 4) is
			 when "0000" => num1 <= not "0111111";
			 when "0001" => num1 <= not "0000110";
			 when "0010" => num1 <= not "1011011";
			 when "0011" => num1 <= not "1001111";
			 when "0100" => num1 <= not "1100110";
			 when "0101" => num1 <= not "1101101";
			 when "0110" => num1 <= not "1111101";
			 when "0111" => num1 <= not "0000111";
			 when "1000" => num1 <= not "1111111";
			 when "1001" => num1 <= not "1101111";
			 when "1010" => num1 <= not "1110111";
			 when "1011" => num1 <= not "1111111";
			 when "1100" => num1 <= not "0111001";
			 when "1101" => num1 <= not "0111111";
			 when "1110" => num1 <= not "1111001";
			 when "1111" => num1 <= not "1110001";
			 when others => num1 <= (others => '1');
		end case;

		-- Terza cifra 
		case outSig(11 downto 8) is
			 when "0000" => num2 <= not "0111111";
			 when "0001" => num2 <= not "0000110";
			 when "0010" => num2 <= not "1011011";
			 when "0011" => num2 <= not "1001111";
			 when "0100" => num2 <= not "1100110";
			 when "0101" => num2 <= not "1101101";
			 when "0110" => num2 <= not "1111101";
			 when "0111" => num2 <= not "0000111";
			 when "1000" => num2 <= not "1111111";
			 when "1001" => num2 <= not "1101111";
			 when "1010" => num2 <= not "1110111";
			 when "1011" => num2 <= not "1111111";
			 when "1100" => num2 <= not "0111001";
			 when "1101" => num2 <= not "0111111";
			 when "1110" => num2 <= not "1111001";
			 when "1111" => num2 <= not "1110001";
			 when others => num2 <= (others => '1');
		end case;

		-- Quarta cifra 
		case outSig(15 downto 12) is
			 when "0000" => num3 <= not "0111111";
			 when "0001" => num3 <= not "0000110";
			 when "0010" => num3 <= not "1011011";
			 when "0011" => num3 <= not "1001111";
			 when "0100" => num3 <= not "1100110";
			 when "0101" => num3 <= not "1101101";
			 when "0110" => num3 <= not "1111101";
			 when "0111" => num3 <= not "0000111";
			 when "1000" => num3 <= not "1111111";
			 when "1001" => num3 <= not "1101111";
			 when "1010" => num3 <= not "1110111";
			 when "1011" => num3 <= not "1111111";
			 when "1100" => num3 <= not "0111001";
			 when "1101" => num3 <= not "0111111";
			 when "1110" => num3 <= not "1111001";
			 when "1111" => num3 <= not "1110001";
			 when others => num3 <= (others => '1');
		end case;

		-- Quinta cifra
		case outSig(19 downto 16) is
			 when "0000" => num4 <= not "0111111";
			 when "0001" => num4 <= not "0000110";
			 when "0010" => num4 <= not "1011011";
			 when "0011" => num4 <= not "1001111";
			 when "0100" => num4 <= not "1100110";
			 when "0101" => num4 <= not "1101101";
			 when "0110" => num4 <= not "1111101";
			 when "0111" => num4 <= not "0000111";
			 when "1000" => num4 <= not "1111111";
			 when "1001" => num4 <= not "1101111";
			 when "1010" => num4 <= not "1110111";
			 when "1011" => num4 <= not "1111111";
			 when "1100" => num4 <= not "0111001";
			 when "1101" => num4 <= not "0111111";
			 when "1110" => num4 <= not "1111001";
			 when "1111" => num4 <= not "1110001";
			 when others => num4 <= (others => '1');
		end case;

		-- Sesta cifra
		case outSig(23 downto 20) is
			 when "0000" => num5 <= not "0111111";
			 when "0001" => num5 <= not "0000110";
			 when "0010" => num5 <= not "1011011";
			 when "0011" => num5 <= not "1001111";
			 when "0100" => num5 <= not "1100110";
			 when "0101" => num5 <= not "1101101";
			 when "0110" => num5 <= not "1111101";
			 when "0111" => num5 <= not "0000111";
			 when "1000" => num5 <= not "1111111";
			 when "1001" => num5 <= not "1101111";
			 when "1010" => num5 <= not "1110111";
			 when "1011" => num5 <= not "1111111";
			 when "1100" => num5 <= not "0111001";
			 when "1101" => num5 <= not "0111111";
			 when "1110" => num5 <= not "1111001";
			 when "1111" => num5 <= not "1110001";
			 when others => num5 <= (others => '1');
		end case;
	else
		num0 <= (others => '1');
		num1 <= (others => '1');
		num2 <= (others => '1');
		num3 <= (others => '1');
		num4 <= (others => '1');
		num5 <= (others => '1');
	end if;
	end if;
end process;	
end funcCpu;
