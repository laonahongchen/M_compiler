package Mxstar.Optimizer;

import Mxstar.Config_Cons;
import Mxstar.IR.BB;
import Mxstar.IR.Func;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.IRProgram;
import Mxstar.IR.Instruction.*;
import Mxstar.IR.Operand.*;

import static Mxstar.IR.Instruction.BinInst.BinOp.*;
import static Mxstar.IR.RegisterSet.*;

public class LVN implements IIRVisitor {
    private SVNTable table;
    private BB curBB;

    private void run() {
        for (IRInst inst = curBB.head, nxtInst = inst; inst != null; inst = nxtInst) {
            nxtInst = nxtInst.next;
            inst.accept(this);
        }
    }

    public LVN(BB bb, SVNTable table) {
        curBB = bb;
        this.table = table;

        run();
    }

    @Override
    public void visit(IRProgram program) {

    }

    @Override
    public void visit(Func func) {

    }

    @Override
    public void visit(BB bb) {

    }

    private int doBinary(BinInst.BinOp op, int lhs, int rhs) {
//        System.out.println(lhs);
//        System.out.println(rhs);
//        System.out.println("val");
        switch (op) {
            case MUL:
                return lhs * rhs;
            case DIV:
                if (rhs == 0)
                    return 1;
                return lhs / rhs;
            case MOD:
                if (rhs == 0)
                    return 1;
                return lhs % rhs;
            case ADD:
                return lhs + rhs;
            case SUB:
                return lhs - rhs;
            case SAL:
                return (lhs << rhs);
            case SAR:
                return (lhs >> rhs);
            case OR:
                return (lhs | rhs);
            case AND:
                return (lhs & rhs);
            case XOR:
                return (lhs ^ rhs);
            default:
                return 0;
        }
    }

    private int doUnary(UnaryInst.UnaryOp op, int val) {
        switch (op) {
            case DEC:
                return val - 1;
            case INC:
                return val + 1;
            case NEG:
                return -val;
            case NOT:
                return ~val;
            default:
                return 0;
        }
    }

    @Override
    public void visit(BinInst inst) {
        int vrhs = table.getOperandVal(inst.src);
        int vlhs = (inst.op == MUL || inst.op == MOD || inst.op == DIV) ? table.getOperandVal(vrax) : table.getOperandVal(inst.dest);
        Operand ilhs = table.getValOperand(vlhs);
        Operand irhs = table.getValOperand(vrhs);

        if (ilhs instanceof Imm && irhs instanceof Imm) {
            if (inst.op == BinInst.BinOp.DIV || inst.op == MOD) {
                assert inst.prev instanceof Cdq;
                inst.prev.remove();
            }
            int res = doBinary(inst.op, ((Imm) ilhs).value, ((Imm) irhs).value);
//            System.out.println(res);
            if (inst.op == MOD) {
                inst.replace(new Mov(inst.bb, vrdx, new Imm(res)));
            } else if (inst.op == MUL || inst.op == DIV) {
                inst.replace(new Mov(inst.bb, vrax, new Imm(res)));
            } else {
                inst.replace(new Mov(inst.bb, inst.dest, new Imm(res)));
            }
            if (inst.op == MOD) {
                table.putRegVal(vrax);
                table.putRegVal(vrdx, table.getImmVal(res));
            } else if (inst.op == BinInst.BinOp.MUL || inst.op == BinInst.BinOp.DIV) {
                table.putRegVal(vrax, table.getImmVal(res));
                table.putRegVal(vrdx);
            } else  {
                if (inst.dest instanceof VirReg) {
                    table.putRegVal((VirReg) inst.dest, table.getImmVal(res));
                }
            }
        } else {
            int keyval = table.getKeyVal(table.getOperandVal(inst.dest), table.getOperandVal(inst.src), inst.op);
            Operand operand = table.getValOperand(keyval);
            if (operand != null && Config_Cons.doVNOptimize) {
                if (inst.op == BinInst.BinOp.DIV || inst.op == MOD) {
                    assert inst.prev instanceof  Cdq;
                    inst.prev.remove();
                }

                if (inst.op == BinInst.BinOp.MUL || inst.op == DIV) {
                    inst.replace(new Mov(inst.bb, vrax, operand));
                } else if (inst.op == MOD) {
                    inst.replace(new Mov(inst.bb, vrdx, operand));
                } else {
                    inst.replace(new Mov(inst.bb, inst.dest, operand));
                }
            }
            if (inst.op == MOD) {
                table.putRegVal(vrax);
                table.putRegVal(vrdx, keyval);
            } else if (inst.op == BinInst.BinOp.MUL || inst.op == BinInst.BinOp.DIV) {
                table.putRegVal(vrax, keyval);
                table.putRegVal(vrdx);
            } else if (inst.dest instanceof VirReg) {
                table.putRegVal((VirReg) inst.dest, keyval);
            }
        }
    }

