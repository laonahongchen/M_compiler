package frontend;

import jdk.nashorn.internal.ir.Block;
import parser.MxstarBaseVisitor;
import parser.MxstarParser;
import parser.MxstarParser.*;
import semanticError.CompileErrorListener;
import semanticError.Location;
import ast.*;

import java.util.LinkedList;
import java.util.List;

public class AstBuilder extends MxstarBaseVisitor<Object> {
    public AstProgram astProgram;
    public CompileErrorListener errorListener;

    public AstBuilder() {
        this.astProgram = new AstProgram();
        this.astProgram.location = new Location(0, 0);
        this.errorListener = new CompileErrorListener();
    }

    public AstBuilder(CompileErrorListener errorListener) {
        this.errorListener = errorListener;
        this.astProgram = new AstProgram();
        this.astProgram.location = new Location(0, 0);
    }

    public AstProgram getAstProgram() {
        return astProgram;
    }

    @Override public Object visitProgram(ProgramContext ctx) {
        for (DeclarationsContext c : ctx.declarations()) {
            if(c.functionDefinition() != null) {
                astProgram.add(visitFunctionDefinition(c.functionDefinition()));
            }
            if(c.classDefinition() != null) {
                astProgram.add(visitClassDefinition(c.classDefinition()));
            }
            if(c.variableDeclaration() != null) {
                astProgram.addAll(visitVariableDeclaration(c.variableDeclaration()));
            }
        }
        return null;
    }

    @Override public FuncDeclaration visitFunctionDefinition(FunctionDefinitionContext ctx) {
        FuncDeclaration funcDeclaration = new FuncDeclaration();
        funcDeclaration.retType = visitVariableTypeOrVoid(ctx.variableTypeOrVoid());
        funcDeclaration.name = ctx.Identifier().getSymbol().getText();
        funcDeclaration.parameters = visitParameterDeclarationList(ctx.parameterDeclarationList());
        funcDeclaration.body = visitBlock(ctx.block());
        funcDeclaration.location = funcDeclaration.retType.location;
        return funcDeclaration;
    }

    @Override public ClassDeclaration visitClassDefinition(ClassDefinitionContext ctx) {
        ClassDeclaration classDeclaration = new ClassDeclaration();
        classDeclaration.name = ctx.Identifier().getSymbol().getText();
        classDeclaration.fields = new LinkedList<>();
        classDeclaration.methods = new LinkedList<>();
        classDeclaration.location = new Location(ctx);

        for (MemberDeclarationContext c: ctx.memberDeclaration()) {
            if(c.functionDefinition() != null) {

                FuncDeclaration tmp = visitFunctionDefinition(c.functionDefinition());
                if(tmp.name.equals(classDeclaration.name)) {
                    errorListener.addError(new Location(c), "the constructor should not have return type.");
                } else {
                    classDeclaration.methods.add(tmp);
                }
            }
            if(c.variableDeclaration() != null) {
                classDeclaration.fields.addAll(visitVariableDeclaration(c.variableDeclaration()));
            }
            if(c.constructDefinition() != null) {
                if(classDeclaration.construct == null) {
                    classDeclaration.construct = visitConstructDefinition(c.constructDefinition());
                } else {
                    errorListener.addError(new Location(c), "there should only be one constructor in one class.");
                }
            }
        }
        if (classDeclaration.construct == null) {
            classDeclaration.construct = FuncDeclaration.defaultConstructor(classDeclaration.name);
        }
        return classDeclaration;

    }

    @Override public List<VariableDeclaration> visitVariableDeclaration(VariableDeclarationContext ctx) {
        List<VariableDeclaration> declarations = visitVariableList(ctx.variableList());
        TypeNode typeNode = visitVariableType(ctx.variableType());
        for(VariableDeclaration c : declarations) {
            c.type = typeNode;
        }
        return declarations;
    }

    @Override public List<VariableDeclaration> visitVariableList(VariableListContext ctx) {
        List<VariableDeclaration> declarations = new LinkedList<>();
        for(VariableDefinitionContext c : ctx.variableDefinition()) {
            declarations.add(visitVariableDefinition(c));
        }
        return  declarations;
    }

