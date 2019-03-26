package ast;

import symbol.VariableSymbol;

public class VariableDeclaration extends  Declaration {
    public TypeNode type;
    public String name;
    public Expression init = null;

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

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
