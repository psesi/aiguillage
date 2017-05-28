open Ixl_t ;;

(* Print the header of the VHDL file *)
let print_header out_chan =
Printf.fprintf out_chan 
"-- type declaration in a package
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package IXL_type is

  type sensor is
    record
      addr : STD_LOGIC_VECTOR (7 downto 0) ;
      dir  : STD_LOGIC_VECTOR (1 downto 0) ;
    end record ;

  -- sensors state type
  type SE_state is array (31 downto 0) of sensor ;

  --track circuit type
  type TC_St is array (31 downto 0) of STD_LOGIC ;

  --Switch command authorization
  type Sw_t is array (15 downto 0) of STD_LOGIC ;
  
end package IXL_type;

-- beggining of program
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.IXL_type.all;

entity Ixl is  

  Port (
         -- synchro   
         CLK        : in  STD_LOGIC;
         reset      : in  STD_LOGIC;

         -- input
         valid_in   : in  STD_LOGIC; 
         Sw_Cmd_Req : in  Sw_t;
         Sw_State   : in  Sw_t;
         Sensor     : in  SE_state;
         
         -- output
         valid_out  : out STD_LOGIC;
         Sw_Cmd_Aut : out Sw_t;

         --debug output
         TC_out     : out TC_St
         );

end Ixl;

--------------------------------------------------------------------------------

architecture Behavioral of Ixl is

  -- component declaration


--------------------------------------------------------------------------------
  
  -- signals declaration


--------------------------------------------------------------------------------
  
begin

  -- component instantiation

  
--------------------------------------------------------------------------------

  
 process (CLK,reset)
 
  -- variable declaration
  -- Track circuit state
  variable TC : TC_St;          

   
 begin

   
   -- RESET gestion
   if reset = '1' then

     -- clear TC
     for i in 0 to 31 loop
       TC(i) := '1';
     end loop;
     -- reset the output value
     valid_out <= '0';
     
   -- end if reset
   end if;
   

   
   if rising_edge (CLK) then 

     -- reset the output value
     valid_out <= '0';
     
     -- process only if the inputs are ok
     if valid_in = '1' then
"
;;

(* Print the trailer of the VHDL file *)
let print_trailer out_channel =
Printf.fprintf out_channel
"    
     -- for debug
     TC_out <= TC;

     valid_out <= '1';    
     -- end valid = 1
     end if;
   --end if rising edge
   end if;    


 end process;
end Behavioral;
"       
;;

let print_sw_state st =
  ""
;;
  

let print_ident_in ident =
  match ident with
  | Ixl.P_SE(nb, _, dir) -> 
     begin
       match dir with
       | Ixl.Up -> "Sensor("^string_of_int(nb-1)^").dir = \"01\""
       | Ixl.Down -> "Sensor("^string_of_int(nb-1)^").dir = \"10\""
       | Ixl.Idle -> raise( Failure "!@*&* Error Sensor Idle" )
     end
       
  | Ixl.P_TC(nb, _)      -> "TC("^string_of_int(nb-1)^")='1'"
							
  | Ixl.P_SW_CMD(nb, st) ->
     begin
       match st with 
       | Ixl.Right -> "Sw_Cmd_Req("^string_of_int((nb-1)*2)^")='1'"
       | Ixl.Left -> "Sw_Cmd_Req("^string_of_int((nb-1)*2+1)^")='1'"
       | Ixl.Idle -> raise( Failure "!@*&* Error Sensor Idle" )
     end
       
  | Ixl.P_SW_ST(nb, st)  -> 
     begin
       match st with 
       | Ixl.Right -> "Sw_State("^string_of_int((nb-1)*2)^")='1'"
       | Ixl.Left -> "Sw_State("^string_of_int((nb-1)*2+1)^")='1'"
       | Ixl.Idle -> raise( Failure "!@*&* Error Sensor Idle" )
     end
       
  | Ixl.P_SW_AUT(nb, st) -> raise( Failure "!@*&* Error SW_AUT never in" )
;;
  
let rec print_bool_exp bool_exp =
  match bool_exp with
  | Ixl.P_IDENT(id)   -> print_ident_in id
  | Ixl.P_NOT(id)     -> "NOT ("^(print_ident_in id)^")"
  | Ixl.P_AND(e1, e2) -> "("^(print_bool_exp e1)^") AND ("^(print_bool_exp e2)^")"
  | Ixl.P_OR(e1, e2)  -> "("^(print_bool_exp e1)^") OR ("^(print_bool_exp e2)^")"
;;
  
let print_equation out_channel equation =
  let exp = print_bool_exp equation.Ixl.boolexpr in
  match equation.Ixl.exprname with
  | Ixl.P_SE(_, _, _)    -> 
     raise( Failure "!@*&* Error writing Sensor." )
  | Ixl.P_TC(nb, _)      -> 
     Printf.fprintf out_channel "        if (%s) then TC(%i) := '1'; else  TC(%i) := '0'; end if;\n" exp (nb - 1) (nb - 1)
  | Ixl.P_SW_CMD(_, _) -> 
     raise( Failure "!@*&* Error writing Sw CMD." )
  | Ixl.P_SW_ST(_, _)  -> 
     raise( Failure "!@*&* Error writing Sw State." )
  | Ixl.P_SW_AUT(nb, st) -> 
     let out_range = 
       match st with 
       | Ixl.Right -> (nb-1)*2
       | Ixl.Left -> (nb-1)*2 + 1
       | Ixl.Idle -> raise(Failure "!@*&* Error writing Sw State.")
     in
     Printf.fprintf out_channel "        if (%s) then Sw_Cmd_Aut(%i) <= '1'; else Sw_Cmd_Aut(%i) <= '0'; end if;\n"  exp out_range out_range 
;;
  
(* Generate each equation one per one *)
let rec print_equations out_channel equations =
  match equations with
  | [] -> ()
  | t::q -> 
     print_equation out_channel t;
     print_equations out_channel q
;;
  
  
let generate out_channel equations =
  print_header out_channel;
  print_equations out_channel equations; 
  print_trailer out_channel
;;
  
