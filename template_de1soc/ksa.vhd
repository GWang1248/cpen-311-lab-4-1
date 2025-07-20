library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ksa is
  port(
    CLOCK_50            : in  std_logic;  -- Clock pin
    KEY                 : in  std_logic_vector(3 downto 0);  -- push button switches
    SW                 : in  std_logic_vector(9 downto 0);  -- slider switches
    LEDR : out std_logic_vector(9 downto 0);  -- red lights
    HEX0 : out std_logic_vector(6 downto 0);
    HEX1 : out std_logic_vector(6 downto 0);
    HEX2 : out std_logic_vector(6 downto 0);
    HEX3 : out std_logic_vector(6 downto 0);
    HEX4 : out std_logic_vector(6 downto 0);
    HEX5 : out std_logic_vector(6 downto 0));
end ksa;

architecture rtl of ksa is
   COMPONENT SevenSegmentDisplayDecoder IS
    PORT
    (
        ssOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        nIn : IN STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
    END COMPONENT;
	 
		component task_1 is
		port (
			clk : in std_logic;
			rst : in std_logic;
			start : in std_logic;
			s_address : out std_logic(7 downto 0);
			s_data : out std_logic(7 downto 0);
			s_wren : out std_logic;
			done : out std_logic;
		);
		end component;
   
    -- clock and reset signals  
	 signal clk, reset_n : std_logic;

begin

		clk <= CLOCK_50;
		reset_n <= KEY(3);

		U_TASK1: task_1
		port map(
			clk	<= CLOCK_50
			rst	<= KEY(3),
			start	<= KEY(0),
			s_address  <= s_address_signal,
         s_data     <= s_data_signal,
         s_wren     <= s_wren_signal,
         done       <= done_signal
		);
		
		U_DEC: SevenSegmentDisplayDecoder
		port map(
			ssOut => HEX0,
         nIn   => s_address_signal(3 downto 0)
		);
end RTL;
