package Mxstar.Ast;

public class ExprStmt extends Statement {
    public Expression expression;

    public ExprStmt() {
        expression = null;
    }
    public ExprStmt (Expression expression){
        this.expression = expression;
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
