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
        LED: out STD_LOGIC_VECTOR (15 downto 0);
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
            
                        
            -- >0
            if nits > 0 then
                LED(0) <= '1';
            elsif tens > 0 then
                LED(0) <= '1';
            elsif hundreds > 0 then
                LED(0) <= '1';
            else
                LED(0) <= '0';
            end if;
            
            -- 15
            if tens > 0 and nits > 4 then
                LED(1) <= '1';
            elsif tens > 1 then
                LED(1) <= '1';
            elsif hundreds > 0 then
                LED(1) <= '1';
            else
                LED(1) <= '0';
            end if;
            
            -- 30
            if tens > 2 then
                LED(2) <= '1';
            elsif hundreds > 0 then
                LED(2) <= '1';
            else
                LED(2) <= '0';
            end if;
            
            -- 45
            if tens > 3 and nits > 4 then
                LED(3) <= '1';
            elsif tens > 4 then
                LED(3) <= '1';
            elsif hundreds > 0 then
                LED(3) <= '1';
            else
                LED(3) <= '0';
            end if;
            
            
            -- 60
            if tens > 5 then
                LED(4) <= '1';
            elsif hundreds > 0 then
                LED(4) <= '1';
            else
                LED(4) <= '0';
            end if;
            
            -- 75
            if tens > 6 and nits > 4 then
                LED(5) <= '1';
            elsif tens > 7 then
                LED(5) <= '1';
            elsif hundreds > 0 then
                LED(5) <= '1';
            else
                LED(5) <= '0';
            end if;
            
            -- 90
            if tens > 8 then
                LED(6) <= '1';
            elsif hundreds > 0 then
                LED(6) <= '1';
            else
                LED(6) <= '0';
            end if;
            
            -- 105
            if hundreds > 0 and nits > 4 then
                LED(7) <= '1';
            elsif hundreds > 0 and tens > 0 then
                LED(7) <= '1';
            elsif hundreds > 1 then
                LED(7) <= '1';
            else
                LED(7) <= '0';
            end if;
            
            
            -- 120
            if hundreds > 0 and tens > 1 then
                LED(8) <= '1';
            elsif hundreds > 1 then
                LED(7) <= '1';
            else
                LED(8) <= '0';
            end if;
            
            -- 135
            if hundreds > 0 and tens > 2 and nits > 4 then
                LED(9) <= '1';
            elsif hundreds > 0 and tens > 3 then
                LED(9) <= '1';
            elsif hundreds > 1 then
                LED(9) <= '1';
            else
                LED(9) <= '0';
            end if;
            
            -- 150
            if hundreds > 0 and tens > 4 then
                LED(10) <= '1';
            elsif hundreds > 1 then
                LED(10) <= '1';
            else
                LED(10) <= '0';
            end if;
            
            -- 165
            if hundreds > 0 and tens > 5 and nits > 4 then
                LED(11) <= '1';
            elsif hundreds > 0 and tens > 6 then
                LED(11) <= '1';
            elsif hundreds > 1 then
                LED(11) <= '1';
            else
                LED(11) <= '0';
            end if;
            
            -- 180
            if hundreds > 0 and tens > 7 then
                LED(12) <= '1';
            elsif hundreds > 1 then
                LED(12) <= '1';
            else
                LED(12) <= '0';
            end if;
            
            -- 195
            if hundreds > 0 and tens > 8 and nits > 4 then
                LED(13) <= '1';
            elsif hundreds > 1 then
                LED(13) <= '1';
            else
                LED(13) <= '0';
            end if;
            
            -- 210
            if hundreds > 1 and tens > 0 then
                LED(14) <= '1';
            else
                LED(14) <= '0';
            end if;
            
            -- 225
            
            if hundreds > 1 and tens >3 then
                LED(15) <= '1';
            else
                LED(15) <= '0';
            end if;
            
           
            
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
