package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.Address;
import Mxstar.IR.Operand.Memory;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.StackSlot;

import java.util.HashMap;
import java.util.LinkedList;

public class UnaryInst extends IRInst {
    public enum UnaryOp{
        NEG, NOT, INC, DEC
    }

    public UnaryOp op;
    public Address dest;

    public UnaryInst(BB bb, UnaryOp op, Address dest) {
        super(bb);
        this.op = op;
        this.dest = dest;
    }

    @Override
    public LinkedList<Register> getUseRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        if (dest instanceof Memory)
            regs.addAll(((Memory)dest).getUseRegs());
        else if (dest instanceof Register)
            regs.add((Register) dest);
        return regs;
    }

    @Override
    public  void renameUseReg(HashMap<Register, Register> renameMap) {
        if (dest instanceof Memory) {
            dest = ((Memory)dest).copy();
            ((Memory)dest).renameUseRegs(renameMap);
        } else if (dest instanceof Register && renameMap.containsKey(dest)) {
            dest = renameMap.get(dest);
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
    public LinkedList<StackSlot> getStackSlots() {
        return defualtGetSlot(dest);
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }


}
