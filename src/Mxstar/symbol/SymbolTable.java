package Mxstar.Symbol;

import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class SymbolTable {
    public Map<String, FunctionSymbol> functions;
    public Map<String, VariableSymbol> variables;
    public SymbolTable parent;
    public List<SymbolTable> children;

    /*public SymbolTable() {
        contents = new LinkedHashMap<>();
        //variables = new LinkedHashMap<>();
        parent = new SymbolTable();
        children = new LinkedList<>();
    }*/

    public SymbolTable(SymbolTable symbolTable) {
        functions = new LinkedHashMap<>();
        variables = new LinkedHashMap<>();
        parent = symbolTable;
        children = new LinkedList<>();
    }


    public FunctionSymbol getFunctionSymbol(String name) {
        return functions.get(name);
    }
    public VariableSymbol getVariableSymbol(String name) {
        return variables.get(name);
    }
    public void putVariableSymbol(String name, VariableSymbol variableSymbol) {
        variables.put(name, variableSymbol);
    }
    public void putFunctionSymbol(String name, FunctionSymbol functionSymbol) {
        functions.put(name, functionSymbol);
    }

}
