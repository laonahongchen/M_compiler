package frontend;

import ast.*;
import semanticError.CompileErrorListener;
import symbol.*;

public class SymbolTableBuilder implements IAstVisitor {
    public SymbolTable curSymbolTable;
    public GlobalSymbolTable globalSymbolTable;
    public CompileErrorListener errorListener;

    public SymbolTableBuilder () {
        globalSymbolTable = new GlobalSymbolTable();
        curSymbolTable = globalSymbolTable;
        errorListener = new CompileErrorListener();
    }

    public SymbolTableBuilder(CompileErrorListener errorListener) {
        this.errorListener = errorListener;
        //curSymbolTable = new SymbolTable();
        globalSymbolTable = new GlobalSymbolTable();
        curSymbolTable = globalSymbolTable;
    }

    private void enter(SymbolTable symbolTable) {
        symbolTable.parent = curSymbolTable;
        curSymbolTable = symbolTable;
    }

    private void leave() {
        curSymbolTable = curSymbolTable.parent;
    }

    private VariableSymbol resolveVariableSymbol (String name, SymbolTable symbolTable) {
        TypeSymbol symbol = symbolTable.getTypeSymbol(name);
        if (symbol != null) {
            if(symbol instanceof  VariableSymbol)
                return (VariableSymbol) symbol;
            else
                return null;
        } else {
            if (symbolTable.parent != null)
                return resolveVariableSymbol(name, symbolTable.parent);
            else
                return null;
        }
    }

    private VariableType resolveVariableType(TypeNode node) {
        if (node instanceof PrimitiveTypeNode) {
            PrimitiveSymbol symbol = globalSymbolTable.getPrimitiveSymbol(((PrimitiveTypeNode) node).name);
            if (symbol != null) {
                return new PrimitiveType(((PrimitiveTypeNode) node).name, symbol);
            } else {
                errorListener.addError(node.location, "there is no this type");
                return null;
            }
        } else if (node instanceof ClassTypeNode) {
            ClassSymbol symbol = globalSymbolTable.getClassSymbol(((ClassTypeNode) node).name);
            if (symbol != null) {
                return new ClassType(((ClassTypeNode) node).name, symbol);
            } else {
                errorListener.addError(node.location, "there is no this type");
                return null;
            }
        } else if (node instanceof  ArrayTypeNode) {
            ArrayTypeNode arrayTypeNode = (ArrayTypeNode) node;
            VariableType baseType;
            if (arrayTypeNode.dim == 1) {
                baseType = resolveVariableType(((ArrayTypeNode) node).arraytype);
            } else {
                ArrayTypeNode newArray = new ArrayTypeNode();

                newArray.dim = arrayTypeNode.dim - 1;
             //   System.err.print(newArray.dim);
                newArray.location = arrayTypeNode.location;
                newArray.arraytype = arrayTypeNode.arraytype;
                baseType = resolveVariableType(newArray);
            }
            if(baseType != null) {
                return new ArrayType(baseType);
            } else
                return null;
        } else {
            assert  false;
            return null;
        }
    }

    private void registerFunc(FuncDeclaration node, ClassSymbol curClass) {
        if (curSymbolTable.getTypeSymbol(node.name) != null) {
            errorListener.addError(node.location, "The function has already been defined.");
            return ;
        }

        if (curSymbolTable.parent == null && globalSymbolTable.getClassSymbol(node.name) != null) {
            errorListener.addError(node.location, "There is a class with the same name with this function which is not permitted.");
            return ;
        }
        FunctionSymbol functionSymbol = new FunctionSymbol();
        functionSymbol.location = node.location;
        functionSymbol.returnType = resolveVariableType(node.retType);
        functionSymbol.name = node.name;
        functionSymbol.funtionSymbolTable = null;
        for (VariableDeclaration d: node.parameters) {
            VariableType type = resolveVariableType(d.type);
            if(type == null)
                return ;
            functionSymbol.parameterTypes.add(type);
            functionSymbol.parameterNames.add(d.name);
        }
        if (curClass != null) {
            functionSymbol.parameterNames.add("this");
            functionSymbol.parameterTypes.add(new ClassType("", curClass));
        }
        node.symbol = functionSymbol;
        curSymbolTable.putTypeSymbol(functionSymbol.name, functionSymbol);
    }

    private  FunctionSymbol resolveFunctionSymbol(String name, SymbolTable symbolTable) {
        TypeSymbol symbol = symbolTable.getTypeSymbol(name);
        if (symbol != null) {
            if (symbol instanceof FunctionSymbol)
                return (FunctionSymbol)symbol;
            else
                return null;
        } else {
            if (symbolTable.parent != null) {
                return resolveFunctionSymbol(name, symbolTable.parent);
            } else {
                return null;
            }
        }
    }

