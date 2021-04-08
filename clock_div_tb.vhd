--
-- filename:    blinker_tb.vhd
-- written by:  steve dinicolantonio
-- description: testbench for blinker.vhd
-- notes:       
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity blinker_tb is
end blinker_tb;

architecture testbench of blinker_tb is

    signal tb_clk : std_logic := '0';
    signal tb_count  : std_logic := '0';
    
    component clock_div is
        port (
      clk : in std_logic;
      div : out std_logic
    );
    end component;

begin

--------------------------------------------------------------------------------
-- procs
--------------------------------------------------------------------------------

    -- simulate a 125 Mhz clock
    clk_gen_proc: process
    begin
    
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';
    end process clk_gen_proc;
    
   
    
--------------------------------------------------------------------------------
-- port mapping
--------------------------------------------------------------------------------

    dut : clock_div
    port map (
    
        clk  => tb_clk,
        div => tb_count
    
    );

    
end testbench; 
