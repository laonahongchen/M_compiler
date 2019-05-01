package Mxstar.Symbol;

import Mxstar.IR.Func;
import Mxstar.SemanticError.Location;

import java.util.HashMap;
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

    public HashSet<FunctionSymbol> visited;

    public FunctionSymbol() {
        this.parameterNames = new LinkedList<>();
        this.parameterTypes = new LinkedList<>();
        this.calleeSet = new HashSet<>();
        this.callerSet = new HashSet<>();
        this.usedGlobalVariables = new HashSet<>();
        this.visited = new HashSet<>();
    }

    public void withSideEffect(FunctionSymbol functionSymbol) {
        if (withSideEffect)
            return ;
        if (visited.contains(functionSymbol)) {
            return ;
        }
        visited.add(functionSymbol);
        for (FunctionSymbol symbol: functionSymbol.calleeSet) {
            if (symbol.withSideEffect) {
                this.withSideEffect = true;
                break;
            }
        }
    }

    public boolean isPrimitiveType(VariableType type) {
        return type instanceof PrimitiveType;
    }


}
