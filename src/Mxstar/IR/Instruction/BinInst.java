package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.*;

import java.util.HashMap;
import java.util.LinkedList;

import static Mxstar.IR.RegisterSet.vrax;
import static Mxstar.IR.RegisterSet.vrdx;

public class BinInst extends IRInst {
    public enum BinOp {
        ADD, SUB, MUL, DIV, MOD,SAL, SAR,AND, OR, XOR
    }
    public BinOp op;
    public Address dest;
    public Operand src;

    public BinInst(BB bb, BinOp op, Address dest, Operand src) {
        super(bb);
        this.op = op;
        this.dest = dest;
        this.src = src;
    }



    @Override
    public void renameUseReg(HashMap<Register, Register> renameMap) {
        if (src instanceof Memory) {
            src = ((Memory)(src)).copy();
            ((Memory)(src)).renameUseRegs(renameMap);
        } else if (src instanceof  Register && renameMap.containsKey(src)) {
            src = renameMap.get(src);
        }

        if (dest instanceof  Memory) {
            dest = ((Memory) dest).copy();
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
    public LinkedList<Register> getUseRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        if (src instanceof  Memory) {
            regs.addAll(((Memory)src).getUseRegs());
        } else if (src instanceof Register) {
            regs.add((Register) src);
        }
        if (dest instanceof  Memory) {
            regs.addAll(((Memory)dest).getUseRegs());
        } else if (dest instanceof Register) {
            regs.add((Register) dest);
        }
        if (op == BinOp.MUL) {
            if (!regs.contains(vrax))
                regs.add(vrax);
        } else if (op == BinOp.DIV || op == BinOp.MOD) {
            if (!regs.contains(vrax))
                regs.add(vrax);
            if (!regs.contains(vrdx))
                regs.add(vrdx);
        }
        return regs;
    }

    @Override
    public LinkedList<StackSlot> getStackSlots() {
        return defualtGetSlot(dest, src);
    }

    @Override
    public IRInst copy(BB bb) {
        return new BinInst(bb, op, dest, src);
    }

    @Override
    public LinkedList<Register> getDefRegs() {
        LinkedList<Register> regs = new LinkedList<>();
        if (dest instanceof Register)
            regs.add((Register) dest);
        if (op == BinOp.DIV || op == BinOp.MOD || op == BinOp.MUL) {
            if (!regs.contains(vrax))
                regs.add(vrax);
            if (!regs.contains(vrdx))
                regs.add(vrdx);
        }
        return regs;
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
