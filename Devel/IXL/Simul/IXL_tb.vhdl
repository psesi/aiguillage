-- type declaration in a package
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use work.IXL_type.all;

entity IXL_tb is
end IXL_tb;

architecture simu of IXL_tb is

  -- synchro   
  signal CLK        :   STD_LOGIC;
  signal reset      :   STD_LOGIC;

  -- input
  signal valid_in   :   STD_LOGIC; 
  signal Sw_Cmd_Req :   Sw_t;
  signal Sw_State   :   Sw_t;
  signal Sensor     :   SE_state;

  -- output
  signal valid_out  :   STD_LOGIC;
  signal Sw_Cmd_Aut :   Sw_t;

  --debug output
  signal TC_out     :   TC_St;

  
begin
  LO : entity work.IXL
    port map (CLK, reset, valid_in, Sw_Cmd_Req, Sw_State, Sensor, valid_out, Sw_Cmd_Aut, TC_out);

  process
  begin

    -- Initialization
    reset <= '1';
    CLK <= '0';
    valid_in <= '0';

    wait for 1 ns;      

    -- Start cycle 1 
    CLK <= '1';
    wait for 1 ns;      

    -- end initialization
    
    reset <= '0';
    
    -- Move 1 full cycle 
    CLK <= '0';
    wait for 1 ns;      
    CLK <= '1';
    wait for 1 ns;      
	
	-- start the simulation with a clock at low level
    CLK <= '0';
    wait for 1 ns;      

    valid_in <= '1';

      report "Cycle 1: --reset the circuit";
      Sensor(0).dir <= "00";
      Sensor(1).dir <= "00";
      Sensor(2).dir <= "00";
      Sensor(3).dir <= "00";
      Sensor(4).dir <= "00";
      Sensor(5).dir <= "00";
      Sensor(6).dir <= "00";
      Sensor(7).dir <= "00";
      Sensor(8).dir <= "00";
      Sensor(9).dir <= "00";
      Sensor(10).dir <= "00";
      Sensor(11).dir <= "00";
      Sensor(12).dir <= "00";
      Sensor(13).dir <= "00";
      Sensor(14).dir <= "00";
      Sensor(15).dir <= "00";
      Sensor(16).dir <= "00";
      Sensor(17).dir <= "00";
      Sensor(18).dir <= "00";
      Sensor(19).dir <= "00";
      Sw_Cmd_req(0) <= '0';
								     Sw_Cmd_Req(1) <= '0';
      Sw_Cmd_req(2) <= '0';
								     Sw_Cmd_Req(3) <= '0';
      Sw_Cmd_req(4) <= '0';
								     Sw_Cmd_Req(5) <= '0';
      Sw_Cmd_req(6) <= '0';
								     Sw_Cmd_Req(7) <= '0';
      Sw_Cmd_req(8) <= '0';
								     Sw_Cmd_Req(9) <= '0';
      Sw_Cmd_req(10) <= '0';
								     Sw_Cmd_Req(11) <= '0';
      Sw_Cmd_req(12) <= '0';
								     Sw_Cmd_Req(13) <= '0';
      Sw_Cmd_req(14) <= '0';
								     Sw_Cmd_Req(15) <= '0';
      Sw_State(1) <= '1';
      Sw_State(3) <= '1';
      Sw_State(5) <= '1';
      Sw_State(7) <= '1';
      Sw_State(9) <= '1';
      Sw_State(11) <= '1';
      Sw_State(13) <= '1';
      Sw_State(15) <= '1';

      CLK <= '1';
      wait for 1 ns;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 2: -- 2 trains block one switch with one and move it after to let the second train changing track";
      Sensor(0).dir <= "01";
      Sensor(9).dir <= "01";

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(0) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(3) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 3:";
      Sensor(0).dir <= "00";
      Sensor(9).dir <= "00";
      Sensor(1).dir <= "01";
      Sensor(19).dir <= "01";

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(1) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(13) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(0) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(3) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 4: -- train 2 stay in TC14";
      Sensor(1).dir <= "00";
      Sensor(19).dir <= "00";
      Sensor(2).dir <= "01";
      Sw_Cmd_Req(8) <='1';

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(2) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(13) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(1) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (Sw_Cmd_Aut(8) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 5: -- ask to open switch 5 ?";
      Sensor(2).dir <= "00";
      Sensor(3).dir <= "01";
      Sw_Cmd_req(8) <= '0';
								     Sw_Cmd_Req(9) <= '0';
      Sw_Cmd_Req(9) <='1';

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(3) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(13) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(2) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 6: -- Train 1 force to continue into the first track";
      Sensor(3).dir <= "00";
      Sensor(4).dir <= "01";
      Sw_Cmd_req(8) <= '0';
								     Sw_Cmd_Req(9) <= '0';

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(4) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(13) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(3) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 7: -- Move Train 2";
      Sensor(4).dir <= "00";
      Sensor(5).dir <= "01";
      Sensor(10).dir <= "01";

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(5) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(8) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(4) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(13) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 8:";
      Sensor(5).dir <= "00";
      Sensor(10).dir <= "00";
      Sensor(0).dir <= "01";
      Sensor(11).dir <= "01";

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(0) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(9) = '0') then report "-- " & " : Pass"; else report "-- " & " : Fail."; end if;
      if (TC_out(5) = '1') then report "-- TC06" & " : Pass"; else report "-- TC06" & " : Fail."; end if;
      if (TC_out(8) = '1') then report "-- TC09" & " : Pass"; else report "-- TC09" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 9:";
      Sensor(0).dir <= "00";
      Sensor(11).dir <= "00";
      Sensor(1).dir <= "01";
      Sw_Cmd_Req(8) <='1';

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(1) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(9) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(0) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 10: -- ask the switch 5 to change";
      Sensor(1).dir <= "00";
      Sensor(2).dir <= "01";
      Sw_Cmd_req(8) <= '0';
								     Sw_Cmd_Req(9) <= '0';
      Sw_Cmd_Req(9) <='1';

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(2) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(9) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(1) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 11:";
      Sensor(2).dir <= "00";
      Sensor(3).dir <= "01";

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(3) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(9) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(2) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 12:";
      Sensor(3).dir <= "00";
      Sensor(19).dir <= "01";
      Sw_Cmd_req(8) <= '0';
								     Sw_Cmd_Req(9) <= '0';

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(13) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(9) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(3) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 13: -- Train 2 is on track 2";
      Sensor(19).dir <= "00";
      Sensor(10).dir <= "01";

      CLK <= '1';
      wait for 1 ns;
      if (TC_out(8) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(9) = '0') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;
      if (TC_out(13) = '1') then report "--" & " : Pass"; else report "--" & " : Fail."; end if;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 14: -- end cycle";

      CLK <= '1';
      wait for 1 ns;


      CLK <= '0';
      wait for 1 ns;
      report "Cycle 15: -- end cycle";

      CLK <= '1';
      wait for 1 ns;


      CLK <= '0';
      wait for 1 ns;
    
    wait;
  end process;
end simu;
