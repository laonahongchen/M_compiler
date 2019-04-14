package Mxstar.Ast;

import Mxstar.Symbol.ArrayType;

public interface IAstVisitor {
    void visit(AstProgram node);

    void visit(Declaration node);
    void visit(ClassDeclaration node);
    void visit(FuncDeclaration node);
    void visit(VariableDeclaration node);

    void visit(TypeNode node);
    void visit(ArrayType node);
    void visit(PrimitiveTypeNode node);
    void visit(ClassTypeNode node);

    void visit(Statement node);
    void visit(LoopStmt node);
    void visit(JumpStmt node);
    void visit(ConditionStmt node);
    void visit(BlockStmt node);
    void visit(VarDeclStmt node);
    void visit(ExprStmt node);

    void visit(Expression node);
    void visit(Identifier node);
    void visit(LiteralExpr node);
    void visit(ArrayExpr node);
    void visit(FuncCallExpr node);
    void visit(NewExpr node);
    void visit(MembExpr node);
    void visit(UnaryExpr node);
    void visit(BinExpr node);
    void visit(AssignExpr node);
}
