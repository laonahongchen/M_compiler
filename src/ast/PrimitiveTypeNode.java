package ast;

public class PrimitiveTypeNode extends TypeNode {
    public String name;

    public PrimitiveTypeNode () {
        name = null;
    }
    public PrimitiveTypeNode (String name) {
        this.name = name;
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
