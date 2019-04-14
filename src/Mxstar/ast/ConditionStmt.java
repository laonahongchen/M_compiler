package Mxstar.Ast;

public class ConditionStmt extends Statement {
    public Expression expression;
    public Statement thenStmt;
    public Statement elseStmt;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
