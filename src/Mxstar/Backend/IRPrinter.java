package Mxstar.Backend;

import Mxstar.IR.BB;
import Mxstar.IR.Func;
import Mxstar.IR.IIRVisitor;
import Mxstar.IR.IRProgram;
import Mxstar.IR.Instruction.*;
import Mxstar.IR.Operand.*;
import Mxstar.Symbol.ArrayType;

import javax.print.attribute.HashPrintJobAttributeSet;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Formatter;
import java.util.HashMap;
import java.util.HashSet;

import static java.lang.System.exit;

public class IRPrinter implements IIRVisitor {
    public StringBuilder stringBuilder;
    public HashMap<BB, String> bbName;
    public HashMap<VirReg, String> varName;
    public HashMap<StackSlot, String> ssNames;
    public HashMap<StaticData, String > sdNames;

    public BB nextbb = null;
    public boolean inLeaInst;
    public int bbCount = 0;
    public int varCount = 0;
    public int ssCount = 0;
    public int sdCount = 0;

    public static boolean showId = false;
    public static boolean showBlockHint = false;
    public static boolean showNasm = false;

    public IRPrinter() {
        init();
    }

    public void init() {
        this.stringBuilder = new StringBuilder();
        this.bbName = new HashMap<>();
        this.varName = new HashMap<>();
        this.ssNames = new HashMap<>();
        this.sdNames = new HashMap<>();
        this.inLeaInst = false;
    }

    public String toString() {
        return stringBuilder.toString();
    }
    public void printTo(PrintStream out) {
        out.println(toString());
    }

    public String getBBName(BB bb) {
        if (!bbName.containsKey(bb)) {
            bbName.put(bb, "l_" + (bbCount++) + (showId ? "(1" + bb.blockID + ")" : ""));
        }
        return bbName.get(bb);
    }
    public String getVarName(VirReg bb) {
        if (!varName.containsKey(bb)) {
            varName.put(bb, "v" + (varCount++) + (showId ? "(3" + bb.id + ")" : ""));
        }
        return varName.get(bb);
    }
    public String getSSName(StackSlot bb) {
        if (!ssNames.containsKey(bb)) {
            ssNames.put(bb, "stack[" + (ssCount++) + "]");
        }
        return ssNames.get(bb);
    }
    public String getSDName(StaticData bb) {
        if (!sdNames.containsKey(bb)) {
            sdNames.put(bb, "g_" + (sdCount++));
        }
        return sdNames.get(bb);
    }

    @Override
    public void visit(IRProgram program) {
        if (showNasm) {
            try {
                BufferedReader br = new BufferedReader(new FileReader("lib/c2nasm/lib.asm"));
                String line;
                while((line = br.readLine()) != null)
                    stringBuilder.append(line + "\n");
                stringBuilder.append(";====================================================\n");
                stringBuilder.append("\t section .text\n");
            } catch (IOException e) {
                exit(1);
            }
        }

        for (Func func: program.funcs)
            func.accept(this);

        if (showNasm) {
            stringBuilder.append("\t section .data\n");
            for (StaticData staticData: program.staticData) {
                stringBuilder.append(getSDName(staticData) + ":\n");
                if (staticData.init != null) {
                    stringBuilder.append("\tdq " + staticData.init.length() + "\n\tdb ");
                    for (int i = 0; i < staticData.init.length(); ++i) {
                        Formatter formatter = new Formatter();
                        formatter.format("%02XH, ", (int)staticData.init.charAt(i));
                        stringBuilder.append(formatter);
                    }
                    stringBuilder.append("00H\n");
                } else {
                    stringBuilder.append("\tdb ");
                    for (int i = 0 ;i < staticData.bytes; ++i) {
                        if (i != 0) {
                            stringBuilder.append(", ");
                        }
                        stringBuilder.append("00H");
                    }
                    stringBuilder.append("\n");
                }
            }
        } else {
            for (StaticData staticData: program.staticData) {
                stringBuilder.append(getSDName(staticData) + ":" + staticData.bytes + "bytes");
                if (staticData.init != null) {
                    stringBuilder.append("init: " + staticData.init);
                    stringBuilder.append("\n");
                }
                stringBuilder.append("\n");
            }
        }
    }

