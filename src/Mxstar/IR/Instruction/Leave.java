package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.StackSlot;

import java.util.HashMap;
import java.util.LinkedList;

public class Leave extends IRInst {
    public Leave(BB bb) {
        super(bb);
    }

    @Override
    public void renameUseReg(HashMap<Register, Register> renameMap) {}

    @Override
    public void renameDefReg(HashMap<Register, Register> renameMap) {}

    @Override
    public LinkedList<Register> getDefRegs() {
        return new LinkedList<>();
    }

    @Override
    public LinkedList<Register> getUseRegs() {
        return new LinkedList<>();
    }

    @Override
    public LinkedList<StackSlot> getStackSlots() {
        return new LinkedList<>();
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
