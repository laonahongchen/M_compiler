package Mxstar.Backend;

import Mxstar.Ast.*;
import Mxstar.Config_Cons;
import Mxstar.IR.Instruction.*;
import Mxstar.IR.Operand.*;
import Mxstar.Symbol.*;
import Mxstar.IR.*;

import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Stack;

import static Mxstar.IR.RegisterSet.*;


public class IRBuilder implements IAstVisitor {
    private GlobalSymbolTable gst;

    private BB curBB;
    private Stack<BB> loopConditionBB;
    private Stack<BB> loopAfterBB;
    private Func curFunc;
    private ClassSymbol curClassSymbol;
    private VirReg curThisPointer;

    private HashMap<String, Func> functionMap;
    private HashMap<String, FuncDeclaration> funcDeclarationMap;

    private HashMap<Expression, BB> trueBBMap;
    private HashMap<Expression, BB> falseBBMap;
    private HashMap<Expression, Operand> exprResultMap;
    private HashMap<Expression, Address> assignToMap;

    private static Func library_print;
    private static Func library_println;
    private static Func library_getString;
    private static Func library_toString;
    private static Func library_getInt;
    private static Func library_string_length;
    private static Func library_string_substring;
    private static Func library_string_parseInt;
    private static Func library_string_ord;
    private static Func library_hasValue;
    private static Func library_setValue;
    private static Func library_getValue;
    private static Func library_init;
    private static Func external_malloc;
    private static Func library_stringComp;
    private static Func library_stringConcat;

    public IRProgram irProgram;

    public IRBuilder(GlobalSymbolTable gst) {
        this.gst = gst;
        this.irProgram = new IRProgram();
        this.loopAfterBB = new Stack<>();
        this.loopConditionBB = new Stack<>();
        this.funcDeclarationMap = new HashMap<>();
        this.functionMap = new HashMap<>();
        initLibraryFunc();

    }

    private void initLibraryFunc() {
        library_print = new Func(Func.Type.Library, "print", false);
        functionMap.put("print", library_print);
        library_println = new Func(Func.Type.Library, "println", false);
        functionMap.put("println", library_println);
        library_getString = new Func(Func.Type.Library, "getString", true);
        functionMap.put("getString", library_getString);
        library_getInt = new Func(Func.Type.Library, "getInt", true);
        functionMap.put("getInt", library_getInt);
        library_toString = new Func(Func.Type.Library, "toString", true);
        functionMap.put("toString", library_toString);
        library_string_length = new Func(Func.Type.Library, "string_length", true);
        functionMap.put("string.length", library_string_length);
        library_string_ord = new Func(Func.Type.Library, "string_ord", true);
        functionMap.put("string.ord", library_string_ord);
        library_string_parseInt = new Func(Func.Type.Library, "string_parseInt", true);
        functionMap.put("string.parseInt", library_string_parseInt);
        library_string_substring = new Func(Func.Type.Library, "string_substring", false);
        functionMap.put("string.substring", library_string_substring);

        library_init = new Func(Func.Type.Library, "init", true);
        library_stringComp = new Func(Func.Type.Library, "stringComp", true);
        library_stringConcat = new Func(Func.Type.Library, "stringConcat", true);
        library_hasValue = new Func(Func.Type.Library, "hasValue", true);
        library_getValue = new Func(Func.Type.Library, "getValue", true);
        library_setValue = new Func(Func.Type.Library, "setValue", true);

        external_malloc = new Func(Func.Type.External, "malloc", true);
    }

    private boolean isVoidType(VariableType type) {
        return type instanceof PrimitiveType &&((PrimitiveType)type).name.equals("void");
    }

    private boolean isIntType(VariableType type) {
        return type instanceof PrimitiveType &&((PrimitiveType)type).name.equals("int");
    }

    private boolean isBoolType(VariableType type) {
        return type instanceof PrimitiveType &&((PrimitiveType)type).name.equals("bool");
    }

    private boolean isStringType(VariableType type) {
        return type instanceof ClassType &&((ClassType)type).name.equals("string");
    }

