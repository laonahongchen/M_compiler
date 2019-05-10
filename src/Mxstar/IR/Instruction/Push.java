package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.Memory;
import Mxstar.IR.Operand.Operand;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.StackSlot;

import java.util.HashMap;
import java.util.LinkedList;

public class Push extends IRInst {
    public Operand src;

    public Push(BB bb, Operand src) {
        super(bb);
        this.src = src;
    }

    @Override
    public void renameUseReg(HashMap<Register, Register> renameMap) {
        if (src instanceof Memory) {
            src = ((Memory) src).copy();
            ((Memory)src).renameUseRegs(renameMap);
        }
    }

    @Override
    public void renameDefReg(HashMap<Register, Register> renameMap) {
        if (src instanceof Register && renameMap.containsKey(src)) {
            src = renameMap.get(src);
        }
    }

    @Override
    public IRInst copy(BB bb) {
        return new Push(bb, src);
    }

    @Override
    public LinkedList<Register> getDefRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        if (src instanceof Register)
            regs.add(((Register)src));

        return regs;
    }

    @Override
    public LinkedList<Register> getUseRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        if (src instanceof Memory)
            regs.addAll(((Memory)src).getUseRegs());

        return regs;
    }

    @Override
    public LinkedList<StackSlot> getStackSlots() {
        return defualtGetSlot(src);
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
