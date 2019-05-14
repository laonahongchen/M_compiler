package Mxstar.Optimizer;

import Mxstar.IR.Func;
import Mxstar.IR.IRProgram;

public class Memorization {
    private IRProgram irProgram;

    public Memorization(IRProgram irProgram) {
        this.irProgram = irProgram;
    }

    private void processFunc(Func func) {
        if (!func.usedGlobalSymbol.isEmpty())
            return ;

//        if (func.)
    }

    public void run() {
        for (Func func: irProgram.funcs) {
            processFunc(func);
        }
    }
}
