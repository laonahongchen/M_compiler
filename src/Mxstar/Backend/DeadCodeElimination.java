package Mxstar.Backend;

import Mxstar.IR.BB;
import Mxstar.IR.Func;
import Mxstar.IR.IRProgram;
import Mxstar.IR.Instruction.*;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.VirReg;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;

public class DeadCodeElimination {
    public IRProgram irProgram;
    public LivenessAnalyzer livenessAnalyzer;
    public HashMap<BB, HashSet<VirReg>> liveOut;

    public DeadCodeElimination(IRProgram irProgram) {
        this.irProgram = irProgram;
        this.livenessAnalyzer = new LivenessAnalyzer();
    }

    public LinkedList<VirReg> tranVir(Collection<Register> regs) {
        LinkedList<VirReg> ret = new LinkedList<>();
        for (Register reg: regs) {
            ret.add((VirReg)reg);
        }
        return ret;
    }

    private boolean canEliminate(IRInst inst) {
        return inst instanceof BinInst || inst instanceof UnaryInst || inst instanceof Mov || inst instanceof Lea;
    }

    private void processFunc(Func func) {
        liveOut = livenessAnalyzer.getLiveOut(func);
        for (BB bb: func.basicblocks) {
            HashSet<VirReg> liveSet = new HashSet<>(liveOut.get(bb));
            for (IRInst inst = bb.tail; inst != null; inst = inst.prev) {
                LinkedList<Register> used = inst instanceof Call ? ((Call) inst).getCallUsed() : inst.getUseRegs();
                LinkedList<Register> defined = inst.getDefRegs();
                boolean dead = true;
                if (defined.isEmpty()) {
                    dead = false;
                }
                for (Register reg: defined) {
                    if (liveSet.contains(reg) || ((VirReg)reg).spillPlace != null) {
                        dead = false;
                        break;
                    }
                }
                if (dead && canEliminate(inst)) {
                    inst.remove();
                } else {
                    liveSet.removeAll(tranVir(defined));
                    liveSet.addAll(tranVir(used));
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
