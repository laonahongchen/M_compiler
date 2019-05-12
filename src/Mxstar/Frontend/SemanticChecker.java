package Mxstar.Frontend;

import Mxstar.Ast.*;
import Mxstar.SemanticError.CompileErrorListener;
import Mxstar.Symbol.*;

public class SemanticChecker implements IAstVisitor {
    private GlobalSymbolTable globalSymbolTable;
    private int loop;
    private FunctionSymbol curFunction;
    private CompileErrorListener errorListener;

    public SemanticChecker(CompileErrorListener errorListener, GlobalSymbolTable globalSymbolTable) {
        this.errorListener = errorListener;
        this.loop = 0;
        this.curFunction = null;
        this.globalSymbolTable = globalSymbolTable;
    }

    @Override
    public void visit(AstProgram node) {
        for (FuncDeclaration d: node.funcDeclarations) {
            d.accept(this);
        }
        if (errorListener.hasError())
            return ;
        for (ClassDeclaration d : node.classDeclarations) {
            d.accept(this);
        }
        if (errorListener.hasError())
            return ;
        for (VariableDeclaration d : node.globalVariables) {
            d.accept(this);
        }
        FunctionSymbol functionSymbol = globalSymbolTable.getFunctionSymbol("main");
        if (functionSymbol == null) {
            errorListener.addError(node.location, "there are some problem with the main function.");
            return ;
        }
//        FunctionSymbol symbol = functionSymbol;
        if (!(functionSymbol.returnType instanceof PrimitiveType && ((PrimitiveType)functionSymbol.returnType).name.equals("int"))) {
            errorListener.addError(node.location, "the main should has return value with integer.");
            return ;
        }
        if (functionSymbol.parameterNames.size() != 0) {
            errorListener.addError(node.location, "the main should not have any parameters.");

        }
    }

    @Override
    public void visit(Declaration node) {
        assert false;
    }

    @Override
    public void visit(ClassDeclaration node) {
        for (FuncDeclaration d : node.methods) {
            d.accept(this);
        }
        if (node.construct != null)
            node.construct.accept(this);
    }

    @Override
    public void visit(FuncDeclaration node) {
        curFunction = node.symbol;
        for (Statement d : node.body) {
            d.accept(this);
        }
    }

