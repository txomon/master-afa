--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:50:48 10/28/2013
-- Design Name:   
-- Module Name:   /home/javier/proyectos/master/master-afa/frecuency_02/test_frequency.vhd
-- Project Name:  frecuency
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: frecuency
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_frequency IS
END test_frequency;
 
ARCHITECTURE behavior OF test_frequency IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT frequency
    PORT(
         clk : IN  std_logic;
         ctl : IN  std_logic_vector(1 downto 0);
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ctl : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: frequency PORT MAP (
          clk => clk,
          ctl => ctl,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      ctl <= "01";
      wait for clk_period*10;
      
      ctl <= "10";
      wait for clk_period*10;
      
      ctl <= "11";
      wait for clk_period*10;
      
      wait;
   end process;

END;
