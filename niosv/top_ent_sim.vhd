library ieee;
use ieee.std_logic_1164.all;

entity top_ent is
    port (
        CLOCK_50 : in  std_logic;
        RESET_N  : in  std_logic;
        HEX0     : out std_logic_vector(6 downto 0);
        HEX1     : out std_logic_vector(6 downto 0);
        HEX2     : out std_logic_vector(6 downto 0);
        HEX3     : out std_logic_vector(6 downto 0);
        HEX4     : out std_logic_vector(6 downto 0);
        HEX5     : out std_logic_vector(6 downto 0)
    );
end entity;

architecture rtl of top_ent is

    -- Segnale che sostituisce "outSig": è l'uscita a 32 bit della periferica PIO del Nios V
    signal PIO : std_logic_vector(31 downto 0);

    -- Registri interni per le cifre del display (uno per ciascun HEX)
    signal num0, num1, num2, num3, num4, num5 : std_logic_vector(6 downto 0);

begin

    -- Istanza del sistema Nios V: il PIO in uscita viene collegato al segnale interno "PIO"
    u0 : entity work.niosv
        port map (
            clk_clk                          => CLOCK_50,
            reset_reset_n                     => RESET_N,
            pio_0_external_connection_export  => PIO
        );

    -- Process per il display su scheda (uguale all'originale,
    -- ma la sorgente dei dati è ora "PIO" invece di "outSig")
    process(CLOCK_50)
    begin
        if (rising_edge(CLOCK_50)) then
				if (RESET_N = '1') then
                -- Prima cifra
                case PIO(3 downto 0) is
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
                case PIO(7 downto 4) is
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
                case PIO(11 downto 8) is
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
                case PIO(15 downto 12) is
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
                case PIO(19 downto 16) is
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
                case PIO(23 downto 20) is
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

    -- Collegamento dei registri interni ai pin fisici del display
    HEX0 <= num0;
    HEX1 <= num1;
    HEX2 <= num2;
    HEX3 <= num3;
    HEX4 <= num4;
    HEX5 <= num5;

end architecture;