package Mxstar.Optimizer;

import Mxstar.Config_Cons;
import Mxstar.IR.BB;
import Mxstar.IR.Func;
import Mxstar.IR.IRProgram;
import Mxstar.IR.Instruction.*;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.VirReg;
import com.sun.corba.se.spi.legacy.interceptor.RequestInfoExt;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;


public class FunctionInliner {
    IRProgram irProgram;

    public FunctionInliner(IRProgram irProgram) {
        this.irProgram = irProgram;
    }

    private LinkedList<VirReg> tranVir(Collection<Register> regs) {
        LinkedList<VirReg> ret = new LinkedList<>();
        for (Register reg: regs) {
            ret.add((VirReg)reg);
        }
        return ret;
    }

    private boolean checkInline(Func func) {
        if (!Config_Cons.doInline)
            return false;
        if (func.type != Func.Type.UserDefined)
            return false;
        int cnt = 0;
        for (BB bb: func.basicblocks) {
            for (IRInst inst = bb.head; inst != null; inst = inst.next) {
                cnt++;
                if (cnt >= Config_Cons.inlineLimit)
                    return false;
            }
        }
        return true;
    }

    private void processFunc (Func func) {
        for (BB bb: func.basicblocks) {
            for (IRInst inst = bb.head; inst != null; inst = inst.next) {
                if (inst instanceof Call) {
                    if (checkInline(((Call) inst).func)) {
//                        inline(func, inst);
                    }
                }
            }
        }
    }

    public void run() {
        for (Func func: irProgram.funcs) {
            processFunc(func);
        }
    }
}

