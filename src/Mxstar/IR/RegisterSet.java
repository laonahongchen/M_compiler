package Mxstar.IR;

import Mxstar.IR.Operand.PhyReg;
import Mxstar.IR.Operand.VirReg;
import Mxstar.Symbol.VariableSymbol;

import java.util.LinkedList;

public class RegisterSet {
    public static PhyReg rax;
    public static PhyReg rbx;
    public static PhyReg rcx;
    public static PhyReg rdx;
    public static PhyReg rbp;
    public static PhyReg rsp;
    public static PhyReg rsi;
    public static PhyReg rdi;
    public static PhyReg r8;
    public static PhyReg r9;
    public static PhyReg r10;
    public static PhyReg r11;
    public static PhyReg r12;
    public static PhyReg r13;
    public static PhyReg r14;
    public static PhyReg r15;

    public static VirReg vrax;
    public static VirReg vrbx;
    public static VirReg vrcx;
    public static VirReg vrdx;
    public static VirReg vrbp;
    public static VirReg vrsp;
    public static VirReg vrsi;
    public static VirReg vrdi;
    public static VirReg vr8;
    public static VirReg vr9;
    public static VirReg vr10;
    public static VirReg vr11;
    public static VirReg vr12;
    public static VirReg vr13;
    public static VirReg vr14;
    public static VirReg vr15;

    public static LinkedList<PhyReg> allRegs;
    public static LinkedList<PhyReg> calleeSave;
    public static LinkedList<PhyReg> callerSave;
    public static LinkedList<PhyReg> args;

    public static LinkedList<VirReg> vallRegs;
    public static LinkedList<VirReg> vcalleeSave;
    public static LinkedList<VirReg> vcallerSave;
    public static LinkedList<VirReg> vargs;

    public static void init() {
        allRegs = new LinkedList<>();
        calleeSave = new LinkedList<>();
        callerSave = new LinkedList<>();
        args = new LinkedList<>();
        vallRegs = new LinkedList<>();
        vcalleeSave = new LinkedList<>();
        vcallerSave = new LinkedList<>();
        vargs = new LinkedList<>();

        String[] name = new String[]{"rax", "rbx","rcx","rdx","rbp","rsp","rsi","rdi","r8","r9","r10","r11","r12","r13","r14","r15"};
        Boolean[] isCallerSave = new Boolean[]{true,false,true,true,null,null,true,true,true,true,true,true,false,false,false,false};
        for (int i = 0; i < 16; ++i) {
            PhyReg pr = new PhyReg();
            VirReg vr = new VirReg("v" + name[i]);
            pr.name = name[i];
            vr.allocatedPhyReg = pr;
            allRegs.add(pr);
            vallRegs.add(vr);
            if (isCallerSave[i] != null) {
                if (isCallerSave[i]) {
                    callerSave.add(pr);
                    vcalleeSave.add(vr);
                } else {
                    calleeSave.add(pr);
                    vcalleeSave.add(vr);
                }
            }
        }
        rax = allRegs.get(0);
        rbx = allRegs.get(1);
        rcx = allRegs.get(2);
        rdx = allRegs.get(3);
        rbp = allRegs.get(4);
        rsp = allRegs.get(5);
        rsi = allRegs.get(6);
        rdi = allRegs.get(7);
        r8 = allRegs.get(8);
        r9 = allRegs.get(9);
        r10 = allRegs.get(10);
        r11 = allRegs.get(11);
        r12 = allRegs.get(12);
        r13 = allRegs.get(13);
        r14 = allRegs.get(14);
        r15 = allRegs.get(15);

        vrax = vallRegs.get(0);
        vrbx = vallRegs.get(1);
        vrcx = vallRegs.get(2);
        vrdx = vallRegs.get(3);
        vrbp = vallRegs.get(4);
        vrsp = vallRegs.get(5);
        vrsi = vallRegs.get(6);
        vrdi = vallRegs.get(7);
        vr8 = vallRegs.get(8);
        vr9 = vallRegs.get(9);
        vr10 = vallRegs.get(10);
        vr11 = vallRegs.get(11);
        vr12 = vallRegs.get(12);
        vr13 = vallRegs.get(13);
        vr14 = vallRegs.get(14);
        vr15 = vallRegs.get(15);

        args.add(rdi);
        args.add(rsi);
        args.add(rdx);
        args.add(rcx);
        args.add(r8);
        args.add(r9);

        vargs.add(vrdi);
        vargs.add(vrsi);
        vargs.add(vrdx);
        vargs.add(vrcx);
        vargs.add(vr8);
        vargs.add(vr9);
    }
}