    @Override public VariableDeclaration visitVariableDefinition(VariableDefinitionContext ctx) {
        VariableDeclaration variableDeclaration = new VariableDeclaration();
        variableDeclaration.name = ctx.Identifier().getSymbol().getText();
        variableDeclaration.location = new Location(ctx);
        if(ctx.expression() != null) {
            variableDeclaration.init = (Expression) ctx.expression().accept(this);
        }
        return variableDeclaration;
    }

    @Override public FuncDeclaration visitConstructDefinition(ConstructDefinitionContext ctx) {
        FuncDeclaration funcDeclaration = new FuncDeclaration();
        funcDeclaration.retType = new PrimitiveTypeNode("void");
        funcDeclaration.name = ctx.Identifier().getSymbol().getText();
        funcDeclaration.parameters = visitParameterDeclarationList(ctx.parameterDeclarationList());
        funcDeclaration.body = visitBlock(ctx.block());
        funcDeclaration.location = new Location(ctx);
        return funcDeclaration;
    }

    @Override public TypeNode visitVariableTypeOrVoid(VariableTypeOrVoidContext ctx) {
        if(ctx.VOID() != null) {
            return new PrimitiveTypeNode("void");
        } else {
            return visitVariableType(ctx.variableType());
        }
    }

    @Override public List<VariableDeclaration> visitParameterDeclarationList(ParameterDeclarationListContext ctx) {
        List<VariableDeclaration> variableDeclarations = new LinkedList<>();
        if (ctx != null) {
            for (ParameterDeclarationContext c : ctx.parameterDeclaration()) {
                variableDeclarations.add(visitParameterDeclaration(c));
            }
        }
        return variableDeclarations;
    }

    @Override public VariableDeclaration visitParameterDeclaration(ParameterDeclarationContext ctx) {
        VariableDeclaration variableDeclaration = new VariableDeclaration();
        variableDeclaration.type = (TypeNode)ctx.variableType().accept(this);
        variableDeclaration.name = ctx.Identifier().getSymbol().getText();
        variableDeclaration.location = new Location(ctx);

        return variableDeclaration;
    }

    @Override public TypeNode visitVariableType(VariableTypeContext ctx) {
        if(ctx.empty().isEmpty()) {
            return visitVariableTypeBasic(ctx.variableTypeBasic());
        } else {
            ArrayTypeNode arrayType = new ArrayTypeNode();
            arrayType.location = new Location(ctx);
            arrayType.dim = ctx.empty().size();
            arrayType.arraytype = visitVariableTypeBasic(ctx.variableTypeBasic());
            return arrayType;
        }
    }

    @Override public TypeNode visitVariableTypeBasic(VariableTypeBasicContext ctx) {
        if(ctx.INT() != null) {
            PrimitiveTypeNode primitiveType = new PrimitiveTypeNode();
            primitiveType.location = new Location(ctx);
            primitiveType.name = "int";
            return primitiveType;
        } else if (ctx.BOOL() != null) {
            PrimitiveTypeNode primitiveType = new PrimitiveTypeNode();
            primitiveType.location = new Location(ctx);
            primitiveType.name = "bool";
            return primitiveType;
        } else {
            ClassTypeNode classType = new ClassTypeNode();
            classType.name = ctx.getText();
            classType.location = new Location(ctx);
            return classType;
        }
    }

    @Override public List<Statement> visitBlock(BlockContext ctx) {
        List<Statement> statements = new LinkedList<>();
        if(ctx.statement() != null) {
            for(StatementContext c : ctx.statement()) {
                if(c instanceof  VariableStmtContext) {
                    statements.addAll(visitVariableStmt((VariableStmtContext) c));
                } else if (!(c instanceof EmptyStmtContext)) {
                    statements.add((Statement)c.accept(this));
                }
            }
        }
        return statements;
    }
    @Override public BlockStmt visitBlockStmt(BlockStmtContext ctx) {
        BlockStmt blockStmt = new BlockStmt();
        blockStmt.location = new Location(ctx);
        blockStmt.statements = visitBlock(ctx.block());
        return blockStmt;
    }

