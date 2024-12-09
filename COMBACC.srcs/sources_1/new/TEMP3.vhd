
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

--entity BCD is
--    Port (CLK : in STD_LOGIC;
--          RST : in STD_LOGIC;
--          HUN_OUT : out STD_LOGIC_VECTOR(3 downto 0);
--          TEN_OUT : out STD_LOGIC_VECTOR(3 downto 0);
--          NIT_OUT : out STD_LOGIC_VECTOR(3 downto 0));
--end BCD;

--architecture Behavioral of BCD is

--    type STATE_TYPE is (I1, I2, SH, SH2, MS, AD1, AD2, AD3, AD4, AD5, AD6, AD7, F);
--    signal State : STATE_TYPE := I1;  -- Current state
--    signal NextS : STATE_TYPE := I1;  -- Next state
--    signal Count : integer := 0;  -- Counter
--    signal InputReg : std_logic_vector(11 downto 0) := "000000000000";  -- Input register
--    signal Reg : std_logic_vector(15 downto 0) := "0000000000000000";  -- Output register
--    signal Temp1, Temp2, Temp3 : std_logic_vector(3 downto 0) := "0000";  -- Temporary variables for calculations
--    signal B, C : std_logic := '0';  -- Flags for adjustments
--    signal H,T,U : std_logic_vector (3 downto 0);
--begin


--    process(CLK, RST)
    
--    begin
--        if RST = '1' then
--            -- Reset condition
--            InputReg <= "001010101010";  -- Initialize the InputReg
--            Reg <= (others => '0');      -- Clear the output register
--            Count <= 0;                  -- Reset the counter
--            State <= I1;                 -- Set the initial state
--            H <= "0000";
--            T <= "0000";
--            U <= "0000";

--        elsif rising_edge(CLK) then

--            -- State transition logic
--            State <= NextS;

--            case State is

--                when I1 =>
--                    NextS <= I2;

--                when I2 =>  -- Initialize
--                    InputReg <= "001010101010";  -- Initialize input register
--                    Reg <= (others => '0');      -- Clear the output register
--                    NextS <= SH;

--                when SH =>  -- Shift output register
--                    Reg <= Reg(14 downto 0) & InputReg(11);  -- Shift in one bit from InputReg
--                    Count <= Count + 1;
--                    NextS <= SH2;

--                when SH2 =>  -- Shift input register
--                    InputReg <= InputReg(10 downto 0) & '0';  -- Shift out one bit
--                    NextS <= MS;

--                when MS =>  -- Comparison state
--                    if Count > 11 then
--                        NextS <= F;
--                    else
--                        NextS <= AD1;
--                    end if;

--                when AD1 =>  -- Check if units or tens are greater than 4
--                    if (unsigned(Reg(11 downto 8)) > 4) then
--                        C <= '1';
--                        Temp3 <= Reg(11 downto 8);
--                        NextS <= AD6;
--                    elsif (unsigned(Reg(7 downto 4)) > 4) then
--                        B <= '1';
--                        Temp2 <= Reg(7 downto 4);
--                        NextS <= AD4;
--                    elsif (unsigned(Reg(3 downto 0)) > 4) then
--                        Temp1 <= Reg(3 downto 0);
--                        NextS <= AD2;
--                    else
--                        NextS <= SH;
--                    end if;

--                when AD2 =>  -- Adjust Units
--                    Temp1 <= std_logic_vector(unsigned(Temp1) + to_unsigned(3, 4));  -- Add 3 to Units
--                    NextS <= AD3;

--                when AD3 =>  -- Update register with adjusted Units
--                    Reg(3 downto 0) <= Temp1;
--                    NextS <= SH;
--                    if C = '1' then
--                        NextS <= AD6;
--                    elsif B = '1' then
--                        NextS <= AD4;
--                    end if;

--                when AD4 =>  -- Adjust Tens
--                    B <= '0';
--                    Temp2 <= std_logic_vector(unsigned(Temp2) + to_unsigned(3, 4));  -- Add 3 to Tens
--                    NextS <= AD5;

--                when AD5 =>  -- Update register with adjusted Tens
--                    Reg(7 downto 4) <= Temp2;
--                    NextS <= SH;
--                    if C = '1' then
--                        NextS <= AD6;
--                    end if;

--                when AD6 =>  -- Adjust Hundreds
--                    C <= '0';
--                    Temp3 <= std_logic_vector(unsigned(Temp3) + to_unsigned(3, 4));  -- Add 3 to Hundreds
--                    NextS <= AD7;

