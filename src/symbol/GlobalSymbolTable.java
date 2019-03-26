package symbol;

import semanticError.Location;

import javax.xml.ws.soap.Addressing;
import java.util.LinkedHashMap;
import java.util.Map;

public class GlobalSymbolTable extends SymbolTable{
    public Map<String, ClassSymbol> classes;
    public Map<String, PrimitiveSymbol> primitives;

    public GlobalSymbolTable() {
        super(null);
        classes = new LinkedHashMap<>();
        primitives = new LinkedHashMap<>();
        addDefaults();
    }

    public void putClassSymbol(String name, ClassSymbol classSymbol) {
        classes.put(name, classSymbol);
    }
    public void putPrimitiveSymbol(String name, PrimitiveSymbol primitiveSymbol) {
        primitives.put(name, primitiveSymbol);
    }
    public ClassSymbol getClassSymbol(String name) {
        return classes.get(name);
    }
    public PrimitiveSymbol getPrimitiveSymbol(String name) {
        return primitives.get(name);
    }

    private void addDefaultPrimitives() {
        primitives.put("int", new PrimitiveSymbol("int"));
        primitives.put("void", new PrimitiveSymbol("void"));
        primitives.put("bool", new PrimitiveSymbol("bool"));
    }

    private VariableType voidType() {
        return new PrimitiveType("void", primitives.get("void"));
    }
    private VariableType intType() {
        return new PrimitiveType("int", primitives.get("int"));
    }
    private VariableType stringType() {
        return new ClassType("string", classes.get("string"));
    }

    private FunctionSymbol stringLength() {
        FunctionSymbol f = new FunctionSymbol();
        f.name = "length";
        f.parameterTypes.add(stringType());
        f.parameterNames.add("this");
        f.location = new Location(0, 0);
        f.returnType = intType();

        return f;
    }

    private  FunctionSymbol stringSubString() {
        FunctionSymbol f = new FunctionSymbol();
        f.name = "substring";
        f.location = new Location(0, 0);
        f.parameterTypes.add(stringType());
        f.parameterNames.add("this");
        f.returnType = stringType();
        f.parameterNames.add("left");
        f.parameterTypes.add(intType());
        f.parameterNames.add("right");
        f.parameterTypes.add(intType());
        return f;
    }

    private  FunctionSymbol stringParseInt() {
        FunctionSymbol f = new FunctionSymbol();
        f.name = "parseInt";
        f.location = new Location(0,0);
        f.parameterTypes.add(stringType());
        f.parameterNames.add("this");
        f.returnType = intType();
        return f;
    }

    private FunctionSymbol stringOrd() {
        FunctionSymbol f = new FunctionSymbol();
        f.name = "ord";
        f.location = new Location(0, 0);
        f.parameterTypes.add(stringType());
        f.parameterNames.add("this");
        f.parameterTypes.add(intType());
        f.parameterNames.add("pos");
        f.returnType = intType();
        return f;
    }

    private FunctionSymbol globalPrint() {
        FunctionSymbol f = new FunctionSymbol();
        f.name = "print";
        f.returnType = voidType();
        f.location = new Location(0, 0);
        f.parameterTypes.add(stringType());
        f.parameterNames.add("this");
        return f;
    }

    private FunctionSymbol globalPrintln() {
        FunctionSymbol f = new FunctionSymbol();
        f.name = "println";
        f.returnType = voidType();
        f.location = new Location(0, 0);
        f.parameterTypes.add(stringType());
        f.parameterNames.add("this");
        return f;
    }

    private FunctionSymbol globalGetString() {
        FunctionSymbol f = new FunctionSymbol();
        f.name = "getString";
        f.returnType = stringType();
        f.location = new Location(0, 0);
        return f;
    }

    private FunctionSymbol globalGetInt() {
        FunctionSymbol f = new FunctionSymbol();
        f.name = "getInt";
        f.returnType = intType();
        f.location = new Location(0, 0);
        return f;
    }

    private  FunctionSymbol globalToString() {
        FunctionSymbol f = new FunctionSymbol();
        f.name = "toString";
        f.returnType = stringType();
        f.location = new Location(0, 0);
        f.parameterTypes.add(intType());
        f.parameterNames.add("i");
        return f;
    }

    private void addDefualtString() {
        ClassSymbol stringSymbol = new ClassSymbol();
        stringSymbol.name = "string";
        stringSymbol.location = new Location(0, 0);
        stringSymbol.symbolTable = new SymbolTable(this);
        stringSymbol.symbolTable.putTypeSymbol("length", stringLength());
        stringSymbol.symbolTable.putTypeSymbol("substring", stringSubString());
        stringSymbol.symbolTable.putTypeSymbol("parseInt", stringParseInt());
        stringSymbol.symbolTable.putTypeSymbol("ord", stringOrd());
        putClassSymbol("string", stringSymbol);
    }

    private void addDefaultNull() {
        ClassSymbol nullSymbol = new ClassSymbol();
        nullSymbol.name = "null";
        nullSymbol.location = new Location(0, 0);
        nullSymbol.symbolTable = new SymbolTable(this);
        putClassSymbol("null", nullSymbol);
    }

    private void addDefaultFunctions() {
        putTypeSymbol("print", globalPrint());
        putTypeSymbol("println", globalPrintln());
        putTypeSymbol("getString", globalGetString());
        putTypeSymbol("getInt", globalGetInt());
        putTypeSymbol("toString", globalToString());
    }

    private void addDefaults() {
        addDefaultPrimitives();
        addDefualtString();
        addDefaultNull();
        addDefaultFunctions();
    }
}
