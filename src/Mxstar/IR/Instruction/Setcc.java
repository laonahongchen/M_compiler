package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.*;

import java.util.HashMap;
import java.util.LinkedList;

import static Mxstar.IR.RegisterSet.vrax;

public class Setcc extends IRInst {
    public Cjump.CompareOP op;
    public Operand src1;
    public Operand src2;
    public Address dest;

    public Cjump.CompareOP getReverseOp() {
        switch (op) {
            case GE:
                return Cjump.CompareOP.L;
            case G:
                return Cjump.CompareOP.LE;
            case E:
                return Cjump.CompareOP.E;
            case L:
                return Cjump.CompareOP.GE;
            case LE:
                return Cjump.CompareOP.G;
            case NE:
                return Cjump.CompareOP.NE;
            default:
                assert false;
                return Cjump.CompareOP.E;
        }
    }

    public Setcc(BB bb, Address dest, Operand src1, Cjump.CompareOP op, Operand src2) {
        super(bb);
        this.dest = dest;
        this.src1 = src1;
        this.op = op;
        this.src2 = src2;
    }

    @Override
    public LinkedList<Register> getUseRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        LinkedList<Operand> srcs = new LinkedList<>();
        srcs.add(src1);
        srcs.add(src2);
        for (Operand src : srcs) {
            if (src instanceof Memory)
                regs.addAll(((Memory)src).getUseRegs());
            else if (src instanceof Register) {
                regs.add((Register)src);
            }
        }
        if (!regs.contains(vrax)) {
            regs.add(vrax);
        }
        return regs;
    }

    @Override
    public void renameUseReg(HashMap<Register, Register> renameMap) {
        if (src1 instanceof Memory) {
            src1 = ((Memory)(src1)).copy();
            ((Memory)(src1)).renameUseRegs(renameMap);
        } else if (src1 instanceof  Register && renameMap.containsKey(src1)) {
            src1 = renameMap.get(src1);
        }
        if (src2 instanceof  Memory) {
            src2 = ((Memory) src2).copy();
            ((Memory)src2).renameUseRegs(renameMap);
        } else if (src2 instanceof Register && renameMap.containsKey(src2)) {
            src2 = renameMap.get(src2);
        }
    }

    @Override
    public IRInst copy(BB bb) {
        return null;
    }

    @Override
    public LinkedList<Register> getDefRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        if (dest instanceof Register)
            regs.add((Register) dest);
        return regs;
    }

    @Override
    public void renameDefReg(HashMap<Register, Register> renameMap){
        if (dest instanceof Register && renameMap.containsKey(dest)) {
            dest = renameMap.get(dest);
        }
    }

    @Override
    public LinkedList<StackSlot> getStackSlots() {
        return defualtGetSlot(src1, src2);
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
