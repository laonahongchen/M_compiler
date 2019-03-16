package ast;

public class PrimitiveType extends TypeNode {
    public String name;

    public PrimitiveType () {
        name = null;
    }
    public PrimitiveType (String name) {
        this.name = name;
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
