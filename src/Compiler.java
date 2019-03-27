import ast.AstProgram;
import frontend.*;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import semanticError.CompileErrorListener;
import semanticError.ParserErrorListener;
import parser.MxstarLexer;
import parser.MxstarParser;
import symbol.GlobalSymbolTable;
import symbol.SymbolTable;

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
        System.err.print("compiler success");
        //exit(0);
    }
}
