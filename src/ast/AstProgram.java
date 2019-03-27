package ast;

import java.util.LinkedList;
import java.util.List;

public class AstProgram extends AstNode{
    public List<FuncDeclaration> funcDeclarations;
    public List<ClassDeclaration> classDeclarations;
    public List<VariableDeclaration> globalVariables;
    public List<Declaration> declarations;

    public AstProgram() {
        funcDeclarations = new LinkedList<>();
        classDeclarations = new LinkedList<>();
        globalVariables = new LinkedList<>();
        declarations = new LinkedList<>();
    }

    public void add(FuncDeclaration funcDeclaration) {
        this.funcDeclarations.add(funcDeclaration);
        declarations.add(funcDeclaration);
    }

    public void add(ClassDeclaration classDeclaration) {
        this.classDeclarations.add(classDeclaration);
        declarations.add(classDeclaration);
    }

    public void addAll(List<VariableDeclaration> variableDeclaration) {
        this.globalVariables.addAll(variableDeclaration);
        declarations.addAll(variableDeclaration);
    }

    public void accept(IAstVisitor visitor) {
        visitor.visit(this);
    }
}
