package symbol;

import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class SymbolTable {
    private Map<String, TypeSymbol> contents;
    //private Map<String, VariableSymbol> variables;
    public SymbolTable parent;
    public List<SymbolTable> children;

    /*public SymbolTable() {
        contents = new LinkedHashMap<>();
        //variables = new LinkedHashMap<>();
        parent = new SymbolTable();
        children = new LinkedList<>();
    }*/

    public SymbolTable(SymbolTable symbolTable) {
        contents = new LinkedHashMap<>();
        //variables = new LinkedHashMap<>();
        parent = symbolTable;
        children = new LinkedList<>();
    }

    /*
    public FunctionSymbol getFunctionSymbol(String name) {
        return contents.get(name);
    }
    public VariableSymbol getVariableSymbol(String name) {
        return contents.get(name);
    }
    public void putVariableSymbol(String name, VariableSymbol variableSymbol) {
        variables.put(name, variableSymbol);
    }
    public void putFunctionSymbol(String name, FunctionSymbol functionSymbol) {
        functions.put(name, functionSymbol);
    }
    */
    public TypeSymbol getTypeSymbol(String name) {
        return contents.get(name);
    }
    public void putTypeSymbol(String name, TypeSymbol typeSymbol) {
        contents.put(name, typeSymbol);
    }
}
