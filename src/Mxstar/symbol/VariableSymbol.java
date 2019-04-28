package Mxstar.Symbol;

import Mxstar.IR.Operand.VirReg;
import Mxstar.SemanticError.Location;

public class VariableSymbol extends TypeSymbol{
    public String name;
    public VariableType variableType;
    public Location location;

    public boolean isClassField;
    public boolean isGlobalVariable;
    public VirReg virReg;


    public VariableSymbol() {
        name = null;
        variableType = null;
        location = null;
    }
    public VariableSymbol(String name, VariableType variableType, Location location, boolean isClassField, boolean isGlobalVariable) {
        this.name = name;
        this.variableType = variableType;
        this.location = location;
        this.isClassField = isClassField;
        this.isGlobalVariable = isGlobalVariable;
    }

}
