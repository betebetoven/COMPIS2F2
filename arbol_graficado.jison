%{
    //codigo en JS
    //importaciones y declaraciones
    const {listaenlazada} = require('./listaenlazada.js');
    const {nodo} = require('./nodo.js');
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
            |DECLARACION_VECTORES {console.log("reconocio sentencia DECLARACION VECTOR")}
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
PAR : TIPODATO_DECLARACION  'id' { p =new listaenlazada();
                                    p.agrega(new nodo("TIPO_DATO")); 
                                    p.agrega(new nodo($1));
                                    p.agrega(new nodo("VARIABLE")); 
                                    $$ = p;
                                    }
;






















PARAMETROSLL : '(' PARSLL ')' { p = new listaenlazada();
                            p.agrega(new nodo("ABRE_PARENTESIS"));
                            p.agrega(new nodo("PARAMETROS")); 
                            p.agrega(new nodo($2)); 
                            p.agrega(new nodo("CIERRA_PARENTESIS"));
                            $$ = p;}
;













PARSLL : PARSLL ',' E    {                   p = $1; 
                                            p.agrega(new nodo("COMA"));
                                            p.agrega(new nodo("E")); 
                                            p.agrega(new nodo($3));  
                                            $$ = p;
                                            }
     | E {              p =new listaenlazada();
                        p.agrega(new nodo("E")); 
                        p.agrega(new nodo($1)); 
                        $$ = p;}
;














//sin parametros

FUNCIONsp: 'id'  '(' ')' ':' TIPODATO_DECLARACION  '{' INSTRUCCIONES '}'{ p = new listaenlazada(); 
                                                p.agrega(new nodo("VARIABLE"));
                                                p.agrega(new nodo("ABRE_PARENTESIS")); 
                                                p.agrega(new nodo("CIERRA_PARENTESIS"));
                                                p.agrega(new nodo("DOS_PUNTOS"));
                                                p.agrega(new nodo("TIPO_DATO_DECLARACION"));
                                                p.agrega(new nodo($5));
                                                p.agrega(new nodo("ABRE_CORCHETE"));
                                                p.agrega(new nodo("BLOQUE_INSTRUCCIONES")); 
                                                p.agrega(new nodo($7));
                                                p.agrega(new nodo("CIERRA_CORCHETE"));
                                                $$ = p;}
;
METODOsp : 'id' '(' ')' ':' 'pr_void'  '{' INSTRUCCIONES '}' { p = new listaenlazada(); 
                                                p.agrega(new nodo("VARIABLE"));
                                                p.agrega(new nodo("ABRE_PARENTESIS")); 
                                                p.agrega(new nodo("CIERRA_PARENTESIS"));
                                                p.agrega(new nodo("DOS_PUNTOS"));
                                                p.agrega(new nodo("VOID"));
                                                p.agrega(new nodo("ABRE_CORCHETE"));
                                                p.agrega(new nodo("BLOQUE_INSTRUCCIONES")); 
                                                p.agrega(new nodo($7));
                                                p.agrega(new nodo("CIERRA_CORCHETE"));
                                                $$ = p;}

        | 'id' '(' ')'   '{' INSTRUCCIONES '}' { p = new listaenlazada(); 
                                                p.agrega(new nodo("VARIABLE"));
                                                p.agrega(new nodo("ABRE_PARENTESIS")); 
                                                p.agrega(new nodo("CIERRA_PARENTESIS"));
                                                p.agrega(new nodo("ABRE_CORCHETE"));
                                                p.agrega(new nodo("BLOQUE_INSTRUCCIONES")); 
                                                p.agrega(new nodo($5));
                                                p.agrega(new nodo("CIERRA_CORCHETE"));
                                                $$ = p;}
;











//EL RETURN

RETURN : 'pr_return' '(' ETS ')' ';'{ p = new listaenlazada(); 
                                p.agrega(new nodo("RETURN"));
                                p.agrega(new nodo("ETS")); 
                                p.agrega(new nodo($3)); 
                                p.agrega(new nodo("PUNTO_Y_COMA"));
                                $$ = p;}
        | 'pr_return' '(' ')' ';'{ p = new listaenlazada(); 
                                p.agrega(new nodo("RETURN"));
                                p.agrega(new nodo("ABRE PARENTESIS")); 
                                p.agrega(new nodo("CIERRA PARENTESIS"));
                                p.agrega(new nodo("PUNTO_Y_COMA"));
                                $$ = p;}
;















//LLAMADA DE FUNCION O METODOS
CALL:  'id' PARAMETROSLL { p = new listaenlazada(); 
                                p.agrega(new nodo("VARIABLE"));
                                p.agrega(new nodo("PARAMETROSLL")); 
                                p.agrega(new nodo($2)); 
                                $$ = p;}
    |  'id' '('')'{ p = new listaenlazada(); 
                                p.agrega(new nodo("VARIABLE"));
                                p.agrega(new nodo("ABRE PARENTESIS")); 
                                p.agrega(new nodo("CIERRA PARENTESIS"));
                                $$ = p;}

;













LISTADEPARSLL: LISTADEPARSLL ',' PARALISTA { p = $1; 
                                            p.agrega(new nodo("COMA"));
                                            p.agrega(new nodo("PARALISTA")); 
                                            p.agrega(new nodo($3));  
                                            $$ = p;
                                            }
            | PARALISTA { p =new listaenlazada();
                        p.agrega(new nodo("PARALISTA")); 
                        p.agrega(new nodo($1)); 
                        $$ = p;}
;
PARALISTA : '{' PARSLL '}' { p = new listaenlazada();
                            p.agrega(new nodo("ABRE_LLAVE"));
                            p.agrega(new nodo("PARAMETROS")); 
                            p.agrega(new nodo($2)); 
                            p.agrega(new nodo("CIERRA_LLAVE"));
                            $$ = p;}

;
LISTADELISTAS : '{' LISTADEPARSLL '}' { p = new listaenlazada();
                            p.agrega(new nodo("ABRE_LLAVE"));
                            p.agrega(new nodo("LISTADEPARSLL")); 
                            p.agrega(new nodo($2)); 
                            p.agrega(new nodo("CIERRA_LLAVE"));
                            $$ = p;}
;

















//INSTRUCCION IMPRIMIR UNA Y VARIAS LINEAS

IMPRIMIR : 'pr_print'  ETS  ';'{ p = new listaenlazada(); 
                                p.agrega(new nodo("IMPRIMIR"));
                                p.agrega(new nodo("ETS")); 
                                p.agrega(new nodo($2)); 
                                p.agrega(new nodo("PUNTO_Y_COMA"));
                                $$ = p;}
;
IMPRIMIRLN : 'pr_println'  ETS  ';'{ p = new listaenlazada(); 
                                p.agrega(new nodo("IMPRIMIRLN"));
                                p.agrega(new nodo("ETS")); 
                                p.agrega(new nodo($2)); 
                                p.agrega(new nodo("PUNTO_Y_COMA"));
                                $$ = p;}
;

//BLOQUE DE INSTRUCCIONES
//BLOQUE: '{' INSTRUCCIONES  '}' {}
//;
//ASIGNACION DE VARIABLES YA DECLARADAS (CAMBIO DE VALOR)













ASIGNACION : IDS '=' ETS ';' { p = new listaenlazada();
                                        p.agrega(new nodo("IDS"));
                                        p.agrega($1);
                                        p.agrega(new nodo("IGUAL"));
                                        p.agrega(new nodo("ETS"));
                                        p.agrega(new nodo($3));
                                        p.agrega(new nodo("PUNTO Y COMA"));
                                        $$ = p;}
            
            |'id' '[' E ']' '=' ETS ';' { p = new listaenlazada();
                                        p.agrega(new nodo("VARIABLE"));
                                        p.agrega(new nodo("ABRE CORCHETE"));
                                        p.agrega(new nodo("E"));
                                        p.agrega($3);
                                        p.agrega(new nodo("CIERRA CORCHETE"));
                                        p.agrega(new nodo("IGUAL"));
                                        p.agrega(new nodo("ETS"));
                                        p.agrega(new nodo($6));
                                        p.agrega(new nodo("PUNTO Y COMA"));
                                        $$ = p;}
            |'id' '[' E ']''[' E ']' '=' ETS ';' { p = new listaenlazada();
                                        p.agrega(new nodo("VARIABLE"));
                                        p.agrega(new nodo("ABRE CORCHETE"));
                                        p.agrega(new nodo("E"));
                                        p.agrega($3);
                                        p.agrega(new nodo("CIERRA CORCHETE"));
                                        p.agrega(new nodo("ABRE CORCHETE"));
                                        p.agrega(new nodo("E"));
                                        p.agrega($6);
                                        p.agrega(new nodo("CIERRA CORCHETE"));
                                        p.agrega(new nodo("IGUAL"));
                                        p.agrega(new nodo("ETS"));
                                        p.agrega(new nodo($9));
                                        p.agrega(new nodo("PUNTO Y COMA"));
                                        $$ = p;}
;


//DECLARACION DE VARIABLES NO DECLARADAS SINGULAR O EN CONJUNTO, FINALES O NO FINALES, INCLUYE EXPRESIONES














TIPO_DECLARACION_CONST: 'pr_const'; 
TIPODATO_DECLARACION  :  'pr_numero' { p = new listaenlazada(); p.agrega( new nodo("TIPO_NUMERO")); $$ = p;}
                       | 'pr_bool'    { p = new listaenlazada(); p.agrega( new nodo("TIPO_BOOLEAN")); $$ = p;}
                       | 'pr_string' { p = new listaenlazada(); p.agrega( new nodo("TIPO_STRING")); $$ = p;}
                       | 'pr_double' { p = new listaenlazada(); p.agrega( new nodo("TIPO_DOUBLE")); $$ = p;}
                       | 'pr_char' { p = new listaenlazada(); p.agrega( new nodo("TIPO_CHAR")); $$ = p;}
                       ; 










DECLARACION : INSTANCIA  '=' ETS ';'  { p = new listaenlazada();
                                        p.concatena($1);
                                        p.agrega(new nodo("IGUAL"));
                                        p.agrega(new nodo("ETS"));
                                        p.agrega(new nodo($3));
                                        p.agrega(new nodo("PUNTO Y COMA"));
                                        $$ = p;}
            
            
            
            ;




DECLARACION_VECTORES:TIPODATO_DECLARACION '[' ']' 'id' '=' 'pr_new' TIPODATO_DECLARACION '[' ETS ']'';'{ p = new listaenlazada();
                                                                                                        p.agrega(new nodo("TIPO_DATO_DECLARACION"));
                                                                                                        p.agrega(new nodo($1));
                                                                                                        p.agrega(new nodo("ABRE_CORCHETE"));
                                                                                                        p.agrega(new nodo("CIERRACORCHETE"));
                                                                                                        p.agrega(new nodo("VARIABLE"));
                                                                                                        p.agrega(new nodo("IGUAL"));
                                                                                                        p.agrega(new nodo("NEW"));
                                                                                                        p.agrega(new nodo("TIPO_DATO_DECLARACION"));
                                                                                                        p.agrega(new nodo($7));
                                                                                                        p.agrega(new nodo("ABRE_CORCHETE"));
                                                                                                        p.agrega(new nodo("ETS"));
                                                                                                        p.agrega(new nodo($9));
                                                                                                        p.agrega(new nodo("CIERRACORCHETE"));
                                                                                                        p.agrega(new nodo("PUNTO_Y_COMA"));
                                                                                                          $$ = p;}
                    |TIPODATO_DECLARACION '[' ']' '[' ']' 'id' '=' 'pr_new' TIPODATO_DECLARACION '[' ETS ']' '[' ETS ']' ';'{ p = new listaenlazada();
                                                                                                        p.agrega(new nodo("TIPO_DATO_DECLARACION"));
                                                                                                        p.agrega(new nodo($1));
                                                                                                        p.agrega(new nodo("ABRE_CORCHETE"));
                                                                                                        p.agrega(new nodo("CIERRACORCHETE"));
                                                                                                        p.agrega(new nodo("ABRE_CORCHETE"));
                                                                                                        p.agrega(new nodo("CIERRACORCHETE"));
                                                                                                        p.agrega(new nodo("VARIABLE"));
                                                                                                        p.agrega(new nodo("IGUAL"));
                                                                                                        p.agrega(new nodo("NEW"));
                                                                                                        p.agrega(new nodo("TIPO_DATO_DECLARACION"));
                                                                                                        p.agrega(new nodo($9));
                                                                                                        p.agrega(new nodo("ABRE_CORCHETE"));
                                                                                                        p.agrega(new nodo("ETS"));
                                                                                                        p.agrega(new nodo($11));
                                                                                                        p.agrega(new nodo("CIERRACORCHETE"));
                                                                                                         p.agrega(new nodo("ABRE_CORCHETE"));
                                                                                                        p.agrega(new nodo("ETS"));
                                                                                                        p.agrega(new nodo($14));
                                                                                                        p.agrega(new nodo("CIERRACORCHETE"));
                                                                                                        p.agrega(new nodo("PUNTO_Y_COMA"));
                                                                                                          $$ = p;}
                    |TIPODATO_DECLARACION '[' ']' 'id' '=' PARALISTA ';'{ p = new listaenlazada();
                                                                                                        p.agrega(new nodo("TIPO_DATO_DECLARACION"));
                                                                                                        p.agrega(new nodo($1));
                                                                                                        p.agrega(new nodo("ABRE_CORCHETE"));
                                                                                                        p.agrega(new nodo("CIERRACORCHETE"));
                                                                                                        p.agrega(new nodo("VARIABLE"));
                                                                                                        p.agrega(new nodo("IGUAL"));
                                                                                                        p.agrega(new nodo("PARALISTA"));
                                                                                                        p.agrega(new nodo($6));
                                                                                                        p.agrega(new nodo("PUNTO_Y_COMA"));
                                                                                                          $$ = p;}
                    |TIPODATO_DECLARACION '[' ']' '[' ']' 'id' '=' LISTADELISTAS ';'{ p = new listaenlazada();
                                                                                                        p.agrega(new nodo("TIPO_DATO_DECLARACION"));
                                                                                                        p.agrega(new nodo($1));
                                                                                                        p.agrega(new nodo("ABRE_CORCHETE"));
                                                                                                        p.agrega(new nodo("CIERRACORCHETE"));
                                                                                                        p.agrega(new nodo("ABRE_CORCHETE"));
                                                                                                        p.agrega(new nodo("CIERRACORCHETE"));
                                                                                                        p.agrega(new nodo("VARIABLE"));
                                                                                                        p.agrega(new nodo("IGUAL"));
                                                                                                        p.agrega(new nodo("LISTADELISTAS"));
                                                                                                        p.agrega(new nodo($8));
                                                                                                        p.agrega(new nodo("PUNTO_Y_COMA"));
                                                                                                          $$ = p;}
;









INSTANCIA: TIPODATO_DECLARACION  IDS { p = new listaenlazada();
                                    p.agrega(new nodo("TIPO_DATO_DECLARACION"));
                                    p.agrega(new nodo($1)); 
                                    p.agrega(new nodo("IDS")); 
                                    p.agrega(new nodo($2));
                                     $$ = p;}
;








DECLARACION_INTERNA : E IDS '=' ETS {}
            ;








AUMENTO : 'id' '+' '+'  { p = $1; p.agrega(new nodo("MAS")); p.agrega(new nodo("MAS"));  $$ = p;}
        | 'id' '-' '-'  { p = $1; p.agrega(new nodo("MAENOS")); p.agrega(new nodo("MENOS"));  $$ = p;}
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
        | E { p = new listaenlazada(); p.agrega(new nodo("E")); p.agrega(new nodo($1)); $$ = p;}
        //| INSTRUCCION {}
; 
















IDS : IDS ',' 'id' { p = $1; p.agrega(new nodo("COMA"));p.agrega(new nodo("VARIABLE")); $$ = p;}
    | 'id' { p =new listaenlazada();p.agrega(new nodo("VARIABLE")); $$ = p;}
    ;











COMPARACIONES: '!' '(' COMPARACIONES ')' { p = new listaenlazada(); p.agrega(new nodo("NOT")); p.agrega(new nodo("ABRE_PARENTESIS"));  p.concatena($3); p.agrega(new nodo("CIERRA_PARENTESIS_PARENTESIS"));$$ = p;}
            |  COMPARACIONES '&&' COMP { p = $1; p.agrega(new nodo("AND")); p.concatena($3);  $$ = p;}
            |  COMPARACIONES '||' COMP { p = $1; p.agrega(new nodo("OR")); p.concatena($3);  $$ = p;}
            |   COMP  { p = $1; $$ = p;} 
;













COMP:  E '<' E { p = $1; p.agrega(new nodo("ES_MENOR")); p.concatena($3);  $$ = p;}
    |  E '>''=' E  { p = $1; p.agrega(new nodo("ES_MAYOR_IGUAL")); p.concatena($4);  $$ = p;}
    |  E '<''=' E  { p = $1; p.agrega(new nodo("ES_MENOR_IGUAL")); p.concatena($4);  $$ = p;}
    |  E '>' E     { p = $1; p.agrega(new nodo("ES_MAYOR")); p.concatena($3);  $$ = p;}
    |  E '!''=' E   { p = $1; p.agrega(new nodo("ES_DIFERENTE")); p.concatena($4);  $$ = p;}
    |  E '=''=' E   { p = $1; p.agrega(new nodo("ES_IGUAL")); p.concatena($4);  $$ = p;}
;















E: E '+' Term { p = $1; p.agrega(new nodo("MAS")); p.concatena($3);  $$ = p;}
|E '-' Term { p = $1; p.agrega(new nodo("MENOS")); p.concatena($3);  $$ = p;}
|'-' Term {p = new listaenlazada(); p.agrega(new nodo("MENOS"));  p.concatena($2); $$ = p;}
| AUMENTO {$$=$1}
//| E '-' '-' {}
//|CALL {}
|Term  {$$=$1}
;












Term: Term '*' Factor { p = $1; p.agrega(new nodo("POR")); p.concatena($3);  $$ = p;}
|Term '/' Factor { p = $1; p.agrega(new nodo("DIVIDIDO")); p.concatena($3);  $$ = p;}
| Term '%' Factor  { p = $1; p.agrega(new nodo("MOD")); p.concatena($3);  $$ = p;}
|  Term '^' '[' E ']' { p = $1; p.agrega(new nodo("POTENCIA")); p.agrega(new nodo("ABRE_CORCHETE"));p.concatena($4);p.agrega(new nodo("CIERRA_CORCHETE"));  $$ = p;}
|Factor {$$=$1}
;









Factor: '(' E ')'  { p = new listaenlazada();p.agrega(new nodo("ABRE_ARENTESIS"));p.concatena($2);p.agrega(new nodo("CIERRA_PARENTESIS"));$$= p;}
    | F { FE = new listaenlazada();
    if($1.constructor.name!="listaenlazada")
    {
     FE.agrega($1);
     }
     else
     {
        FE.concatena($1);
     }
     $$= FE;}
    
;














F: expreR_numero {$$= new nodo("INT");}
    | 'true' {$$= new nodo("TRUE");}
    | 'false' {$$= new nodo("FALSE");}
    |expreR_cadena {$$= new nodo("FRASE");}
    |expreR_cadenita() {$$ = new nodo("FRASECITA");}
    |TIPODATO_DECLARACION {$$=$1}
    |CALL {$$=$1}
    |'id' '[' E ']' { p = new listaenlazada();p.agrega(new nodo("VARIABLE"));p.agrega(new nodo("ABRE_CORCHETE"));p.concatena($3);p.agrega(new nodo("CIERRA_CORCHETE"));$$= p;}
    |'id' '[' E ']''[' E ']' { p = new listaenlazada();p.agrega(new nodo("VARIABLE"));p.agrega(new nodo("ABRE_CORCHETE"));p.concatena($3);p.agrega(new nodo("CIERRA_CORCHETE"));p.agrega(new nodo("ABRE_CORCHETE"));p.concatena($6);p.agrega(new nodo("CIERRA_CORCHETE"));$$= p;}
    | E  E { p = new listaenlazada();p.concatena($1);p.concatena($2);$$= p;}
    | 'pr_TL'  E { p = new listaenlazada();p.agrega(new nodo("TO_LOWER"));p.concatena($2);$$= p;}
    | 'pr_TU'  E { p = new listaenlazada();p.agrega(new nodo("TO_UPPER"));p.concatena($2);$$= p;}
    | 'pr_round'  E { p = new listaenlazada();p.agrega(new nodo("ROUND"));p.concatena($2);$$= p;}
    | 'pr_len'  E { p = new listaenlazada();p.agrega(new nodo("LENGTH"));p.concatena($2);$$= p;}
    | 'pr_typeof'  E { p = new listaenlazada();p.agrega(new nodo("TYPE_OF"));p.concatena($2);$$= p;}
    | 'pr_TS'  E { p = new listaenlazada();p.agrega(new nodo("TO_STRING"));p.concatena($2);$$= p;}
    | 'pr_TCA'  E { p = new listaenlazada();p.agrega(new nodo("TO_CHAR_ARRAY"));p.concatena($2);$$= p;}
    | COMPARACIONES {$$=$1}
    | 'id' {$$= new nodo("VARIABLE");}
;
// INSSTRUCCION FOR
