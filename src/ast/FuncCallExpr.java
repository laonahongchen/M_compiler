package ast;

import symbol.FunctionSymbol;

import java.util.List;

public class FuncCallExpr extends Expression {
    public String functionName;
    public List<Expression> arguments;

    public FunctionSymbol functionSymbol;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