    @Override public ExprStmt visitExprStmt(ExprStmtContext ctx) {
        ExprStmt exprStmt = new ExprStmt();
        exprStmt.location = new Location(ctx);
        exprStmt.expression = (Expression)ctx.expression().accept(this);
        return exprStmt;
    }

    @Override public ConditionStmt visitConditionStmt(ConditionStmtContext ctx) {
        return visitConditionStatement(ctx.conditionStatement());
    }

    @Override public LoopStmt visitLoopStmt(LoopStmtContext ctx) {
        return (LoopStmt)ctx.loopStatement().accept(this);
    }

    @Override public JumpStmt visitJumpStmt(JumpStmtContext ctx) {
        return visitJumpStatement(ctx.jumpStatement());
    }

    @Override public JumpStmt visitJumpStatement(JumpStatementContext ctx) {
        JumpStmt jumpStmt= new JumpStmt();
        jumpStmt.location = new Location(ctx);
        if(ctx.RETURN() != null) {
            jumpStmt.isReturn = true;
            if (ctx.expression() != null)
                jumpStmt.retExpr = (Expression)ctx.expression().accept(this);
        } else
            jumpStmt.isReturn = false;
//        System.out.println(jumpStmt.location);
//        System.out.println(jumpStmt.isReturn);
        return jumpStmt;
    }

    @Override public List<Statement> visitVariableStmt(VariableStmtContext ctx) {
        List<Statement> statements = new LinkedList<>();
        List<VariableDeclaration> declarations = visitVariableDeclaration(ctx.variableDeclaration());
        for(VariableDeclaration c : declarations) {
            VarDeclStmt decl = new VarDeclStmt();
            decl.location = new Location(ctx);
            decl.declaration = c;
            statements.add(decl);
        }
        return statements;
    }

    @Override public ConditionStmt visitConditionStatement(ConditionStatementContext ctx) {
        ConditionStmt conditionStmt = new ConditionStmt();
        conditionStmt.location = new Location(ctx);
        //System.out.println(conditionStmt.location);
        conditionStmt.thenStmt = (Statement)ctx.thenStatement.accept(this);
        if (ctx.elseStatement != null) {
            conditionStmt.elseStmt = (Statement) ctx.elseStatement.accept(this);
        }
        conditionStmt.expression = (Expression)ctx.expression().accept(this);
        return conditionStmt;
    }


    @Override public LoopStmt visitWhileExpr(WhileExprContext ctx) {
        LoopStmt loopStmt = new LoopStmt();
        loopStmt.location = new Location(ctx);
        loopStmt.startStmt = null;
        loopStmt.condition = (Expression) ctx.expression().accept(this);
        loopStmt.updateStmt = null;
        loopStmt.body = (Statement) ctx.statement().accept(this);
        return loopStmt;
    }

    @Override public LoopStmt visitForExpr(ForExprContext ctx) {
        LoopStmt loopStmt = new LoopStmt();
        if (ctx.initialize != null)
            loopStmt.startStmt = new ExprStmt((Expression) ctx.initialize.accept(this));
        if (ctx.step != null)
            loopStmt.updateStmt = new ExprStmt((Expression) ctx.step.accept(this));
        if (ctx.condition != null)
            loopStmt.condition = (Expression) ctx.condition.accept(this);
        loopStmt.body = (Statement) ctx.statement().accept(this);
        return loopStmt;
    }

    @Override public NewExpr visitNewExpr(NewExprContext ctx) {
        return (NewExpr)ctx.creator().accept(this);
    }

    @Override public UnaryExpr visitUnaryExpr(UnaryExprContext ctx) {
        UnaryExpr unaryExpr = new UnaryExpr();
        unaryExpr.location = new Location(ctx);
        if(ctx.postfix != null) {
            if(ctx.postfix.getText().equals("++")) {
                unaryExpr.op = "v++";
            } else {
                unaryExpr.op = "v--";
            }
        } else {
            if (ctx.prefix.getText().equals("++")) {
                unaryExpr.op = "++v";
            } else if(ctx.prefix.getText().equals("--")){
                unaryExpr.op = "--v";
            } else {
                unaryExpr.op =ctx.prefix.getText();
            }
        }
        unaryExpr.expr = (Expression) ctx.expression().accept(this);
        return unaryExpr;
    }

