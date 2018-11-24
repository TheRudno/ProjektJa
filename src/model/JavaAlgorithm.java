package model;

import java.util.concurrent.ThreadLocalRandom;

/**
 * @author Michał Kamiński
 */
public class JavaAlgorithm {

    public static float[] BarnsleyFernAlgorithm(float[] points, int pointsCount, float startX, float startY,
                                             float e1, float e2, float e3, float e4,
                                             float f1, float f2, float f3, float f4){
        int p;
        for (int i = 0; i < pointsCount; i=i+2)
        {
            p = ThreadLocalRandom.current().nextInt(0, 100 + 1);
            if (p <= 2) {
                startX = 0 + e1;
                startY = 0.16f * startY + f1;
            }
            else if (p <= 86) {
                startX = 0.85f * startX + 0.04f * startY + e2;
                startY = -0.04f * startX + 0.85f * startY + 1.6f + f2;
            }
            else if (p <= 93) {
                startX = 0.2f * startX - 0.26f * startY + e3;
                startY = 0.23f * startX + 0.22f * startY + 1.6f + f3;
            }
            else {
                startX = -0.15f * startX + 0.28f * startY + e4;
                startY = 0.26f * startX + 0.24f * startY + 0.44f + f4;
            }
            points[i] = startX;
            points[i + 1] = startY;
        }
        return points;
    }

}
