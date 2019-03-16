package ast;


import org.antlr.v4.runtime.Token;
import semanticError.Location;

import static parser.MxstarLexer.*;

public class LiteralExpr extends Expression {
    public String typeName;
    public String value;

    public LiteralExpr(Token token) {
        location = new Location(token);
        switch (token.getType()) {
            case Integer_Literal:
                typeName = "int";
                value = token.getText();
                break;
            case NULL_Literal:
                typeName = "null";
                value = token.getText();
                break;
            case Bool_Literal:
                typeName = "bool";
                value = token.getText();
                break;
            default:
                typeName = "String";
                value = escape(token.getText());
        }
    }
    private String escape(String string) {
        StringBuilder stringBuilder = new StringBuilder();
        int len = string.length();
        for(int i = 0; i < len; ++i) {
            char c = string.charAt(i);
            if(c == '\\') {
                char nc = string.charAt(i + 1);
                switch (nc) {
                    case 'n':
                        stringBuilder.append('\n');
                        break;
                    case 't':
                        stringBuilder.append('\t');
                        break;
                    case '\\':
                        stringBuilder.append('\\');
                        break;
                    case '"':
                        stringBuilder.append('"');
                        break;
                    default:
                        stringBuilder.append(nc);

                }
            } else {
                stringBuilder.append(c);
            }
        }
        return stringBuilder.toString();
    }

    @Override public void accept(IAstVisitor visitor) { visitor.visit(this); }

}
