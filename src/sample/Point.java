package sample;

/**
 * @author Michał Kamiński
 */
public class Point {

    float x;
    float y;

    public Point(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public static float Remap(float value, float from1, float to1, float from2, float to2)
    {
        return (value - from1) / (to1 - from1) * (to2 - from2) + from2;
    }
}
