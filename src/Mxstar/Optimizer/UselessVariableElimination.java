package Mxstar.Optimizer;

import Mxstar.Ast.*;
import Mxstar.Symbol.ArrayType;
import Mxstar.Symbol.VariableSymbol;

import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;

public class UselessVariableElimination implements IAstVisitor {
    private HashSet<VariableSymbol> usedVariables;
    public AstProgram astProgram;
    private HashMap<AstNode,  HashSet<VariableSymbol>> usedSymbol;
    private HashMap<AstNode, HashSet<VariableSymbol>> definedSymbol;
    private LinkedList<Boolean> inAssign;
    private boolean getDefines;
    private boolean getUses;

    public UselessVariableElimination(AstProgram astProgram) {
        this.astProgram = new AstProgram();
        usedVariables = new HashSet<>();
        usedSymbol = new HashMap<>();
        definedSymbol = new HashMap<>();
        inAssign = new LinkedList<>();
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
        getUses = false;
        getDefines = true;
        for (FuncDeclaration d : node.funcDeclarations) {
            d.accept(this);
        }
        getDefines = false;
        getUses = true;
        for (FuncDeclaration d: node.funcDeclarations) {
            d.accept(this);
        }
        getUses = false;
        for (FuncDeclaration d: node.funcDeclarations) {
            d.accept(this);
        }
    }

    @Override
    public void visit(Declaration node) {

    }

    private void remove(List<Statement> list) {
        LinkedList<Statement> needRemove = new LinkedList<>();
        for (Statement st: list) {
            if (shouldRemove(st)) {
                needRemove.add(st);
            } else {
                st.accept(this);
            }
        }
        list.removeAll(needRemove);
    }

    @Override
    public void visit(ClassDeclaration node) {

    }

    @Override
    public void visit(FuncDeclaration node) {
        if (getUses || getDefines) {
            for (Statement st: node.body) {
                st.accept(this);
            }
        } else {
            remove(node.body);
        }
    }

    private void update(AstNode a, AstNode b) {
        definedSymbol.get(a).addAll(definedSymbol.get(b));
        usedSymbol.get(a).addAll(usedSymbol.get(b));
    }

    private void propagate(AstNode node, AstNode... used) {
        if (!shouldRemove(node)) {
            for (AstNode u: used) {
                if (u != null) {
                    usedVariables.addAll(usedSymbol.get(u));
                }
            }
        }
    }

    private void init(AstNode node) {
        definedSymbol.put(node, new HashSet<>());
        usedSymbol.put(node, new HashSet<>());
    }

    @Override
    public void visit(VariableDeclaration node) {
        if (getDefines) {
            init(node);
            if (node.init != null) {
                node.init.accept(this);
                update(node, node.init);
            }
            definedSymbol.get(node).add(node.symbol);
        } else if (getUses) {
            if (node.init != null) {
                propagate(node, node.init);
                node.init.accept(this);
            }
        }
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
        if (getDefines) {
            init(node);
            if (node.startStmt != null) {
                node.startStmt.accept(this);
                update(node, node.startStmt);
            }
            if (node.condition != null) {
                node.condition.accept(this);
                update(node, node.condition);
            }
            if (node.updateStmt != null) {
                node.updateStmt.accept(this);
                update(node, node.updateStmt);
            }
            if (node.body != null) {
                node.body.accept(this);
                update(node, node.body);
            }
        } else if (getUses) {
            propagate(node, node.startStmt, node.updateStmt, node.condition, node.body);
            if (node.body != null) {
                node.body.accept(this);
            }
            if (node.startStmt != null) {
                node.startStmt.accept(this);
            }
            if (node.updateStmt != null) {
                node.updateStmt.accept(this);
            }
            if (node.condition != null) {
                node.condition.accept(this);
            }
        } else {
            if (node.body != null) {
                node.body.accept(this);
            }
        }
    }

    @Override
    public void visit(JumpStmt node) {
        if (getDefines) {
            init(node);
            if (node.isReturn && node.retExpr != null) {
                node.retExpr.accept(this);
                update(node, node.retExpr);
                usedVariables.addAll(usedSymbol.get(node.retExpr));
            }
        } else if (getUses) {
            if (node.isReturn && node.retExpr != null) {
                node.retExpr.accept(this);
            }
        }
    }

    @Override
    public void visit(ConditionStmt node) {
        if (getDefines) {
            init(node);
            node.expression.accept(this);
            update(node, node.expression);
            node.thenStmt.accept(this);
            update(node, node.thenStmt);
            if (node.elseStmt != null) {
                update(node, node.elseStmt);
            }
        } else if (getUses) {
            propagate(node, node.expression);
            node.expression.accept(this);
            node.thenStmt.accept(this);
            if (node.elseStmt != null) {
                node.elseStmt.accept(this);
            }
        } else {
            node.expression.accept(this);
            node.thenStmt.accept(this);
            if (node.elseStmt != null) {
                node.elseStmt.accept(this);
            }
        }
    }

