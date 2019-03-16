package ast;

public class EmptyStmt extends Statement {
    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