    void boolAssign(Expression expr, Address vr) {
        BB trueBB = new BB(curFunc, "trueBB");
        BB falseBB = new BB(curFunc, "falseBB");
        BB mergeBB = new BB(curFunc, "mergeBB");
        trueBBMap.put(expr, trueBB);
        falseBBMap.put(expr, falseBB);
        expr.accept(this);
        trueBB.append(new Mov(trueBB, vr, new Imm(1)));
        falseBB.append(new Mov(falseBB, vr, new Imm(0)));
        trueBB.append(new Jump(trueBB, mergeBB));
        falseBB.append(new Jump(falseBB, mergeBB));
        curBB = mergeBB;
    }

    private void assign(Expression expr, Address vr) {
        if (isBoolType(expr.type)) {
            boolAssign(expr, vr);
        } else {
            assignToMap.put(expr, vr);
            expr.accept(this);
            Operand result = exprResultMap.get(expr);
            if (result != vr)
                curBB.append(new Mov(curBB, vr, result));
        }
    }

    private void buildInitFunction(AstProgram node) {
        irProgram.funcs.add(library_init);
        curFunc = library_init;
        library_init.usedGlobalSymbol = new HashSet<>(gst.globalInitVars);
        BB enterBB = new BB(curFunc, "enterBB");
        curBB = curFunc.enterBB = enterBB;
        for (VariableDeclaration d: node.globalVariables) {
            if (d.init != null)
                assign(d.init, d.symbol.virReg);
        }
        curBB.append(new Call(curBB, vrax, functionMap.get("main")));
        curBB.append(new Ret(curBB));
        curFunc.leaveBB = curBB;
        curFunc.finishBuild();
    }

    @Override
    public void visit(AstProgram node) {
        // vr for global Variables
        for (VariableDeclaration variableDeclaration: node.globalVariables) {
            StaticData data = new StaticData(variableDeclaration.name, Config_Cons.REGISTER_WIDTH);
            VirReg vr = new VirReg(variableDeclaration.name);
            vr.spillPlace = new Memory(data);
            irProgram.staticData.add(data);
            variableDeclaration.symbol.virReg = vr;
        }

        //define functions
        LinkedList<FuncDeclaration> funcDeclarations = new LinkedList<>(node.funcDeclarations);
        for (ClassDeclaration cd: node.classDeclarations) {
            if (cd.construct != null) {
                funcDeclarations.add(cd.construct);
            }
            funcDeclarations.addAll(cd.methods);
        }
        for (FuncDeclaration funcDeclaration: funcDeclarations) {
            funcDeclarationMap.put(funcDeclaration.symbol.name, funcDeclaration);
        }
        for (FuncDeclaration funcDeclaration: funcDeclarations) {
            if (functionMap.containsKey(funcDeclaration.symbol.name))
                continue;
            functionMap.put(funcDeclaration.symbol.name, new Func(Func.Type.UserDefined, funcDeclaration.name, !isVoidType(funcDeclaration.symbol.returnType)));
        }

        //normal visit successors
        for (FuncDeclaration funcDeclaration: node.funcDeclarations)
            funcDeclaration.accept(this);
        for (ClassDeclaration classDeclaration: node.classDeclarations)
            classDeclaration.accept(this);

        for (Func func: functionMap.values()) {
            if (func.type == Func.Type.UserDefined)
                func.finishBuild();
        }

        buildInitFunction(node);
    }

    @Override
    public void visit(Declaration node) {

    }

    @Override
    public void visit(ClassDeclaration node) {
        curClassSymbol = node.symbol;
        if (node.construct != null)
            node.construct.accept(this);
        for (FuncDeclaration func: node.methods)
            func.accept(this);
    }