    @Override
    public void visit(UnaryInst inst) {
        int val = table.getOperandVal(inst.dest);
        int res = -1;
        Operand operand = table.getValOperand(val);
        if (operand instanceof Imm) {
            res = doUnary(inst.op, ((Imm) operand).value);
            inst.replace(new Mov(inst.bb, inst.dest, new Imm(res)));
            res = table.getImmVal(res);
        } else {
            if (inst.op == UnaryInst.UnaryOp.INC) {
                res = table.getKeyVal(val, table.getImmVal(1), BinInst.BinOp.ADD);
            } else if (inst.op == UnaryInst.UnaryOp.DEC) {
                res = table.getKeyVal(val, table.getImmVal(1), BinInst.BinOp.SUB);
            }
            Operand reg = table.getValOperand(res);
            if (reg instanceof VirReg && Config_Cons.doVNOptimize) {
                inst.replace(new Mov(inst.bb, inst.dest, reg));
            }
        }
        if (inst.dest instanceof VirReg) {
            if (res == -1)
                table.putRegVal((VirReg) inst.dest);
             else {
                 table.putRegVal((VirReg) inst.dest, res);
            }
        }
    }

    @Override
    public void visit(Mov inst) {
        int val = table.getOperandVal(inst.src);
        if (table.getOperandVal(inst.dest) == val && Config_Cons.doVNOptimize) {
            inst.remove();
            return ;
        }
//        System.out.println(val);
        Operand result = table.getValOperand(val);
        if (result instanceof Imm) {
            inst.replace(new Mov(inst.bb, inst.dest, new Imm((Imm)result)));
        }
        if (inst.dest instanceof VirReg) {
            table.putRegVal((VirReg) inst.dest, val);
//            System.out.println(table.getValOperand(1) instanceof Imm);
        }
//        System.out.println(inst.dest == vrax);
//        System.out.println("finish move");
    }

    @Override
    public void visit(Push inst) {

    }

    @Override
    public void visit(Pop inst) {
        if (inst.dest instanceof VirReg) {
            table.putRegVal((VirReg) inst.dest);
        }
    }

    @Override
    public void visit(Jump inst) {

    }

    @Override
    public void visit(Cjump inst) {
        int lhs = table.getOperandVal(inst.src1);
        int rhs = table.getOperandVal(inst.src2);
        Operand rlhs = table.getValOperand(lhs);
        Operand rrhs = table.getValOperand(rhs);
        if (rlhs instanceof Imm) {
            inst.src1 = new Imm((Imm)rlhs);
        }
        if (rrhs instanceof Imm) {
            inst.src2 = new Imm((Imm)rrhs);
        }
    }

    @Override
    public void visit(Leave inst) {

    }

    @Override
    public void visit(Call inst) {
        table.putRegVal(vrax);
    }

    @Override
    public void visit(Ret inst) {

    }

    @Override
    public void visit(Cdq inst) {
        table.putRegVal(vrdx);
    }

    @Override
    public void visit(Lea inst) {
        if (inst.dest instanceof VirReg) {
            table.putRegVal((VirReg) inst.dest);
        }
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
