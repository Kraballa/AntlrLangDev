grammar GScript;

program: line+ EOF;

line:
    statement ';'        # statementLine
    | ifBlock            # ifBlockLine
    | whileBlock         # whileBlockLine
    | block              # blockLine
    | functionDefinition # functionDefinitionLine
    | returnStatement    # returnStatementLine;

statement: assignment | functionCall;

ifBlock: 'if' '(' expression ')' block ('else' elseIfBlock)?;

elseIfBlock: block | ifBlock;

whileBlock: 'while' '(' expression ')' block;

block: '{' line* '}';

assignment: (scope '.')? IDENTIFIER assignOp expression;

functionDefinition:
    'function' IDENTIFIER '(' (IDENTIFIER (',' IDENTIFIER)*)? ')' block;

functionCall:
    IDENTIFIER '(' (expression (',' expression)*)? ')';

returnStatement: 'return' expression? ';';

expression:
    constant                          # constantExpression
    | (scope '.')? IDENTIFIER         # identifierExpression
    | functionCall                    # functionCallExpression
    | '(' expression ')'              # enclosedExpression
    | expression '|' type             # typecastExpression
    | unaryOp expression              # unaryExpression
    | expression multOp expression    # multExpression
    | expression addOp expression     # addExpression
    | expression compareOp expression # compareExpression
    | expression andOp expression     # andExpression
    | expression orOp expression      # orExpression
    | expression nullOp expression    # nullCoalescingExpression;

scope: 'global';
type: 'int' | 'float' | 'string' | 'bool';
assignOp: '=' | '+=' | '-=';
multOp: '*' | '/' | '%';
addOp: '+' | '-';
compareOp: '==' | '!=' | '>' | '<' | '>=' | '<=';
andOp: '&';
orOp: '|';
nullOp: '??';
unaryOp: '-' | '!';

constant: INTEGER | FLOAT | STRING | BOOL | NULL;

// lexer

FLOAT: [0-9]+ '.' [0-9]* | '.' [0-9]+;
INTEGER: [0-9]+;
STRING: ('"' ~'"'* '"') | ('\'' ~'\''* '\'');
BOOL: 'true' | 'false';
NULL: 'null';

IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*;

WS: [ \t\r\n]+ -> skip;
COMMENT: '//' ~[\n]+ -> skip;