#Ast Design

## Non-Terminal :

AstNode

  AstProgram
  
  Declaration
  
  TypeNode
  
    ArrayType
    
    PrimitiveType
    
    ClassType
    
  Statement
  
    ConditionStmt
    LoopStmt
    JumpStmt
    BlockStmt
    ExprStmt
    EmptyStmt
  
  Expression
  
    IntConstant
    BoolConstant
    StringConstant
    NullConstant
    Identifier
    ArrayExpr
    FuncCallExpr
    NewExpr
    UnaryExpr
    MembExpr
    BinExpr
    AssignExpr
