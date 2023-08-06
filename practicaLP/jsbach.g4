grammar jsbach;

root : function* EOF;

instr:  assignacion 
		| while
		| condicional 
        | write
        | lectura
        | reproduccion
        | invocacion
        | crearLlista
        | afegirLlista
        | eliminarLlista
    ;

expr:	'(' expr ')'
        | VAR '[' expr* ']'
		| expr (IGUALTAT | DESIGUALTAT | MENOR | MAJOR | MENOR_IGUAL | MAJOR_IGUAL) expr
		| expr (DIV | MUL | MOD) expr
		| expr (MES | RES) expr
    	| (NUM | VAR | NOTA | LENTGHLIST)
    ;

assignacion : VAR '<-' expr;

write : '<!>' (expr | STRING | ('[' expr* ']'))*;

lectura : '<?>' VAR;

reproduccion : '<:>' (expr | '{' expr* '}');

condicional : 'if' expr ABRE instr* CIERRA sino;

sino : 'else' ABRE instr* CIERRA | ;

while : 'while' expr ABRE instr* CIERRA;

function : ID VAR* ABRE instr* CIERRA;

crearLlista : VAR '<-' '{' expr* '}';

afegirLlista : VAR '<<' expr;

eliminarLlista : '8<' VAR '[' expr ']';

LENTGHLIST : '#' VAR;

invocacion : ID expr*;

IGUALTAT : '=';

DESIGUALTAT : '/=';

MENOR : '<';

MAJOR : '>';

MENOR_IGUAL : '<=';

MAJOR_IGUAL : '>=';

NUM : '-'? [0-9]+ ;

NOTA : [A-G] [0-8]*;

VAR : [a-z] [a-zA-Z_0-9\u0080-\u00FF]*;

ID :[A-Z] ([a-zA-Z\u0080-\u00FF]|'_')*;

STRING : '"' .*? '"';

MOD : '%';

DIV : '/';

MUL : '*';

MES : '+' ;

RES : '-';

ABRE : '|:';

CIERRA : ':|';

COMMENT : '~~~' .*? '~~~' -> skip ; 

WS : [ \n]+ -> skip ;
