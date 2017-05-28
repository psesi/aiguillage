%{
open Ixl_t ;;

let ind_eq = ref 0;;

%}

%token <string> VALUE
%token LPAREN
%token RPAREN
%token AND
%token OR
%token NOT
%token ASSIGN
%token SEMI
%token SE_UP
%token SE_DO
%token TC
%token SW_CMD_RI
%token SW_CMD_LE
%token SW_ST_RI
%token SW_ST_LE
%token SW_AUT_RI
%token SW_AUT_LE
%token EOF

%start toplevel_phrase
%type <Ixl_t.Ixl.equations> toplevel_phrase
%%

toplevel_phrase:
   equations  EOF   { $1 }
 | EOF              { raise End_of_file }
;

equations:
 |                    {[]}
 | equation equations { $1::$2 }
;
 
equation:
 | ident ASSIGN bool_expr SEMI 
    { {Ixl_t.Ixl.exprname = $1;
       Ixl_t.Ixl.boolexpr = $3}
	}
; 

bool_expr:
 | simpl_bool_expr
   { $1 }
 | simpl_bool_expr AND bool_expr
   { Ixl_t.Ixl.P_AND ($1, $3) }
 | simpl_bool_expr OR bool_expr
   { Ixl_t.Ixl.P_OR ($1, $3) }
;

simpl_bool_expr:
 | ident
    { Ixl_t.Ixl.P_IDENT ($1) }
 | NOT ident
    { Ixl_t.Ixl.P_NOT ($2) }
 | LPAREN bool_expr RPAREN 
    { $2 }
;

ident:
 | SE_UP VALUE       { Ixl_t.Ixl.P_SE(int_of_string($2), 0, Ixl_t.Ixl.Up)}
 | SE_DO VALUE       { Ixl_t.Ixl.P_SE(int_of_string($2), 0, Ixl_t.Ixl.Down)}
 | TC VALUE          { Ixl_t.Ixl.P_TC(int_of_string($2), 0)}
 | SW_CMD_RI VALUE   { Ixl_t.Ixl.P_SW_CMD(int_of_string($2), Ixl_t.Ixl.Right)}
 | SW_CMD_LE VALUE   { Ixl_t.Ixl.P_SW_CMD(int_of_string($2), Ixl_t.Ixl.Left)}
 | SW_ST_RI VALUE    { Ixl_t.Ixl.P_SW_ST(int_of_string($2), Ixl_t.Ixl.Right)}
 | SW_ST_LE VALUE    { Ixl_t.Ixl.P_SW_ST(int_of_string($2), Ixl_t.Ixl.Left)}
 | SW_AUT_RI VALUE   { Ixl_t.Ixl.P_SW_AUT(int_of_string($2), Ixl_t.Ixl.Right)}
 | SW_AUT_LE VALUE   { Ixl_t.Ixl.P_SW_AUT(int_of_string($2), Ixl_t.Ixl.Left)}
;

