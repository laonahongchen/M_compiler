package Mxstar.Ast;

public class MembExpr extends Expression{
    public Expression object;
    public Identifier fieldAccess;
    public FuncCallExpr methodCall;

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
