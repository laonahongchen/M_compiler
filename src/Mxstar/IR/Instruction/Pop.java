package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.Memory;
import Mxstar.IR.Operand.Operand;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.StackSlot;

import java.util.HashMap;
import java.util.LinkedList;

public class Pop extends IRInst {
    public Operand dest;

    public Pop(BB bb, Operand dest) {
        super(bb);
        this.dest = dest;
    }

    @Override
    public void renameUseReg(HashMap<Register, Register> renameMap) {
        if (dest instanceof Memory) {
            dest = ((Memory) dest).copy();
            ((Memory)dest).renameUseRegs(renameMap);
        }
    }

    @Override
    public void renameDefReg(HashMap<Register, Register> renameMap) {
        if (dest instanceof Register && renameMap.containsKey(dest)) {
            dest = renameMap.get(dest);
        }
    }

    @Override
    public LinkedList<Register> getDefRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        if (dest instanceof Register)
            regs.add(((Register)dest));

        return regs;
    }

    @Override
    public LinkedList<Register> getUseRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        if (dest instanceof Memory)
            regs.addAll(((Memory)dest).getUseRegs());

        return regs;
    }

    @Override
    public LinkedList<StackSlot> getStackSlots() {
        return defualtGetSlot(dest);
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
