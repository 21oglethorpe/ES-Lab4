
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top is
Port ( clk: in std_logic;
        vga_hs, vga_vs : out std_logic;
        vga_r, vga_b: out std_logic_vector(4 downto 0);
        vga_g: out std_logic_vector(5 downto 0));
end image_top;

architecture Behavioral of image_top is
component clock_div
port (
  clk : in std_logic;
  div : out std_logic :='0'
);
end component;
component picture
 PORT (
   clka : IN STD_LOGIC;
   addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
   douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
 );
end component;
component pixel_pusher
Port (  clk, en, VS, vid: in std_logic;
	pixel : in std_logic_vector(7 downto 0);

	hcount : in std_logic_vector(9 downto 0);
        R, B: out std_logic_vector(4 downto 0) ;
	G : out std_logic_vector(5 downto 0);
        addr: out std_logic_vector(17 downto 0));
end component;
component vga_ctrl
Port (  clk, en: in std_logic;
        hcount, vcount:out std_logic_vector(9 downto 0) ;
        vid, hs, vs: out std_logic);
end component;
signal en : std_logic;
signal addr : std_logic_vector(17 downto 0);
signal pixels : std_logic_vector(7 downto 0);
signal vs, vid : std_logic;
signal hcount : std_logic_vector(9 downto 0);
begin
Two5mHz : clock_div
port map(clk => clk, div => en); 
u2 : picture
port map(clka => clk, addra => addr, douta => pixels);
u3: pixel_pusher
port map(clk => clk, en => en, VS => vs, vid => vid, pixel => pixels, hcount => hcount,
R => vga_r, B => vga_b, G => vga_g);
u4: vga_ctrl
port map(clk => clk, en => en, hs => vga_hs, vs => vga_vs, vid => vid, hcount => hcount);
end Behavioral;
