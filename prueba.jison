%{
    //codigo en JS
    //importaciones y declaraciones
    //const {Declaracion} = require('./instrucciones/declaracion.js');
    //const {Asignacion} = require('./instrucciones/asignar.js');
    //const {Literal} = require('./expresiones/literal.js')
    //const {Type} = require('./symbols/type.js');
    //const {Arithmetic} = require('./expresiones/aritmeticas.js');
    //const {Acceso} = require('./expresiones/Acceso.js');
    //const {AritmeticOption} = require('./expresiones/aritmeticOption.js');
    //const {Bloque} = require('./instrucciones/Env')
    //const {Imprimir} = require('./instrucciones/imprimir')
   //const {Sentencia_if} = require('./instrucciones/condicionIf')
    //const {metodo} = require('./instrucciones/metodo')
    //const {llamada} = require('./instrucciones/llamada')
    //const { RelacionalOption } = require("./expresiones/relacionalOptions.js");
    //const { Relacional } = require("./expresiones/relacional.js");
    var array_erroresLexicos;
   
%}

%lex
%options case-insensitive

nunumber [0-9]+
//DecIntegerLiteral  0 | [1-9][0-9]*
number [0-9]+"."? [0-9]*
cadena "\"" [^\"]* "\""
cadenita "'" [^']* "'"
bool    "true"|"false"   

%%

\s+                   /* skip whitespace */
"//".*                // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] // comentario multiple líneas












//expresiones regulare


{number}    return 'expreR_numero'
{cadena}    return 'expreR_cadena'
{bool}      return 'expreR_bool'
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
INIT: INSTRUCCIONES    EOF {} ;


INSTRUCCIONES :   INSTRUCCIONES INSTRUCCION {  console.log("s ")}
              |   INSTRUCCION               { console.log("s ") }
              ;


INSTRUCCION : DECLARACION   { console.log("reconocio declaracion ") } 
            | IMPRIMIR      { console.log("reconocio PRINT ") } 
            | IMPRIMIRLN    { console.log("reconocio PRINTLN ") } 
            | ASIGNACION    { console.log("reconocio asignacion ") }
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
            | AUMENTO ';'   {console.log("reconocio sentencia AUMENTO")}
            | INSTANCIA ';'   {console.log("reconocio sentencia INSTANCIA")}
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
PARAMETROSLL : '(' PARSLL ')' 
;
PARSLL : PARSLL ',' E
     | E 
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




//INSTRUCCION IMPRIMIR UNA Y VARIAS LINEAS

IMPRIMIR : 'pr_print'  ETS  ';'
;
IMPRIMIRLN : 'pr_println'  ETS  ';'
;

//BLOQUE DE INSTRUCCIONES
//BLOQUE: '{' INSTRUCCIONES  '}' {}
//;
//ASIGNACION DE VARIABLES YA DECLARADAS (CAMBIO DE VALOR)
ASIGNACION : IDS '=' ETS ';' {} 
            
;


//DECLARACION DE VARIABLES NO DECLARADAS SINGULAR O EN CONJUNTO, FINALES O NO FINALES, INCLUYE EXPRESIONES


TIPO_DECLARACION_CONST: 'pr_const'; 
TIPODATO_DECLARACION  :  'pr_numero' {}
                       | 'pr_bool'    {}
                       | 'pr_string' {}
                       | 'pr_double' {}
                       | 'pr_char' {}
                       ; 

DECLARACION : INSTANCIA  '=' ETS ';'  {}
            ;
INSTANCIA: TIPODATO_DECLARACION  IDS {}
;
DECLARACION_INTERNA : E IDS '=' ETS {}
            ;
AUMENTO : 'id' '+' '+'  {}
        | 'id' '-' '-'  {}
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
        | E {}
        //| INSTRUCCION {}
; 


IDS : IDS ',' 'id' {}
    | 'id' {}
    ;
COMPARACIONES: '!' '(' COMPARACIONES ')' {}
            |  COMPARACIONES '&&' COMP {}
            |  COMPARACIONES '||' COMP {}
            |   COMP  {} 
;
COMP:  E '<' E {}
    |  E '>''=' E  {}
    |  E '<''=' E  {}
    |  E '>' E     {}
    |  E '!''=' E   {}
    |  E '=''=' E   {}
;



E: E '+' Term {}
|E '-' Term {}
|'-' Term {}
| AUMENTO {}
//| E '-' '-' {}
//|CALL {}
|Term  {}
;

Term: Term '*' Factor {}
|Term '/' Factor {}
| Term '%' Factor  {}
|  Term '^' '[' E ']' {}
|Factor {}
;




Factor: '(' E ')' 
    | F
    
;
F: expreR_numero {}
    |expreR_bool {}
    |expreR_cadena {}
    |expreR_cadenita() {}
    |TIPODATO_DECLARACION {}
    |CALL {}
    | E  E {}
    | 'pr_TL'  E {}
    | 'pr_TU'  E {}
    | 'pr_round'  E {}
    | 'pr_len'  E {}
    | 'pr_typeof'  E {}
    | 'pr_TS'  E {}
    | 'pr_TCA'  E {}
    | COMPARACIONES {}
    | 'id' {}
;
// INSSTRUCCION FOR
