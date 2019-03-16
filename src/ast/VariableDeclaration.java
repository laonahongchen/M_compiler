package ast;

public class VariableDeclaration extends  Declaration {
    public TypeNode type;
    public String name;
    public Expression init = null;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
