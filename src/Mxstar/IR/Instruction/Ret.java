package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.StackSlot;
import Mxstar.IR.RegisterSet;

import java.util.HashMap;
import java.util.LinkedList;

public class Ret extends IRInst {
    public Ret(BB bb) {
        super(bb);
    }

    @Override
    public IRInst copy(BB bb) {
        return new Ret(bb);
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
        LinkedList<Register> regs =  new LinkedList<>();
        if (bb.func.hasReturnValue)
            regs.add(RegisterSet.vrax);
        return regs;
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
