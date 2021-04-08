----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2021 02:19:12 AM
-- Design Name: 
-- Module Name: image_top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top_tb is
--  Port ( );
end image_top_tb;

architecture Behavioral of image_top_tb is
component image_top
Port ( clk: in std_logic;
        clk_n, clk_p, hdmi_out_en: out std_logic;
        n, p: out std_logic_vector (2 downto 0));
        end component;
signal clk, clk_n, clk_p, hdmi_out_en : std_logic;
signal n, p:  std_logic_vector(2 downto 0);


begin
clk_gen_proc: process
    begin
    
        wait for 4 ns;
        clk <= '1';
        
        wait for 4 ns;
        clk <= '0';
    end process clk_gen_proc;
    tb : image_top
    port map(clk => clk, clk_n => clk_n, clk_p => clk_p, hdmi_out_en => hdmi_out_en, n => n, p => p);
end Behavioral;
