%{
    //codigo en JS
    //importaciones y declaraciones
    const {Declaracion} = require('./instrucciones/declaracion.js');
    const {Asignacion} = require('./instrucciones/asignar.js');
    const {Literal} = require('./expresiones/literal.js')
    const {Type} = require('./symbols/type.js');
    const {Arithmetic} = require('./expresiones/aritmeticas.js');
    const {Acceso} = require('./expresiones/Acceso.js');
    const {AritmeticOption} = require('./expresiones/aritmeticOption.js');
    //const {Bloque} = require('./instrucciones/Env')
    //const {Imprimir} = require('./instrucciones/imprimir')
   //const {Sentencia_if} = require('./instrucciones/condicionIf')
    //const {metodo} = require('./instrucciones/metodo')
    //const {llamada} = require('./instrucciones/llamada')
    const { RelacionalOption } = require("./expresiones/relacionalOptions.js");
    const { Relacional } = require("./expresiones/relacional.js");
    const {DeclaracionARRAY} = require('./instrucciones/declaracionarray.js');
    const {imprimir} = require('./instrucciones/imprimir.js');
    var array_erroresLexicos;
   
%}

%lex
%options case-insensitive

nunumber [0-9]+
//DecIntegerLiteral  0 | [1-9][0-9]*
number [0-9]+"."? [0-9]*
cadena "\"" [^\"]* "\""
cadenita "'" [^']* "'"
//bool    "true"|"false"   

%%

\s+                   /* skip whitespace */
"//".*                // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] // comentario multiple líneas












//expresiones regulare


{number}    return 'expreR_numero'
{cadena}    return 'expreR_cadena'
//{bool}      return 'expreR_bool'
{cadenita}  return 'expreR_cadenita'





//palabras reservadas

"var"   return 'pr_var'
"let"   return 'pr_let'
"const" return 'pr_const'

"int" return 'pr_numero'
"double" return 'pr_double'
"char" return 'pr_char'
"string" return 'pr_string'
"boolean" return 'pr_bool'
"print" return 'pr_print'
"println" return 'pr_println'
"return" return 'pr_return'
"while" return 'pr_while'
"switch" return 'pr_switch'
"for" return 'pr_for'
"do" return 'pr_do'
"if" return 'pr_if'
"else" return 'pr_else'
"elif" return 'pr_elif'
"break" return 'pr_break'
"void" return 'pr_void'
"call" return 'pr_call'
"typeof" return 'pr_typeof'
"case" return 'pr_case'
"default" return 'pr_default'
"until" return 'pr_until'
"continue" return 'pr_continue'
"tolower" return 'pr_TL'
"toupper" return 'pr_TU'
"round" return 'pr_round'
"length" return 'pr_len'
"tostring" return 'pr_TS'
"tochararray" return 'pr_TCA'
"new" return 'pr_new'
"true" return 'true'
"false" return 'false'




//simbolos

";" return ';' 
"=" return '='
":" return ':' 
"+" return '+' 
"-" return '-' 
"*" return '*' 
"/" return '/' 
"," return ','
"{" return '{' 
"}" return '}' 
")" return ')' 
"(" return '(' 
"<" return '<'
">" return '>'
"||" return '||'
"&&" return '&&'
"^" return '^'
"!" return '!'
"%" return '%'
//"<=" return '<='
//">=" return '>='
//"==" return '=='
//"!=" return '!='
"[" return '['
"]" return ']'





[a-zA-ZñÑ][a-zA-Z0-9_ñÑ]*	return 'id';


<<EOF>>		            return 'EOF'

.   { 
        console.log("error lexico :"+yytext)
        //push para array errores
    }

/lex 
/*
%right   '!'
%left '*' '/' '%'
%left '+' '-'
%left  '<' '>' '<=' '>=' '==' '!='
%left '^'
*/
%start INIT


%%

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
 
//GENERAL INSTRUCCIONES 
INIT: INSTRUCCIONES    EOF {return $1} ;


INSTRUCCIONES :   INSTRUCCIONES INSTRUCCION {$1.push($2); $$=$1;   console.log("s ")}
              |   INSTRUCCION               {$$ = [$1]; console.log("s ") }
              ;


INSTRUCCION : DECLARACION   {$$=$1; console.log("reconocio declaracion ") } 
            | IMPRIMIR      {$$=$1; console.log("reconocio PRINT ") } 
            | IMPRIMIRLN    {$$=$1; console.log("reconocio PRINTLN ") } 
            | ASIGNACION    {$$=$1; console.log("reconocio asignacion ") }
            | METODO        {  console.log("reconocio metodo")}
            | FUNCION       { console.log("reconocio funcion") }
            | METODOsp        {  console.log("reconocio metodo sin parametros")}
            | FUNCIONsp       { console.log("reconocio funcion sin parametros") }
            | CONDICIONIF   { console.log("reconocio condicion if") } 
            | CICLO         {console.log("reconocio  ciclo")}
            | RETURN   {console.log("reconocio  RETURN")}
            | CALL ';'     {console.log("reconocio  LLAMADA")}
            | SWITCH    {console.log("reconocio sentencia SWITCH")}
            | BREAK     {console.log("reconocio sentencia BREAK")}
            | CONTINUE     {console.log("reconocio sentencia CONTINUE")}
            | AUMENTO ';'   {$$=$1;console.log("reconocio sentencia AUMENTO")}
            | INSTANCIA ';'   {$$=$1;console.log("reconocio sentencia INSTANCIA")}
            |DECLARACION_VECTORES {$$=$1;console.log("reconocio sentencia DECLARACION VECTOR")}
            | error    ';'  { console.log("Error sintactico en la linea"+(yylineno+1)); }
;
//INSTRUCCIONES CICLOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOS
CICLO: 'pr_for'  '(' DECLARACION ETS ';'  ETS ')' '{' INSTRUCCIONES '}'  {}
    | 'pr_for' '('  ASIGNACION ETS ';'  ETS   ')'  '{' INSTRUCCIONES '}'  {}
    |'pr_for'  '(' DECLARACION ETS ';'  ASIGNACION ')' '{' INSTRUCCIONES '}'  {}
    | 'pr_for' '('  ASIGNACION ETS ';'  ASIGNACION   ')'  '{' INSTRUCCIONES '}'  {}
    | 'pr_while' '(' ETS ')' '{' INSTRUCCIONES '}'  {}
    | 'pr_do' '{' INSTRUCCIONES '}' 'pr_while' '(' ETS ')' ';' {}
    | 'pr_do' '{' INSTRUCCIONES '}' 'pr_until' '(' ETS ')' ';' {}
    ;

SWITCH : 'pr_switch' '(' 'id' ')' '{' OPCIONES 'pr_default' ':' '{' INSTRUCCIONES '}' '}' {}
;
OPCIONES: OPCIONES OPCION  {}
            | OPCION  {}
;
OPCION : 'pr_case'  ETS  ':' '{' INSTRUCCIONES '}' {}
;

BREAK: 'pr_break' ';' {}
;
CONTINUE: 'pr_continue' ';' {}
;






//CONDICION IF

CONDICIONIF: 'pr_if' '(' ETS ')'  '{' INSTRUCCIONES '}'  {}
                | 'pr_if' '(' ETS ')'  '{' INSTRUCCIONES '}' IFANIDADOS {}
;
IFANIDADOS : IFANIDADOS  'pr_elif' '(' ETS ')'  '{' INSTRUCCIONES '}' {}
                | IFANIDADOS  'pr_else' '{' INSTRUCCIONES '}' {}
                |  'pr_elif' '(' ETS ')'  '{' INSTRUCCIONES '}' {}
                | 'pr_else' '{' INSTRUCCIONES '}' {}
;






//FUNCIONES Y METODOS CON PARAMETROS
FUNCION: 'id' PARAMETROS ':'  TIPODATO_DECLARACION '{' INSTRUCCIONES '}'
;
METODO : 'id' PARAMETROS ':' 'pr_void'  '{' INSTRUCCIONES '}'
        | 'id' PARAMETROS   '{' INSTRUCCIONES '}'
;
PARAMETROS : '(' PARS ')' 
;
PARS : PARS ',' PAR
     | PAR          
;
PAR : TIPODATO_DECLARACION  'id'
;
PARAMETROSLL : '(' PARSLL ')' {$$ = $2}
;
PARSLL : PARSLL ',' E {$1.push($3); $$=$1;}
     | E {$$ = [$1]}
;

//sin parametros

FUNCIONsp: 'id'  '(' ')' ':' TIPODATO_DECLARACION  '{' INSTRUCCIONES '}'
;
METODOsp : 'id' '(' ')' ':' 'pr_void'  '{' INSTRUCCIONES '}' 
        | 'id' '(' ')'   '{' INSTRUCCIONES '}' 
;
//EL RETURN

RETURN : 'pr_return' '(' ETS ')' ';'
        | 'pr_return' '(' ')' ';'
;

//LLAMADA DE FUNCION O METODOS
CALL:  'id' PARAMETROSLL 
    |  'id' '('')'

;


LISTADEPARSLL: LISTADEPARSLL ',' PARALISTA {$1.push($3); $$=$1;}
            | PARALISTA {$$ = [$1]}
;
PARALISTA : '{' PARSLL '}' {$$ = $2}

;
LISTADELISTAS : '{' LISTADEPARSLL '}' {$$ = $2}
;
//INSTRUCCION IMPRIMIR UNA Y VARIAS LINEAS

IMPRIMIR : 'pr_print'  ETS  ';' {$$ = new imprimir($2,@1.first_line, @1.first_column );}
;
IMPRIMIRLN : 'pr_println'  ETS  ';' {$$ = new imprimir($2,@1.first_line, @1.first_column );}
;

//BLOQUE DE INSTRUCCIONES
//BLOQUE: '{' INSTRUCCIONES  '}' {}
//;
//ASIGNACION DE VARIABLES YA DECLARADAS (CAMBIO DE VALOR)
ASIGNACION : 'id' '=' ETS ';' {$$= new Asignacion($1,$3, @1.first_line, @1.first_column);}  
            |'id' '[' E ']' '=' ETS ';' {} 
            |'id' '[' E ']''[' E ']' '=' ETS ';' {} 
;


//DECLARACION DE VARIABLES NO DECLARADAS SINGULAR O EN CONJUNTO, FINALES O NO FINALES, INCLUYE EXPRESIONES


TIPO_DECLARACION_CONST: 'pr_const'; 
TIPODATO_DECLARACION  :  'pr_numero' {$$=Type.NUMBER}
                       | 'pr_bool'    {$$=Type.BOOLEAN}
                       | 'pr_string' {$$=Type.STRING}
                       | 'pr_double' {$$=Type.NUMBER}
                       | 'pr_char' {$$=Type.STRING}
                       ; 

DECLARACION : TIPODATO_DECLARACION  IDS   '=' ETS ';'  {$$=new Declaracion(false,$1, $2,$4, @1.first_line, @1.first_column)}
            ;
DECLARACION_VECTORES:TIPODATO_DECLARACION '[' ']' IDS '=' 'pr_new' TIPODATO_DECLARACION '[' ETS ']'';' {$$= new DeclaracionARRAY(false, $1,$4,null, $9,null,false,@1.first_line, @1.first_column)}
                    |TIPODATO_DECLARACION '[' ']' '[' ']' IDS '=' 'pr_new' TIPODATO_DECLARACION '[' ETS ']' '[' ETS ']' ';' {$$= new DeclaracionARRAY(false, $1,$2,null, $11,$14,true,@1.first_line, @1.first_column)}
                    |TIPODATO_DECLARACION '[' ']' IDS '=' PARALISTA ';' {$$= new DeclaracionARRAY(false, $1,$4,$6,null,null,false,@1.first_line, @1.first_column)}
                    ||TIPODATO_DECLARACION '[' ']' '[' ']' IDS '=' LISTADELISTAS ';' {$$= new DeclaracionARRAY(false, $1,$6,$8,null,null,true,@1.first_line, @1.first_column)}
;
INSTANCIA: TIPODATO_DECLARACION  IDS {$$=new Declaracion(false,$1, $2,new Literal("0",Type.NUMBER , @1.first_line, @1.first_column), @1.first_line, @1.first_column)}
;
AUMENTO : 'id' '+' '+'  {$$= new Arithmetic(new Literal($1,Type.VARIABLE , @1.first_line, @1.first_column),null,AritmeticOption.SOBRESUMA, @1.first_line, @1.first_column);}
        | 'id' '-' '-'  {$$= new Arithmetic(new Literal($1,Type.VARIABLE , @1.first_line, @1.first_column),null,AritmeticOption.SOBRERESTA, @1.first_line, @1.first_column);}
;


ETS :   /*'(' TIPODATO_DECLARACION ')'  ETS {}
        | 'pr_TL' '(' ETS ')'{}
        | 'pr_TU' '(' ETS ')'{}
        | 'pr_round' '(' ETS ')'{}
        | 'pr_len' '(' ETS ')'{}
        | 'pr_typeof' '(' ETS ')'{}
        | 'pr_TS' '(' ETS ')'{}
        | 'pr_TCA' '(' ETS ')'{}
        | COMPARACIONES {}*/
        | E {$$=$1;} 
        //| INSTRUCCION {}
; 


IDS : IDS ',' 'id' {$1.push($3); $$=$1;}
    | 'id'{$$ = [$1]}
    ;
COMPARACIONES: '!' '(' COMPARACIONES ')' {$$= new Relacional(null,$2,RelacionalOption.NEGACION, @1.first_line, @1.first_column);}
            |  COMPARACIONES '&&' COMP {$$= new Relacional($1,$3,RelacionalOption.AND, @1.first_line, @1.first_column);}
            |  COMPARACIONES '||' COMP {$$= new Relacional($1,$3,RelacionalOption.OR, @1.first_line, @1.first_column);}
            |   COMP  {$$=$1;}  
;
COMP:  E '<' E {$$= new Relacional($1,$3,RelacionalOption.MENOR, @1.first_line, @1.first_column);}
    |  E '>''=' E  {$$= new Relacional($1,$3,RelacionalOption.MAYORIGUAL, @1.first_line, @1.first_column);}
    |  E '<''=' E  {$$= new Relacional($1,$3,RelacionalOption.MENORIGUAL, @1.first_line, @1.first_column);}
    |  E '>' E     {$$= new Relacional($1,$3,RelacionalOption.MAYOR, @1.first_line, @1.first_column);}
    |  E '!''=' E   {$$= new Relacional($1,$3,RelacionalOption.NOIGUAL, @1.first_line, @1.first_column);}
    |  E '=''=' E   {$$= new Relacional($1,$3,RelacionalOption.IGUAL, @1.first_line, @1.first_column);}
;



E: E '+' Term {$$= new Arithmetic($1,$3,AritmeticOption.MAS, @1.first_line, @1.first_column);}
|E '-' Term {$$= new Arithmetic($1,$3,AritmeticOption.MENOS, @1.first_line, @1.first_column);} 
|'-' Term {{$$= new Arithmetic(new Literal("0",Type.NUMBER , @1.first_line, @1.first_column),$2,AritmeticOption.MENOS, @1.first_line, @1.first_column);} }
| AUMENTO {$$=$1;} 
//| E '-' '-' {}
//|CALL {}
|Term  {$$=$1;} 
;

Term: Term '*' Factor {$$= new Arithmetic($1,$3,AritmeticOption.MULTIPLICACION, @1.first_line, @1.first_column);}
|Term '/' Factor {$$= new Arithmetic($1,$3,AritmeticOption.DIVISION, @1.first_line, @1.first_column);}
| Term '%' Factor  {$$= new Arithmetic($1,$3,AritmeticOption.MODULO, @1.first_line, @1.first_column);}
|  Term '^' '[' E ']' {$$= new Arithmetic($1,$4,AritmeticOption.POTENCIA, @1.first_line, @1.first_column);}
|Factor {$$=$1;} 
;




Factor: '(' E ')' {$$=$2;} 
    | F {$$=$1;} 
    
;
F: expreR_numero {$$=new Literal($1,Type.NUMBER , @1.first_line, @1.first_column)}
    | 'true' {$$=new Literal($1,Type.BOOLEAN, @1.first_line, @1.first_column)}
    | 'false' {$$=new Literal($1,Type.BOOLEAN, @1.first_line, @1.first_column)}
    |expreR_cadena {$$=new Literal($1,Type.STRING , @1.first_line, @1.first_column)}
    |expreR_cadenita() {$$=new Literal($1,Type.STRING , @1.first_line, @1.first_column)}
    |TIPODATO_DECLARACION {}
    |CALL {$$=$1;}
    |'id' '[' E ']'
    |'id' '[' E ']''[' E ']'
    | E  E {$$=$2;}
    | 'pr_TL'  E {$$=$1;}
    | 'pr_TU'  E {$$=$1;}
    | 'pr_round'  E {$$=$1;}
    | 'pr_len'  E {$$=$1;}
    | 'pr_typeof'  E {$$=$1;}
    | 'pr_TS'  E {$$=$1;}
    | 'pr_TCA'  E {$$=$1;}
    | COMPARACIONES {$$=$1;} 
    | 'id' {$$=new Literal($1,Type.VARIABLE , @1.first_line, @1.first_column)}
;
// INSSTRUCCION FOR
