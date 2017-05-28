open Simul_t ;;
  
  
let print_dir dir =
  match dir with
  | Simul.Up -> "Up"
  | Simul.Down -> "Down"
  | Simul.Idle -> "Idle"
;;
  
let print_sw_state st =
  match st with
  | Simul.Left  -> "Left"
  | Simul.Right -> "Right"
  | Simul.Idle -> "Idle"
;;
  
let print_bool b =
  match b with
  | true -> "True"
  | false -> "False"
;;
  
let print_comment c =
  match c with
  | None -> ""
  | Some c1 -> c1
;;
  
let print_ident id =
  match id with
  | Simul.P_SE(nb, ad, di) -> "P_SE_"^string_of_int(nb)^"_"^string_of_int(ad)^"_"^print_dir(di)
  | Simul.P_TC(nb, ad)     -> "P_TC_"^string_of_int(nb)^"_"^string_of_int(ad)
  | Simul.P_SW_CMD(nb, st) -> "P_SW_CMD_"^string_of_int(nb)^"_"^print_sw_state(st)
  | Simul.P_SW_ST(nb, st)  -> "P_SW_ST_"^string_of_int(nb)^"_"^print_sw_state(st)
  | Simul.P_SW_AUT(nb, st) -> "P_SW_AUT_"^string_of_int(nb)^"_"^print_sw_state(st)
;;
  
  
let print_event event =
  Printf.fprintf stdout "%s  %s\n" (print_ident event.Simul.evname) (print_comment event.Simul.comment);
;;
  
let rec print_events events =
  match events with
  | [] -> 
     ()
  | t::q -> 
     print_event t; 
     print_events q
;;
  
let print_output output =
  Printf.fprintf stdout "%s = %s; %s\n" (print_ident output.Simul.outname) (print_bool output.Simul.outval)
                 (print_comment output.Simul.comment);
  
;;
  
let rec print_outputs outputs =
  match outputs with
  | [] -> 
     ()
  | t::q -> 
     print_output t; 
     print_outputs q
;;
  
let print_cycle cycle =
  Printf.fprintf stdout "Cycle %i : %s \n" cycle.Simul.cycle (print_comment cycle.Simul.comment) ;
  print_events cycle.Simul.events;
  print_outputs cycle.Simul.outputs
;;
  
let rec print_cycles cycles =
  match cycles with
  | [] -> 
     ()
  | t::q -> 
     print_cycle t; 
     print_cycles q
;;
  
