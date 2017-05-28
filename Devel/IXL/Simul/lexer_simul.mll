{
open Parser_simul ;;
open Simul_t ;;
exception LexError ;;
exception Unterminated_comment ;;
exception Unterminated_string ;;

let line = ref 1;;

}

rule token = parse
   [' ' '\t' ]	           { token lexbuf }
 | '\n'	                   { line := !line + 1;
                             token lexbuf }
 | "Free"                  { VALUE (true) }
 | "Occ"                   { VALUE (false) }
 | "Aut"                   { VALUE (true) }
 | "NoAut"                 { VALUE (false) }

 | "--" [^'\n']*           { COMMENT (Lexing.lexeme lexbuf)}

 | "<="                    { ASSIGN }
 | "="                     { EQUALS }
 | ";"                     { SEMI }
 | ":"                     { COLON }
 | "Cycle"                 { CYCLE }
 | "Events"                { EVENTS }
 | "Outputs"               { OUTPUTS }
 | ['0'-'9']+              { INDEX (Lexing.lexeme lexbuf) }
 | "SE_UP_"                { SE_UP }
 | "SE_DO_"                { SE_DO }
 | "SE_ID_"                { SE_ID }
 | "TC_"                   { TC }
 | "SW_CMD_RI_"            { SW_CMD_RI }
 | "SW_CMD_LE_"            { SW_CMD_LE }
 | "SW_CMD_NO_"            { SW_CMD_NO }
 | "SW_ST_RI_"             { SW_ST_RI }
 | "SW_ST_LE_"             { SW_ST_LE }
 | "SW_AUT_RI_"            { SW_AUT_RI }
 | "SW_AUT_LE_"            { SW_AUT_LE }

 | eof			   { EOF }
 | _			   { raise LexError }


and comment = parse
 | ['\n']	           
      { line := !line +1;
        () }
 | eof
      { raise Unterminated_comment }
 | _
      { comment lexbuf }

