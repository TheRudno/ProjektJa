package model;
/**
 * @author Michał Kamiński
 */
public class CDLLLib {

    static{
        try {
         System.load("C:/Users/theru/Desktop/ProjektJa/CppDllLib/x64/Release/CDllLib.dll");
         //System.loadLibrary("CDllLib");
        } catch (UnsatisfiedLinkError e) {
            System.err.println("Native code library failed to load.\n" + e);
            System.exit(1);
        }
    }
    public static native void BarnsleyFernAlgorithm(float[] points, int pointsCount, float startX, float startY,
                                                float e1, float e2, float e3, float e4,
                                                float f1, float f2, float f3, float f4);

}
