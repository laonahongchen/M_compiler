package Mxstar;

import Mxstar.Ast.AstProgram;
import Mxstar.Backend.*;
import Mxstar.Frontend.*;
import Mxstar.IR.IRProgram;
import Mxstar.IR.RegisterSet;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import Mxstar.SemanticError.*;
import Mxstar.Parser.MxstarLexer;
import Mxstar.Parser.MxstarParser;
import Mxstar.Symbol.GlobalSymbolTable;

import java.io.*;

import static java.lang.System.exit;

public class Compiler {

    public static void main(String args[]) throws IOException {
        //parseArgs(args);
        compile();
        exit(0);
    }
    public static void compile() throws IOException{
        BufferedReader is = new BufferedReader(new InputStreamReader(System.in));
        //InputStream is = Config.in;
//        FileInputStream is = new FileInputStream("program.txt");
        ANTLRInputStream ais = new ANTLRInputStream(is);
        MxstarLexer mstarLexer = new MxstarLexer(ais);
        CommonTokenStream tokens = new CommonTokenStream(mstarLexer);
        MxstarParser parser = new MxstarParser(tokens);

        CompileErrorListener errorListener = new CompileErrorListener();
        ParserErrorListener parserErrorListener = new ParserErrorListener(errorListener);
        parser.removeErrorListeners();
        parser.addErrorListener(parserErrorListener);

        ParseTree parseTree = parser.program();

        if (errorListener.hasError()) {
            errorListener.printTo(System.err);
            exit(1);
        }


        AstBuilder astBuilder = new AstBuilder(errorListener);
        astBuilder.visit(parseTree);

        if(errorListener.hasError()) {
            errorListener.printTo(System.err);
            exit(1);
        }

        AstProgram astProgram = astBuilder.getAstProgram();

        SymbolTableBuilder symbolTableBuilder = new SymbolTableBuilder(errorListener);

        symbolTableBuilder.visit(astProgram);

        if(errorListener.hasError()) {
            errorListener.printTo(System.err);
            exit(1);
        }

        GlobalSymbolTable globalSymbolTable = symbolTableBuilder.globalSymbolTable;

        SemanticChecker semanticChecker = new SemanticChecker(errorListener, globalSymbolTable);
        semanticChecker.visit(astProgram);

        if(errorListener.hasError()) {
            errorListener.printTo(System.err);
            exit(1);
        }

//        exit(0);

        RegisterSet.init();
//        System.out.print("compiler success");
        IRBuilder irBuilder = new IRBuilder(globalSymbolTable);
        astProgram.accept(irBuilder);
        IRProgram irProgram = irBuilder.irProgram;

        if (Config_Cons.PrintIRAfterBuild) {
            System.err.println("===============================================");
            System.err.println("IR after build:");
            IRPrinter irPrinter = new IRPrinter();
            irPrinter.visit(irProgram);
            irPrinter.printTo(System.err);
        }

        IRCorrector irCorrector = new IRCorrector();
        irProgram.accept(irCorrector);

        if (Config_Cons.PrintIRAfterCorrector) {
            System.err.println("===============================================");
            System.err.println("IR after corrector:");
            IRPrinter irPrinter = new IRPrinter();
            irPrinter.visit(irProgram);
            irPrinter.printTo(System.err);
        }

        switch (Config_Cons.allocator) {
            case NAIVE_ALLOCATOR:
                NaiveAllocator naiveAllocator = new NaiveAllocator(irProgram);
                break;
            default:
                break;
        }

        if (Config_Cons.PrintIRAfterAllocator) {
            System.err.println("===============================================");
            System.err.println("IR after allocator:");
            IRPrinter irPrinter = new IRPrinter();
            irPrinter.visit(irProgram);
            irPrinter.printTo(System.err);
        }

        StackBuilder stackBuilder = new StackBuilder(irProgram);
        stackBuilder.run();

        if (Config_Cons.PrintIRAfterAll) {
            System.err.println("===============================================");
            System.err.println("IR after all:");
            IRPrinter irPrinter = new IRPrinter();
            irPrinter.visit(irProgram);
            irPrinter.printTo(System.err);
        }

        IRPrinter irPrinter = new IRPrinter();
        IRPrinter.showNasm = true;
        irPrinter.stringBuilder = new StringBuilder();
        irPrinter.visit(irProgram);
        PrintStream printStream = new PrintStream("mx.asm");
        irPrinter.printTo(printStream);
    }
}
