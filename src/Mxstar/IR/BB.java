package Mxstar.IR;

//import Mxstar.IR.Instruction.IRInst;
import Mxstar.IR.Instruction.*;
import Mxstar.Symbol.FunctionSymbol;
import org.antlr.v4.runtime.tree.ParseTree;

import java.util.LinkedList;
import java.util.List;

public class BB {
    public String hint;
    public Func func;
    public IRInst head = null;
    public IRInst tail = null;

    public List<BB> frontiers;
    public List<BB> successers;

    public int blockID;
    public static int globalBlockID = 0;

    public BB(Func func, String hint) {
        this.hint = hint;
        this.func = func;
        this.frontiers = new LinkedList<>();
        this.successers = new LinkedList<>();
        this.func.basicblocks.add(this);
        this.blockID = globalBlockID++;
    }

    public boolean isEnded() {
        return tail instanceof Jump || tail instanceof Ret || tail instanceof Cjump;
    }

    public void prepend(IRInst inst)  {
        head.prepend(inst);
    }
    public void append(IRInst inst) {
        if (isEnded())
            return ;
        if (head == null) {
            inst.prev = null;
            inst.next = null;
            head = tail = inst;
        } else {
            tail.append(inst);
        }
    }

    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
