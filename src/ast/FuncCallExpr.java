package ast;

import java.util.List;

public class FuncCallExpr extends Expression {
    public String functionName;
    public List<Expression> arguments;


    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
