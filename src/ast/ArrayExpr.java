package ast;

public class ArrayExpr extends Expression{
    public Expression Expr;
    public Expression idx;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
