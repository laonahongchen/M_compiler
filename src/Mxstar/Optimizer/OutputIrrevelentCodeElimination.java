package Mxstar.Optimizer;

import Mxstar.Ast.*;
import Mxstar.Symbol.ArrayType;
import Mxstar.Symbol.VariableSymbol;

import java.util.HashMap;
import java.util.HashSet;

public class OutputIrrevelentCodeElimination implements IAstVisitor {
    private HashSet<VariableSymbol> usedVariables;
    public AstProgram astProgram;
    private HashMap<AstNode,  HashSet<VariableSymbol>> usedSymbol;
    private HashMap<AstNode, HashSet<VariableSymbol>> definedSymbol;

    public OutputIrrevelentCodeElimination(AstProgram astProgram) {
        this.astProgram = new AstProgram();
        usedVariables = new HashSet<>();
        usedSymbol = new HashMap<>();
        definedSymbol = new HashMap<>();
    }

    public void run() {
        astProgram.accept(this);
    }

    private boolean shouldRemove(AstNode node) {
        HashSet<VariableSymbol> tmp = new HashSet<>(definedSymbol.get(node));
        tmp.retainAll(usedVariables);
        return tmp.isEmpty();
    }

    @Override
    public void visit(AstProgram node) {
        usedSymbol.clear();

    }

    @Override
    public void visit(Declaration node) {

    }

    @Override
    public void visit(ClassDeclaration node) {

    }

    @Override
    public void visit(FuncDeclaration node) {

    }

    @Override
    public void visit(VariableDeclaration node) {

    }

    @Override
    public void visit(TypeNode node) {

    }

    @Override
    public void visit(ArrayType node) {

    }

    @Override
    public void visit(PrimitiveTypeNode node) {

    }

    @Override
    public void visit(ClassTypeNode node) {

    }

    @Override
    public void visit(Statement node) {

    }

    @Override
    public void visit(LoopStmt node) {

    }

    @Override
    public void visit(JumpStmt node) {

    }

    @Override
    public void visit(ConditionStmt node) {

    }

    @Override
    public void visit(BlockStmt node) {

    }

    @Override
    public void visit(VarDeclStmt node) {

    }

    @Override
    public void visit(ExprStmt node) {

    }

    @Override
    public void visit(Expression node) {

    }

    @Override
    public void visit(Identifier node) {

    }

    @Override
    public void visit(LiteralExpr node) {

    }

    @Override
    public void visit(ArrayExpr node) {

    }

    @Override
    public void visit(FuncCallExpr node) {

    }

    @Override
    public void visit(NewExpr node) {

    }

    @Override
    public void visit(MembExpr node) {

    }

    @Override
    public void visit(UnaryExpr node) {

    }

    @Override
    public void visit(BinExpr node) {

    }

    @Override
    public void visit(AssignExpr node) {

    }
}
