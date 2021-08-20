LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

-- Hexadecimal to 7 Segment Decoder for LED Display
--  1) when free held low, displays latched data
--  2) when free held high, constantly displays input (free-run)
--  3) data is latched on rising edge of CS

ENTITY HEX_OCTAVE IS
  PORT( switches : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        cs       : IN STD_LOGIC := '0';
        free     : IN STD_LOGIC := '0';
        resetn   : IN STD_LOGIC := '1';
        segments : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END HEX_OCTAVE;

ARCHITECTURE a OF HEX_OCTAVE IS
  SIGNAL latched_hex : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL octave      : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL seven       : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL six         : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL five        : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL four        : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL three       : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL invalid     : STD_LOGIC_VECTOR(5 DOWNTO 0);

BEGIN
	
	seven <= "111011";
	six <= "101111";
	five <= "100011";
	four <= "010111";
	three <= "001011";
	invalid <= "111100";

	octave <= 
		"0000" when ((std_logic_vector(unsigned(switches))) > (std_logic_vector(unsigned(invalid)))) else
		"0111" when ((std_logic_vector(unsigned(switches))) > (std_logic_vector(unsigned(seven)))) else
		"0110" when ((std_logic_vector(unsigned(switches))) > (std_logic_vector(unsigned(six)))) else
		"0101" when ((std_logic_vector(unsigned(switches))) > (std_logic_vector(unsigned(five)))) else
		"0100" when ((std_logic_vector(unsigned(switches))) > (std_logic_vector(unsigned(four)))) else
		"0011" when ((std_logic_vector(unsigned(switches))) > (std_logic_vector(unsigned(three)))) else
		"0010";
--
--	IF (switches > "111011") THEN
--		octave <= "0111";
--	ELSIF (switches > "101111") THEN
--		octave <= "0110";
--	ELSIF (switches > "100011") THEN
--		octave <= "0101";
--	ELSIF (switches > "010111" THEN
--		octave <= "0100";
--	ELSIF (switches > "001011") THEN
--		octave <= "0011";
--	ELSE
--		octave <= "0010";
--	END IF;
--	 

  PROCESS (resetn, cs)
  BEGIN
    IF (resetn = '0') THEN
      latched_hex <= "0000";
    ELSIF ( RISING_EDGE(cs) ) THEN
      latched_hex <= octave;
    END IF;
  END PROCESS;
           
  WITH latched_hex SELECT
    segments <= "1111111" WHEN "0000",
                "1111001" WHEN "0001",
                "0100100" WHEN "0010",
                "0110000" WHEN "0011",
                "0011001" WHEN "0100",
                "0010010" WHEN "0101",
                "0000010" WHEN "0110",
                "1111000" WHEN "0111",
                "0000000" WHEN "1000",
                "0010000" WHEN "1001", 
                "0001000" WHEN "1010",
                "0000011" WHEN "1011", 
                "1000110" WHEN "1100", 
                "0100001" WHEN "1101", 
                "0000110" WHEN "1110", 
                "0001110" WHEN "1111", 
                "0111111" WHEN OTHERS;
END a;