package Mxstar.Ast;

public class AssignExpr extends Expression {
    public Expression lhs, rhs;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
