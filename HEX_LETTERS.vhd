LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

-- Hexadecimal to 7 Segment Decoder for LED Display, denote flat
--  1) when free held low, displays latched data
--  2) when free held high, constantly displays input (free-run)
--  3) data is latched on rising edge of CS

ENTITY HEX_LETTERS IS
  PORT( switches : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        cs       : IN STD_LOGIC := '0';
        free     : IN STD_LOGIC := '0';
        resetn   : IN STD_LOGIC := '1';
        segments : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END HEX_LETTERS;

ARCHITECTURE a OF HEX_LETTERS IS
  SIGNAL latched_hex : STD_LOGIC_VECTOR(5 DOWNTO 0);

BEGIN

  PROCESS (resetn, cs)
  BEGIN
    IF (resetn = '0') THEN
      latched_hex <= "000000";
    ELSIF ( RISING_EDGE(cs) ) THEN
      latched_hex <= switches;
    END IF;
  END PROCESS;
 
 
           
  WITH latched_hex SELECT
    segments <= "0001000" WHEN "001000" | "001001" | "010100" | "010101" | "100000" | "100001" | "101100" | "101101" | "111000" | "111001", --a
                "0000000" WHEN "001010" | "001011" | "010110" | "010111" | "100010" | "100011" | "101110" | "101111" | "111010" | "111011", --b
                "1000110" WHEN "000000" | "001100" | "011000" | "100100" | "110000" | "111100", --c
                "0100001" WHEN "000001" | "000010" | "001101" | "001110" | "011001" | "011010" | "100101" | "100110" | "110001" | "110010", --d
                "0000110" WHEN "000011" | "000100" | "001111" | "010000" | "011011" | "011100" | "100111" | "101000" | "110011" | "110100", --e
                "0001110" WHEN "000101" | "010001" | "011101" | "101001" | "110101", --f
                "0000010" WHEN "000110" | "000111" | "010010" | "010011" | "011110" | "011111" | "101010" | "101011" | "110110" | "110111", --g
                "1111111" WHEN OTHERS; --none
END a;