    @Override
    public void visit(BlockStmt node) {
        if (getDefines) {
            init(node);
            for (Statement st: node.statements) {
                st.accept(this);
                update(node, st);
            }
        } else if (getUses) {
            for (Statement st: node.statements) {
                st.accept(this);
            }
        } else {
            remove(node.statements);
        }
    }

    @Override
    public void visit(VarDeclStmt node) {
        if (getDefines) {
            init(node);
            node.declaration.accept(this);
            update(node, node.declaration);
        } else if (getUses) {
            propagate(node, node.declaration);
            node.declaration.accept(this);
        }
    }

    @Override
    public void visit(ExprStmt node) {
        if (getDefines) {
            init(node);
            node.expression.accept(this);
            update(node, node.expression);
        } else if (getUses) {
            propagate(node, node.expression);
            node.expression.accept(this);
        }
    }

    @Override
    public void visit(Expression node) {

    }

    @Override
    public void visit(Identifier node) {
        if (getDefines) {
            init(node);
            if (inAssign.getLast()) {
                definedSymbol.get(node).add(node.symbol);
            } else {
                definedSymbol.get(node).add(node.symbol);
            }
        }
    }

    @Override
    public void visit(LiteralExpr node) {
        if (getDefines) {
            init(node);
        }
    }

    @Override
    public void visit(ArrayExpr node) {
        if (getDefines) {
            init(node);
            node.expr.accept(this);
            update(node, node.expr);
            inAssign.addLast(false);
            node.idx.accept(this);
            update(node, node.idx);
            inAssign.removeLast();
        }
    }

    @Override
    public void visit(FuncCallExpr node) {
        if (getDefines) {
            init(node);
            for (Expression expression: node.arguments) {
                expression.accept(this);
                update(node,expression);
            }
            if (node.functionSymbol != null && node.functionSymbol.withSideEffect) {
                usedVariables.addAll(usedSymbol.get(node));
            }
        } else if (getUses) {
            for (Expression expression: node.arguments) {
                propagate(node, expression);
                expression.accept(this);
            }
        }
    }

    @Override
    public void visit(NewExpr node) {
        if (getDefines) {
            init(node);
            for (Expression expr: node.expressionDimension) {
                expr.accept(this);
                update(node, expr);
            }
        } else if (getUses) {
            for (Expression expr: node.expressionDimension) {
                propagate(node, expr);
                expr.accept(this);
            }
        }
    }

    @Override
    public void visit(MembExpr node) {
        if (getDefines) {
            init(node);
            node.object.accept(this);
            update(node, node.object);
            if (node.methodCall != null) {
                node.methodCall.accept(this);
                update(node, node.methodCall);
            } else {
                node.fieldAccess.accept(this);
                update(node, node.fieldAccess);
            }
        } else if (getUses) {
            propagate(node, node.object, node.methodCall, node.fieldAccess);
            node.object.accept(this);
            if (node.methodCall != null) {
                node.methodCall.accept(this);
            } else {
                node.fieldAccess.accept(this);
            }
        }
    }

    @Override
    public void visit(UnaryExpr node) {
        if (getDefines) {
            init(node);
            node.expr.accept(this);
            update(node, node.expr);
            if (node.op.contains("++") || node.op.contains("--"))
                definedSymbol.get(node).addAll(usedSymbol.get(node.expr));
        } else if (getUses) {
            propagate(node, node.expr);
            node.expr.accept(this);
        }
    }

    @Override
    public void visit(BinExpr node) {
        if (getDefines) {
            init(node);
            node.lhs.accept(this);
            update(node, node.lhs);
            node.rhs.accept(this);
            update(node, node.rhs);
        } else if (getUses) {
            propagate(node,node.lhs, node.rhs);
            node.lhs.accept(this);
            node.rhs.accept(this);
        }
    }

    @Override
    public void visit(AssignExpr node) {
        if (getDefines) {
            init(node);
            inAssign.addLast(true);
            node.lhs.accept(this);
            update(node, node.lhs);
            inAssign.removeLast();
            node.rhs.accept(this);
            update(node, node.rhs);
            if (node.rhs.type instanceof ArrayType) {
                definedSymbol.get(node).addAll(usedSymbol.get(node.rhs));
            }
        } else if (getUses) {
            propagate(node,node.lhs, node.rhs);
            node.lhs.accept(this);
            node.rhs.accept(this);
        }
    }

    @Override
    public void visit(EmptyStmt node) {
        if (getDefines) {
            init(node);
        }
    }
}
