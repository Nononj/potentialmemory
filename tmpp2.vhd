library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_std;

entity tmppt2 is
end tmppt2;



architecture Behavioral of tmppt2 is

	component mppt2 is port(
		vpv : in numeric_std.signed(15 downto 0);
		ipv : in numeric_std.signed(15 downto 0);
		clock : in std_logic;
		reset : in std_logic;
	
		done : out std_logic;
		ref : out numeric_std.signed(15 downto 0));
	end component;

	signal tclock : std_logic;
	signal tvpv : numeric_std.signed(15 downto 0);
	signal tipv : numeric_std.signed(15 downto 0);
	signal tref :   numeric_std.signed(15 downto 0);
	signal treset : std_logic;
	signal tdone : std_logic;
	
	begin
	inst : mppt2 port map (
		clock => tclock,
		vpv => tvpv,
		ipv => tipv,
		ref => tref,
		reset => treset,
		done => tdone 
		);

	process
  	begin
  		tclock <= '0';
  		wait for 5 ns;
  		tclock <= '1';
  		wait for 5 ns;
 	end process;
	
	process
  	begin
		wait for 10 ns;
			tvpv <="0000000000000011" ;
			tipv <="0000000000011111" ;
		wait for 100 ns;
	end process;
	
end Behavioral;
	
	
