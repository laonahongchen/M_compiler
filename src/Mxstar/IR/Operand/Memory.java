package Mxstar.IR.Operand;

import Mxstar.Config_Cons;
import Mxstar.IR.IIRVisitor;

import java.util.HashMap;
import java.util.LinkedList;

public class Memory extends Address {
    public Register base = null;
    public Register index = null;
    public int scale = 0;
    public Constant constant = null;

    public Memory(){ }
    public Memory(Register base) {
        this.base = base;
    }
    public  Memory(Register base, Register index, int scale) {
        this.base = base;
        this.index = index;
        this.scale = scale;
    }

    public Memory(Register index, int scale, Constant constant) {
        this.index = index;
        this.scale = scale;
        this.constant = constant;
    }

    public Memory(Constant constant) {
        this.constant = constant;
    }
    public Memory(Register base, Constant constant) {
        this.base = base;
        this.constant = constant;
    }
    public Memory(Register base, Register index, int scale, Constant constant) {
        this.base = base;
        this.index = index;
        this.scale = scale;
        this.constant = constant;
    }
    public Memory copy() {
        if (this instanceof  StackSlot) {
            return this;
        }
        return new Memory(base, index, scale, constant);
    }

    public LinkedList<Register> getUseRegs(){
        LinkedList<Register> regs = new LinkedList<>();
        if (base != null) {
            regs.add(base);
        }
        if (index != null) {
            regs.add(index);
        }
        return regs;
    }

    public void renameUseRegs(HashMap<Register, Register> renameMap) {
        if (renameMap.containsKey(base)) {
            base = renameMap.get(base);
        }
        if (renameMap.containsKey(index)) {
            index = renameMap.get(index);
        }
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
