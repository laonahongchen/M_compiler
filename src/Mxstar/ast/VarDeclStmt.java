package Mxstar.Ast;

public class VarDeclStmt extends Statement {
    public VariableDeclaration declaration;

    @Override public void accept(IAstVisitor visitor) { visitor.visit(this); }
}
