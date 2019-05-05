package Mxstar.Backend;

import Mxstar.Config_Cons;
import Mxstar.IR.BB;
import Mxstar.IR.Func;
import Mxstar.IR.IRProgram;
import Mxstar.IR.Instruction.*;
import Mxstar.IR.Operand.*;
import Mxstar.IR.RegisterSet;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;


/*
          +----------+
         rsp-24 |    a     |
                +----------+
         rsp-16 |    b     |
                +----------+
         rsp-8  |    c     |
                +----------+
         rsp    | retaddr  |
                +----------+
         rsp+8  | caller's |
                | stack    |
                | frame    |
                | ...     |
                +----------+
 */

public class StackBuilder {
    class Frame{
        public LinkedList<StackSlot> parameters = new LinkedList<>();
        public LinkedList<StackSlot> temporaries = new LinkedList<>();
        public int getFrameSize() {
//            System.out.println(parameters.size());
//            System.out.println(temporaries.size() + "\n");
            int bytes = Config_Cons.REGISTER_WIDTH * (parameters.size() + temporaries.size());
            bytes = (bytes + 15) / 16 * 16;
            return bytes;
        }
    }

    public IRProgram irProgram;
    public HashMap<Func,  Frame> frameMap;

    public StackBuilder(IRProgram irProgram) {
        this.irProgram = irProgram;
        frameMap = new HashMap<>();
    }

    public void processFunc(Func func) {
        Frame frame = new Frame();
        frameMap.put(func, frame);
        LinkedList<VirReg> parameters = func.parameters;
//        int[] paraRegisters = new int[] {7,6,2,1,8,9};
        for (int i = 6; i < parameters.size(); ++i) {
            StackSlot stackSlot = (StackSlot)parameters.get(i).spillPlace;
            frame.parameters.add(stackSlot);
        }

        HashSet<StackSlot> slots = new HashSet<>();
        for (BB bb: func.basicblocks) {
            for (IRInst inst = bb.head; inst != null; inst = inst.next) {
                LinkedList<StackSlot> stackSlots = new LinkedList<>(inst.getStackSlots());
                for (StackSlot stackSlot: stackSlots) {
                    if (!frame.parameters.contains(stackSlot))
                        slots.add(stackSlot);
                }
//                slots.addAll(inst.getStackSlots());
//                System.out.println(slots.size());
            }

        }

        frame.temporaries.addAll(slots);
        for (int i = 0; i < frame.parameters.size(); ++i) {
            StackSlot stackSlot = frame.parameters.get(i);
            stackSlot.base = RegisterSet.rbp;
            stackSlot.constant = new Imm(16 + 8 * i);
        }

        for (int i = 0; i < frame.temporaries.size(); ++i) {
            StackSlot stackSlot = frame.temporaries.get(i);
            stackSlot.base = RegisterSet.rbp;
            stackSlot.constant = new Imm(-8 - 8 * i);
        }

        IRInst headinst = func.enterBB.head;
        headinst.prepend(new Push(headinst.bb, RegisterSet.rbp));
        headinst.prepend(new Mov(headinst.bb, RegisterSet.rbp, RegisterSet.rsp));
        headinst.prepend(new BinInst(headinst.bb, BinInst.BinOp.SUB, RegisterSet.rsp, new Imm(frame.getFrameSize())));

        HashSet<PhyReg> needToSave = new HashSet<>(func.usedPhysicalRegister);
        needToSave.retainAll(RegisterSet.calleeSave);
        headinst = headinst.prev;
        for (PhyReg pr: needToSave)
            headinst.append(new Push(headinst.bb, pr));


        Ret ret = (Ret)func.leaveBB.tail;
        for (PhyReg pr: needToSave)
            ret.prepend(new Pop(ret.bb, pr));
        ret.prepend(new Leave(ret.bb));
    }

    public void run() {
        for (Func func : irProgram.funcs) {
            processFunc(func);
        }
    }
}
