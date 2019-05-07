package Mxstar.Optimizer;

import Mxstar.IR.BB;
import Mxstar.IR.Func;
import Mxstar.IR.IRProgram;

import java.util.HashSet;
import java.util.LinkedList;


public class SVN {
    LinkedList<BB> workList;
    IRProgram irProgram;
    HashSet<BB> alreadyVisit;

    public SVN(IRProgram irProgram) {
        this.irProgram = irProgram;
        workList = new LinkedList<>();

    }

    public void runSVN(BB curBB, SVNTable table) {
        LVN lvn = new LVN(curBB, table);
        for (BB s: curBB.successers) {
            if (s.frontiers.size() == 1) {
                alreadyVisit.add(s);
                runSVN(s, new SVNTable(table));
            } else {
                if (!alreadyVisit.contains(s)) {
                    workList.add(s);
                    alreadyVisit.add(s);
                }
            }
        }
    }

    public void processFunc(Func func) {
        //System.out.println(func.name);
        alreadyVisit = new HashSet<>();
        workList.add(func.enterBB);
        alreadyVisit.add(func.enterBB);
        while (!workList.isEmpty()) {
            BB bb = workList.getFirst();
            workList.removeFirst();
            runSVN(bb, new SVNTable());
        }
    }

    public void run() {
        for (Func func: irProgram.funcs) {
            processFunc(func);
        }
    }
}
