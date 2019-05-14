package Mxstar.Optimizer;

import Mxstar.IR.Instruction.*;
import Mxstar.IR.Operand.*;

import java.util.HashMap;
import java.util.HashSet;

public class SVNTable {
    private class SVNKey {
        BinInst.BinOp op;
        Integer lhs;
        Integer rhs;

        public SVNKey(BinInst.BinOp op, Integer lhs, Integer rhs) {
            this.lhs = lhs;
            this.rhs = rhs;
            this.op = op;
        }

        @Override
        public int hashCode() {
            return lhs * 12281 + rhs * 13 + op.ordinal();
        }

        @Override
        public boolean equals(Object b) {
            if (b instanceof SVNKey) {
                if (lhs.equals(((SVNKey) b).lhs) && rhs.equals(((SVNKey) b).rhs) && op.ordinal() == ((SVNKey) b).op.ordinal()) {
                    return true;
                }
                if (op == BinInst.BinOp.ADD || op == BinInst.BinOp.MUL || op == BinInst.BinOp.AND || op == BinInst.BinOp.OR || op == BinInst.BinOp.XOR) {
                    if (lhs.equals(((SVNKey) b).rhs) && rhs.equals(((SVNKey) b).lhs) && op.ordinal() == ((SVNKey) b).op.ordinal()) {
                        return true;
                    }
                }
                return false;
            } else {
                return false;
            }
        }
    }

    private HashMap<VirReg, Integer> regValueMap;
    private HashMap<SVNKey, Integer> keyValueMap;
    private HashMap<Integer, Integer> immValueMap;
    private HashMap<Integer, HashSet<VirReg>> valRegMap;
    private HashMap<Integer, Integer> valImmMap;
    private int valCnt;


    public SVNTable(){
        regValueMap = new HashMap<>();
        keyValueMap = new HashMap<>();
        immValueMap = new HashMap<>();
        valImmMap = new HashMap<>();
        valRegMap = new HashMap<>();
        valCnt = 0;
    }
    public SVNTable(SVNTable table){
        regValueMap = new HashMap<>(table.regValueMap);
        keyValueMap = new HashMap<>(table.keyValueMap);
        immValueMap = new HashMap<>(table.immValueMap);
        valRegMap = new HashMap<>(table.valRegMap);
        valImmMap = new HashMap<>(table.valImmMap);
        valCnt = table.valCnt;
    }

    public void addRegVal(VirReg reg, int val) {
        if (!valRegMap.containsKey(val)) {
            valRegMap.put(val, new HashSet<>());
        }
        if (reg.spillPlace == null && reg.allocatedPhyReg == null)
            valRegMap.get(val).add(reg);
        regValueMap.put(reg, val);
    }

    public int getRegVal(VirReg reg) {
        if (!regValueMap.containsKey(reg)) {
            addRegVal(reg, ++valCnt);
        }
        return regValueMap.get(reg);
    }

    public int getImmVal(int imm) {
        if (!immValueMap.containsKey(imm)) {
            valImmMap.put(++valCnt, imm);
            immValueMap.put(imm, valCnt);
        }
        return immValueMap.get(imm);
    }

    public int getOperandVal(Operand operand) {
        if (operand instanceof VirReg) {
            return getRegVal((VirReg) operand);
        } else if (operand instanceof Imm) {
            return getImmVal(((Imm) operand).value);
        } else {
            return ++valCnt;
        }
    }

    public int getKeyVal(int lhs, int rhs, BinInst.BinOp op) {
        SVNKey svnKey = new SVNKey(op, lhs, rhs);
        if (keyValueMap.containsKey(svnKey)) {
            return keyValueMap.get(svnKey);
        } else {
            keyValueMap.put(svnKey, ++valCnt);
            valRegMap.put(valCnt, new HashSet<>());
            return valCnt;
        }
    }

    public Operand getValOperand(int val) {
        if (valImmMap.containsKey(val)) {
            return new Imm(valImmMap.get(val));
        } else if (valRegMap.containsKey(val)) {
            if (valRegMap.get(val).size() > 0)
                return valRegMap.get(val).iterator().next();
             else
                 return null;
        } else {
            return null;
        }
    }

    public void putRegVal(VirReg reg, int val) {
        if (regValueMap.containsKey(reg)) {
            int num = regValueMap.get(reg);
            valRegMap.get(num).remove(reg);
        }
        addRegVal(reg, val);
    }

    public void putRegVal(VirReg reg) {
        putRegVal(reg, ++valCnt);
    }
}
