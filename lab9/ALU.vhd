library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    generic(
        BinaryCap       :   integer 
    );
    port(
        EN      :   in  std_logic; -- Enable
        SEL     :   in  std_logic( 1 downto 0); -- Selector
        SW      :   in  std_logic(BinaryCap - 1 downto 0); -- Switch
        DSW     :   in  std_logic(BinaryCap - 1 downto 0); -- DIP Switch
        output  :   out std_logic(BinaryCap - 1 downto 0)
    );
end ALU;

architecture RTL of ALU is
    function twoComplement(Bits : std_logic_vector( BinaryCap - 1 downto 0 ) )
        return std_logic_vector is
            variable Binary : std_logic_vector(BinaryCap - 1 downto 0);
    begin
        Binary := std_logic_vector(unsigned(not(Bits)) + 1);  -- invert and then plus 1
        return Binary;
    end function twoComplement;
    

begin
    process(EN,SEL,SW,DSW)
    begin
        if EN = '1' then
            if SEL = "00" then --ADD
                output <= std_logic_vector(unsigned(SW) + unsigned(DSW));
            
            elsif SEL = "01" then --SUBTRACT
                output <= std_logic_vector(unsigned(SW) + unsigned(twoComplement(DSW)));
            
            elsif SEL = "10" then --XOR
                output <= SW xor DSW;
            
            elsif SEL = "11" then --SHL for SW
                output <= std_logic_vector(shift_left(unsigned(SW),1));

            end if;
        else
            output <= (others => '0');
        end if;
        
    end process;
    
end architecture RTL;

