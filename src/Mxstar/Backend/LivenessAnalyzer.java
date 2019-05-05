package Mxstar.Backend;


import Mxstar.IR.BB;
import Mxstar.IR.Func;
import Mxstar.IR.IRProgram;
import Mxstar.IR.Instruction.Call;
import Mxstar.IR.Instruction.IRInst;
import Mxstar.IR.Instruction.Mov;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.VirReg;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;

public class LivenessAnalyzer {
    private HashMap<BB, HashSet<VirReg>> liveOut;
    private HashMap<BB, HashSet<VirReg>> ueVar;
    private HashMap<BB, HashSet<VirReg>> varKill;


    void prepare (Func func) {
        liveOut = new HashMap<>();
        ueVar = new HashMap<>();
        varKill = new HashMap<>();

        for (BB bb: func.basicblocks) {
            liveOut.put(bb, new HashSet<>());
            ueVar.put(bb, new HashSet<>());
            varKill.put(bb, new HashSet<>());
        }
    }

    public LinkedList<VirReg> tranVir(Collection<Register> regs) {
        LinkedList<VirReg> ret = new LinkedList<>();
        for (Register reg: regs) {
            ret.add((VirReg)reg);
        }
        return ret;
    }

    private void init(BB bb, boolean afterAllocation) {
        HashSet<VirReg> localUEVar = new HashSet<>();
        HashSet<VirReg> localVarKill = new HashSet<>();

        for (IRInst inst = bb.head; inst != null; inst = inst.next) {
            LinkedList<Register> tmpUse;
            if (inst instanceof Call && !afterAllocation) {
                tmpUse = ((Call) inst).getCallUsed();
            } else {
                tmpUse = inst.getUseRegs();
            }
            for (VirReg reg: tranVir(tmpUse)) {
                if (!localVarKill.contains(reg)) {
                    localUEVar.add(reg);
                }
            }
            localVarKill.addAll(tranVir(inst.getDefRegs()));
        }
        ueVar.put(bb, localUEVar);
        varKill.put(bb, localVarKill);
    }

    public void calcLiveOut(Func func, boolean afterAllocation) {
        prepare(func);

        for (BB bb: func.basicblocks) {
            init(bb, afterAllocation);
        }

        boolean changed = true;
        while(changed) {
            changed = false;
            for (BB bb: func.reversePostOrderOnCFG) {
                int oldSize = liveOut.get(bb).size();
                for (BB succ: bb.successers) {
                    HashSet<VirReg> regs = new HashSet<>(liveOut.get(succ));
                    regs.removeAll(varKill.get(succ));
                    regs.addAll(ueVar.get(succ));
                    liveOut.get(bb).addAll(regs);
                }
                if (liveOut.get(bb).size() != oldSize)
                    changed = true;
            }
        }
    }

    public HashMap<BB, HashSet<VirReg>> getLiveOut(Func func) {
        calcLiveOut(func, false);
        return liveOut;
    }

    public void calcUDCnt(Func func) {
        HashSet<VirReg> alreadyUD = new HashSet<>();
        for (BB bb: func.basicblocks) {
            for (IRInst inst = bb.head; inst != null; inst = inst.next) {
                LinkedList<VirReg> virRegs = tranVir(inst.getUseRegs());
                virRegs.addAll(tranVir(inst.getDefRegs()));
                for (VirReg reg: virRegs) {
                    if (alreadyUD.contains(reg)) {
                        reg.cntUD = reg.cntUD + 1;
                    } else {
                        alreadyUD.add(reg);
                        reg.cntUD = 1;
                    }
                }
            }
        }

    }


    public void getInterferenceGraph(Func func, Graph graph) {
        calcLiveOut(func, true);

        graph.clear();;
        for (BB bb: func.basicblocks) {
            for (IRInst inst = bb.head; inst != null; inst = inst.next) {
                graph.addRegisters(tranVir(inst.getUseRegs()));
                graph.addRegisters(tranVir(inst.getDefRegs()));
            }
        }

        for (BB bb: func.basicblocks) {
            HashSet<VirReg> liveNow = new HashSet<>(liveOut.get(bb));
            for (IRInst inst = bb.tail; inst != null; inst = inst.prev ) {
                for (VirReg reg1: tranVir(inst.getDefRegs())) {
                    for (VirReg reg2: liveNow) {
                        graph.addEdge(reg1, reg2);
                    }
                }
                liveNow.removeAll(tranVir(inst.getDefRegs()));
                liveNow.addAll(tranVir(inst.getUseRegs()));
            }
        }
    }
}
