package model;

import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

/**
 * @author Michał Kamiński
 */
public class JavaAlgorithm {

    public static float[] BarnsleyFernAlgorithm(float[] points, int pointsCount, float startX, float startY,
                                             float e1, float e2, float e3, float e4,
                                             float f1, float f2, float f3, float f4){
        int p;
        float x,y;
        for (int i = 0; i < pointsCount; i=i+2)
        {
            x = startX;
            y = startY;
            p = ThreadLocalRandom.current().nextInt(0, 100 + 1);
            if (p <= 2) {
                startX = 0 + e1;
                startY = 0.16f * y + f1;
            }
            else if (p <= 86) {
                startX = 0.85f * x + 0.04f * y + e2;
                startY = -0.04f * x + 0.85f * y + f2;
            }
            else if (p <= 93) {
                startX = 0.2f * x - 0.26f * y + e3;
                startY = 0.23f * x + 0.22f * y + f3;
            }
            else {
                startX = -0.15f * x + 0.28f * y + e4;
                startY = 0.26f * x + 0.24f * y + f4;
            }

            points[i] = startX;
            points[i + 1] = startY;
        }
        return points;
    }

}
