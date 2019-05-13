package Mxstar;

import java.io.FileInputStream;
import java.io.PrintStream;

public class Config_Cons{
    public static int REGISTER_WIDTH = 8;
    public enum ALLOCATOR {
        NAIVE_ALLOCATOR, GRAPH_ALLOCATOR
    }
    public static ALLOCATOR allocator = ALLOCATOR.GRAPH_ALLOCATOR;

    public static boolean PrintIRAfterBuild = false;
    public static boolean PrintIRAfterCorrector = false;
    public static boolean PrintIRAfterAllocator = false;
    public static boolean PrintIRAfterAll = false;


    //all the optimizers which is not those kind of definitely good for the compiler will have a option here
    public static boolean doVNOptimize = true; // may extend the UD-list so may don't have such good result
    public static boolean doGlobalAllocate = false;

    public static boolean doInline = true;
    public static int inlineLimit = 50;
    public static int inlineDepth = 1;
}
