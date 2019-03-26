package ast;

public class JumpStmt extends Expression {
    public Expression retExpr = null; // if it is a return jump then this will have true value
    public boolean isReturn;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
