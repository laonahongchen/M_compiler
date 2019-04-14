package Mxstar.Symbol;

import Mxstar.SemanticError.Location;

import java.util.LinkedList;
import java.util.List;

public class FunctionSymbol extends TypeSymbol{
    public String name;
    public Location location;
    public VariableType returnType;
    public List<VariableType> parameterTypes;
    public List<String> parameterNames;
    public SymbolTable funtionSymbolTable;

    public FunctionSymbol() {
        this.parameterNames = new LinkedList<>();
        this.parameterTypes = new LinkedList<>();
    }
}
