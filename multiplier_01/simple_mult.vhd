LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY simple_mult IS
  PORT (
    SIGNAL a :IN STD_LOGIC;
    SIGNAL b :IN STD_LOGIC;
    SIGNAL pin :IN STD_LOGIC;
    SIGNAL cin :IN STD_LOGIC;
    SIGNAL cout :OUT STD_LOGIC;
    SIGNAL pout :OUT STD_LOGIC
  );
END simple_mult;

ARCHITECTURE behavioral OF simple_mult IS
  SIGNAL w, x, y, z : STD_LOGIC;
BEGIN
  w <= a AND b;
  x <= pin AND w;
  y <= pin XOR w;
  z <= y AND cin;
  cout <= x OR z;
  pout <= y XOR cin;
END behavioral;

