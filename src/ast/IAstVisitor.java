package ast;

public interface IAstVisitor {
    void visit(ArrayExpr node);
    void visit(ArrayType node);
    void visit(AstNode node);
    void visit(AstProgram node);
    void visit(BinExpr node);

    void visit(BlockStmt node);
    void visit(ClassType node);
    void visit(ConditionStmt node);
    void visit(EmptyStmt node);

    void visit(ExprStmt node);
    void visit(FuncCallExpr node);
    void visit(Identifier node);

    void visit(JumpStmt node);
    void visit(LoopStmt node);
    void visit(MembExpr node);
    void visit(NewExpr node);
    void visit(PrimitiveType node);

    void visit(UnaryExpr node);
    void visit(ClassDeclaration node);
    void visit(VariableDeclaration node);
    void visit(FuncDeclaration node);
}
