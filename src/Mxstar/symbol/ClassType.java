package Mxstar.Symbol;

import Mxstar.Config_Cons;

import java.util.Collection;

public class ClassType extends VariableType{
    public String name;

    public ClassSymbol symbol;

    public ClassType() {
        name = null;
        symbol = null;
    }
    public ClassType(String name, ClassSymbol symbol)  {
        this.name = name;
        this.symbol = symbol;
    }

    @Override
    public boolean match(VariableType other) {
        if(other instanceof  ClassType) {
            String otherName = ((ClassType) other).name;
            if((otherName.equals("null") && name.equals("string")) || (name.equals("null") && otherName.equals("string")))
                return false;
            else
                return otherName.equals("null") || name.equals("null") || otherName.equals(name);
        } else {
            return false;
        }
    }

    @Override
    public int getBytes() {
        Collection<VariableSymbol> fields = symbol.symbolTable.variables.values();
        return fields.size() * Config_Cons.REGISTER_WIDTH;
    }
}
