----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:11:29 10/28/2013 
-- Design Name: 
-- Module Name:    frecuency - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frequency is
    Port (
      clk : in  STD_LOGIC;
      ctl : in  STD_LOGIC_VECTOR (1 downto 0);
      output : out  STD_LOGIC
    );
end frequency;

architecture Behavioral of frequency is
  signal in_cnt : unsigned(1 downto 0) := (others => '0');
  signal in_output : std_logic;
  signal in_ctl : std_logic_vector(1 downto 0):= (others => '0');
begin
  PROCESS(clk)
    begin
      if rising_edge(clk) then
        if in_cnt = unsigned(in_ctl) then
          in_cnt <= (others => '0');
          in_ctl <= ctl;
        else
          in_cnt <= in_cnt + 1;
        end if;
      end if;
    end process;
    
  in_output <= '1' when in_cnt = 0 else '0';
  
  output <= '0' when in_ctl = "00" else in_output;
            
end Behavioral;