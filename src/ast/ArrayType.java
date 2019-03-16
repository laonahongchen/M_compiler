package ast;

public class ArrayType extends TypeNode{
    public TypeNode arraytype = null;
    public int dim;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