    public String getNasmFuncName(Func func) {
        switch (func.type) {
            case Library:
                return "__" + func.name;
            case UserDefined:
                return "_" + func.name + "_User_Defined_fihriaifhiahidsafans";//in case the name conflict with some libc func
            case External:
                return func.name;
            default:
                return null;
        }
    }

    @Override
    public void visit(Func func) {
        if (showNasm) {
            stringBuilder.append(getNasmFuncName(func) + ":\n");
        } else {
            stringBuilder.append("define " + getNasmFuncName(func) + " (");
            for (VirReg virReg: func.parameters) {
                virReg.accept(this);
                stringBuilder.append(",");
            }
            stringBuilder.append(")\n");
        }
        ArrayList<BB> reversePostOrder = new ArrayList<>(func.reversePostOrder);
        for (int i = 0; i < reversePostOrder.size(); ++i) {
            BB bb = reversePostOrder.get(i);
            try {
                nextbb = reversePostOrder.get(i + 1);
            } catch (Exception e) {
                nextbb = null;
            }

            bb.accept(this);
        }
        if (!showNasm)
            stringBuilder.append("}\n");
    }

    @Override
    public void visit(BB bb) {
        if (bb.head == null)
            return ;
        stringBuilder.append("\t" + getBBName(bb) + (showBlockHint ? "(2" + bb.hint+ ")" : "") + ":\n");
        for (IRInst inst = bb.head; inst != null; inst = inst.next) {
            inst.accept(this);
        }
    }

    @Override
    public void visit(BinInst inst) {
        if (inst.op == BinInst.BinOp.ADD || inst.op == BinInst.BinOp.SUB || inst.op == BinInst.BinOp.SAL || inst.op == BinInst.BinOp.SAR)
            if (inst.src instanceof Imm && ((Imm) inst.src).value == 0) {
                return ;
            }
        if ((inst.op == BinInst.BinOp.MUL)) {
            stringBuilder.append("\timul ");
            inst.src.accept(this);
            stringBuilder.append("\n");
            return ;
        }
        if ((inst.op == BinInst.BinOp.MOD) || (inst.op == BinInst.BinOp.DIV)) {
            stringBuilder.append("\tidiv ");
            inst.src.accept(this);
            stringBuilder.append("\n");
            return ;
        }
        if ((inst.op == BinInst.BinOp.SAL) || (inst.op == BinInst.BinOp.SAR)) {
            stringBuilder.append("\t" + inst.op.toString().toLowerCase() + " ");
            inst.dest.accept(this);
            stringBuilder.append(", cl\n");
            return ;
        }
        stringBuilder.append("\t" + inst.op.toString().toLowerCase() + " ");
        inst.dest.accept(this);
        stringBuilder.append(", ");
        inst.src.accept(this);
        stringBuilder.append("\n");
    }

    @Override
    public void visit(UnaryInst inst) {
        stringBuilder.append("\t" + inst.op.toString().toLowerCase() + " ");
        inst.dest.accept(this);
        stringBuilder.append("\n");
    }

    @Override
    public void visit(Mov inst) {
        if (inst.dest == inst.src)
            return ;
        stringBuilder.append("\tmov ");
//        if (inst.dest == null) {
//            System.out.println("inst in null");
//        }
        inst.dest.accept(this);
        stringBuilder.append(", ");
        inst.src.accept(this);
        stringBuilder.append("\n");
    }

    @Override
    public void visit(Push inst) {
        stringBuilder.append("\tpush ");
        inst.src.accept(this);
        stringBuilder.append("\n");
    }

    @Override
    public void visit(Pop inst) {
        stringBuilder.append("\tpop ");
        inst.dest.accept(this);
        stringBuilder.append("\n");
    }

    @Override
    public void visit(Jump inst) {
        if (inst.targetBB != nextbb) {
            stringBuilder.append("\tjmp " + getBBName(inst.targetBB) + "\n");
        }
//        } else {
//            inst.remove();
//        }
    }

