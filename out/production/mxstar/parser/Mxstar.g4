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
    : variableType '['empty']'
    | variableTypeBasic
    ;

empty
    :;

variableTypeBasic
    : INT               #intType
    | STRING            #stringType
    | BOOL              #boolType
    | Identifier        #identifierType
    ;



//----------blocks------------
block
    : '{' blockBody* '}'
    ;

blockBody
    : variableDeclaration
    | statement
    ;

statement
    : block
    | expression';'
    | conditionStatement
    | loopStatement
    | jumpStatement
    | ';'
    ;

conditionStatement
    : IF '('expression ')' thenStatement=statement (ELSE elseStatement=statement)?
    ;

jumpStatement
    : CONTINUE';'                                           #continueStmt
    | BREAK';'                                              #breakStmt
    | RETURN expression?';'                                 #returnStmt
    ;

loopStatement
    : WHILE'('expression')'statement                                                            #WhileExpr
    | FOR'('initialize=expression? ';' condition=expression? ';'step=expression?')'statement    #ForEXpr
    ;
//---------Expressions
expression
    : Identifier                                            # primaryExpr
    | THIS                                                  # primaryExpr
    | BoolConstant                                          # primaryExpr
    | StringConstant                                        # primaryExpr
    | IntegerConstant                                       # primaryExpr
    | NULL                                                  # primaryExpr
    | expression '.' (Identifier | functionCall)            # memberExpr
    | expression '[' expression ']'                         # arrayExpr
    | '(' expression ')'                                    # subExpr
    | functionCall                                          # funtionExpr
    | NEW creator                                           # newExpr
    | expression postfix=('++'|'--')                        # unaryExpr
    | prefix=('++' | '--' | '+' | '-')expression            # unaryExpr
    | prefix=('~'|'!')expression                            # unaryExpr
    | expression bop = ('*' | '/' | '%') expression         # binaryExpr
    | expression bop = ('+' | '-') expression               # binaryExpr
    | expression bop = ('>>' | '<<') expression             # binaryExpr
    | expression bop = ('<=' | '>=' | '<' | '>') expression # binaryExpr
    | expression bop = ('==' | '!=') expression             # binaryExpr
    | expression bop = '&' expression                       # binaryExpr
    | expression bop = '^' expression                       # binaryExpr
    | expression bop = '|' expression                       # binaryExpr
    | expression bop = '&&' expression                      # binaryExpr
    | expression bop = '||' expression                      # binaryExpr
    | expression bop = '?' expression ':' expression        # binaryExpr
    | <assoc=right> expression bop='=' expression           # assignExpr
    ;

functionCall
    : Identifier '('(expression (',' expression)*)?')'
    ;

creator
    : variableTypeBasic  (('['expression']')*('['empty']')*|('('empty')'))//--------------------------------'('')' need to be written separately , and if I write it in '()' it would go wrong
  //  | variableTypeBasic ()
    ;


//----------lexer-----------------------------------------------
//----------Reserved Keywords

BOOL : 'bool';
INT : 'int';
STRING: 'string';
NULL: 'null';
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

IntegerConstant
    : [1-9][0-9]*
    | '0'
    ;

StringConstant
    : '"'StringCharacters*'"'
    ;

fragment StringCharacters
    : ~["\\\r\n]
    | '\\' ["n\\]
    ;

BoolConstant
    : TRUE
    | FALSE
    ;

Identifier
    : [a-zA-Z][a-zA-Z_0-9]*;

WhiteSpaces : [ \t]+ ->skip;

NewLines: '\r' ? '\n' ->skip;

LineComment:  '//' ~[\r\n]* ->skip;

BlockComment
    :   '/*' .*? '*' -> skip
    ;


