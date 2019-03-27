grammar Mxstar;

program
    : declarations* EOF
    ;

declarations
    : functionDefinition
    | classDefinition
    | variableDeclaration
    ;

functionDefinition
    : variableTypeOrVoid Identifier  '(' parameterDeclarationList? ')' block
    ;

classDefinition
    : CLASS Identifier '{' memberDeclaration* '}'
    ;

variableDeclaration
    : variableType variableList ';'
    ;

variableList
    : variableDefinition (','variableDefinition)*
    ;

variableDefinition
    : Identifier ('='expression)?
    ;

memberDeclaration
    : functionDefinition | variableDeclaration | constructDefinition
    ;

constructDefinition
    : Identifier '(' parameterDeclarationList? ')' block
    ;


variableTypeOrVoid
    : variableType
    | VOID
    ;


parameterDeclarationList
    :   parameterDeclaration(','parameterDeclaration)*
    ;

parameterDeclaration
    :   variableType Identifier
    ;

variableType
    : variableTypeBasic( '['empty']')*
//    | variableTypeBasic
    ;

empty
    :;

variableTypeBasic
    : INT
    | STRING
    | BOOL
    | Identifier
    ;



//----------blocks------------
block
    : '{' statement* '}'
    ;
/*
blockBody
    : variableDeclaration
    | statement
    ;
*/
statement
    : block                                                 #blockStmt
    | expression';'                                         #exprStmt
    | conditionStatement                                    #conditionStmt
    | loopStatement                                         #loopStmt
    | jumpStatement                                         #jumpStmt
    | variableDeclaration                                   #variableStmt
    | ';'                                                   #emptyStmt
    ;

conditionStatement
    : IF '('expression ')' thenStatement=statement (ELSE elseStatement=statement)?
    ;

jumpStatement
    : CONTINUE';'
    | BREAK';'
    | RETURN expression?';'
    ;

loopStatement
    : WHILE'('expression')'statement                                                            #WhileExpr
    | FOR'('initialize=expression? ';' condition=expression? ';'step=expression?')'statement    #ForExpr
    ;
//---------Expressions
expression
    : Identifier                                            # primaryExpr
    | THIS                                                  # primaryExpr
    | token=Bool_Literal                                    # primaryExpr
    | token=String_Literal                                  # primaryExpr
    | token=Integer_Literal                                 # primaryExpr
    | token=NULL_Literal                                    # primaryExpr
    | expression '.' (Identifier | functionCall)            # memberExpr
    | NEW creator                                           # newExpr
    | expression '[' expression ']'                         # arrayExpr
    | '(' expression ')'                                    # subExpr
    | functionCall                                          # funtionExpr
    | expression postfix=('++'|'--')                        # unaryExpr
    | prefix=('++' | '--' | '+' | '-')expression            # unaryExpr
    | prefix=('~'|'!')expression                            # unaryExpr
    | expression bop=('*' | '/' | '%') expression           # binaryExpr
    | expression bop=('+' | '-') expression                 # binaryExpr
    | expression bop=('>>' | '<<') expression               # binaryExpr
    | expression bop=('<=' | '>=' | '<' | '>') expression   # binaryExpr
    | expression bop=('==' | '!=') expression               # binaryExpr
    | expression bop='&' expression                         # binaryExpr
    | expression bop='^' expression                         # binaryExpr
    | expression bop='|' expression                         # binaryExpr
    | expression bop='&&' expression                        # binaryExpr
    | expression bop='||' expression                        # binaryExpr
    | expression bop='?' expression ':' expression          # binaryExpr
    | <assoc=right> expression bop='=' expression           # assignExpr
    ;

functionCall
    : Identifier '('(expression (',' expression)*)?')'
    ;

creator
    : variableTypeBasic  (('['expression']')*('['empty']')+('['expression']')+)                    #invalidCreater
    | variableTypeBasic  (('['expression']')*('['empty']')*|('('')'))                              #validCreater   //--------------------------------'('')' need to be written separately , and if I write it in '()' it would go wrong
    ;


//----------lexer-----------------------------------------------
//----------Reserved Keywords

BOOL : 'bool';
INT : 'int';
STRING: 'string';
fragment NULL: 'null';
VOID: 'void';
fragment TRUE: 'true';
fragment FALSE: 'false';
IF: 'if';
ELSE: 'else';
FOR: 'for';
WHILE: 'while';
BREAK: 'break';
CONTINUE: 'continue';
RETURN: 'return';
NEW: 'new';
CLASS: 'class';
THIS: 'this';

//-------------Constant

Integer_Literal
    : [1-9][0-9]*
    | '0'
    ;

NULL_Literal
    : NULL
    ;

String_Literal
    : '"'StringCharacters*'"'
    ;

fragment StringCharacters
    : ~["\\\r\n]
    | '\\' ["n\\]
    ;

Bool_Literal
    : TRUE
    | FALSE
    ;

Identifier
    : [a-zA-Z][a-zA-Z_0-9]*;

WhiteSpaces : [ \t]+ ->skip;

NewLines: '\r' ? '\n' ->skip;

LineComment:  '//' ~[\r\n]* ->skip;

BlockComment
    :   '/*' .*? '*/' -> skip
    ;


