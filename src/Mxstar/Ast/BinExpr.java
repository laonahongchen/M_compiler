package Mxstar.Ast;

public class BinExpr extends Expression {
    public Expression lhs, rhs;
    public String op;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
