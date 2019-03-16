package semanticError;
import ast.AstNode;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;



public class Location {
    private final int line, col;


    public Location(int line, int col) {
        this.line = line;
        this.col = col;
    }

    public Location(Token token) {
        this.line = token.getLine();
        this.col = token.getCharPositionInLine();
    }

    public Location(ParserRuleContext ctx) {
        this(ctx.start);
    }

    public Location(AstNode node) {
        this.line = node.location.line;
        this.col = node.location.col;
    }

    public int getLine() {
        return line;
    }
    public int getcol() {
        return col;
    }

    @Override
    public String toString() {
        return '(' + line + ',' + col + ")";
    }
}
