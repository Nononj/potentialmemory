library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std;
use work.FloatPt.all;

entity mppt2 is port(
	vpv : in numeric_std.signed(15 downto 0);
	ipv : in numeric_std.signed(15 downto 0);
	clock : in std_logic;
	reset : in std_logic;
	
	done : out std_logic;
	ref : out numeric_std.signed(15 downto 0));
end mppt2;

architecture Behavioral of mppt2 is
--	signal pvp : std_logic_vector(15 downto 0);
	signal vpv_pt : std_logic_vector( 31 downto 0);
	signal ipv_pt : std_logic_vector(31 downto 0);
	signal res_32 : std_logic_vector(31 downto 0);
	signal go_mul: std_logic;
	
begin
	
	MUL1 : FPP_MULT port map
	(	
		A => vpv_pt, 
		B => ipv_pt,
		clk => clock, 
		reset => reset,
		go => go_mul,
		done => done,
		overflow => open, 
		result => res_32
	);
	
	process
	begin
		wait for 20 ns;
		vpv_pt <= SIGNED_TO_FP(vpv);
		ipv_pt <= SIGNED_TO_FP(ipv);
		wait for 22 ns;
		go_mul <= '1';
	end process;
	
	process(res_32)
	begin
		ref <= FP_TO_SIGNED(res_32, 16);
	end process;
end Behavioral;

	
