
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD is
    Port (
        CLK     : in  STD_LOGIC;
        RST     : in  STD_LOGIC;
        HUN_OUT : out STD_LOGIC_VECTOR(3 downto 0);
        TEN_OUT : out STD_LOGIC_VECTOR(3 downto 0);
        NIT_OUT : out STD_LOGIC_VECTOR(3 downto 0);
        bin : in STD_LOGIC_VECTOR(7 downto 0)
    );
end BCD;

architecture Behavioral of BCD is

    
   
    
begin
    
    process(CLK, RST)
        
        variable i : integer;
        variable binary: STD_LOGIC_VECTOR (7 downto 0);
        variable bcd  : STD_LOGIC_VECTOR(11 downto 0);
    begin
        
        if RST = '1' then
            binary := (others => '0');
            bcd    := (others => '0');
           
        elsif rising_edge(CLK) then
            binary := bin; -- Load the binary input

            -- Reset the BCD output
            bcd := (others => '0');

            -- Shift binary to BCD using Double-Dabble algorithm
            for i in 7 downto 0 loop
                
                if bcd(3 downto 0) >= "0101" then
                    bcd(3 downto 0) := bcd(3 downto 0) + "0011";
                end if;

                if bcd(7 downto 4) >= "0101" then
                    bcd(7 downto 4) := bcd(7 downto 4) + "0011";
                end if;

                if bcd(11 downto 8) >= "0101" then
                    bcd(11 downto 8) := bcd(11 downto 8) + "0011";
                end if;
                
                bcd(11 downto 1) := bcd(10 downto 0);
                bcd(0) := binary(7);
                binary(7 downto 1) := binary(6 downto 0);
                binary(0) := '0';

                
                
            end loop;
            HUN_OUT <= bcd(11 downto 8);
            TEN_OUT <= bcd(7 downto 4);
            NIT_OUT <= bcd(3 downto 0);
        end if;
    end process;
end Behavioral;


