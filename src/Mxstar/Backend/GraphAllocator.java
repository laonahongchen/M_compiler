package Mxstar.Backend;

import Mxstar.IR.Func;
import Mxstar.IR.IRProgram;
import Mxstar.IR.Operand.PhyReg;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.VirReg;
import Mxstar.IR.RegisterSet;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;

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
    HashMap<VirReg, PhyReg> color;

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
        int rank = -2;

    }

    private void processFunc (Func func) {
        Graph graph = new Graph();
        irPrinter.init();

    }

    public void run() {
        for (Func func: irProgram.funcs) {
            processFunc(func);
        }
    }

}
