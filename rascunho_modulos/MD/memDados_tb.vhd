LIBRARY ieee;                                                
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all;            

ENTITY memDados_tb IS 
END memDados_tb; 

ARCHITECTURE tb_arch OF memDados_tb IS 

	--signals
	SIGNAL address : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL clock : STD_LOGIC;
	SIGNAL data : STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL wren : STD_LOGIC;
	SIGNAL q : STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	COMPONENT memDados IS
		PORT ( address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
				 clock		: IN STD_LOGIC  := '1';
				 data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
				 wren		: IN STD_LOGIC ;
				 q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
	begin i1 : memDados PORT MAP (address => address, clock => clock, data => data, wren => wren, q => q);
	
   init : process
   BEGIN
		--reset passo 0
		clock <= '0';
		data <= X"0000FFFF";
		wren <= '0';
		wait for 4 ps;
		
		address <= X"00";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"01";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"02";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"03";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"04";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"05";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"06";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"07";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"08";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"09";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"10";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
		address <= X"11";
		clock <= '1';
		wait for 4 ps;
		clock <= '0';
		wait for 4 ps;
		
	END PROCESS init; 
end tb_arch; 