package symbol;

public class PrimitiveType extends VariableType {
    public String name;
    public PrimitiveSymbol symbol;

    public PrimitiveType() {
        name = null;
        symbol = null;
    }
    public PrimitiveType(String name, PrimitiveSymbol symbol) {
        this.name = name;
        this.symbol = symbol;
    }

    @Override
    public boolean match(VariableType other) {
        if(other instanceof ClassType && ((ClassType) other).name.equals("null")) {
            return true;
        } else if(other instanceof PrimitiveType && ((PrimitiveType) other).name.equals(name))
            return true;
        else {
            return false;
        }
    }
}
