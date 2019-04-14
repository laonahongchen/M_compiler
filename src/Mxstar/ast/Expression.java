package Mxstar.Ast;

import Mxstar.Symbol.VariableType;

public abstract class Expression extends AstNode {
    public VariableType type;
    public boolean modifiable;
}
