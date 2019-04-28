package Mxstar.Ast;

import Mxstar.Symbol.VariableSymbol;

public class VariableDeclaration extends  Declaration {
    public TypeNode type;
    public String name;
    public Expression init;

    public VariableSymbol symbol = null;

    public VariableDeclaration() {
        type = null;
        name = null;
        init = null;
    }
    public VariableDeclaration(TypeNode type, String name, Expression init) {
        this.type = type;
        this.name = name;
        this.init = init;
    }

    public VariableDeclaration(TypeNode type, String name, Expression init, VariableSymbol symbol) {
        this.type = type;
        this.name = name;
        this.init = init;
        this.symbol = symbol;
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
