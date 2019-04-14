package Mxstar.Frontend;

import Mxstar.SemanticError.CompileErrorListener;
import Mxstar.Ast.*;
import Mxstar.Symbol.*;

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
//        System.out.println("+1");
        symbolTable.parent = curSymbolTable;
        curSymbolTable = symbolTable;
    }

    private void leave() {
//        System.out.println("-1");
        curSymbolTable = curSymbolTable.parent;
    }

    private VariableSymbol resolveVariableSymbol (String name, SymbolTable symbolTable) {
        VariableSymbol symbol = symbolTable.getVariableSymbol(name);
        if (symbol != null) {
//            if(symbol instanceof  VariableSymbol)
                return (VariableSymbol) symbol;
//            else {
//                System.out.println("wrong type");
//                return null;
//            }
        } else {
            if (symbolTable.parent != null)
                return resolveVariableSymbol(name, symbolTable.parent);
            else {
                return null;
            }
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
        if (curSymbolTable.getFunctionSymbol(node.name) != null) {
            errorListener.addError(node.location, "The function has already been defined.");
            return ;
        }
        if (curSymbolTable.getVariableSymbol(node.name) != null) {
            errorListener.addError(node.location, "The function has already been defined as a variable.");
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
        if (curClass != null) {
            functionSymbol.parameterNames.add("this");
            functionSymbol.parameterTypes.add(new ClassType("", curClass));
        }
        for (VariableDeclaration d: node.parameters) {
            VariableType type = resolveVariableType(d.type);
            if(type == null)
                return ;
            functionSymbol.parameterTypes.add(type);
            functionSymbol.parameterNames.add(d.name);
        }

        node.symbol = functionSymbol;

        curSymbolTable.putFunctionSymbol(functionSymbol.name, functionSymbol);
        //System.out.println(functionSymbol.name);
    }

    private  FunctionSymbol resolveFunctionSymbol(String name, SymbolTable symbolTable) {
        FunctionSymbol symbol = symbolTable.getFunctionSymbol(name);
        if (symbol != null) {
//            if (symbol instanceof FunctionSymbol)
                return symbol;
//            else
//                return null;
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
            classSymbol.variableType = new ClassType(node.name, classSymbol);

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
            if (curSymbolTable.getVariableSymbol(node.name) != null) {
                errorListener.addError(node.location, "the variable has already been defined");
                return ;
            }  else if (curSymbolTable.getFunctionSymbol(node.name) != null) {
                errorListener.addError(node.location, "the variable has already been defined");
                return ;
            }  else if (curSymbolTable.parent == null && globalSymbolTable.getClassSymbol(node.name) != null) {
                errorListener.addError(node.location, "there is a class already been defined in the same field with this variable and has the same name.");
                return ;
            } else {
//                System.out.println("define " + node.name);
                node.symbol = new VariableSymbol(node.name, type,node.location);
                curSymbolTable.putVariableSymbol(node.name, node.symbol);
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

    private void getCurrentDepth() {
        SymbolTable x = curSymbolTable;
        int ret = 0;
        while(!(x instanceof GlobalSymbolTable)) {
            ret++;
            x = x.parent;
        }
        System.out.println(ret);
    }

    private void defineFunction(FuncDeclaration node, ClassSymbol classSymbol) {
        FunctionSymbol functionSymbol = (FunctionSymbol)curSymbolTable.getFunctionSymbol(node.name);
//        System.out.println("defining function" + node.name );
        //if (functionSymbol == null)
        //    System.out.println("can not find such function" + node.name );

        functionSymbol.funtionSymbolTable = new SymbolTable(curSymbolTable);
        enter(functionSymbol.funtionSymbolTable);

        if (classSymbol != null) {
//            VariableDeclaration thisVar = (new VariableDeclaration(new ClassTypeNode(classSymbol.name), "this", null, classSymbol));
//            curSymbolTable.putTypeSymbol("this", thisVar.Mxstar.Symbol);
            defineVariable(new VariableDeclaration(new ClassTypeNode(classSymbol.name), "this", null));
        }
        for (VariableDeclaration d: node.parameters)
            defineVariable(d);
        for (Statement d: node.body) {
//            if (d == null)
//                System.out.println("fuck");
            d.accept(this);
        }

        leave();
        /*if (node.name.equals( "init")) {
            System.out.println("now out init");
            getCurrentDepth();
        }*/
        //getCurrentDepth();
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

        for (ClassDeclaration d : node.classDeclarations) {
            defineClassFields(d);
        }
        if (errorListener.hasError())
            return;
        //enter(globalSymbolTable.getClassSymbol("moment_ring").symbolTable);
        //leave();
        for (Declaration d : node.declarations) {
            //if (!(curSymbolTable instanceof  GlobalSymbolTable))
                //System.out.println("out error");
            if (d instanceof VariableDeclaration) {
//                System.out.println("variable");
                defineVariable((VariableDeclaration)d);
            } else if (d instanceof ClassDeclaration) {
//                System.out.println("class");
                defineClassFunction((ClassDeclaration)d);
            } else {
//                System.out.println("function");
                defineFunction((FuncDeclaration)d, null);
            }
        }

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
//        System.out.println("in block stmt now");
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
//        System.out.println("in expr stmt now");
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
            //System.out.println("have not find Mxstar.Symbol");
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
                node.type = new ClassType("null", globalSymbolTable.getClassSymbol("null"));
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
        System.out.println(node.location);
        System.out.println(dimension);
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
            if (node.methodCall == null || node.methodCall.functionName.equals("size") == false) {
                errorListener.addError(node.location, "this is not a class");
                return ;
            } else {
                node.type = new PrimitiveType("int", globalSymbolTable.getPrimitiveSymbol("int"));
            }
        } else {
            ClassType classType = (ClassType) node.object.type;
            /*if (classType == null) {
                System.out.println("no such class type");
            }
            SymbolTable symbolTable = classType.Mxstar.Symbol.symbolTable;
            enter(symbolTable);*/
            if (node.methodCall != null) {
                if (classType.symbol == null) {

                    System.out.println(classType.name);
                }
                node.methodCall.functionSymbol = resolveFunctionSymbol(node.methodCall.functionName, classType.symbol.symbolTable);
                if (node.methodCall.functionSymbol == null) {
                    node.type = null;
                    errorListener.addError(node.location, "don't have such method");
                } else {
                    node.methodCall.type = node.methodCall.functionSymbol.returnType;
                    node.type = node.methodCall.type;
                    for (Expression e : node.methodCall.arguments)
                        e.accept(this);
                }
            } else {
                node.fieldAccess.symbol = resolveVariableSymbol(node.fieldAccess.name, classType.symbol.symbolTable);
                if (node.fieldAccess.symbol == null) {
                    node.type = null;
                    errorListener.addError(node.location, "don't have such component");
                } else {
                    node.fieldAccess.type = node.fieldAccess.symbol.variableType;
                    node.type = node.fieldAccess.type;
                }
            }
            //leave();
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
