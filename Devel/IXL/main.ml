open Ixl_t ;;
open Utils_IXL ;;
open Parsing;;
open Lexer_IXL;;
  
(* Storage of the input and output files *)
let in_IXL_channel = ref stdin ;;
let out_IXL_channel = ref stdout ;;
  
(* Parse of an IXL file *) 
let parse_IXL in_IXL_channel =
  (* Initialize the lexer channel *)
  let current_expr_lexbuf = Lexing.from_channel in_IXL_channel in
  begin
    try
      (* Parse the equations *)
      let equations = Parser_IXL.toplevel_phrase
			Lexer_IXL.token current_expr_lexbuf
      in 
      (* Return the parsed equations *)
      equations
	(* Management of the exceptions *)
    with
    | Parsing.Parse_error -> 
       Format.printf "Syntax error at line '%i' @." !Lexer_IXL.line; exit 0
    | Lexer_IXL.LexError -> 
       Format.printf "Lexical error at line '%i' @." !Lexer_IXL.line; exit 0
    | Lexer_IXL.Unterminated_comment -> 
       Format.printf "Unterminated comment@." ; exit 0
    | End_of_file -> exit 0
  end;
;;
  
let mainloop () =
  let equation_l = 
    (* check that there is a file as input *)
    if (!in_IXL_channel <> stdin) then
      (* parse the file *)
      parse_IXL !in_IXL_channel
    else
      begin
	Format.printf "option -i  mandatory.\n";
	exit(0)
      end
  in
  (* Print the parsed file, for debug purpose only *)
  (* Utils_IXL.print_eqs equation_l; *)
  
  (* Generate the VHDL from the boolean equations *)
  Logic.generate !out_IXL_channel equation_l;
  
  (* Close the output file *)
  close_out !out_IXL_channel
;;
  
Arg.parse 
  [("-i", 
    Arg.String(fun f_in_name -> in_IXL_channel := open_in f_in_name;),
    " : IXL input file");
   ("-o", 
    Arg.String(fun f_out_name -> out_IXL_channel := open_out f_out_name;),
    " : IXL output file");
  ]
  (fun f_other -> ())
  "Glop pas glop..." ;


try
  mainloop ()
with
| Failure explanation -> Printf.fprintf stderr "%s" explanation
;; 
  
