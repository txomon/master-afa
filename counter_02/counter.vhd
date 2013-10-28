----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:59:48 10/28/2013 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY counter IS
  PORT ( 
    rst : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    ctl : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    cnt : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END counter;

ARCHITECTURE behavioral OF counter IS
  SIGNAL in_cnt : UNSIGNED(7 DOWNTO 0) := (OTHERS => '0');
BEGIN
  PROCESS(clk)
  BEGIN
    IF RISING_EDGE(clk) THEN
      IF rst = '1' THEN
        in_cnt <= (OTHERS => '0');
      ELSIF ctl = "01" THEN
        in_cnt <= in_cnt + 1;
      ELSIF ctl = "10" THEN
        in_cnt <= in_cnt - 1;
      END IF;
    END IF;
  END PROCESS;
  
  cnt <= CONV_STD_LOGIC_VECTOR(in_cnt,8);
END behavioral;