library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 
use work.rv_pkg.all;
use work.imm_pkg.all;
use work.xregs_pkg.all;

entity UNICICLO_RV is
	port (
		);
end UNICICLO_RV; 

architecture behavioral of UNICICLO_RV is

	COMPONENT ULA_RV
		PORT ( opcode : IN ULA_OP;
				 a : IN STD_LOGIC_VECTOR(31 downto 0);
				 b : IN STD_LOGIC_VECTOR(31 downto 0);
				 z : OUT STD_LOGIC_VECTOR(31 downto 0);
				 zero : OUT STD_LOGIC); 
	END COMPONENT;
	
	COMPONENT genImm32
		PORT ( instr:  in  std_logic_vector(31 downto 0);
				 imm32:	out signed(31 downto 0));
	END COMPONENT;

	COMPONENT XREGS
		PORT ( clk, wren, rst : in std_logic;
				 rs1, rs2, rd : in std_logic_vector(4 downto 0);
				 data : in std_logic_vector(31 downto 0);
				 ro1, ro2 : out std_logic_vector(31 downto 0));
	END COMPONENT;
	
	COMPONENT memIns
		PORT ( 
				address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
				clock		: IN STD_LOGIC  := '1';
				data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
				wren		: IN STD_LOGIC ;
				q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
begin

	
	
end behavioral;
