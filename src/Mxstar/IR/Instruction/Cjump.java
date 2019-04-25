package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.*;

import java.lang.management.LockInfo;
import java.util.HashMap;
import java.util.LinkedList;

public class Cjump extends IRInst {
    public enum CompareOP {
        E, NE, G, GE, L, LE
    }

    public CompareOP op;
    public BB thenbb;
    public BB elsebb;
    public Operand src1;
    public Operand src2;

    public Cjump(BB bb, Operand src1, CompareOP op, Operand src2, BB thenbb, BB elsebb) {
        super(bb);
        this.src1 = src1;
        this.op = op;
        this.src2 = src2;
        this.thenbb = thenbb;
        this.elsebb = elsebb;
    }

    public BB doCompare() {
        int v1 = ((Imm)src1).value;
        int v2 = ((Imm)src2).value;
        boolean r;
        switch (op) {
            case NE:
                r = v1 != v2;
                break;
            case E:
                r = v1 == v2;
                break;
            case LE:
                r = v1 <= v2;
                break;
            case L:
                r = v1 < v2;
                break;
            case G:
                r = v1 > v2;
                break;
            case GE:
                r = v1 >= v2;
                break;
            default:
                r = false;
                break;
        }
        return r ? thenbb : elsebb;
    }

    public CompareOP getNegOp() {
        switch (op) {
            case GE:
                return CompareOP.L;
            case G:
                return CompareOP.LE;
            case E:
                return CompareOP.NE;
            case L:
                return CompareOP.GE;
            case LE:
                return CompareOP.G;
            case NE:
                return CompareOP.E;
            default:
                assert false;
                return CompareOP.E;
        }
    }

    public CompareOP getReverseOp() {
        switch (op) {
            case GE:
                return CompareOP.L;
            case G:
                return CompareOP.LE;
            case E:
                return CompareOP.E;
            case L:
                return CompareOP.GE;
            case LE:
                return CompareOP.G;
            case NE:
                return CompareOP.NE;
            default:
                assert false;
                return CompareOP.E;
        }
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
    public LinkedList<Register> getDefRegs() {
        return new LinkedList<>();
    }

    @Override
    public void renameDefReg(HashMap<Register, Register> renameMap){}

    @Override
    public LinkedList<StackSlot> getStackSlots() {
        return defualtGetSlot(src1, src2);
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
