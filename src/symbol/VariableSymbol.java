package symbol;

import semanticError.Location;

public class VariableSymbol extends TypeSymbol{
    public String name;
    public VariableType variableType;
    public Location location;

    public VariableSymbol() {
        name = null;
        variableType = null;
        location = null;
    }
    public VariableSymbol(String name, VariableType variableType, Location location) {
        this.name = name;
        this.variableType = variableType;
        this.location = location;
    }

}
