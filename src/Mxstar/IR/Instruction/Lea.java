package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.Memory;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.StackSlot;
import Mxstar.IR.RegisterSet;

import java.util.HashMap;
import java.util.LinkedList;

public class Lea extends IRInst {
    public Register dest;
    public Memory src;

    public Lea(BB bb, Register dest, Memory src) {
        super(bb);
        this.dest = dest;
        this.src = src;
    }

    @Override
    public void renameUseReg(HashMap<Register, Register> renameMap) {
        src = src.copy();
        src.renameUseRegs(renameMap);
    }

    @Override
    public void renameDefReg(HashMap<Register, Register> renameMap) {
        if (renameMap.containsKey(dest))
            dest = renameMap.get(dest);
    }

    @Override
    public IRInst copy(BB bb) {
        return new Lea(bb, dest, src);
    }

    @Override
    public LinkedList<Register> getDefRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        regs.add(dest);
        return regs;
    }

    @Override
    public LinkedList<Register> getUseRegs() {
        LinkedList<Register> regs = new LinkedList<>(src.getUseRegs());
        regs.add(dest);
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