    @Override
    public void visit(FuncDeclaration node) {
        /******
         *  Processes in a function:
         *  1. save arguments in physical registers to virtual registers
         *  2. load global variables in memory to virtual registers
         *  3. function body
         *  4. save global variables in virtual registers to memory
         *
         *  callee and caller register saving code are added in StackFrameBuilder
         *                                                                  ---- copy from @Idy002 's compiler
         */


        curFunc = functionMap.get(node.symbol.name);
        curBB = curFunc.enterBB = new BB(curFunc, "enter" + node.symbol.name);

        for (VariableDeclaration variableDeclaration: node.parameters)
            variableDeclaration.accept(this);

        for (int i = 0; i < curFunc.parameters.size(); ++i) {
            if (i < 6) {
                curBB.append(new Mov(curBB, curFunc.parameters.get(i), vargs.get(i)));
            } else {
                curBB.append(new Mov(curBB, curFunc.parameters.get(i), curFunc.parameters.get(i).spillPlace));
            }
        }

        for (VariableSymbol variableSymbol: node.symbol.usedGlobalVariables) {
            curBB.append(new Mov(curBB, variableSymbol.virReg, variableSymbol.virReg.spillPlace));
        }

        for (Statement statement: node.body) {
            statement.accept(this);
        }
        if (!(curBB.tail instanceof Ret)) {
            if (isVoidType(node.symbol.returnType)) {
                curBB.append(new Ret(curBB));
            } else {
                curBB.append(new Mov(curBB, vrax, new Imm(0)));
                curBB.append(new Ret(curBB));
            }
        }

        LinkedList<Ret> returnInst = new LinkedList<>();
        for (BB bb: curFunc.basicblocks) {
            for (IRInst inst = bb.head; inst != null; inst = inst.next) {
                returnInst.add((Ret) inst);
            }
        }

        BB leaveBB = new BB(curFunc, "leaveBB");
        for (Ret ret: returnInst) {
            ret.prepend(new Jump(ret.bb, leaveBB));
            ret.remove();
        }
        leaveBB.append(new Ret(leaveBB));
        curFunc.leaveBB = leaveBB;

        //save global variable
        IRInst retInst = curFunc.leaveBB.tail;
        for (VariableSymbol variableSymbol: node.symbol.usedGlobalVariables) {
            retInst.prepend(new Mov(retInst.bb, variableSymbol.virReg.spillPlace, variableSymbol.virReg));
        }
        functionMap.put(node.symbol.name, curFunc);
        irProgram.funcs.add(curFunc);
    }

