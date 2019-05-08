package Mxstar.IR;

import Mxstar.IR.Instruction.*;
import Mxstar.IR.Operand.PhyReg;
import Mxstar.IR.Operand.Register;
import Mxstar.IR.Operand.VirReg;
import Mxstar.Symbol.VariableSymbol;

import java.util.HashSet;
import java.util.LinkedList;

public class Func {
    public enum Type {
        External, Library, UserDefined
    }

    public Type type;
    public String name;
    public boolean hasReturnValue;
    public boolean hasOutput;
    public BB enterBB;
    public BB leaveBB;
    public LinkedList<BB> basicblocks;
    public LinkedList<BB> reversePostOrder;
    public LinkedList<BB> reversePostOrderOnCFG;
    public LinkedList<VirReg> parameters;

    public HashSet<VariableSymbol> usedGlobalSymbol;
    public HashSet<VariableSymbol> recursiveUsedGlobalSymbol;
    public HashSet<PhyReg> usedPhysicalRegister;
    public HashSet<PhyReg> recursiveUsedPhysicalRegister;

    public HashSet<Func> callee;

    public HashSet<BB> visitedBB;
    public HashSet<Func> visitedFunc;


    public Func(Type type, String name, boolean HasReturnValue) {
        this.type = type;
        this.name = name;
        this.hasReturnValue = HasReturnValue;
        this.hasOutput = false;
        this.basicblocks = new LinkedList<>();
        this.reversePostOrder = new LinkedList<>();
        this.reversePostOrderOnCFG = new LinkedList<>();
        this.parameters = new LinkedList<>();
        this.usedGlobalSymbol = new HashSet<>();
        this.recursiveUsedGlobalSymbol = new HashSet<>();
        this.usedPhysicalRegister = new HashSet<>();
        this.recursiveUsedPhysicalRegister = new HashSet<>();
        this.callee = new HashSet<>();
        this.visitedBB = new HashSet<>();
        this.visitedFunc = new HashSet<>();

        if (type != Type.UserDefined && !name.equals("init")) {
            for (PhyReg pr : RegisterSet.allRegs) {
                if (pr.name.equals("rbp") || pr.name.equals("rsp"))
                    continue;
                this.usedPhysicalRegister.add(pr);
                this.recursiveUsedPhysicalRegister.add(pr);
            }
        }
    }

    public void dfsReversePostOrder(BB node) {
        if (visitedBB.contains(node))
            return ;
        visitedBB.add(node);
        for (BB bb: node.successers)
            dfsReversePostOrder(bb);
        reversePostOrder.addFirst(node);
    }

    public void dfsReversePostOrderOnReversedCFG(BB node) {
        if (visitedBB.contains(node))
            return ;
        visitedBB.add(node);
        for (BB bb: node.frontiers)
            dfsReversePostOrderOnReversedCFG(bb);
        reversePostOrderOnCFG.addFirst(node);
    }

    public void dfsRecursiveUsedGlobalVariables(Func node) {
        if (visitedFunc.contains(node))
            return ;
        visitedFunc.add(node);
        for (Func func: node.callee)
            dfsRecursiveUsedGlobalVariables(func);
        recursiveUsedGlobalSymbol.addAll(node.usedGlobalSymbol);
    }

    public void finishBuild() {
        for (BB bb: basicblocks) {
            bb.successers.clear();
            bb.frontiers.clear();
        }
        for (BB bb: basicblocks) {
            if (bb.tail instanceof Cjump) {
//                if (((Cjump) bb.tail).thenbb == null)
//                    System.out.println("thenbb null");
                bb.successers.add(((Cjump)bb.tail).thenbb);
//                if (((Cjump) bb.tail).elsebb == null)
//                    System.out.println("elsebb null");
                bb.successers.add(((Cjump)bb.tail).elsebb);

            } else if (bb.tail instanceof Jump) {
//                if (((Jump) bb.tail).targetBB == null)
//                    System.out.println("targetbb null");
                bb.successers.add(((Jump)bb.tail).targetBB);
            }
            for (BB suc: bb.successers) {
//                if (suc == null)
//                    System.out.println(this.name + " suc is null!!!");
                suc.frontiers.add(bb);
            }
        }

        for (BB bb: basicblocks) {
            if (bb.tail instanceof Cjump) {
                Cjump cjump = (Cjump)bb.tail;
                if (cjump.thenbb.frontiers.size() < cjump.elsebb.frontiers.size()) {
                    cjump.op = cjump.getNegOp();
                    BB temp = cjump.thenbb;
                    cjump.thenbb = cjump.elsebb;
                    cjump.elsebb = temp;
                }
            }
        }
        visitedBB.clear();
        reversePostOrder.clear();
        dfsReversePostOrder(enterBB);

        visitedBB.clear();
        reversePostOrderOnCFG.clear();
        dfsReversePostOrderOnReversedCFG(leaveBB);

        visitedFunc.clear();
        recursiveUsedGlobalSymbol.clear();
        dfsRecursiveUsedGlobalVariables(this);
    }

    public LinkedList<PhyReg> trans(LinkedList<Register> regs) {
        LinkedList<PhyReg> ret = new LinkedList<>();
        for (Register reg: regs) {
            ret.add((PhyReg) reg);
        }
        return ret;
    }

    public void dfsRecursiveUsedPhysicalRegisters(Func node) {
        if (visitedFunc.contains(node))
            return ;
        visitedFunc.add(node);
        for (Func func: node.callee)
            dfsRecursiveUsedPhysicalRegisters(func);
        recursiveUsedPhysicalRegister.addAll(node.usedPhysicalRegister);
    }

    public boolean isSpecialBinaryOp(BinInst.BinOp op) {
        return op == BinInst.BinOp.MUL || op == BinInst.BinOp.DIV || op == BinInst.BinOp.MOD;
    }

    public void finishAllocate() {
        for (BB bb: basicblocks) {
            for (IRInst inst = bb.head; inst != null;  inst = inst.next) {
                if (inst instanceof Ret)
                    return;
                if (inst instanceof Call) {
                    usedPhysicalRegister.addAll(RegisterSet.callerSave);
                } else if (inst instanceof BinInst && isSpecialBinaryOp(((BinInst)inst).op)) {
                    usedPhysicalRegister.add(RegisterSet.rax);
                    usedPhysicalRegister.add(RegisterSet.rdx);
                    if (((BinInst)inst).src instanceof Register)
                        usedPhysicalRegister.add((PhyReg)(((BinInst)inst).src));
                } else if (inst instanceof Setcc) {
                    usedPhysicalRegister.add(RegisterSet.rax);
                    if (((Setcc)inst).src1 instanceof Register)
                        usedPhysicalRegister.add((PhyReg)(((Setcc)inst).src1));
                    if (((Setcc)inst).src2 instanceof Register)
                        usedPhysicalRegister.add((PhyReg)(((Setcc)inst).src2));
                    if (((Setcc)inst).dest instanceof Register)
                        usedPhysicalRegister.add((PhyReg)(((Setcc)inst).dest));
                } else {
                    usedPhysicalRegister.addAll(trans(inst.getUseRegs()));
                    usedPhysicalRegister.addAll(trans(inst.getDefRegs()));
                }
            }
        }
        visitedFunc.clear();
        dfsRecursiveUsedPhysicalRegisters(this);
    }

    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