    private void registerClass(ClassDeclaration node) {
        if (globalSymbolTable.getClassSymbol(node.name) != null) {
            errorListener.addError(node.location, "the class has already been defined!");
            return ;
        } else {
            ClassSymbol classSymbol = new ClassSymbol();
            classSymbol.name = node.name;
            classSymbol.location = node.location;
            classSymbol.symbolTable = new SymbolTable(globalSymbolTable);
            globalSymbolTable.putClassSymbol(node.name, classSymbol);
        }
    }

    private void registerClassFunction(ClassDeclaration node) {
        ClassSymbol classSymbol = globalSymbolTable.getClassSymbol(node.name);
        enter(classSymbol.symbolTable);
        for (FuncDeclaration d : node.methods) {
            registerFunc(d, classSymbol);
        }
        registerFunc(node.construct, classSymbol);
        leave();
    }

    private void defineVariable(VariableDeclaration node) {
        //System.out.println(node.location);
        VariableType type = resolveVariableType(node.type);
        if (node.init != null)
            node.init.accept(this);
        if (type != null) {
            if (curSymbolTable.getTypeSymbol(node.name) != null) {
                errorListener.addError(node.location, "the variable has already been defined");
                return ;
            }  else if (curSymbolTable.parent == null && globalSymbolTable.getClassSymbol(node.name) != null) {
                errorListener.addError(node.location, "there is a class already been defined in the same field with this variable and has the same name.");
                return ;
            } else {
                node.symbol = new VariableSymbol(node.name, type,node.location);
                curSymbolTable.putTypeSymbol(node.name, node.symbol);
            }
        }
    }

    private void defineClassFields(ClassDeclaration node) {
        ClassSymbol classSymbol = globalSymbolTable.getClassSymbol(node.name);
        enter(classSymbol.symbolTable);
        for (VariableDeclaration d: node.fields) {
            defineVariable(d);
        }
        leave();
    }

    private void defineFunction(FuncDeclaration node, ClassSymbol classSymbol) {
        FunctionSymbol functionSymbol = (FunctionSymbol)curSymbolTable.getTypeSymbol(node.name);
        functionSymbol.funtionSymbolTable = new SymbolTable(curSymbolTable);
        enter(functionSymbol.funtionSymbolTable);
        if (classSymbol != null) {
            defineVariable(new VariableDeclaration(new ClassTypeNode(classSymbol.name), "this", null));
        }
        for (VariableDeclaration d: node.parameters)
            defineVariable(d);
        for (Statement d: node.body)
            d.accept(this);
        leave();
    }

    private void defineClassFunction(ClassDeclaration node) {
        ClassSymbol classSymbol = globalSymbolTable.getClassSymbol(node.name);
        enter(classSymbol.symbolTable);
        defineFunction(node.construct, classSymbol);
        for (FuncDeclaration d: node.methods) {
            defineFunction(d, classSymbol);
        }
        leave();
    }


    @Override
    public void visit(AstProgram node) {
        for (ClassDeclaration d : node.classDeclarations) {
            registerClass(d);
        }
        if (errorListener.hasError())
            return;
        for (ClassDeclaration d : node.classDeclarations) {
            registerClassFunction(d);
        }
        if (errorListener.hasError())
            return;
        for (FuncDeclaration d : node.funcDeclarations) {
            registerFunc(d, null);
        }
        if (errorListener.hasError())
            return;
        for (VariableDeclaration d : node.globalVariables) {
            defineVariable(d);
        }
        if (errorListener.hasError())
            return;
        for (ClassDeclaration d : node.classDeclarations) {
            defineClassFields(d);
        }
        if (errorListener.hasError())
            return;
        for (ClassDeclaration d : node.classDeclarations) {
            defineClassFunction(d);
        }
        if (errorListener.hasError())
            return;
        for (FuncDeclaration d : node.funcDeclarations) {
            defineFunction(d, null);
        }
        if (errorListener.hasError())
            return;

    }


    @Override
    public void visit(Declaration node) {
        assert  false;
    }

    @Override
    public void visit(ClassDeclaration node) {

    }

    @Override
    public void visit(FuncDeclaration node) {

    }

    @Override
    public void visit(VariableDeclaration node) {
        defineVariable(node);
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
        assert false;
    }

    @Override
    public void visit(LoopStmt node) {
        if (node.startStmt != null)
            node.startStmt.accept(this);
        if (node.condition != null)
            node.condition.accept(this);
        if (node.updateStmt != null)
            node.updateStmt.accept(this);
        node.body.accept(this);
    }

    @Override
    public void visit(JumpStmt node) {
        if (node.retExpr != null)
            node.retExpr.accept(this);
    }

    @Override
    public void visit(ConditionStmt node) {
        if (node.expression != null)
            node.expression.accept(this);
        if (node.elseStmt != null)
            node.elseStmt.accept(this);
        if (node.thenStmt != null)
            node.thenStmt.accept(this);
    }

