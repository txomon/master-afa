LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY multiplier IS
  GENERIC (
    CONSTANT m :IN INTEGER := 3; -- Row
    CONSTANT n :IN INTEGER := 3 -- Col
  );
  PORT (
    SIGNAL a :IN STD_LOGIC_VECTOR(m-1 DOWNTO 0) := "101";
    SIGNAL b :IN STD_LOGIC_VECTOR(n-1 DOWNTO 0) := "110";
    SIGNAL result :OUT STD_LOGIC_VECTOR(m + n - 1 DOWNTO 0)
  );
END multiplier;

ARCHITECTURE behavioral OF multiplier IS
  COMPONENT simple_mult
    PORT (
      SIGNAL a :IN STD_LOGIC;
      SIGNAL b :IN STD_LOGIC;
      SIGNAL pin :IN STD_LOGIC;
      SIGNAL cin :IN STD_LOGIC;
      SIGNAL cout :OUT STD_LOGIC;
      SIGNAL pout :OUT STD_LOGIC
    );
   END COMPONENT;
   TYPE Matrix IS ARRAY(0 TO m, 0 TO n) OF STD_LOGIC;
   SIGNAL pss, css : Matrix; 
BEGIN

-- We first design how the matrix will be connected
--  p   |row,pin |
--      |col,pout|
--
--  |0,03|0,02|0,01|    
--  |2,12|1,11|0,10|    
--  ----------------    
--  |1,13|1,12|1,11|    
--  |2,22|1,21|0,20|    
--  ----------------    
--  |2,23|2,22|2,21|    
--  |2,32|1,31|0,30|    

--  c   |row, cin|
--      |row,cout|
--  
--  |0,02|0,01|0,00|    
--  |2,03|1,02|0,01|    
--  ----------------    
--  |1,12|1,11|1,10|    
--  |2,13|1,12|0,11|    
--  ----------------    
--  |2,22|2,21|2,20|    
--  |2,23|1,22|0,21| 

  ROW : FOR F IN 0 TO (m-1) GENERATE
    COL : FOR C IN 0 TO (n-1) GENERATE
      MUL : simple_mult
        PORT MAP (
           a => a(C),
           b => b(F),
           pin => pss(F, C+1),
           cin => css(F, C),
           cout => css(F, C+1),
           pout => pss(F+1, C)
         );
    END GENERATE COL;
  END GENERATE ROW;

-- Now we inter-connect some signasls, like inputs and outputs
  IN_ROW : FOR F IN 0 TO m GENERATE
    IN_COL : FOR C IN 0 TO n GENERATE

      -- pss inputs are 0
      IN_ROW_TOP : IF F=0 GENERATE
        pss(F, C) <= '0';
      END GENERATE IN_ROW_TOP;

      -- css inputs are 0 at right
      IN_COL_RIGHT : IF C=0 GENERATE
        css(F, C) <= '0';
      END GENERATE IN_COL_RIGHT;

      -- pss input is css output
      IN_COL_LEFT : IF C=n AND F<m-1  GENERATE
        pss(F+1, C) <= css(F, C);
      END GENERATE IN_COL_LEFT;

      -- Result is first of the first column
      IN_COL_RESULT : IF (C=0 AND F>0) GENERATE
        result(F-1) <= pss(F, C);
      END GENERATE IN_COL_RESULT;
      
      -- Result is the pss row
      IN_ROW_RESULT : IF (C<n AND F=m) GENERATE
        result(C+F-1) <= pss(F, C);
      END GENERATE IN_ROW_RESULT;

      -- And finally, the output is the carry
      IN_LAST_RESULT : IF (C=n AND F=m-1) GENERATE
        result(m+n-1) <= css(F, C);
      END GENERATE IN_LAST_RESULT;
    END GENERATE IN_COL;
  END GENERATE IN_ROW;
END behavioral;

