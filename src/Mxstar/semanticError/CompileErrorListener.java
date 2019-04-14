package Mxstar.SemanticError;

import java.io.PrintStream;
import java.util.LinkedList;
import java.util.List;

public class CompileErrorListener extends RuntimeException {
    private List<String> errorList;

    private static final String ANSI_RESET = "\u001B[0m";
    private static final String ANSI_BLACK = "\u001B[30m";
    private static final String ANSI_RED = "\u001B[31m";
    private static final String ANSI_GREEN = "\u001B[32m";
    private static final String ANSI_YELLOW = "\u001B[33m";
    private static final String ANSI_BLUE = "\u001B[34m";
    private static final String ANSI_PURPLE = "\u001B[35m";
    private static final String ANSI_CYAN = "\u001B[36m";
    private static final String ANSI_WHITE = "\u001B[37m";

    public CompileErrorListener() {
        errorList = new LinkedList<>();
    }

    public void addError(Location loc, String msg) {
        StackTraceElement[] stackTraceElements = new Throwable().getStackTrace();
        errorList.add(stackTraceElements[1].getClassName() + '.' + stackTraceElements[1].getLineNumber() + ':' + loc +  ':' + msg);
    }

    public boolean hasError() {
        return (!errorList.isEmpty());
    }

    @Override
    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("There are in total " + errorList.size() + " errors:\n");
        for(String s : errorList) {
            stringBuilder.append(s + '\n');
        }
        return stringBuilder.toString();
    }

    public void printTo(PrintStream out) {
        out.print(toString());
    }
}
