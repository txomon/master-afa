LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY alu IS
  GENERIC (
    CONSTANT n_bits :IN INTEGER := 8
  );
  
  PORT (
    SIGNAL a :IN STD_LOGIC_VECTOR(n_bits-1 DOWNTO 0) := "00010101";
    SIGNAL b :IN STD_LOGIC_VECTOR(n_bits-1 DOWNTO 0) := "10101010";
    SIGNAL opera :IN STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL cout :OUT STD_LOGIC;
    SIGNAL result :OUT STD_LOGIC_VECTOR(n_bits-1 DOWNTO 0)
  );
END alu;

ARCHITECTURE behavioral OF alu IS
  SIGNAL suma_resta :STD_LOGIC_VECTOR(n_bits-1 DOWNTO 0);
  SIGNAL min_max :STD_LOGIC_VECTOR(n_bits-1 DOWNTO 0);
  SIGNAL tmp_cout :STD_LOGIC_VECTOR(n_bits DOWNTO 0);
  SIGNAL f_opera :STD_LOGIC;
BEGIN
  f_opera <=  opera(0) OR opera(1);

  tmp_cout(0) <= f_opera;
  cout <= tmp_cout(n_bits-1);

  SUM : FOR I IN 0 TO (n_bits-1) GENERATE
    suma_resta(I) <= b(I) XOR f_opera XOR a(I) XOR tmp_cout(I);
    tmp_cout(I+1) <= (a(I) AND (b(I) XOR f_opera)) OR ((a(I) OR (b(I) XOR f_opera)) AND tmp_cout(I));
  END generate;
  
  min_max <= b WHEN tmp_cout(n_bits)=opera(0) ELSE a;
  
  WITH opera(1) SELECT
  result <= suma_resta WHEN '0', min_max WHEN '1', (OTHERS => '0') WHEN OTHERS;

END behavioral;
