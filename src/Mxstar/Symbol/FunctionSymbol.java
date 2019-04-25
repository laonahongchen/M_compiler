package Mxstar.Symbol;

import Mxstar.SemanticError.Location;

import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;

public class FunctionSymbol extends TypeSymbol{
    public String name;
    public Location location;
    public VariableType returnType;
    public List<VariableType> parameterTypes;
    public List<String> parameterNames;
    public SymbolTable funtionSymbolTable;

    public HashSet<FunctionSymbol> calleeSet;
    public HashSet<FunctionSymbol> callerSet;

    public HashSet<VariableSymbol> usedGlobalVariables;
    public boolean isGlobalFunction;
    public boolean withSideEffect;



    public FunctionSymbol() {
        this.parameterNames = new LinkedList<>();
        this.parameterTypes = new LinkedList<>();
        this.calleeSet = new HashSet<>();
        this.callerSet = new HashSet<>();
        this.usedGlobalVariables = new HashSet<>();
    }
}