    @Override public Expression visitPrimaryExpr(PrimaryExprContext ctx) {
        if(ctx.Identifier() != null) {
            Identifier identifier = new Identifier();
            identifier.name = ctx.Identifier().getSymbol().getText();
            identifier.location = new Location(ctx);
            return identifier;
        } else if (ctx.THIS() != null) {
            Identifier identifier = new Identifier();
            identifier.name = ctx.THIS().getSymbol().getText();
            identifier.location = new Location(ctx);
            return identifier;
        } else {
            return new LiteralExpr(ctx.token);
        }
    }

    @Override public Expression visitArrayExpr(ArrayExprContext ctx) {
        ArrayExpr expr = new ArrayExpr();
        expr.location = new Location(ctx);
        expr.expr = (Expression) ctx.expression(0).accept(this);
        expr.idx = (Expression) ctx.expression(1).accept(this);
        if(expr.idx instanceof  NewExpr && ctx.expression(0).stop.getText().equals("]")) {
            errorListener.addError(expr.idx.location, "can not mess new a[n][i] with (new a[n])[i]");
        }
        return expr;
    }

    @Override public Expression visitMemberExpr(MemberExprContext ctx) {
        MembExpr expression = new MembExpr();
        expression.location = new Location(ctx);
        expression.object = (Expression) ctx.expression().accept(this);
        if(ctx.functionCall() != null) {
            expression.fieldAccess = null;
            expression.methodCall = visitFunctionCall(ctx.functionCall());
        } else {
            expression.methodCall = null;
            expression.fieldAccess = new Identifier(ctx.Identifier().getSymbol());
        }
        return expression;
    }

    @Override public BinExpr visitBinaryExpr(BinaryExprContext ctx) {
        BinExpr binExpr = new BinExpr();
        binExpr.lhs = (Expression)ctx.expression(0).accept(this);
        binExpr.rhs = (Expression)ctx.expression(1).accept(this);
        binExpr.op = ctx.bop.getText();
        binExpr.location = new Location(ctx);
        return  binExpr;
    }

    @Override public Expression visitSubExpr(SubExprContext ctx) {
        return (Expression)ctx.expression().accept(this);
    }

    @Override public AssignExpr visitAssignExpr(AssignExprContext ctx) {
        AssignExpr assignExpr = new AssignExpr();
        assignExpr.lhs = (Expression)ctx.expression(0).accept(this);
        assignExpr.rhs = (Expression)ctx.expression(1).accept(this);
        assignExpr.location = new Location(ctx);
        return assignExpr;
    }

    @Override public FuncCallExpr visitFuntionExpr(FuntionExprContext ctx) {
        return visitFunctionCall(ctx.functionCall());
    }

    @Override public FuncCallExpr visitFunctionCall(FunctionCallContext ctx) {
        FuncCallExpr funcCallExpr = new FuncCallExpr();
        funcCallExpr.functionName = ctx.Identifier().getSymbol().getText();
        funcCallExpr.arguments = new LinkedList<>();
        funcCallExpr.location = new Location(ctx);
        if (ctx.expression() != null) {
            for (ExpressionContext c : ctx.expression()) {
                funcCallExpr.arguments.add((Expression) c.accept(this));
                //System.out.print(((LinkedList<Expression>) funcCallExpr.arguments).getLast().);
            }
        }
        return funcCallExpr;
    }

    @Override public NewExpr visitInvalidCreater(InvalidCreaterContext ctx) {
        errorListener.addError(new Location(ctx), "can not resolve this new creator");
        return new NewExpr();
    }

    @Override public NewExpr visitValidCreater(ValidCreaterContext ctx) {
        NewExpr newExpr = new NewExpr();
        newExpr.location = new Location(ctx);
        newExpr.typeNode = visitVariableTypeBasic(ctx.variableTypeBasic());
        newExpr.expressionDimension = new LinkedList<>();
        if(ctx.expression() != null) {
            for(ExpressionContext c : ctx.expression()) {
                newExpr.expressionDimension.add((Expression)c.accept(this));
            }
        }
        if(ctx.empty() != null) {
            newExpr.restDimension = ctx.empty().size();
        } else {
            newExpr.restDimension = 0;
        }
        return newExpr;
    }
}