    @Override
    public void visit(Cjump inst) {
        String op = "j" + inst.op.toString().toLowerCase() + " ";
        if (showNasm) {
            stringBuilder.append("\tcmp ");
            inst.src1.accept(this);
            stringBuilder.append(", ");
            inst.src2.accept(this);
            stringBuilder.append("\n\t");
            stringBuilder.append(op + getBBName(inst.thenbb) + "\n");
            if (inst.elsebb != nextbb) {
                stringBuilder.append("\tjmp " + getBBName(inst.elsebb) + "\n");
            }
        } else {
            stringBuilder.append("\t" + op);
            inst.src1.accept(this);
            stringBuilder.append(", ");
            inst.src2.accept(this);
            stringBuilder.append(" then " + getBBName(inst.thenbb) + " else " + getBBName(inst.elsebb) + "\n");
        }
    }

    @Override
    public void visit(Leave inst) {
        stringBuilder.append("\tleave \n");
    }

    @Override
    public void visit(Call inst) {
        stringBuilder.append("\tcall ");
        stringBuilder.append(getNasmFuncName(inst.func) + " ");

        if (!showNasm && inst.dest != null) {
            inst.dest.accept(this);
            stringBuilder.append(" = ");
        }

        if (!showNasm) {
            for (Operand operand: inst.args) {
                stringBuilder.append(", ");
                if (operand == null) {
//                    System.out.println(getNasmFuncName(inst.func) + " ");
                }
                operand.accept(this);
            }
        }
        stringBuilder.append("\n");
    }

    @Override
    public void visit(Ret inst) {
        stringBuilder.append("\tret\n");
    }

    @Override
    public void visit(Cdq inst) {
        stringBuilder.append("\tcdq\n");
    }

    @Override
    public void visit(Lea inst) {
        inLeaInst = true;
        stringBuilder.append("\tlea ");
        inst.dest.accept(this);
        stringBuilder.append(", ");
        inst.src.accept(this);
        stringBuilder.append("\n");
        inLeaInst = false;
    }

    @Override
    public void visit(IRInst inst) {

    }

    @Override
    public void visit(FuncAddr operand) {
        stringBuilder.append(getNasmFuncName(operand.func));
    }

    @Override
    public void visit(VirReg operand) {
        if (operand.allocatedPhyReg != null) {
            operand.allocatedPhyReg.accept(this);
            varName.put(operand, operand.allocatedPhyReg.name);
        } else {
            stringBuilder.append(getVarName(operand));
        }
    }

    @Override
    public void visit(PhyReg operand) {
        stringBuilder.append(operand.name);
    }

    @Override
    public void visit(Imm operand) {
        stringBuilder.append(operand.value);
    }

    @Override
    public void visit(Memory operand) {
        boolean occur = false;
        if (!inLeaInst) {
            stringBuilder.append("qword ");
        }

        stringBuilder.append("[");
        if (operand.base != null) {
            operand.base.accept(this);
            occur = true;
        }
        if (operand.index != null) {
            if (occur)
                stringBuilder.append(" + ");
            operand.index.accept(this);
            if (operand.scale != 1) {
                stringBuilder.append(" * ");
                stringBuilder.append(operand.scale);
            }
            occur = true;
        }
        if (operand.constant != null) {
            Constant constant = operand.constant;
            if (constant instanceof  StaticData) {
                if (occur)
                    stringBuilder.append(" + ");
                constant.accept(this);
            } else if (constant instanceof  Imm) {
                int val = ((Imm) constant).value;
                if (occur && val >= 0)
                    stringBuilder.append(" + ");
                stringBuilder.append(val);
            }
        }

        stringBuilder.append("]");
    }

    @Override
    public void visit(StackSlot operand) {
        if (operand.base != null || operand.index != null || operand.constant != null) {
            visit((Memory)operand);
        } else {
            stringBuilder.append(getSSName(operand));
        }
    }

    @Override
    public void visit(StaticData operand) {
        stringBuilder.append(getSDName(operand));
    }

    @Override
    public void visit(Constant operand) {

    }
}
