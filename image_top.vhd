
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
        clk_n, clk_p, hdmi_out_en: out std_logic;
        n, p: out std_logic_vector (2 downto 0));
        
end image_top;

architecture Behavioral of image_top is
component clock_div
port (
  clk : in std_logic;
  div : out std_logic
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
component rgb2dvi_0
Port(vid_pData : in std_logic_vector(23 downto 0); 
     vid_pHSync, vid_pVSync,vid_pVDE : in std_logic;
    aRst,PixelClk,SerialClk : in std_logic; 
    TMDS_Clk_p : out std_logic; 
    TMDS_Clk_n : out std_logic; 
    TMDS_Data_p : out std_logic_vector(2 downto 0); 
    TMDS_Data_n : out std_logic_vector(2 downto 0)); 
end component;
component vga_ctrl
Port (  clk, en: in std_logic;
        hcount, vcount:out std_logic_vector(9 downto 0) ;
        vid, hs, vs: out std_logic);
end component;
signal en : std_logic;
signal addr : std_logic_vector(17 downto 0);
signal pixels : std_logic_vector(7 downto 0);
signal vid : std_logic;
signal hcount, vcount : std_logic_vector(9 downto 0);
signal vga_hs, vga_vs :  std_logic;
signal     vga_r, vga_b:  std_logic_vector(4 downto 0);
signal    vga_g:  std_logic_vector(5 downto 0);
signal full_data: std_logic_vector(23 downto 0);
signal r, g, b : std_logic_vector(7 downto 0);
begin
--r <= std_logic_vector(unsigned(vga_r)*255/31);
--b <= std_logic_vector(unsigned(vga_b)*255/31);
--g <= std_logic_vector(unsigned(vga_g)*255/63);
r <=  vga_r & "000";
b <= vga_b & "000";
g <= vga_g & "00";
hdmi_out_en <= '1';
full_data <= r & g & b;
Two5mHz : clock_div
port map(clk => clk, div => en); 
u2 : picture
port map(clka => clk, addra => addr, douta => pixels);
u3: pixel_pusher
port map(clk => clk, en => en, VS => vga_vs, vid => vid, pixel => pixels, hcount => hcount, addr => addr,
R => vga_r, B => vga_b, G => vga_g);
u4: vga_ctrl
port map(clk => clk, en => en, hs => vga_hs, vs => vga_vs, vid => vid, hcount => hcount, vcount => vcount);
u5: rgb2dvi_0
port map(vid_pData => full_data, 
         vid_pHSync => vga_hs,
         vid_pVSync => vga_vs,
         vid_pVDE => vid,
         aRst => '0', 
         SerialClk => clk, 
         PixelClk => en,
         TMDS_Clk_p => clk_p,
         TMDS_Clk_n => clk_n, 
         TMDS_Data_p => p,
         TMDS_Data_n => n);
end Behavioral;
