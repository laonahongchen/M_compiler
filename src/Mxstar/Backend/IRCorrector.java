package Mxstar.Backend;

import Mxstar.Config_Cons;
import Mxstar.IR.*;
import Mxstar.IR.Instruction.*;
import Mxstar.IR.Operand.*;
import Mxstar.Symbol.VariableSymbol;

import java.util.HashSet;

import static java.lang.System.exit;

public class IRCorrector implements IIRVisitor {
    IRProgram irProgram;

    @Override
    public void visit(IRProgram program) {
        this.irProgram = program;
        for (Func func: program.funcs) {
            func.accept(this);
        }
    }

    @Override
    public void visit(Func func) {
        for (BB bb: func.basicblocks) {
            bb.accept(this);
        }
    }

    @Override
    public void visit(BB bb) {
        for (IRInst inst = bb.head; inst != null; inst = inst.next) {
            inst.accept(this);
        }
    }

    @Override
    public void visit(BinInst inst) {
        if ((inst.op == BinInst.BinOp.MUL || inst.op == BinInst.BinOp.MOD || inst.op == BinInst.BinOp.DIV) && inst.src instanceof Constant) {
            VirReg virReg = new VirReg("");
            inst.prepend(new Mov(inst.bb, virReg, inst.src));
            inst.src = virReg;
        }
    }

    @Override
    public void visit(UnaryInst inst) {

    }

    private PhyReg getPhyReg(Operand operand) {
        if (operand instanceof VirReg) {
            return ((VirReg)operand).allocatedPhyReg;
        } else if (operand instanceof PhyReg) {
            return (PhyReg)operand;
        } else {
            return null;
        }
    }

    @Override
    public void visit(Mov inst) {
        if (inst.src instanceof Memory && inst.dest instanceof Memory) {
            VirReg virReg = new VirReg("");
            inst.prepend(new Mov(inst.bb, virReg, inst.src));
            inst.src = virReg;
        } else {
            if (Config_Cons.allocator == Config_Cons.ALLOCATOR.NAIVE_ALLOCATOR) {
                PhyReg pdest = getPhyReg(inst.dest);
                PhyReg psrc = getPhyReg(inst.src);
                if (pdest != null && inst.src instanceof Memory) {
                    VirReg virReg = new VirReg("");
                    inst.prepend(new Mov(inst.bb, virReg, inst.src));
//                    System.out.println((((Memory) inst.src).index));
//                    System.out.println((((Memory) inst.src).scale));
                    inst.src = virReg;
                } else if (psrc != null && inst.dest instanceof Memory) {
                    VirReg virReg = new VirReg("");
                    inst.prepend(new Mov(inst.bb, virReg, inst.dest));
                    inst.dest = virReg;
                }
            }
        }

    }

    @Override
    public void visit(Push inst) {

    }

    @Override
    public void visit(Pop inst) {

    }

    @Override
    public void visit(Jump inst) {

    }

    @Override
    public void visit(Cjump inst) {
        if (inst.src1 instanceof Constant) {
            if (inst.src2 instanceof Constant) {
                inst.prepend(new Jump(inst.bb, inst.doCompare()));
                inst.remove();
            } else {
                Operand tmp = inst.src1;
                inst.src1 = inst.src2;
                inst.src2 = tmp;
                inst.op = inst.getReverseOp();
            }
        }
    }

    @Override
    public void visit(Leave inst) {

    }

    @Override
    public void visit(Call inst) {
        Func caller = inst.bb.func;
        Func callee = inst.func;
        HashSet<VariableSymbol> callerUsed = caller.usedGlobalSymbol;
        HashSet<VariableSymbol> calleeUsed = callee.recursiveUsedGlobalSymbol;
        for (VariableSymbol variableSymbol: callerUsed) {
            if (calleeUsed.contains(variableSymbol)) {
                inst.prepend(new Mov(inst.bb, variableSymbol.virReg.spillPlace, variableSymbol.virReg));
                inst.prev.accept(this);
            }
        }
        while (inst.args.size() > 6 ) {
            inst.prepend(new Push(inst.bb, inst.args.removeLast()));
        }
        for (int i = inst.args.size() - 1; i >= 0 ; --i) {
            inst.prepend(new Mov(inst.bb, RegisterSet.vargs.get(i), inst.args.get(i)));
            inst.prev.accept(this);
        }
        for (VariableSymbol variableSymbol: callerUsed) {
            if (calleeUsed.contains(variableSymbol)) {
                inst.prepend(new Mov(inst.bb, variableSymbol.virReg, variableSymbol.virReg.spillPlace));
                inst.prev.accept(this);
            }
        }
    }

    @Override
    public void visit(Ret inst) {

    }

    @Override
    public void visit(Cdq inst) {

    }

    @Override
    public void visit(Lea inst) {

    }

    @Override
    public void visit(IRInst inst) {

    }

    @Override
    public void visit(FuncAddr operand) {

    }

    @Override
    public void visit(VirReg operand) {

    }

    @Override
    public void visit(PhyReg operand) {
    }

    @Override
    public void visit(Imm operand) {

    }

    @Override
    public void visit(Memory operand) {

    }

    @Override
    public void visit(StackSlot operand) {

    }

    @Override
    public void visit(StaticData operand) {

    }

    @Override
    public void visit(Constant operand) {

    }
}
