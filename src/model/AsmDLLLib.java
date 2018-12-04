package model;

/**
 * @author Michał Kamiński
 */
public class AsmDLLLib {

    static{
        try {
            System.load("E:/projekty java/fernc/AssemblerDLL_VISUAL_STUDIO/x64/Debug/AssemblerDllLibrary.dll");
        } catch (UnsatisfiedLinkError e) {
            System.err.println("Native code library failed to load.\n" + e);
            System.exit(1);
        }
    }
    public static native void BarnsleyFernAlgorithm(float[] points, int pointsCount,
                                                    float e1, float e2, float e3, float e4,
                                                    float f1, float f2, float f3, float f4);
}
