package ast;

public class ConditionStmt extends Statement {
    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
