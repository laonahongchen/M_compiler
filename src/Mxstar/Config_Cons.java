package Mxstar;

import java.io.FileInputStream;
import java.io.PrintStream;

public class Config_Cons{
    public static int REGISTER_WIDTH = 8;
    public enum ALLOCATOR {
        NAIVE_ALLOCATOR, GRAPH_ALLOCATOR
    }
    public static ALLOCATOR allocator = ALLOCATOR.GRAPH_ALLOCATOR;

    public static FileInputStream fin;
    public static PrintStream fout;
    public static boolean PrintIRAfterBuild = false;
    public static boolean PrintIRAfterCorrector = false;
    public static boolean PrintIRAfterAllocator = false;
    public static boolean PrintIRAfterAll = false;
}
