library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity runninglights is
    Port (
        CLK :  in  STD_LOGIC;
        RST :  in  STD_LOGIC;
        Hund,Ten,ITS: in STD_LOGIC_VECTOR (3 downto 0);
        AN : out  STD_LOGIC_VECTOR (7 downto 0);
        CA,CB,CC,CD,CE,CF,CG, DP: out STD_logic	 );
end runninglights;

architecture Behavioral of runninglights is

begin
    process(CLK, RST)
        variable temp: std_logic_vector (7 downto 0);
        variable count: std_logic_vector (2 downto 0);
        variable hundreds,tens,nits: std_logic_vector (3 downto 0);
        
    begin
        
        if RST = '1' then
            temp := "01111111";
            count := "000";
            

        elsif rising_edge(CLK) then
            hundreds := Hund;
            tens := Ten;
            nits := ITS;
           
            
            temp := temp(0) & temp(7 downto 1);
            AN <= temp;
            case temp is
            when "11111011" =>
                case hundreds is
                when "0000" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '0'; CF <= '0'; CG <= '1';DP <= '1';
                when "0001" =>
                    CA <= '1'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '1'; CF <= '1'; CG <= '1';DP <= '1';
                when "0010" =>
                    CA <= '0'; CB <= '0'; CC <= '1'; CD <= '0'; CE <= '0'; CF <= '1'; CG <= '0';DP <= '1';
                when "0011" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '1'; CF <= '1'; CG <= '0';DP <= '1';
                when "0100" =>
                    CA <= '1'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '1'; CF <= '0'; CG <= '0';DP <= '1';
                when "0101" =>
                    CA <= '0'; CB <= '1'; CC <= '0'; CD <= '0'; CE <= '1'; CF <= '0'; CG <= '0';DP <= '1';
                when "0110" =>
                    CA <= '0'; CB <= '1'; CC <= '0'; CD <= '0'; CE <= '0'; CF <= '0'; CG <= '0';DP <= '1';
                when "0111" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '1'; CF <= '0'; CG <= '1';DP <= '1';
                when "1000" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '0'; CF <= '0'; CG <= '0';DP <= '1';
                when "1001" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '1'; CF <= '0'; CG <= '0';DP <= '1';
                when "1010" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '0'; CF <= '0'; CG <= '0';DP <= '1';    
                
                when others =>
                    CA <= '1'; CB <= '1'; CC <= '1'; CD <= '1'; CE <= '1'; CF <= '1'; CG <= '1'; DP <= '1';
                end case;
            when "11111101" =>
                case tens is
                when "0000" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '0'; CF <= '0'; CG <= '1';DP <= '1';
                when "0001" =>
                    CA <= '1'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '1'; CF <= '1'; CG <= '1';DP <= '1';
                when "0010" =>
                    CA <= '0'; CB <= '0'; CC <= '1'; CD <= '0'; CE <= '0'; CF <= '1'; CG <= '0';DP <= '1';
                when "0011" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '1'; CF <= '1'; CG <= '0';DP <= '1';
                when "0100" =>
                    CA <= '1'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '1'; CF <= '0'; CG <= '0';DP <= '1';
                when "0101" =>
                    CA <= '0'; CB <= '1'; CC <= '0'; CD <= '0'; CE <= '1'; CF <= '0'; CG <= '0';DP <= '1';
                when "0110" =>
                    CA <= '0'; CB <= '1'; CC <= '0'; CD <= '0'; CE <= '0'; CF <= '0'; CG <= '0';DP <= '1';
                when "0111" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '1'; CF <= '0'; CG <= '1';DP <= '1';
                when "1000" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '0'; CF <= '0'; CG <= '0';DP <= '1';
                when "1001" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '1'; CF <= '0'; CG <= '0';DP <= '1';
                when "1010" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '0'; CF <= '0'; CG <= '0';DP <= '1';
                when others =>
                    CA <= '1'; CB <= '1'; CC <= '1'; CD <= '1'; CE <= '1'; CF <= '1'; CG <= '1'; DP <= '1';
                end case;
            when "11111110" =>
                case nits is
                when "0000" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '0'; CF <= '0'; CG <= '1';DP <= '1';
                when "0001" =>
                    CA <= '1'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '1'; CF <= '1'; CG <= '1';DP <= '1';
                when "0010" =>
                    CA <= '0'; CB <= '0'; CC <= '1'; CD <= '0'; CE <= '0'; CF <= '1'; CG <= '0';DP <= '1';
                when "0011" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '1'; CF <= '1'; CG <= '0';DP <= '1';
                when "0100" =>
                    CA <= '1'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '1'; CF <= '0'; CG <= '0';DP <= '1';
                when "0101" =>
                    CA <= '0'; CB <= '1'; CC <= '0'; CD <= '0'; CE <= '1'; CF <= '0'; CG <= '0';DP <= '1';
                when "0110" =>
                    CA <= '0'; CB <= '1'; CC <= '0'; CD <= '0'; CE <= '0'; CF <= '0'; CG <= '0';DP <= '1';
                when "0111" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '1'; CF <= '0'; CG <= '1';DP <= '1';
                when "1000" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '0'; CF <= '0'; CG <= '0';DP <= '1';
                when "1001" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '0'; CE <= '1'; CF <= '0'; CG <= '0';DP <= '1';
                when "1010" =>
                    CA <= '0'; CB <= '0'; CC <= '0'; CD <= '1'; CE <= '0'; CF <= '0'; CG <= '0';DP <= '1';
                when others =>
                    CA <= '1'; CB <= '1'; CC <= '1'; CD <= '1'; CE <= '1'; CF <= '1'; CG <= '1'; DP <= '1';
                end case;
            when others =>
                    CA <= '1'; CB <= '1';CC <= '1';CD <= '1';CE <= '1';CF <= '1';CG <= '1';DP <= '1';
            end case;
            
            AN <= temp;
            
           
        end if;
        
    end process;

end Behavioral;
