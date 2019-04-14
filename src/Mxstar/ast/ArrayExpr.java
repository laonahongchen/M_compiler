package Mxstar.Ast;

public class ArrayExpr extends Expression{
    public Expression expr;
    public Expression idx;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
