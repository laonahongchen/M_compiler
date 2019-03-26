package ast;

public class ClassTypeNode extends TypeNode {
    public String name;

    public ClassTypeNode() {
        name = null;
    }
    public ClassTypeNode(String name) {
        this.name = name;
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
