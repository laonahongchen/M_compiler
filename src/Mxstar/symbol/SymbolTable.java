package Mxstar.Symbol;

import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import Mxstar.Config_Cons;
import org.antlr.v4.misc.OrderedHashMap;

public class SymbolTable {
    public Map<String, FunctionSymbol> functions;
    public Map<String, VariableSymbol> variables;
    public SymbolTable parent;
    public List<SymbolTable> children;
    public Map<String, Integer> offset;
    public Integer curOffset;


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
        curOffset = 0;
        offset = new OrderedHashMap<>();
    }

    public int getVariableOffset(String name) {
        return offset.get(name);
    }
    public FunctionSymbol getFunctionSymbol(String name) {
        return functions.get(name);
    }
    public VariableSymbol getVariableSymbol(String name) {
        return variables.get(name);
    }
    public void putVariableSymbol(String name, VariableSymbol variableSymbol) {
        variables.put(name, variableSymbol);
        offset.put(name, curOffset);
        curOffset += Config_Cons.REGISTER_WIDTH;
    }
    public void putFunctionSymbol(String name, FunctionSymbol functionSymbol) {
        functions.put(name, functionSymbol);
    }

}
