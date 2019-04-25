package Mxstar.Ast;

import Mxstar.SemanticError.Location;

public abstract class AstNode {
    public Location location = null;
    public abstract void accept(IAstVisitor visitor);
}
