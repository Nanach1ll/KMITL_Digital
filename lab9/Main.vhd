library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity Main is
    port(
        clkin    : in  std_logic;                     -- main clock
        SW       : in  std_logic_vector(7 downto 0);  -- operand A (switch)
        DSW      : in  std_logic_vector(7 downto 0);  -- operand B (dip switch)
        BTN      : in  std_logic;                     -- single button to toggle operation
        common   : out std_logic_vector(3 downto 0);  -- seven segment commons
        AtoG     : out std_logic_vector(6 downto 0)   -- seven segment segments
    );
end entity Main;

architecture RTL of Main is
    -- ALU component
    component ALU is
        generic(
            BinaryCap : integer := 8
        );
        port(
            EN     : in  std_logic;
            SEL    : in  std_logic_vector(1 downto 0);
            SW     : in  std_logic_vector(BinaryCap-1 downto 0);
            DSW    : in  std_logic_vector(BinaryCap-1 downto 0);
            output : out std_logic_vector(BinaryCap-1 downto 0)
        );
    end component;

    component MODN is
        generic(
            Nbits : integer := 16;
            DNum  : integer := 2
        );
        port(
            clk    : in  std_logic;
            count  : out std_logic_vector(Nbits-1 downto 0);
            clkout : out std_logic
        );
    end component;

    component SevenSegController is
        port(
            clkin  : in  std_logic;
            common : out std_logic_vector(3 downto 0);
            AtoG   : out std_logic_vector(6 downto 0);
            Inp    : in  std_logic_vector(7 downto 0)
        );
    end component;

    signal alu_out   : std_logic_vector(7 downto 0);
    signal slow_clk  : std_logic;
    signal dummy_cnt : std_logic_vector(15 downto 0);


    signal SEL        : std_logic_vector(1 downto 0) := "00";
    signal btn_prev   : std_logic := '0';

begin
    process(clkin)
    begin
        if rising_edge(clkin) then
            if BTN = '1' and btn_prev = '0' then
                SEL <= std_logic_vector(unsigned(SEL) + 1);
            end if;
            btn_prev <= BTN;
        end if;
    end process;

    U_ALU: ALU
        generic map(BinaryCap => 8)
        port map(
            EN     => '1',
            SEL    => SEL,
            SW     => SW,
            DSW    => DSW,
            output => alu_out
        );

    U_DIV: MODN
        generic map(Nbits => 16, DNum => 2)
        port map(
            clk    => clkin,
            count  => dummy_cnt,
            clkout => slow_clk
        );

    U_SSEG: SevenSegController
        port map(
            clkin  => slow_clk,
            common => common,
            AtoG   => AtoG,
            Inp    => alu_out
        );

end architecture RTL;
