package Mxstar.IR;

import Mxstar.IR.Operand.StaticData;

import java.util.LinkedList;

public class IRProgram {
    public LinkedList<Func> funcs;
    public LinkedList<StaticData> staticData;

    public IRProgram() {
        funcs = new LinkedList<>();
        staticData = new LinkedList<>();
    }

    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
