LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

-- Hexadecimal to 7 Segment Decoder for LED Display, denote flat
--  1) when free held low, displays latched data
--  2) when free held high, constantly displays input (free-run)
--  3) data is latched on rising edge of CS

ENTITY HEX_FLAT IS
  PORT( switches : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        cs       : IN STD_LOGIC := '0';
        free     : IN STD_LOGIC := '0';
        resetn   : IN STD_LOGIC := '1';
        segments : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END HEX_FLAT;

ARCHITECTURE a OF HEX_FLAT IS
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
    segments <= "0000011" WHEN "000001" | "000011" | "000110" | "001000"
					  | "001010" | "001101" | "001111" | "010010"
					  | "010100" | "010110" | "011001" | "011011" 
					  | "011110" | "100000" | "100010" | "100101"
					  | "100111" | "101010" | "101100" | "101110"
					  | "110001" | "110011" | "110110" | "111000"
					  | "111010",
                "1111111" WHEN OTHERS;
END a;