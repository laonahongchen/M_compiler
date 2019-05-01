package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.*;

import java.util.HashMap;
import java.util.LinkedList;

public class Mov extends IRInst {
    public Address dest;
    public Operand src;

    public Mov(BB bb, Address dest, Operand src) {
        super(bb);
        this.dest = dest;
        this.src = src;
    }

    @Override
    public void renameUseReg(HashMap<Register, Register> renameMap) {
        if (dest instanceof Memory) {
            dest = ((Memory) dest).copy();
            ((Memory)dest).renameUseRegs(renameMap);
        }
        if (src instanceof Memory) {
            src = ((Memory) src).copy();
            ((Memory)src).renameUseRegs(renameMap);
        } else if (src instanceof Register && renameMap.containsKey(src)) {
            src = renameMap.get(src);
        }
    }

    @Override
    public void renameDefReg(HashMap<Register, Register> renameMap) {
        if (dest instanceof Register && renameMap.containsKey(dest))
            dest = renameMap.get(dest);
    }

    @Override
    public LinkedList<Register> getDefRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        if (dest instanceof Register)
            regs.add((Register) dest);
        return regs;
    }

    @Override
    public LinkedList<Register> getUseRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        if (dest instanceof Memory)
            regs.addAll(((Memory)dest).getUseRegs());
        if (src instanceof Memory)
            regs.addAll(((Memory)src).getUseRegs());
        else if (src instanceof Register)
            regs.add((Register) src);
        return regs;
    }

    @Override
    public LinkedList<StackSlot> getStackSlots() {
        return defualtGetSlot(src,dest);
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
