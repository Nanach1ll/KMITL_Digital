library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity SevenSegController is 
    port(
        clkin   : in  std_logic;                    -- clk
        common  : out std_logic_vector(3 downto 0); -- common 0 - 3
        AtoG    : out std_logic_vector(6 downto 0); -- Segments a..g,dp
        Inp     : in  std_logic_vector(7 downto 0)  -- hex input
    );
end SevenSegController;

architecture RTL of SevenSegController is  
    signal nibble   :   std_logic_vector(3 downto 0);
    signal MOD2     :   std_logic := '0';
    signal counter  :   unsigned(15 downto 0) := (others => '0');
begin
    process(clkin)
    begin
        if rising_edge(clkin) then
            counter <= counter + 1;
            MOD2    <= counter(15);
        end if;
    end process;
    process(Inp,MOD2)
    begin

        if MOD2 = '0' then
            common <= "10";
            nibble <= Inp(3 downto 0);
        else
            common <= "01";
            nibble <= Inp(7 downto 4);
        end if;

        case nibble is
            when "0000" => AtoG <= "1111110"; -- 0
            when "0001" => AtoG <= "0110000"; -- 1
            when "0010" => AtoG <= "1101101"; -- 2
            when "0011" => AtoG <= "1111001"; -- 3
            when "0100" => AtoG <= "0110011"; -- 4
            when "0101" => AtoG <= "1011011"; -- 5
            when "0110" => AtoG <= "1011111"; -- 6
            when "0111" => AtoG <= "1110000"; -- 7
            when "1000" => AtoG <= "1111111"; -- 8
            when "1001" => AtoG <= "1111011"; -- 9
            when "1010" => AtoG <= "1110111"; -- A
            when "1011" => AtoG <= "0011111"; -- b
            when "1100" => AtoG <= "1001110"; -- C
            when "1101" => AtoG <= "0111101"; -- d
            when "1110" => AtoG <= "1001111"; -- E
            when "1111" => AtoG <= "1000111"; -- F
            when others => AtoG <= "0000000"; -- blank
        end case;
    end process;
end architecture RTL;
