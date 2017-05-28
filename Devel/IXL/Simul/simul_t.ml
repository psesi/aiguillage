module Simul =
struct

exception Not_found;; 

(* sensor direction *)
type dir_def =
  | Up
  | Down
  | Idle
;;  
 
(* Switch state *)
type sw_state_def =
  | Right
  | Left
  | Idle
;;

type ident_def =
  | P_SE of int * int * dir_def     (* Sensor : sensor number * train address * direction *)
  | P_TC of int * int               (* Track Circuit : track circuit number * train_address *)
  | P_SW_CMD of int * sw_state_def  (* Switch command : switch number * switch state *)
  | P_SW_ST of int * sw_state_def   (* Switch state : switch number * switch state *)
  | P_SW_AUT of int * sw_state_def  (* Signal state : signal number * signal state *)
;;

type event =
{ evname  : ident_def ; 
  comment : string option ;
}
;;


type output =
{ outname : ident_def ;
  outval  : bool; 
  comment : string option ;
}
;;


type cycle =
{ 
  cycle   : int;
  comment : string option;
  events  : event list;
  outputs : output list;
}


type simul = cycle list;;

end
;;