    @Override
    public void visit(VariableDeclaration node) {
        VirReg virReg = new VirReg(node.name);
        node.symbol.virReg = virReg;
        if (node.init != null) {
            assign(node.init, virReg);
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
        if (node.startStmt != null) {
            node.startStmt.accept(this);
        }
        BB bodyBB = new BB(curFunc, "bodyBB");
        BB afterBB = new BB(curFunc, "afterBB");
        BB updBB = new BB(curFunc, "updBB");
        BB condBB = new BB(curFunc, "condBB");
        curBB.append(new Jump(curBB, condBB));
        loopConditionBB.push(condBB);
        loopAfterBB.push(afterBB);
        if (node.condition != null) {
            trueBBMap.put(node.condition, bodyBB);
            falseBBMap.put(node.condition, afterBB);
            curBB = condBB;
            node.condition.accept(this);
        }
        curBB = bodyBB;
        node.body.accept(this);
        curBB.append(new Jump(curBB, updBB));
        if (node.updateStmt != null) {
            curBB = updBB;
            node.updateStmt.accept(this);
            curBB.append(new Jump(curBB, condBB));
        }
        curBB = afterBB;
        loopConditionBB.pop();
        loopAfterBB.pop();
    }

    @Override
    public void visit(JumpStmt node) {
        if (node.isBreak) {
            curBB.append(new Jump(curBB, loopAfterBB.peek()));
        } else if (node.isReturn) {
            if (node.retExpr != null) {
                if (isVoidType(node.retExpr.type)) {
                    boolAssign(node.retExpr, vrax);
                } else {
                    node.retExpr.accept(this);
                    curBB.append(new Mov(curBB, vrax, exprResultMap.get(node.retExpr)));
                }
            }
        }
    }

    @Override
    public void visit(ConditionStmt node) {
        BB thenBB = new BB(curFunc, "thenBB");

        BB afterBB = new BB(curFunc, "afterBB");
        BB elseBB = node.elseStmt == null ? afterBB : new BB(curFunc,"elseBB");
        trueBBMap.put(node.expression, thenBB);
        falseBBMap.put(node.expression, elseBB);
        node.expression.accept(this);
        curBB = thenBB;
        node.thenStmt.accept(this);
        curBB.append(new Jump(curBB, afterBB));
        if (node.elseStmt != null) {
            curBB = elseBB;
            node.elseStmt.accept(this);
            curBB.append(new Jump(curBB, afterBB));
        }
        curBB = afterBB;
    }

    @Override
    public void visit(BlockStmt node) {
        for (Statement statement: node.statements)
            statement.accept(this);
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
        Operand operand;
        if (node.name.equals("this")) {
            operand = curThisPointer;
        } else if (node.symbol.isClassField) {
            String fieldName = node.name;
            int offset = curClassSymbol.symbolTable.getVariableOffset(fieldName);
            operand = new Memory(curThisPointer, new Imm(offset));
        } else {
            operand = node.symbol.virReg;
            if (node.symbol.isGlobalVariable)
                curFunc.usedGlobalSymbol.add(node.symbol);
        }
        if (trueBBMap.containsKey(node)) {
            curBB.append(new Cjump(curBB, operand, Cjump.CompareOP.E, new Imm(1), trueBBMap.get(node), falseBBMap.get(node)));
        } else {
            exprResultMap.put(node, operand);
        }
    }

    @Override
    public void visit(LiteralExpr node) {
        Operand operand;
        switch (node.typeName) {
            case "int":
                operand = new Imm(Integer.valueOf(node.value));
                break;
            case "null":
                operand = new Imm(0);
                break;
            case "bool":
                curBB.append(new Jump(curBB, node.value.equals("true") ? trueBBMap.get(node) : falseBBMap.get(node)));
                return ;
            default:
                StaticData sd = new StaticData("static_string", node.value.substring(1, node.value.length() - 1));
                irProgram.staticData.add(sd);
                operand = sd;
        }
        exprResultMap.put(node, operand);
    }

    @Override
    public void visit(ArrayExpr node) {
        node.expr.accept(this);
        Operand baseAddr = exprResultMap.get(node.expr);
        node.idx.accept(this);
        Operand idx = exprResultMap.get(node.idx);

        VirReg base;
        if (baseAddr instanceof Register) {
            base = (VirReg) baseAddr;
        } else{
            base = new VirReg("");
            curBB.append(new Mov(curBB, base, baseAddr));
        }
        Memory memory;

        if (idx instanceof Imm) {
            memory = new Memory(base, new Imm(((Imm)idx).value * Config_Cons.REGISTER_WIDTH + Config_Cons.REGISTER_WIDTH));
        } else if (idx instanceof Register) {
            memory = new Memory(base, (Register)idx, Config_Cons.REGISTER_WIDTH, new Imm(Config_Cons.REGISTER_WIDTH));
        } else if (idx instanceof Memory) {
            VirReg virReg = new VirReg("");
            curBB.append(new Mov(curBB, virReg, idx));
            memory = new Memory(base, virReg, Config_Cons.REGISTER_WIDTH, new Imm(Config_Cons.REGISTER_WIDTH));
        } else {
            memory = null;
        }

        if (trueBBMap.containsKey(node)) {
            curBB.append(new Cjump(curBB, memory, Cjump.CompareOP.NE, new Imm(0), trueBBMap.get(node), falseBBMap.get(node)));
        } else {
            exprResultMap.put(node, memory);
        }
    }

    @Override
    public void visit(FuncCallExpr node) {
        LinkedList<Operand> args = new LinkedList<>();
        if (!node.functionSymbol.isGlobalFunction)
            args.add(curThisPointer);
        for (int i = 0; i < node.arguments.size(); ++i) {
            Expression e = node.arguments.get(i);
            e.accept(this);
            args.add(exprResultMap.get(e));
        }
        curBB.append(new Call(curBB, vrax, functionMap.get(node.functionName), args));
        if (trueBBMap.containsKey(node)) {
            curBB.append(new Cjump(curBB, vrax, Cjump.CompareOP.NE, new Imm(0), trueBBMap.get(node), falseBBMap.get(node)));
        } else {
            if (!isVoidType(node.functionSymbol.returnType)) {
                VirReg virReg = new VirReg("");
                curBB.append(new Mov(curBB, virReg, vrax));
                exprResultMap.put(node, virReg);
            }
        }
    }

    public Operand allocateArray(LinkedList<Operand> dims, int baseBytes, Func constructor) {
        if (dims.size() == 0) {
            if (baseBytes == 0) {
                return new Imm(0);
            } else {
                VirReg retAddr = new VirReg("");
                curBB.append(new Call(curBB, vrax, external_malloc, new Imm(baseBytes)));
                curBB.append(new Mov(curBB, retAddr, vrax));
                if (constructor != null) {
                    curBB.append(new Call(curBB, vrax, constructor, retAddr));
                } else {
                    curBB.append(new BinInst(curBB, BinInst.BinOp.ADD, retAddr, new Imm(Config_Cons.REGISTER_WIDTH)));
                    curBB.append(new Mov(curBB, new Memory(retAddr), new Imm(0)));
                    curBB.append(new BinInst(curBB, BinInst.BinOp.SUB, retAddr, new Imm(Config_Cons.REGISTER_WIDTH)));
                }
                return retAddr;
            }
        } else {//new A [b]
            VirReg addr = new VirReg("");
            VirReg size = new VirReg("");
            VirReg bytes = new VirReg("");
            curBB.append(new Mov(curBB, size, dims.get(0)));
            curBB.append(new Lea(curBB, bytes, new Memory(size, Config_Cons.REGISTER_WIDTH, new Imm(Config_Cons.REGISTER_WIDTH))));
            curBB.append(new Call(curBB, vrax, external_malloc, bytes));
            curBB.append(new Mov(curBB, addr, vrax));
            curBB.append(new Mov(curBB, new Memory(addr), size));
            BB condBB = new BB(curFunc,"condBB" );
            BB afterBB = new BB(curFunc, "afterBB");
            BB bodyBB = new BB(curFunc, "bodyBB");
            curBB.append(new Jump(curBB, condBB));
            condBB.append(new Cjump(condBB, size, Cjump.CompareOP.G, new Imm(0), bodyBB, afterBB));
            curBB = bodyBB;
            if (dims.size() == 1 ) {
                Operand pointer = allocateArray(new LinkedList<>(), baseBytes, constructor);
                curBB.append(new Mov(curBB,new Memory(addr, size, Config_Cons.REGISTER_WIDTH), pointer));
            }
            curBB.append(new UnaryInst(curBB, UnaryInst.UnaryOp.DEC, size));
            curBB.append(new Jump(curBB, condBB));
            curBB = afterBB;
            return addr;
        }
    }

    @Override
    public void visit(NewExpr node) {
        Func constructor;
        if (node.restDimension == 0) {
            if (node.type instanceof ClassType) {
                ClassType classType = (ClassType)(node.type);
                if (classType.name.equals("string")) {
                    constructor = null;
                } else {
                    if (classType.symbol.symbolTable.getFunctionSymbol(classType.name) == null)
                        constructor = null;
                    else
                        constructor = functionMap.get(classType.name);
                }
            } else {
                constructor = null;
            }
        } else {
            constructor = null;
        }
        LinkedList<Operand> dims = new LinkedList<>();
        for (Expression expression: node.expressionDimension) {
            expression.accept(this);
            dims.add(exprResultMap.get(expression));
        }
        if (node.restDimension > 0 || node.typeNode instanceof PrimitiveTypeNode) {
            Operand pointer = allocateArray(dims, 0 , constructor);
            exprResultMap.put(node, pointer);
        } else {
            int bytes;
            if (node.type instanceof ClassType && ((ClassType)node.type).name.equals("string"))
                bytes = Config_Cons.REGISTER_WIDTH * 2;
            else
                bytes = node.type.getBytes();
            Operand pointer = allocateArray(dims, bytes, constructor);
            exprResultMap.put(node, pointer);
        }
    }

    @Override
    public void visit(MembExpr node) {
        VirReg baseAddr = new VirReg("");
        node.object.accept(this);
        curBB.append(new Mov(curBB, baseAddr, exprResultMap.get(node.object)));

        if (node.object.type instanceof ArrayType) {
            exprResultMap.put(node, new Memory(baseAddr));
        } else {//classType
            ClassType classType = (ClassType)node.object.type;
            Operand operand;
            if (node.fieldAccess != null) {
                operand = new Memory(baseAddr, new Imm(classType.symbol.symbolTable.getVariableOffset(node.fieldAccess.name)));
            } else {
                Func func = functionMap.get(node.methodCall.functionName);
                LinkedList<Operand> args = new LinkedList<>();
                args.add(baseAddr);
                for (Expression expression: node.methodCall.arguments) {
                    expression.accept(this);
                    args.add(exprResultMap.get(expression));
                }
                curBB.append(new Call(curBB, vrax, func, args));
                if (!isVoidType(node.methodCall.functionSymbol.returnType)) {
                    VirReg retvalue = new VirReg("");
                    curBB.append(new Mov(curBB, retvalue, vrax));
                    operand = retvalue;
                } else {
                    operand = null;
                }
            }

            if (trueBBMap.containsKey(node)) {
                curBB.append(new Cjump(curBB, operand, Cjump.CompareOP.NE, new Imm(0), trueBBMap.get(node), falseBBMap.get(node)));
            } else {
                exprResultMap.put(node, operand);
            }
        }
    }

    @Override
    public void visit(UnaryExpr node) {
        if (node.op.equals("!")) {
            trueBBMap.put(node.expr, falseBBMap.get(node));
            falseBBMap.put(node.expr, trueBBMap.get(node));
            node.expr.accept(this);
            return ;
        }
        node.expr.accept(this);
        Operand operand = exprResultMap.get(node.expr);
        switch (node.op) {
            case "v++": case "v--": {
                VirReg val = new VirReg("val");
                curBB.append(new Mov(curBB, val, operand));
                curBB.append(new UnaryInst(curBB, node.op.equals("v++") ? UnaryInst.UnaryOp.INC : UnaryInst.UnaryOp.DEC, (Address)operand));
                exprResultMap.put(node, val);
                break;
            }
            case "++v": case "--v": {
                curBB.append(new UnaryInst(curBB, node.op.equals("++v") ? UnaryInst.UnaryOp.INC : UnaryInst.UnaryOp.DEC, (Address)operand));
                exprResultMap.put(node, operand);
                break;
            }
            case "-": case "~": {
                VirReg val = new VirReg("val");
                curBB.append(new Mov(curBB, val, operand));
                curBB.append(new UnaryInst(curBB, node.op.equals("-") ? UnaryInst.UnaryOp.NEG : UnaryInst.UnaryOp.NOT, val));
                exprResultMap.put(node, val);
                break;
            }
            default: {
                exprResultMap.put(node, operand);
            }
        }
    }

    public Operand doStringConcat(Expression lhs, Expression rhs) {
        Address result = new VirReg("");
        lhs.accept(this);
        rhs.accept(this);
        Operand rlhs = exprResultMap.get(lhs);
        Operand rrhs = exprResultMap.get(rhs);
        VirReg virReg;
        if (rlhs instanceof Memory && !(rlhs instanceof StackSlot)) {
            virReg = new VirReg("");
            curBB.append(new Mov(curBB, virReg, rlhs));
            rlhs = virReg;
        }
        if (rrhs instanceof Memory && !(rrhs instanceof StackSlot)) {
            virReg = new VirReg("");
            curBB.append(new Mov(curBB, virReg, rrhs));
            rrhs = virReg;
        }
        curBB.append(new Call(curBB, vrax, library_stringConcat, rlhs, rrhs));
        curBB.append(new Mov(curBB, result, vrax));
        return result;
    }

    public Operand doArithCalc(String op, Address dest, Expression lhs, Expression rhs) {
        Address result = new VirReg("");
        lhs.accept(this);
        rhs.accept(this);
        Operand rlhs = exprResultMap.get(lhs);
        Operand rrhs = exprResultMap.get(rhs);
        BinInst.BinOp bop = null;
        boolean isSpecial = false;
        boolean isReverseAble = false;
        switch (op) {
            case "*": {
                bop = BinInst.BinOp.MUL;
                isSpecial = true;
                break;
            }
            case "%": {
                bop = BinInst.BinOp.MOD;
                isSpecial = true;
                break;
            }
            case "/": {
                bop = BinInst.BinOp.DIV;
                isSpecial = true;
                break;
            }
            case "+": {
                bop = BinInst.BinOp.ADD;
                isReverseAble = true;
                break;
            }
            case "-": {
                bop = BinInst.BinOp.SUB;
                break;
            }
            case "<<": {
                bop = BinInst.BinOp.SAL;
                break;
            }
            case ">>": {
                bop = BinInst.BinOp.SAR;
                break;
            }
            case "|": {
                bop = BinInst.BinOp.OR;
                isReverseAble = true;
                break;
            }
            case "&": {
                bop = BinInst.BinOp.AND;
                isReverseAble = true;
                break;
            }
            case "^": {
                bop = BinInst.BinOp.XOR;
                isReverseAble = true;
                break;
            }
            default: {
                assert false;
            }
        }
        if (!isSpecial) {
            if (rlhs == dest) {
                result = dest;
                if (op.equals("<<") || op.equals(">>")) {
                    curBB.append(new Mov(curBB, vrcx, rrhs));
                    curBB.append(new BinInst(curBB, bop, result, vrcx));
                } else {
                    curBB.append(new BinInst(curBB, bop, result, rrhs));
                }
            } else if (isReverseAble && rrhs == dest) {
                result = dest;
                curBB.append(new BinInst(curBB, bop, result, rlhs));
            } else {
                if (op.equals("<<") || op.equals(">>")) {
                    curBB.append(new Mov(curBB, result, rlhs));
                    curBB.append(new Mov(curBB, vrcx, rrhs));
                    curBB.append(new BinInst(curBB, bop, result, vrcx));
                } else {
                    curBB.append(new Mov(curBB, result, rlhs));
                    curBB.append(new BinInst(curBB, bop, result, rrhs));
                }
            }
        } else {
            if (op.equals("*")) {
                curBB.append(new Mov(curBB, vrax, rlhs));
                curBB.append(new BinInst(curBB, bop, null, rrhs));
                curBB.append(new Mov(curBB, result, vrax));
            } else {
                curBB.append(new Mov(curBB, vrax, rlhs));
                curBB.append(new Cdq(curBB));
                curBB.append(new BinInst(curBB, bop, null, rrhs));
                if (op.equals("/")) {
                    curBB.append(new Mov(curBB, result, vrax));
                } else {
                    curBB.append(new Mov(curBB, result, vrdx));
                }
            }
        }
        return result;
    }

    public void doLogicCalc(String op, Expression lhs, Expression rhs, BB trueBB, BB falseBB) {
        BB checkBB = new BB(curFunc, "secondCondBB");
        if (op.equals("&&")) {
            falseBBMap.put(lhs, falseBB);
            trueBBMap.put(lhs, checkBB);
        } else {
            falseBBMap.put(lhs, trueBB);
            trueBBMap.put(lhs, checkBB);
        }
        lhs.accept(this);
        curBB = checkBB;
        trueBBMap.put(rhs, trueBB);
        falseBBMap.put(rhs, falseBB);
        rhs.accept(this);
    }

    public void doCompCalc(String op, Expression lhs, Expression rhs, BB trueBB, BB falseBB) {
        lhs.accept(this);
        rhs.accept(this);
        Operand rlhs = exprResultMap.get(lhs);
        Operand rrhs = exprResultMap.get(rhs);
        Cjump.CompareOP cop = null;
        switch (op) {
            case ">": cop = Cjump.CompareOP.G; break;
            case ">=": cop = Cjump.CompareOP.GE; break;
            case "<": cop = Cjump.CompareOP.L; break;
            case "<=": cop = Cjump.CompareOP.LE; break;
            case "==": cop = Cjump.CompareOP.E; break;
            case "!=": cop = Cjump.CompareOP.NE; break;
        }
        if (lhs.type instanceof ClassType && ((ClassType)lhs.type).name.equals("string")) {
            VirReg result = new VirReg("");
            curBB.append(new Call(curBB, vrax, library_stringComp, rlhs, rrhs));
            curBB.append(new Mov(curBB, result, vrax));
            curBB.append(new Cjump(curBB, result, cop, new Imm(0), trueBB, falseBB));
        } else {
            if (rlhs instanceof Memory && rrhs instanceof  Memory) {
                VirReg virReg = new VirReg("");
                curBB.append(new Mov(curBB, virReg, rlhs));
                rlhs = virReg;
            }
            curBB.append(new Cjump(curBB, rlhs, cop, rrhs, trueBB, falseBB));
        }
    }

    @Override
    public void visit(BinExpr node) {
        switch (node.op) {
            case "*": case "/": case "+": case "-": case "%": case "&": case "|": case "^": case"<<": case ">>": {
                if (node.op.equals("+") && isStringType(node.type)) {
                    exprResultMap.put(node, doStringConcat(node.lhs, node.rhs));
                } else {
                    exprResultMap.put(node, doArithCalc(node.op, assignToMap.get(node), node.lhs, node.rhs));
                }
                break;
            }
            case "<": case ">": case "<=": case ">=": case"==": case "!=": {
                doCompCalc(node.op, node.lhs, node.rhs, trueBBMap.get(node), falseBBMap.get(node));
                break;
            }
            case "&&": case "||": {
                doLogicCalc(node.op, node.lhs, node.rhs, trueBBMap.get(node), falseBBMap.get(node));
                break;
            }
        }
    }

    @Override
    public void visit(AssignExpr node) {
        node.lhs.accept(this);
        Operand lval = exprResultMap.get(node.lhs);
        assign(node.rhs, (Address)lval);
    }
}