--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:25:58 10/28/2013
-- Design Name:   
-- Module Name:   /home/javier/proyectos/master/master-afa/counter/test_counter.vhd
-- Project Name:  counter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter
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
USE ieee.std_logic_arith.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_counter IS
END test_counter;
 
ARCHITECTURE behavior OF test_counter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         ctl : IN  std_logic_vector(1 downto 0);
         cnt : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '1';
   signal clk : std_logic := '0';
   signal ctl : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal cnt : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter PORT MAP (
          rst => rst,
          clk => clk,
          ctl => ctl,
          cnt => cnt
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
      wait for clk_period;
      -- hold reset state for 100 ns.
      assert unsigned(cnt) = 0
        report "The counter in reset is not 0" 
        severity FAILURE;
      wait for clk_period*2;	
      
      rst <= '0';
      wait for clk_period;
      assert unsigned(cnt) = 0
        report "The counter in ctl is not 0" 
        severity FAILURE;
      wait for clk_period*2;

      ctl <= "01";
      wait for clk_period;
      assert 1 = unsigned(cnt)
        report "The counter in ctl=increasing is not 1 after 0" 
        severity FAILURE;
      wait for clk_period*2;
      
      rst <= '1';
      wait for clk_period*2;
      rst <= '0';
      ctl <= "10";
      wait for clk_period;
      assert cnt = (others => '1')
        report "The counter doesn't decrease correctly"
        severity FAILURE;
      
      wait;
   end process;

END;
