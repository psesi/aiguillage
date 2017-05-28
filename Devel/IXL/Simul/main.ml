open Simul_t ;;
open Utils_simul ;;
open Parsing;;
open Lexer_simul;;
open Simulation;;
  
(* Storage of the input and output files *)
let in_Simul_channel = ref stdin ;;
let out_Simul_channel = ref stdout ;;
  
(* Parse of a simulation file *) 
let parse_simul in_Simul_channel =
  (* Initialize the lexer channel *)
  let current_expr_lexbuf = Lexing.from_channel in_Simul_channel in
  begin
    try
      (* Parse the cycles *)
      let cycles = Parser_simul.toplevel_phrase
		     Lexer_simul.token current_expr_lexbuf
      in 
      (* Return the parsed equations *)
      cycles
	(* Management of the exceptions *)
    with
    | Parsing.Parse_error -> 
       Format.printf "Syntax error at line '%i' @." !Lexer_simul.line; exit 0
    | Lexer_simul.LexError -> 
       Format.printf "Lexical error at line '%i' @." !Lexer_simul.line; exit 0
    | Lexer_simul.Unterminated_comment -> 
       Format.printf "Unterminated comment@." ; exit 0
    | End_of_file -> exit 0
  end;
;;
  
let mainloop () =
  let cycles = 
    (* check that there is a file as input *)
    if (!in_Simul_channel <> stdin) then
      (* parse the file *)
      parse_simul !in_Simul_channel
    else
      begin
	Format.printf "option -i  mandatory.\n";
	exit(0)
      end
  in
  (* Print the parsed file, for debug purpose only *)
  (* Utils_simul.print_cycles cycles; *)
  
  (* Generate the VHDL from the simulation *)
  Simulation.generate !out_Simul_channel cycles;
  
  (* Close the output file *)
  close_out !out_Simul_channel
;;
  
Arg.parse 
  [("-i", 
    Arg.String(fun f_in_name -> in_Simul_channel := open_in f_in_name;),
    " : Simulation input file");
   ("-o", 
    Arg.String(fun f_out_name -> out_Simul_channel := open_out f_out_name;),
    " : Simulation output file");
  ]
  (fun f_other -> ())
  "Glop pas glop..." ;

try
  mainloop ()
with
| Failure explanation -> Printf.fprintf stderr "%s" explanation 
;;
  
