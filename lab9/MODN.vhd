library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity MODN is
    generic(
        Nbits : integer := 16;  -- number of bits 
        DNum  : integer := 10   -- modulus (e.g. MOD-10 counter)
    );
    port(
        clk     : in  std_logic;
        count   : out std_logic_vector(Nbits-1 downto 0); -- binary count value
        clkout  : out std_logic                           -- divided clock
    );
end entity MODN;

architecture RTL of MODN is
    signal counter : unsigned(Nbits-1 downto 0) := (others => '0');
    signal divclk  : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if counter = to_unsigned(DNum-1, Nbits) then
                counter <= (others => '0');  -- reset to 0
                divclk  <= not divclk;       -- toggle clkout
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    count  <= std_logic_vector(counter);
    clkout <= divclk;
end architecture RTL;
