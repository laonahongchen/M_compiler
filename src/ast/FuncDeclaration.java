package ast;

import java.util.List;

public class FuncDeclaration extends  Declaration {
    public TypeNode retType;
    public String name;
    public List<VariableDeclaration> parameters;
    public List<Statement> body;

    @Override
    public String toString() {
        return name + '\n';
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
