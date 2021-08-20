LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

-- Hexadecimal to 7 Segment Decoder for LED Display
-- Always shows nothing

ENTITY HEX_NOSHOW IS
  PORT( segments : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END HEX_NOSHOW;

ARCHITECTURE a OF HEX_NOSHOW IS

BEGIN
	segments <= "1111111";
END a;