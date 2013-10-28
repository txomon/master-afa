--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:54:35 10/28/2013
-- Design Name:   
-- Module Name:   /home/javier/proyectos/master/master-afa/multiplier_01/test_multiplier.vhd
-- Project Name:  multiplier_01
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: multiplier
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
 
ENTITY test_multiplier IS
END test_multiplier;
 
ARCHITECTURE behavior OF test_multiplier IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT multiplier
    PORT(
         a : IN  std_logic_vector(2 downto 0);
         b : IN  std_logic_vector(2 downto 0);
         result : OUT  std_logic_vector(5 downto 0);
         in_pss : OUT  std_logic_vector(15 downto 0);
         in_css : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(2 downto 0) := (others => '0');
   signal b : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(5 downto 0);
   signal in_pss : std_logic_vector(15 downto 0);
   signal in_css : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: multiplier PORT MAP (
          a => a,
          b => b,
          result => result,
          in_pss => in_pss,
          in_css => in_css
        );

   -- Stimulus process
   stim_proc: process
   begin		
      a <= "101";
      b <= "100";
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      a <= "010";
      b <= "111";
      wait for 100 ns;	

      a <= "110";
      b <= "111";
      -- insert stimulus here 

      wait;
   end process;

END;
