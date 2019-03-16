package ast;

import java.util.List;

public class NewExpr extends Expression {
    public TypeNode type;
    public List<Expression> expressionDimension;
    public int restDimension;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
