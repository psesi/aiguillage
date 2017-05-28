%{
open Simul_t ;;

let ind_eq = ref 0;;

%}

%token <string> INDEX
%token <string> COMMENT
%token <bool>   VALUE
%token CYCLE
%token ASSIGN
%token EQUALS
%token SEMI
%token COLON
%token EVENTS
%token OUTPUTS
%token SE_UP
%token SE_DO
%token SE_ID
%token TC
%token SW_CMD_RI
%token SW_CMD_LE
%token SW_CMD_NO
%token SW_ST_RI
%token SW_ST_LE
%token SW_AUT_RI
%token SW_AUT_LE
%token EOF

%start toplevel_phrase
%type <Simul_t.Simul.simul> toplevel_phrase
%%

toplevel_phrase:
   cycles  EOF      { $1 }
 | EOF              { raise End_of_file }
;

cycles:
 |               {[]}
 | cycle cycles  { $1::$2 }
;
 
cycle:
  CYCLE INDEX COLON comment EVENTS events OUTPUTS outputs
   { {Simul_t.Simul.cycle = int_of_string($2);
      Simul_t.Simul.comment = $4;
      Simul_t.Simul.events = $6;
      Simul_t.Simul.outputs = $8;}
   }
;

events:
 |               {[]}
 | event events  { $1::$2 }
;

outputs:
 |                 {[]}
 | output outputs  { $1::$2 }
;

event:
 | ident SEMI comment
    { {Simul_t.Simul.evname  = $1;
       Simul_t.Simul.comment = $3; }
    }
;

output:
 | ident EQUALS VALUE SEMI comment
    { {Simul_t.Simul.outname = $1;
       Simul_t.Simul.outval = $3;
       Simul_t.Simul.comment = $5; }
    }
;

ident:
 | SE_UP INDEX       { Simul_t.Simul.P_SE(int_of_string($2), 0, Simul_t.Simul.Up)}
 | SE_DO INDEX       { Simul_t.Simul.P_SE(int_of_string($2), 0, Simul_t.Simul.Down)}
 | SE_ID INDEX       { Simul_t.Simul.P_SE(int_of_string($2), 0, Simul_t.Simul.Idle)}
 | TC INDEX          { Simul_t.Simul.P_TC(int_of_string($2), 0)}
 | SW_CMD_RI INDEX   { Simul_t.Simul.P_SW_CMD(int_of_string($2), Simul_t.Simul.Right)}
 | SW_CMD_LE INDEX   { Simul_t.Simul.P_SW_CMD(int_of_string($2), Simul_t.Simul.Left)}
 | SW_CMD_NO INDEX   { Simul_t.Simul.P_SW_CMD(int_of_string($2), Simul_t.Simul.Idle)}
 | SW_ST_RI INDEX    { Simul_t.Simul.P_SW_ST(int_of_string($2), Simul_t.Simul.Right)}
 | SW_ST_LE INDEX    { Simul_t.Simul.P_SW_ST(int_of_string($2), Simul_t.Simul.Left)}
 | SW_AUT_RI INDEX   { Simul_t.Simul.P_SW_AUT(int_of_string($2), Simul_t.Simul.Right)}
 | SW_AUT_LE INDEX   { Simul_t.Simul.P_SW_AUT(int_of_string($2), Simul_t.Simul.Left)}
;

comment:
 |           { None }
 | COMMENT   {Some $1 }