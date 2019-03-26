package ast;

import parser.MxstarParser;
import symbol.VariableSymbol;
import symbol.VariableType;

public abstract class Expression extends AstNode {
    public VariableType type;
    public boolean modifiable;
}
