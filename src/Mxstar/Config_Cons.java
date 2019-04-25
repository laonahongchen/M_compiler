package Mxstar;

import java.io.FileInputStream;
import java.io.PrintStream;

public class Config_Cons{
    public static int REGISTER_WIDTH = 8;
    public enum ALLOCATOR {
        NAIVE_ALLOCATOR, SIMPLE_GRAPH_ALLOCATOR
    }
    public static ALLOCATOR allocator = ALLOCATOR.NAIVE_ALLOCATOR;

    public static FileInputStream fin;
    public static PrintStream fout;

}