    @Override
    public void visit(VariableDeclaration node) {
        if (node.init != null && !node.symbol.variableType.match(node.init.type)) {
            errorListener.addError(node.location, "they should be in the same type!");
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

    private boolean checkBooleanExpr(VariableType type) {
        return !(type instanceof PrimitiveType && ((PrimitiveType) type).name.equals("bool"));
    }

    @Override
    public void visit(LoopStmt node) {
        if (node.startStmt != null)
            node.startStmt.accept(this);

        if (node.condition != null) {
            node.condition.accept(this);
            if (checkBooleanExpr(node.condition.type)) {
                errorListener.addError(node.location, "the condition should be a boolean experssion.");
                return ;
            }
        }
        if (node.updateStmt != null)
            node.updateStmt.accept(this);
        if (node.body != null) {
            loop++;
            node.body.accept(this);
            loop--;
        }
    }

    @Override
    public void visit(JumpStmt node) {
        if (!node.isReturn) {
            if (loop == 0) {
                errorListener.addError(node.location, "here is not in a loop!");
            }
        } else {//return here
//            System.out.println("return!!!");
            VariableType requireType = curFunction.returnType;
            PrimitiveType voidType = new PrimitiveType("void", globalSymbolTable.getPrimitiveSymbol("void"));
            if (requireType.match(voidType) && node.retExpr != null) {
                errorListener.addError(node.location, "we cannot return a value");
                return ;
            }
            VariableType retType;
            if (node.retExpr == null)
                retType = new PrimitiveType("void", globalSymbolTable.getPrimitiveSymbol("void"));
            else
                retType = node.retExpr.type;
//            System.out.println(((PrimitiveType)requireType).name);
//            System.out.println(retType instanceof ClassType);
            if (!requireType.match(retType)) {
                errorListener.addError(node.location, "the return type does not match");
            }
        }
    }

    @Override
    public void visit(ConditionStmt node) {
        node.expression.accept(this);
        if (checkBooleanExpr(node.expression.type)) {
            errorListener.addError(node.location, "the condition expression should be boolean");
            return ;
        }
        node.thenStmt.accept(this);
        if (errorListener.hasError()) {
            return ;
        }
        if (node.elseStmt != null) {
            node.elseStmt.accept(this);
        }
    }

    @Override
    public void visit(BlockStmt node) {
        for (Statement d : node.statements)
            d.accept(this);
    }

    @Override
    public void visit(VarDeclStmt node) {
        node.declaration.accept(this);
    }

    @Override
    public void visit(ExprStmt node) {
        node.expression.accept(this);
    }

    @Override
    public void visit(Expression node) {

    }

    @Override
    public void visit(Identifier node) {
        //if (node.name.equals("this"))
        node.modifiable = (!node.name.equals("this"));
        //else
        //    node.modifiable = true;
    }

    @Override
    public void visit(LiteralExpr node) {
        node.modifiable = false;
    }

    @Override
    public void visit(ArrayExpr node) {
        node.expr.accept(this);
        node.idx.accept(this);
        node.modifiable = true;
    }

    @Override
    public void visit(FuncCallExpr node) {
        int inClass = (node.functionSymbol.parameterNames.size() > 0 && node.functionSymbol.parameterNames.get(0).equals("this")) ? 1 : 0;
        if (node.arguments.size() + inClass != node.functionSymbol.parameterTypes.size()) {
//            System.out.println(node.arguments.size());
//            System.out.println(inClass);
//            System.out.println(node.functionSymbol.parameterTypes.size());
            errorListener.addError(node.location, "there is not enough parameters");
        } else {
            for (int i = 0; i < node.arguments.size(); ++i) {
                node.arguments.get(i).accept(this);

                if (!node.arguments.get(i).type.match(node.functionSymbol.parameterTypes.get(i + inClass))) {
                    errorListener.addError(node.location, "the parameter type does not match");
                    break;
                }
            }
        }
        node.modifiable = false;
    }

    @Override
    public void visit(NewExpr node) {
        for (Expression e : node.expressionDimension)
            e.accept(this);
        node.modifiable = false;
    }

    @Override
    public void visit(MembExpr node) {
        node.object.accept(this);
        if (node.object.type instanceof ArrayType) {
            node.modifiable = false;
        } else {
            if (node.methodCall != null) {
                node.methodCall.accept(this);
                node.modifiable = false;
            } else {
                node.modifiable = true;
            }
        }
    }

    private boolean isIntType(VariableType type) {
        return type instanceof PrimitiveType && ((PrimitiveType)type).name.equals("int");
    }
    private boolean isBoolType(VariableType type) {
        return type instanceof PrimitiveType && ((PrimitiveType)type).name.equals("bool");
    }
    private boolean isStringType(VariableType type) {
        return type instanceof ClassType && ((ClassType)type).name.equals("string");
    }

    @Override
    public void visit(UnaryExpr node) {
        node.expr.accept(this);
        boolean modifiedError = false;
        boolean typeError = false;
        switch (node.op) {
            case "v++": case "v--":
                if (!node.expr.modifiable)
                    modifiedError = true;
                if (!isIntType(node.type))
                    typeError = true;
                node.modifiable = false;
                break;
            case "++v": case "--v":
                if (!node.expr.modifiable)
                    modifiedError = true;
                if (!isIntType(node.type))
                    typeError = true;
                node.modifiable = true;
                break;
            case "!":
                if (!isBoolType(node.type))
                    typeError = true;
                node.modifiable = false;
                break;
            case "~":
                if (!isIntType(node.type))
                    typeError = true;
                node.modifiable = false;
                break;
            default:
                assert false;
        }
        if (typeError) {
            errorListener.addError(node.location, "type error occured");
        } else if (modifiedError) {
            errorListener.addError(node.location, "Error! This can not be modified");
        }
    }

    @Override
    public void visit(BinExpr node) {
        node.lhs.accept(this);
        node.rhs.accept(this);
        if (!node.lhs.type.match(node.rhs.type)) {
//            System.out.println(node.rhs.type instanceof  ClassType );
            errorListener.addError(node.location, "type can not match");
        } else {
            boolean typeError = false;
            switch (node.op) {
                case "<<": case ">>": case "&": case "|": case "^":case "-": case "*": case "/": case "%":
                    if (!isIntType(node.lhs.type))
                        typeError = true;
                    break;
                case "<=": case ">=": case "<" : case ">": case "+":
                    if (!isIntType(node.lhs.type) && !isStringType(node.lhs.type))
                        typeError = true;
                    break;
                case "&&": case "||":
                    if (!isBoolType(node.lhs.type))
                        typeError = true;
                    break;
                default:
                    break;
            }
            if (typeError) {
                errorListener.addError(node.location, "type error occured");
            }
        }
        node.modifiable = false;
    }

    @Override
    public void visit(AssignExpr node) {
        node.rhs.accept(this);
        node.lhs.accept(this);
        if (!node.lhs.type.match(node.rhs.type)) {
//            System.out.println(node.lhs.type instanceof ClassType);
            errorListener.addError(node.location, "two expression are not the same type");
        }
        if (!node.lhs.modifiable) {
            errorListener.addError(node.location, "the left expression cannot be modified");
        }
        node.modifiable = false;
    }

    @Override
    public void visit(EmptyStmt node) {

    }
}
