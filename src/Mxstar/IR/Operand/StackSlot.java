package Mxstar.IR.Operand;

import Mxstar.IR.Func;
import Mxstar.IR.IIRVisitor;

public class StackSlot extends Memory {
    public Func func;
    public String hint;

    public StackSlot(String hint) {
        this.hint = hint;
    }
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
