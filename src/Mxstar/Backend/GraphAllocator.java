package Mxstar.Backend;

import Mxstar.IR.BB;
import Mxstar.IR.Func;
import Mxstar.IR.IRProgram;
import Mxstar.IR.Instruction.IRInst;
import Mxstar.IR.Instruction.Mov;
import Mxstar.IR.Operand.*;
import Mxstar.IR.RegisterSet;

import java.util.*;

public class GraphAllocator {
    public IRProgram irProgram;
    public IRPrinter irPrinter;
    public static LivenessAnalyzer livenessAnalyzer = new LivenessAnalyzer();
    public LinkedList<PhyReg> generalRegisters;
    public int K;

    public GraphAllocator(IRProgram irProgram) {
        this.irPrinter = new IRPrinter();
        this.irProgram = irProgram;
        generalRegisters = new LinkedList<>();
        for (PhyReg pr : RegisterSet.allRegs) {
            if (pr.name.equals("rbp") || pr.name.equals("rsp"))
                continue;
            generalRegisters.add(pr);
        }
        K = generalRegisters.size();

        for (Func func: irProgram.funcs) {
            processFunc(func);
        }
    }

    public LinkedList<VirReg> tranVir(Collection<Register> regs) {
        LinkedList<VirReg> ret = new LinkedList<>();
        for (Register reg: regs) {
            ret.add((VirReg)reg);
        }
        return ret;
    }

    private Func func;
    private Graph originGraph;
    private Graph graph;
    private HashSet<VirReg> simplifyList;
    private HashSet<VirReg> spillList;
    private HashSet<VirReg> spillRegs;
    private LinkedList<VirReg> selectStack;
    private HashMap<VirReg, PhyReg> color;

    private void init() {
        simplifyList = new HashSet<>();
        spillList = new HashSet<>();
        spillRegs = new HashSet<>();
        selectStack = new LinkedList<>();
        color = new HashMap<>();
        for (VirReg virReg: graph.getAllRegs()) {
            if (graph.getDeg(virReg) < K) {
                simplifyList.add(virReg);
            } else {
                spillList.add(virReg);
            }
        }
    }

    private void simplify() {
        VirReg reg = simplifyList.iterator().next();
        LinkedList<VirReg> neighbors = new LinkedList<>(graph.getAdjacent(reg));
        graph.delReg(reg);
        simplifyList.remove(reg);
        for (VirReg virReg: neighbors) {
            if (graph.getDeg(virReg) < K && spillList.contains(virReg)) {
                spillList.remove(virReg);
                simplifyList.add(virReg);
            }
        }
        selectStack.addFirst(reg);
    }

    private void spill() {
        VirReg candidate = null;
        double mxRank = -2;
        for (VirReg reg: spillList) {
            double rank = 1.0 * graph.getDeg(reg) / reg.cntUD  ;
            if (reg.allocatedPhyReg != null) {
                rank = -1;
            }

            if (rank > mxRank) {
                mxRank = rank;
                candidate = reg;
            }
        }
        graph.delReg(candidate);
        spillList.remove(candidate);
        selectStack.addFirst(candidate);
    }

    private void assignColor() {
        for (VirReg virReg: selectStack) {
            if (virReg.allocatedPhyReg != null)
                color.put(virReg, virReg.allocatedPhyReg);
        }
        for (VirReg virReg: selectStack) {
            if (virReg.allocatedPhyReg != null)
                continue;

            HashSet<PhyReg> okColors = new HashSet<>(generalRegisters);
//            if (originGraph == null) {
//                System.out.println("is origin graph a idiot");
//            }
            for (VirReg neighbor: originGraph.getAdjacent(virReg)) {
                if (color.containsKey(neighbor)) {
                    okColors.remove(color.get(neighbor));
                }
            }
            if (okColors.isEmpty()) {
                spillRegs.add(virReg);
            } else {
                PhyReg phyReg  = null;
                for (PhyReg reg: RegisterSet.callerSave) {
                    if (okColors.contains(reg)) {
                        phyReg = reg;
                        break;
                    }
                }
                if (phyReg == null)
                    phyReg = okColors.iterator().next();
                color.put(virReg, phyReg);
            }
        }
    }

    private void rewriteProgram() {
        HashMap<VirReg, Memory> spillPlaces = new HashMap<>();
        for (VirReg virReg: spillRegs) {
            if (virReg.spillPlace != null) {
                spillPlaces.put(virReg, virReg.spillPlace);
            } else {
                spillPlaces.put(virReg, new StackSlot(virReg.hint));
            }
        }
        for (BB bb: func.basicblocks) {
            for (IRInst inst = bb.head; inst != null; inst = inst.next) {
                LinkedList<VirReg> used = tranVir(inst.getUseRegs());
                LinkedList<VirReg> defined = tranVir(inst.getDefRegs());
                HashMap<Register, Register> renameMap = new HashMap<>();
                used.retainAll(spillRegs);
                defined.retainAll(spillRegs);
                for (VirReg virReg: used) {
                    if (!renameMap.containsKey(virReg)) {
                        renameMap.put(virReg, new VirReg(""));
                    }
                }
                for (VirReg virReg: defined) {
                    if (!renameMap.containsKey(virReg)) {
                        renameMap.put(virReg, new VirReg(""));
                    }
                }
                inst.renameUseReg(renameMap);
                inst.renameDefReg(renameMap);
                for (VirReg virReg: used) {
                    inst.prepend(new Mov(bb, renameMap.get(virReg), spillPlaces.get(virReg)));
                }
                for (VirReg virReg: defined) {
                    inst.append(new Mov(bb, spillPlaces.get(virReg), renameMap.get(virReg)));
                    inst = inst.next;
                }
            }
        }
    }

    private void rewriteRegs() {
        HashMap<Register, Register> tmpMap = new HashMap<>();
        for (HashMap.Entry<VirReg, PhyReg> entry: color.entrySet()) {
            tmpMap.put(entry.getKey(), entry.getValue());
        }
//        System.out.println(func.name + tmpMap.size());
        for (BB bb: func.basicblocks) {
            for (IRInst inst = bb.head; inst != null; inst = inst.next) {
                inst.renameDefReg(tmpMap);
                inst.renameUseReg(tmpMap);
            }
        }
    }

    private void processFunc (Func func) {
        this.func = func;
        originGraph = new Graph();
        while(true) {
            livenessAnalyzer.getInterferenceGraph(func, originGraph);
            livenessAnalyzer.calcUDCnt(func);

            graph = new Graph(originGraph);
            init();
            while(true) {
                if (!simplifyList.isEmpty())
                    simplify();
                else if (!spillList.isEmpty())
                    spill();
                else
                    break;
            }
//            if (originGraph == null) {
//                System.out.println();
//            }
            assignColor();

            if (!spillRegs.isEmpty()) {
                rewriteProgram();
            } else {
                rewriteRegs();
                break;
            }
        }

        /*
        System.err.println("===============================================");
        System.err.println("IR for debug: after " + func.name);
        IRPrinter irPrinter = new IRPrinter();
        irPrinter.visit(irProgram);
        irPrinter.printTo(System.err);
*/

        func.finishAllocate();
    }

}
