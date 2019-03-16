package ast;

public class Declaration extends AstNode{
    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
