import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import semanticError.CompileErrorListener;
import semanticError.ParserErrorListener;
import parser.MxstarLexer;
import parser.MxstarParser;

import java.io.*;

import static java.lang.System.exit;

public class Compiler {

    public static void main(String args[]) throws IOException {
        //parseArgs(args);
        compile();
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
        else {
            System.out.println("compile success!");
        }
    }
}
