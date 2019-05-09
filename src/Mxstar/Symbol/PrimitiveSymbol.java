package Mxstar.Symbol;

import Mxstar.SemanticError.Location;

public class PrimitiveSymbol extends TypeSymbol{
    public String name;
    public Location location;

    public PrimitiveSymbol() {
        this.name = null;
        this.location = new Location(0, 0);
    }
    public PrimitiveSymbol(String name, Location location) {
        this.name = name;
        this.location = location;
    }
    public PrimitiveSymbol(String name) {
        this.name = name;
        this.location = new Location(0, 0);
    }


}
