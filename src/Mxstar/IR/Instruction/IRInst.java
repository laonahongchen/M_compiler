package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.Operand;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.StackSlot;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

public abstract class IRInst {
    public BB bb;
    public IRInst prev = null;
    public IRInst next = null;

    public IRInst() {
        this.bb = null;
    }
    public IRInst(BB bb) {
        this.bb = bb;
    }
    public void prepend(IRInst inst) {
        if (prev == null) {
            inst.next = this;
            this.prev = inst;
            bb.head = inst;
        } else {
            prev.next = inst;
            inst.prev = prev;
            inst.next = this;
            this.prev = inst;
        }
    }

    public void append(IRInst inst) {
        if (next == null) {
            this.next = inst;
            inst.prev = this;
            bb.tail = inst;
        } else {
            next.prev = inst;
            inst.next = next;
            inst.prev = this;
            this.next = inst;
        }
    }

    public void remove() {
        if (prev == null && next == null) {
            bb.head = bb.tail = null;
        } else if (prev == null){
            bb.head = next;
            next.prev = null;
        } else if (next == null) {
            bb.tail = prev;
            prev.next = null;
        } else {
            prev.next = next;
            next.prev = prev;
        }
    }

    public void replace(IRInst inst) {
        if (prev == null && next == null) {
            bb.head = bb.tail = inst;
        } else if (prev == null) {
            bb.head = inst;
            next.prev = inst;
            inst.next = next;
            inst.prev = null;
        } else if (next == null) {
            bb.tail = inst;
            prev.next = inst;
            inst.prev = prev;
            inst.next = null;
        } else {
            next.prev = inst;
            prev.next = inst;
            inst.next = next;
            inst.prev = prev;
        }
    }

    public abstract LinkedList<Register> getDefRegs();
    public abstract LinkedList<Register> getUseRegs();
    public abstract void renameUseReg(HashMap<Register, Register> renameMap);
    public abstract void renameDefReg(HashMap<Register, Register> renameMap);
    public abstract LinkedList<StackSlot> getStackSlots();

    LinkedList<StackSlot> defualtGetSlot(Operand... operands) {
        LinkedList<StackSlot> slots = new LinkedList<>();
        for (Operand op: operands) {
            if (op instanceof StackSlot) {
                slots.add((StackSlot) op);
            }
        }
        return slots;
    }

    public abstract void accept(IIRVisitor visitor);
}
