package Mxstar.IR.Instruction;

import Mxstar.IR.BB;
import Mxstar.IR.Func;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.Operand.*;
import Mxstar.IR.RegisterSet;

import java.time.chrono.MinguoChronology;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;

import static java.lang.Integer.min;

public class Call extends IRInst {
    public Address dest;
    public Func func;
    public LinkedList<Operand> args;

    public void update() {
        Func caller = super.bb.func;
        caller.callee.add(func);
        if (func.name.equals("print") || func.name.equals("println"))
            super.bb.func.hasOutput = true;
    }

    public Call(BB bb, Address dest, Func func, LinkedList<Operand> args) {
        super(bb);
        this.dest = dest;
        this.func = func;
        this.args = new LinkedList<>(args);
        update();
    }

    public Call(BB bb, Address dest, Func func, Operand... args) {
        super(bb);
        this.dest = dest;
        this.func = func;
        this.args = new LinkedList<>(Arrays.asList(args));
        update();
    }

    public LinkedList<Register> getCallUsed() {
        LinkedList<Register> registers = new LinkedList<>();
        for (Operand operand: args) {
            if (operand instanceof Memory) {
                registers.addAll(((Memory)operand).getUseRegs());
            } else if (operand instanceof VirReg){
                registers.add((Register)operand);
            }
        }
        return registers;
    }

    @Override
    public void renameUseReg(HashMap<Register, Register> renameMap) {}

    @Override
    public void renameDefReg(HashMap<Register, Register> renameMap) {
        if (dest instanceof Register && renameMap.containsKey(dest)) {
            dest = renameMap.get(dest);
        }
    }

    @Override
    public IRInst copy(BB bb) {
        return new Call(bb, dest, func, args);
    }

    @Override
    public LinkedList<Register> getDefRegs() {
        return new LinkedList<>(RegisterSet.vcallerSave);
    }

    @Override
    public LinkedList<Register> getUseRegs() {
        return new LinkedList<>(RegisterSet.vargs.subList(0, min(6, args.size())));
    }

    @Override
    public LinkedList<StackSlot> getStackSlots() {
        LinkedList<StackSlot> slots = new LinkedList<>(defualtGetSlot(dest));
        for (Operand op: args) {
            if (op instanceof StackSlot) {
                slots.add((StackSlot)op);
            }
        }
        return slots;
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
