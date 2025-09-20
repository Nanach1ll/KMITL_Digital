library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity main is
    generic(
        Bits    :   integer
    );
    port(
        clkin       :   in  integer;
        SW          :   in  std_logic_vector(Bits - 1 downto 0);
        DSW         :   in  std_logic_vector(Bits - 1 downto 0);
        SevenSeg    :   out std_logic_vector(7 downto 0)
    );
end entity;

architecture RTL of main is 
    constant BitAmount : integer := 8;
    component ALU is
        port(
            EN      :   in  std_logic; -- Enable
            SEL     :   in  std_logic( 1 downto 0); -- Selector
            SW      :   in  std_logic(BinaryCap - 1 downto 0); -- Switch
            DSW     :   in  std_logic(BinaryCap - 1 downto 0); -- DIP Switch
            output  :   out std_logic(BinaryCap - 1 downto 0)
        );
    end component;

    component BCDtoSevenSeg is
        port(
            AtoG    :   std_logic_vector(7 downto 0) --
        );
    end component;

    component MODN is
        port(
            bitsIn  :   std_logic_vector(hi downto 0)
        );
    end component;
begin
    
end architecture RTL;
