package Mxstar.IR.Operand;

import Mxstar.IR.IIRVisitor;

public class VirReg extends Register {
    public String hint;
    public PhyReg allocatedPhyReg;
    public Memory spillPlace = null;

    public int id;
    public static int globalId = 0;
    public int cntUD;

    public VirReg(String hint) {
        this.hint = hint;
        this.allocatedPhyReg = null;
        this.id = globalId++;
    }

    @Override
    public  void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