--                when AD7 =>  -- Update register with adjusted Hundreds
--                    Reg(11 downto 8) <= Temp3;
--                    NextS <= SH;

--                when F =>  -- Final case: output result
--                    H <= Reg(11 downto 8);
--                    T <= Reg(7 downto 4);
--                    U <= Reg(3 downto 0);
--                    Count <= 0;
--                    NextS <= I2;

--                when others =>
--                    NextS <= I2;

--            end case;

--        end if;
----                    HUN_OUT <= H;
----                    TEN_OUT <= T;
----                    NIT_OUT <= U;
--    end process;

--end Behavioral;

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

--entity BCD is
--    Port ( CLK     : in STD_LOGIC;
--           RST     : in STD_LOGIC;
--           HUN_OUT : out STD_LOGIC_VECTOR(3 downto 0);
--           TEN_OUT : out STD_LOGIC_VECTOR(3 downto 0);
--           NIT_OUT : out STD_LOGIC_VECTOR(3 downto 0));
--end BCD;

--architecture Behavioral of BCD is

--    signal InputReg : std_logic_vector(11 downto 0) := "000000000000";  -- 12-bit input value
--    signal Reg : std_logic_vector(15 downto 0) := "0000000000000000";  -- 16-bit BCD register for intermediate results
--    signal Count : integer := 0;  -- Simple counter to manage conversion progress

--begin

--    process(CLK, RST)
--        variable H, T, U : std_logic_vector(3 downto 0);  -- Variables to hold hundreds, tens, and units
--    begin
--        if RST = '1' then
--            -- Reset condition

--            InputReg <= "000000000000";  -- Clear input register
--            Reg <= (others => '0');      -- Clear BCD register
--            Count <= 0;                  -- Reset counter
--            H := "0000";                 -- Clear hundreds
--            T := "0000";                 -- Clear tens
--            U := "0000";                 -- Clear units

--        elsif rising_edge(CLK) then
            
            
--            -- Perform BCD conversion (no state machine, just simple shifting and adjustment)
--            if Count < 12 then
--                -- Shift the input register and BCD register
--                Reg <= Reg(14 downto 0) & InputReg(11);  -- Shift in one bit of the input value
--                InputReg <= InputReg(10 downto 0) & '0'; -- Shift input register

--                -- Add 3 to any nibble that is greater than 4 (BCD correction)
--                if unsigned(Reg(11 downto 8)) > 4 then
--                    Reg(11 downto 8) <= std_logic_vector(unsigned(Reg(11 downto 8)) + 3);
--                end if;
--                if unsigned(Reg(7 downto 4)) > 4 then
--                    Reg(7 downto 4) <= std_logic_vector(unsigned(Reg(7 downto 4)) + 3);
--                end if;
--                if unsigned(Reg(3 downto 0)) > 4 then
--                    Reg(3 downto 0) <= std_logic_vector(unsigned(Reg(3 downto 0)) + 3);
--                end if;

--                -- Increment counter after each shift
--                Count <= Count + 1;
--            else
--                -- After the shift process is complete, extract the BCD digits
--                H := Reg(11 downto 8);  -- Hundreds
--                T := Reg(7 downto 4);   -- Tens
--                U := Reg(3 downto 0);   -- Units

--                -- Reset the counter after conversion
--                Count <= 0;
--            end if;
--            HUN_OUT <= H;
--            TEN_OUT <= T;
--            NIT_OUT <= U;
--        end if;

--        -- Assign output ports to the corresponding BCD values

--    end process;

--end Behavioral;

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
                -- Shift left all BCD digits and binary
                bcd(11 downto 1) := bcd(10 downto 0);
                bcd(0) := binary(7);
                binary(7 downto 1) := binary(6 downto 0);
                binary(0) := '0';

                -- Add 3 to BCD digits greater than or equal to 5
                if bcd(3 downto 0) >= "0101" then
                    bcd(3 downto 0) := bcd(3 downto 0) + "0011";
                end if;

                if bcd(7 downto 4) >= "0101" then
                    bcd(7 downto 4) := bcd(7 downto 4) + "0011";
                end if;

                if bcd(11 downto 8) >= "0101" then
                    bcd(11 downto 8) := bcd(11 downto 8) + "0011";
                end if;
            end loop;
            HUN_OUT <= bcd(11 downto 8);
            TEN_OUT <= bcd(7 downto 4);
            NIT_OUT <= bcd(3 downto 0);
        end if;
    end process;
