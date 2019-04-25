package Mxstar.IR.Operand;

import Mxstar.IR.IIRVisitor;

public class Imm extends Constant {
    public int value;

    public Imm(int val) {
        this.value = val;
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
