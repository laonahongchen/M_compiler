package Mxstar.Ast;

public class UnaryExpr extends Expression {
    public String op;
    public Expression expr;


    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
