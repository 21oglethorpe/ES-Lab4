----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2021 03:29:53 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
Port (  clk, en: in std_logic;
        hcount, vcount:out std_logic_vector(9 downto 0) ;
        vid, hs, vs: out std_logic);
end vga_ctrl;

architecture Behavioral of vga_ctrl is
signal hreg, vreg : std_logic_vector(9 downto 0):= (others => '0');
begin
hcount <= hreg;
vcount <= vreg;
process(clk)
begin
    if rising_edge(clk) then
    if(en = '1') then
        if(unsigned(hreg) < 799) then
            hreg <= std_logic_vector(unsigned(hreg)+1);
        else
            hreg <= (others => '0');
            if(unsigned(vreg) < 524) then
                  vreg <= std_logic_vector(unsigned(vreg)+1);
            else
                  vreg <= (others => '0');
             end if;
        end if;
    end if;
    if(unsigned(hreg) < 640 AND unsigned(vreg) < 480) then
    vid <= '1';
    else
    vid <= '0';
    end if;
    if(unsigned(hreg) < 656 OR unsigned(hreg) > 751) then
        hs <= '1';
    else
        hs <= '0';
    end if;
    if(unsigned(hreg) = 490 OR unsigned(hreg) = 491) then
        vs <= '0';
    else
        vs <= '1';
    end if;
    end if;
end process;
end Behavioral;
