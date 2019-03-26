package ast;

import java.util.List;

public class BlockStmt extends Statement{
    public List<Statement> statements;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
