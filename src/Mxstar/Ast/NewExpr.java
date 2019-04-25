package Mxstar.Ast;

import java.util.List;

public class NewExpr extends Expression {
    public TypeNode typeNode;
    public List<Expression> expressionDimension;
    public int restDimension;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
