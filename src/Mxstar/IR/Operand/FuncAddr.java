package Mxstar.IR.Operand;

import Mxstar.IR.Func;
import Mxstar.IR.IIRVisitor;

public class FuncAddr extends Constant {
    public Func func;

    public FuncAddr(Func func) {
        this.func = func;
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
