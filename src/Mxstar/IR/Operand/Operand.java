package Mxstar.IR.Operand;

import Mxstar.IR.IIRVisitor;

public abstract class Operand {
    public abstract void accept(IIRVisitor visitor);
}
