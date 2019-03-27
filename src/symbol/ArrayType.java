package symbol;

public class ArrayType extends VariableType {
    public VariableType baseType;

    public ArrayType () {
        baseType = null;
    }

    public  ArrayType (VariableType baseType) {
        this.baseType = baseType;
    }

    public boolean match(VariableType other) {
        if(other instanceof  ClassType && ((ClassType)other).name.equals("null"))
            return false;
        else if(other instanceof  ArrayType) {
            return baseType.match(((ArrayType) other).baseType);
        } else
            return false;
    }
}
