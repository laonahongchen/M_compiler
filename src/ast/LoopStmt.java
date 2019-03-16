package ast;

import java.util.List;

public class LoopStmt extends Statement {
    public Statement startStmt;
    public Expression condition;
    public Statement updateStmt;
    public Statement body;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
