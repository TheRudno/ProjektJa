package sample;

import javafx.fxml.FXML;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ToggleButton;
import javafx.scene.layout.BorderPane;
import javafx.scene.paint.Color;
import javafx.scene.shape.ArcType;
import model.CDLLLib;
import model.JavaAlgorithm;

import java.util.concurrent.ThreadLocalRandom;


public class Controller {
    @FXML
    Canvas fernCanvas;
    @FXML
    Button generateBtn;
    @FXML
    BorderPane pane;
    @FXML
    ToggleButton asmBtn;
    @FXML
    ToggleButton cBtn;
    @FXML
    ToggleButton javaBtn;
    @FXML
    Label cTimeLabel;
    @FXML
    Label asmTimeLabel;

    @FXML
    public void initialize() {
        pane.setStyle("-fx-background-color: #d9e5f7;");

    }

    @FXML
    private void onGenerateClick(){
        generateBtn.setDisable(true);
        int size = 100000;
        float points[]= new float[size];
        long startTime = 0;
        if(asmBtn.isSelected()){
            startTime = System.currentTimeMillis();
            System.out.println("wykonuje asm");
        }else if(cBtn.isSelected()){
            startTime = System.currentTimeMillis();
            System.out.println("wykonuje c");
            CDLLLib cLib = new CDLLLib();
            cLib.BarnsleyFernAlgorithm(points,size,0f,0f,0f,0f,0f,0f,0f,1.6f,1.6f,0.44f);
        }else if(javaBtn.isSelected()){
            System.out.println("wykonuje java");
            startTime = System.currentTimeMillis();
            points = JavaAlgorithm.BarnsleyFernAlgorithm(points,size,0f,0f,0f,0f,0f,0f,0f,1.6f,1.6f,0.44f);
        }
        draw(points);
        drawOld();
        long endTime = System.currentTimeMillis();
        asmTimeLabel.setText("Czas wykonania programu w ASM to: " + (endTime-startTime) + " ms");
        cTimeLabel.setText("Czas wykonania programu w C to: " + (endTime-startTime) + " ms");
        asmBtn.setSelected(false);
        cBtn.setSelected(false);
        javaBtn.setSelected(false);
        generateBtn.setDisable(false);
    }

    private void draw(float points[]){
        GraphicsContext gc = fernCanvas.getGraphicsContext2D();
        gc.clearRect(0,0,fernCanvas.getWidth(),fernCanvas.getHeight());
        gc.setFill(Color.GREEN);
        gc.setStroke(Color.GREEN);
        for (int i = 0; i < points.length; i=i+2) {
            gc.fillArc(Point.Remap(points[i], -5, 5, 0, 630),
                    Point.Remap(points[i+1], 0, 10, 464, 0),
                    1, 1, 0, 360, ArcType.ROUND);
        }
    }

    private void drawOld(){
        GraphicsContext gc = fernCanvas.getGraphicsContext2D();
        gc.setFill(Color.GREEN);
        gc.setStroke(Color.GREEN);
        Point tmp = new Point(0, 0);
        int iterations = 50000;
        for (int i = 0; i <= iterations; i++) {
           gc.fillArc(tmp.Remap(tmp.x, -5, 5, 0, 630),
                    tmp.Remap(tmp.y, 0, 10, 464, 0),
                    1, 1, 0, 360, ArcType.ROUND);
            tmp = FernAlgorithm(ThreadLocalRandom.current().nextInt(0, 100 + 1), tmp.x, tmp.y);
        }
    }

    private Point FernAlgorithm(int p, float xn, float yn) {
            float x, y;
            if (p <= 2) {
                x = 0;
                y = 0.16f * yn;
            } else if (p <= 86) {
                x = 0.85f * xn + 0.04f * yn;
                y = -0.04f * xn + 0.85f * yn + 1.6f;
            } else if (p <= 93) {
                x = 0.2f * xn - 0.26f * yn;
                y = 0.23f * xn + 0.22f * yn + 1.6f;
            } else {
                x = -0.15f * xn + 0.28f * yn;
                y = 0.26f * xn + 0.24f * yn + 0.44f;
            }
            return new Point(x, y);
        }
}