    @Override
    public void visit(BlockStmt node) {
        SymbolTable symbolTable = new SymbolTable(curSymbolTable);
        enter(symbolTable);
        for (Statement d: node.statements) {
            d.accept(this);
        }
        leave();
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
        assert false;
    }

    @Override
    public void visit(Identifier node) {
        VariableSymbol symbol = resolveVariableSymbol(node.name, curSymbolTable);
        if (symbol == null) {
            errorListener.addError(node.location, "cannot resolve variable");
            node.type = null;
        } else {
            node.type = symbol.variableType;
            node.symbol = symbol;
        }
    }

    @Override
    public void visit(LiteralExpr node) {
//        System.out.print("now in literal expression:"+ node.location + node.typeName);
        switch (node.typeName) {
            case "int":
                node.type = new PrimitiveType("int", globalSymbolTable.getPrimitiveSymbol("int"));
                break;
            case "bool":
                node.type = new PrimitiveType("bool", globalSymbolTable.getPrimitiveSymbol("bool"));
                break;
            case "null":
                node.type = new PrimitiveType("null", globalSymbolTable.getPrimitiveSymbol("null"));
                break;
            case "string":
//                System.out.print(node.location);
                node.type = new ClassType("string", globalSymbolTable.getClassSymbol("string"));
                break;
            default:
                assert false;
        }
    }

    @Override
    public void visit(ArrayExpr node) {
        node.expr.accept(this);
        node.idx.accept(this);
        if (node.expr.type instanceof ArrayType)
            node.type = ((ArrayType) node.expr.type).baseType;
        else {
            node.type = null;
            errorListener.addError(node.location, "This is not a array type");
        }
    }

    @Override
    public void visit(FuncCallExpr node) {
        FunctionSymbol functionSymbol = resolveFunctionSymbol(node.functionName, curSymbolTable);
        if (functionSymbol == null) {
            errorListener.addError(node.location, "can not find the function you want here");
            return ;
        }
        for (Expression e : node.arguments)
            e.accept(this);
        node.type = functionSymbol.returnType;
        node.functionSymbol = functionSymbol;
    }

    @Override
    public void visit(NewExpr node) {
        for (Expression e: node.expressionDimension) {
            e.accept(this);
        }
        int dimension = node.expressionDimension.size() + node.restDimension;
        node.type = resolveVariableType(node.typeNode);
        if (node.type == null) {
            errorListener.addError(node.location, "cannot resolve the type 2");
            node.type = null;
            return ;
        }
        if (dimension == 0 && node.typeNode instanceof PrimitiveTypeNode && ((PrimitiveTypeNode) node.typeNode).name.equals("void")) {
            errorListener.addError(node.location, "cannot new void");
            node.type = null;
            return ;
        }
        for (int i = 0; i < dimension; ++i) {
            node.type = new ArrayType(node.type);
        }
    }

    @Override
    public void visit(MembExpr node) {
        node.object.accept(this);
        if (node.object.type instanceof  PrimitiveType) {
            errorListener.addError(node.location, "this is not a class");
            return ;
        } else if (node.object.type instanceof ArrayType) {
            ArrayType arrayType = (ArrayType)node.object.type;
            if (node.methodCall != null || node.methodCall.functionName.equals("size") == false) {
                errorListener.addError(node.location, "this is not a class");
                return ;
            } else {
                node.type = new PrimitiveType("int", globalSymbolTable.getPrimitiveSymbol("int"));
            }
        } else {
            ClassType classType = (ClassType) node.object.type;
            SymbolTable symbolTable = classType.symbol.symbolTable;
            enter(symbolTable);
            if (node.methodCall != null) {
                node.methodCall.accept(this);
                node.type = node.methodCall.type;
            } else {
                node.fieldAccess.accept(this);
                node.type = node.fieldAccess.type;
            }
            leave();
        }
    }

    @Override
    public void visit(UnaryExpr node) {
        node.expr.accept(this);
        node.type = node.expr.type;
    }

    private boolean isRelationOperation(String op) {
        return (op.equals("==") || op.equals(">") || op.equals("<") || op.equals(">=") || op.equals("<=") || op.equals("!="));
    }

    @Override
    public void visit(BinExpr node) {
        node.lhs.accept(this);
        node.rhs.accept(this);
        if (isRelationOperation(node.op)) {
            node.type = new PrimitiveType("bool", globalSymbolTable.getPrimitiveSymbol("bool"));
        } else {
            node.type = node.lhs.type;
        }
        /*if (node.op == "<") {
            System.out.println(node.location);
            if (node.type instanceof PrimitiveType) {
                System.out.println("name: " + ((PrimitiveType)node.type).name);
            }
        }*/
    }

    @Override
    public void visit(AssignExpr node) {
        node.lhs.accept(this);
        node.rhs.accept(this);
        node.type = new PrimitiveType("void", globalSymbolTable.getPrimitiveSymbol("void"));
    }
}
