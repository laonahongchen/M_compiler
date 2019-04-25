package Mxstar.IR;

import Mxstar.IR.Instruction.*;
import Mxstar.IR.Operand.*;

public interface IIRVisitor {
    void visit(IRProgram program);
    void visit(Func func);
    void visit(BB bb);
    void visit(BinInst inst);
    void visit(UnaryInst inst);
    void visit(Mov inst);
    void visit(Push inst);
    void visit(Pop inst);
    void visit(Jump inst);
    void visit(Cjump inst);
    void visit(Leave inst);
    void visit(Call inst);
    void visit(Ret inst);
    void visit(IRInst inst);
    void visit(FuncAddr operand);
    void visit(VirReg operand);
    void visit(PhyReg operand);
    void visit(Imm operand);
    void visit(Memory operand);
    void visit(StackSlot operand);
    void visit(StaticData operand);
}
