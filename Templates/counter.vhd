library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_to_n is
    port(
        clk     :   in  std_logic;
        count   :   out std_logic_vector(3 downto 0)    -- (N used-bits - 1) downto 0
    );
    
end counter_to_n;
	 
architecture RTL of counter_to_n is
    signal   counter      :   unsigned(3 downto 0)	:= (others => '0'); -- As same as count port
    constant DNum_int     :   integer := 15;   --desired Number
    constant DNum         :   unsigned(3 downto 0) :=  to_unsigned(DNum_int,4);     --4 is N used-bits
    begin
	 
		  process(clk)
		  begin
			if  rising_edge(clk) then
            if  counter =   DNum then
                counter <=  (others => '0');
            else
                counter <=  counter + 1;
            end if;
        end if;
    end process;
    count   <=  std_logic_vector(counter);
end architecture RTL;