end Behavioral;
----    -- Map BCD signals to outputs

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity BCD is
--    Port (
--        CLK     : in  STD_LOGIC;
--        RST     : in  STD_LOGIC;
--        HUN_OUT : out STD_LOGIC_VECTOR(3 downto 0);
--        TEN_OUT : out STD_LOGIC_VECTOR(3 downto 0);
--        NIT_OUT : out STD_LOGIC_VECTOR(3 downto 0);
--        bin : in STD_LOGIC_VECTOR(7 downto 0)
--    );
--end BCD;

--architecture Behavioral of BCD is


  

--begin

--    process(CLK, RST)
--        variable binary: STD_LOGIC_VECTOR(7 downto 0);
--        variable i : integer;
--        variable bcd: STD_LOGIC_VECTOR(11 downto 0);
--    begin
--        if RST = '1' then
--            binary := (others => '0');
--            bcd    := (others => '0');
--        elsif rising_edge(CLK) then
            
--            binary := bin; -- Example test value (decimal 42)

--            -- Reset the BCD output
--            bcd := (others => '0');

--            -- Shift binary to BCD using Double-Dabble algorithm
--            for i in 7 downto 0 loop
--                -- Shift left all BCD digits and binary
--                bcd(11 downto 1) := bcd(10 downto 0);
--                bcd(0) := binary(7);
--                binary(7 downto 1) := binary(6 downto 0);
--                binary(0) := '0';

--                -- Add 3 to BCD digits greater than or equal to 5
--                if bcd(3 downto 0) >= "0101" then
--                    bcd(3 downto 0) := bcd(3 downto 0) + "0011";
--                end if;

--                if bcd(7 downto 4) >= "0101" then
--                    bcd(7 downto 4) := bcd(7 downto 4) + "0011";
--                end if;

--                if bcd(11 downto 8) >= "0101" then
--                    bcd(11 downto 8) := bcd(11 downto 8) + "0011";
--                end if;
--            end loop;

--            -- Assign BCD digits to outputs
--            HUN_OUT <= bcd(11 downto 8);
--            TEN_OUT <= bcd(7 downto 4);
--            NIT_OUT <= bcd(3 downto 0);
--        end if;
--    end process;

--end Behavioral;

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity BCD is
--    Port (
--        hex_in  : in  STD_LOGIC_VECTOR(7 downto 0); -- Input binary value
--        HUN_OUT : out STD_LOGIC_VECTOR(3 downto 0); -- Hundreds place in BCD
--        TEN_OUT : out STD_LOGIC_VECTOR(3 downto 0); -- Tens place in BCD
--        NIT_OUT : out STD_LOGIC_VECTOR(3 downto 0);  -- Units place in BCD
--        CLK     : in  STD_LOGIC
--    );
--end BCD;

--architecture Behavioral of BCD is
--        signal hex_src : STD_LOGIC_VECTOR(7 downto 0) := x"00"; -- Working binary value
--        signal bcd     : STD_LOGIC_VECTOR(11 downto 0) := "000000000000"; -- Temporary BCD storage
--begin
    
--    process(CLK)
--    begin
--        hex_src <= hex_in; 
--        bcd <= (others => '0'); 

--        -- Double-Dabble algorithm
--        for i in 0 to 7 loop
--            -- Shift left BCD digits and append the MSB of hex_src
--            bcd <= bcd(11 downto 1) & hex_src(7);
--            -- Shift left hex_src and pad with 0
--            hex_src <= hex_src(7 downto 1) & '0';

--            -- Add 3 to BCD digits >= 5
--            if bcd(3 downto 0) > "0100" then
--                bcd(3 downto 0) <= bcd(3 downto 0) + "0011";
--            end if;
--            if bcd(7 downto 4) > "0100" then
--                bcd(7 downto 4) <= bcd(7 downto 4) + "0011";
--            end if;
--            if bcd(11 downto 8) > "0100" then
--                bcd(11 downto 8) <= bcd(11 downto 8) + "0011";
--            end if;
--        end loop;

--        -- Map results to outputs
--        HUN_OUT <= bcd(11 downto 8);
--        TEN_OUT <= bcd(7 downto 4);
--        NIT_OUT <= bcd(3 downto 0);
--    end process;
--end Behavioral;

