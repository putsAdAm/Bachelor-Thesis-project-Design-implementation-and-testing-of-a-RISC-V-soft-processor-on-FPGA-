library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.memTypes.all;

entity t0 is
end entity;

architecture Behavioral of t0 is

    component CPU
        port (
            clk      : in std_logic;
            switchon : in std_logic;
				ctrl     : in std_logic;
            num0     : out std_logic_vector(6 downto 0);
            num1     : out std_logic_vector(6 downto 0);
            num2     : out std_logic_vector(6 downto 0);
            num3     : out std_logic_vector(6 downto 0);
            num4     : out std_logic_vector(6 downto 0);
            num5     : out std_logic_vector(6 downto 0)
        );
    end component;

    signal clk      : std_logic := '0';
	 signal ctrl     : std_logic := '1';
    signal switchon : std_logic := '1';
    signal num0     : std_logic_vector(6 downto 0) := (others => '0');
    signal num1     : std_logic_vector(6 downto 0) := (others => '0');
    signal num2     : std_logic_vector(6 downto 0) := (others => '0');
    signal num3     : std_logic_vector(6 downto 0) := (others => '0');
    signal num4     : std_logic_vector(6 downto 0) := (others => '0');
    signal num5     : std_logic_vector(6 downto 0) := (others => '0');

begin

    -- Clock
    clk_process : process
    begin
        while true loop
            clk  <= '0';
            wait for 5 ns;
            clk  <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- DUT
    DUT: CPU
        port map (
            clk      => clk,
            switchon => switchon,
				ctrl     => ctrl,
            num0     => num0,
            num1     => num1,
            num2     => num2,
            num3     => num3,
            num4     => num4,
            num5     => num5
        );

    -- Stimoli
stim_proc : process
begin
for i in 0 to 4 loop
    wait for 500 ns;

        ctrl <= '0';
        wait for 10 ns;   

        ctrl <= '1';
        wait for 10 ns; 
		  
end loop;

    -- Ferma il processo
    wait;

end process;

end;