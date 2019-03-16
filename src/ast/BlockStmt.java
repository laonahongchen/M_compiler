package ast;

import java.util.List;

public class BlockStmt extends Statement{
    List<Statement> statements;
    //List<Va>

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
