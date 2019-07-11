library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

ENTITY PC IS PORT(
    d   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clr : IN STD_LOGIC; -- clear.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END PC;

ARCHITECTURE arch OF PC IS

BEGIN
    process(clk, clr)
    begin
        if clr = '1' then
            q <= x"00000000";
        elsif rising_edge(clk) then
            q <= d;
        end if;
    end process;
END arch;