package ast;


import org.antlr.v4.runtime.Token;
import semanticError.Location;

public class Identifier extends Expression {
    public String name;

    public Identifier(){}
    public Identifier(Token token) {
        this.name = token.getText();
        this.location = new Location(token);
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
