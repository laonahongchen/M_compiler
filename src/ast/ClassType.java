package ast;

public class ClassType extends TypeNode {
    public String name;

    public ClassType() {
        name = null;
    }
    public ClassType(String name) {
        this.name = name;
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
