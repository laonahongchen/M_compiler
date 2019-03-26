package ast;


import org.antlr.v4.runtime.Token;
import semanticError.Location;
import symbol.VariableSymbol;

public class Identifier extends Expression {
    public String name;

    public VariableSymbol symbol;

    public Identifier(){}
    public Identifier(Token token) {
        this.name = token.getText();
        this.location = new Location(token);
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
