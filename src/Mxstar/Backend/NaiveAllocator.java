package Mxstar.Backend;

import Mxstar.IR.BB;
import Mxstar.IR.Func;
import Mxstar.IR.IRProgram;
import Mxstar.IR.Instruction.Call;
import Mxstar.IR.Instruction.IRInst;
import Mxstar.IR.Instruction.Mov;
import Mxstar.IR.Operand.*;

import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;

import static Mxstar.IR.RegisterSet.*;
import static java.lang.System.exit;

public class NaiveAllocator {
    public IRProgram irProgram;
    LinkedList<PhyReg> generalRegisters = new LinkedList<>();

    public NaiveAllocator(IRProgram irProgram) {
        this.irProgram = irProgram;
        generalRegisters.add(rbx);
        generalRegisters.add(r10);
        generalRegisters.add(r11);
        generalRegisters.add(r12);
        generalRegisters.add(r13);
        generalRegisters.add(r14);
        generalRegisters.add(r15);

        for (Func func: irProgram.funcs) {
            processFunc(func);
        }
    }

    private PhyReg getPhyReg(Operand operand) {
        if (operand instanceof VirReg) {
            return ((VirReg)operand).allocatedPhyReg;
        } else {
            return null;
        }
    }

    private void processFunc(Func func) {

        for (BB bb: func.basicblocks) {
            for (IRInst inst = bb.head; inst != null; inst = inst.next) {
                if (inst instanceof Call)
                    continue;
                HashMap<Register, Register> renameMap = new HashMap<>();
                HashSet<Register> allregs = new HashSet<>();
                HashSet<Register> usedregs = new HashSet<>(inst.getUseRegs());
                HashSet<Register> defregs = new HashSet<>(inst.getDefRegs());
                allregs.addAll(usedregs);
                allregs.addAll(defregs);
                for (Register register: allregs) {
                    VirReg virReg = (VirReg) register;
                    if (virReg.allocatedPhyReg != null)
                        continue;
                    if (virReg.spillPlace == null)
                        virReg.spillPlace = new StackSlot(virReg.hint);
                }

                if (inst instanceof Mov) {
                    Mov mov = (Mov)inst;
                    Address dest = mov.dest;
                    Operand src = mov.src;
                    PhyReg pdest = getPhyReg(dest);
                    PhyReg psrc = getPhyReg(src);
                    if (pdest != null && psrc != null) {
                        mov.dest = pdest;
                        mov.src = psrc;
                        continue;
                    } else if (pdest != null){
                        mov.dest = pdest;
                        if (mov.src instanceof VirReg) {
                            mov.src = ((VirReg) mov.src).spillPlace;
                        }
                        continue;
                    } else if (psrc != null) {
                        mov.src = psrc;
                        if (mov.dest instanceof VirReg) {
                            mov.dest = ((VirReg) mov.dest).spillPlace;
                        }
                        continue;
                    }
                }

                int cnt = 0;
                for (Register regs: allregs) {
                    if (!renameMap.containsKey(regs)) {
                        PhyReg phyReg = ((VirReg)regs).allocatedPhyReg;
                        if (phyReg == null) {
                            renameMap.put(regs, generalRegisters.get(cnt++));
                        } else {
                            renameMap.put(regs, phyReg);
                        }
                    }
                }

                inst.renameUseReg(renameMap);
                inst.renameDefReg(renameMap);
                for (Register regs: usedregs) {
                    if (((VirReg)regs).allocatedPhyReg == null) {
                        //System.out.println(renameMap.get(regs));
                        System.out.println("in rename use");
                        inst.prepend(new Mov(bb, renameMap.get(regs), ((VirReg) regs).spillPlace));
                    }
                }

                for (Register regs: defregs) {
                    if (((VirReg)regs).allocatedPhyReg == null) {
                        System.out.println("in rename def\n");
                        inst.append(new Mov(bb, ((VirReg) regs).spillPlace, renameMap.get(regs)));
                        inst = inst.next;
                    }
                }
            }


        }


    }

}
