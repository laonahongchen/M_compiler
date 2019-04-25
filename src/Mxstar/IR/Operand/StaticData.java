package Mxstar.IR.Operand;


import Mxstar.Config_Cons;
import Mxstar.IR.IIRVisitor;

public class StaticData extends Constant {
    public String hint;
    public int bytes;
    public String init;

    public StaticData(String hint, int bytes) {
        this.hint = hint;
        this.bytes = bytes;
        this.init = null;
    }
    public StaticData(String hint, String init) {
        this.hint = hint;
        this.init = init;
        this.bytes = init.length() + 1 + Config_Cons.REGISTER_WIDTH;
    }

    @Override
    public void accept(IIRVisitor visitor) {
        visitor.visit(this);
    }
}
