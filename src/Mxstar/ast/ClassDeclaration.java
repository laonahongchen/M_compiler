package Mxstar.Ast;

import Mxstar.Symbol.ClassSymbol;

import java.util.List;

public class ClassDeclaration extends  Declaration {
    public String name;

    public List<VariableDeclaration> fields;
    public List<FuncDeclaration> methods;
    public FuncDeclaration construct = null;

    public ClassSymbol symbol;

    @Override
    public String toString() {
        return name + '\n';
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
