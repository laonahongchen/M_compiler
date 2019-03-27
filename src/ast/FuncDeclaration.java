package ast;

import symbol.FunctionSymbol;

import java.util.LinkedList;
import java.util.List;

public class FuncDeclaration extends  Declaration {
    public TypeNode retType;
    public String name;
    public List<VariableDeclaration> parameters;
    public List<Statement> body;

    public FunctionSymbol symbol;

    public static FuncDeclaration defaultConstructor(String name) {
        FuncDeclaration funcDeclaration = new FuncDeclaration();
        funcDeclaration.name = name;
        funcDeclaration.parameters = new LinkedList<>();
        funcDeclaration.body = new LinkedList<>();
        funcDeclaration.retType = new PrimitiveTypeNode("void");
        return funcDeclaration;
    }

    @Override
    public String toString() {
        return name + '\n';
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
