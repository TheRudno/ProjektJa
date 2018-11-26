package controller;

import javafx.fxml.FXML;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.control.ToggleButton;
import javafx.scene.layout.BorderPane;
import javafx.scene.paint.Color;
import javafx.scene.shape.ArcType;
import model.CDLLLib;
import model.JavaAlgorithm;
import sample.Point;

import java.util.concurrent.ThreadLocalRandom;


public class Controller {
    @FXML Canvas fernCanvas;
    @FXML Button generateBtn;
    @FXML BorderPane pane;
    @FXML ToggleButton asmBtn;
    @FXML ToggleButton cBtn;
    @FXML ToggleButton javaBtn;
    @FXML Label cTimeLabel;
    @FXML Label asmTimeLabel;
    @FXML Label javaTimeLabel;
    @FXML TextField e1Text;
    @FXML TextField e2Text;
    @FXML TextField e3Text;
    @FXML TextField e4Text;
    @FXML TextField f1Text;
    @FXML TextField f2Text;
    @FXML TextField f3Text;
    @FXML TextField f4Text;
    @FXML TextField pointsText;

    @FXML
    public void initialize() {
        pane.setStyle("-fx-background-color: #d9e5f7;");
        asmBtn.setStyle("-fx-base: lightgreen;");
        cBtn.setStyle("-fx-base: lightblue;");
        javaBtn.setStyle("-fx-base: salmon;");
        asmBtn.setOnAction(event -> onToggle(asmBtn));
        javaBtn.setOnAction(event -> onToggle(javaBtn));
        cBtn.setOnAction(event -> onToggle(cBtn));
        setDefault();
    }

    @FXML
    private void onGenerateClick(){
        generateBtn.setDisable(true);
        int size = (int)getValue(pointsText);
        float points[]= new float[size];
        long startTime = 0 ;
        long endTime = 0;
        if(asmBtn.isSelected()){
            startTime = System.currentTimeMillis();
            System.out.println("wykonuje asm");
            endTime = System.currentTimeMillis();
        }else if(cBtn.isSelected()){
            startTime = System.currentTimeMillis();
            System.out.println("wykonuje c");
            CDLLLib.BarnsleyFernAlgorithm(points,size,0f,0f,getValue(e1Text),getValue(e2Text),getValue(e3Text),getValue(e4Text),getValue(f1Text),getValue(f2Text),getValue(f3Text),getValue(f4Text));
            endTime = System.currentTimeMillis();
        }else if(javaBtn.isSelected()){
            System.out.println("wykonuje java");
            startTime = System.currentTimeMillis();
            points = JavaAlgorithm.BarnsleyFernAlgorithm(points,size,0.f,0.f,getValue(e1Text),getValue(e2Text),getValue(e3Text),getValue(e4Text),getValue(f1Text),getValue(f2Text),getValue(f3Text),getValue(f4Text));
            endTime = System.currentTimeMillis();
        }
        //drawOld();
        draw(points);
        cTimeLabel.setText("");
        javaTimeLabel.setText("");
        asmTimeLabel.setText("Czas wykonania programu to: " + (endTime-startTime) + " ms");
        generateBtn.setDisable(false);
    }

    @FXML
    public void onResetClick(){
        setDefault();
    }

    @FXML
    public void onToggle(ToggleButton button){
        asmBtn.setSelected(false);
        cBtn.setSelected(false);
        javaBtn.setSelected(false);
        button.setSelected(true);
    }

    @FXML
    public void onTestClick(){
        long asmTime = 0,cTime = 0,javaTime = 0;
        int size = 5000000;
        float points[]= new float[size];
        long startTime = 0 ;
        long endTime = 0;
        for (int i = 0; i < 10; i++) {
            startTime = System.currentTimeMillis();
            CDLLLib.BarnsleyFernAlgorithm(points,size,0f,0f,getValue(e1Text),getValue(e2Text),getValue(e3Text),getValue(e4Text),getValue(f1Text),getValue(f2Text),getValue(f3Text),getValue(f4Text));
            endTime = System.currentTimeMillis();
            cTime = cTime + (endTime-startTime);
        }
        for (int i = 0; i < 10; i++) {
            startTime = System.currentTimeMillis();
            JavaAlgorithm.BarnsleyFernAlgorithm(points,size,0f,0f,getValue(e1Text),getValue(e2Text),getValue(e3Text),getValue(e4Text),getValue(f1Text),getValue(f2Text),getValue(f3Text),getValue(f4Text));
            endTime = System.currentTimeMillis();
            javaTime = javaTime + (endTime-startTime);
        }
        for (int i = 0; i < 10; i++) {
            startTime = System.currentTimeMillis();

            endTime = System.currentTimeMillis();
            asmTime = asmTime + (endTime-startTime);
        }

        cTimeLabel.setText("Czas wykonania programu w Cpp to: " + (cTime/10) + "ms");
        asmTimeLabel.setText("Czas wykonania programu w ASM to: " + (asmTime/10) + "ms");
        javaTimeLabel.setText("Czas wykonania programu w JAVA to: " + (javaTime/10) + "ms");

    }

    private void draw(float points[]){
        GraphicsContext gc = fernCanvas.getGraphicsContext2D();
        gc.clearRect(0,0,fernCanvas.getWidth(),fernCanvas.getHeight());
        gc.setFill(Color.GREEN);
        gc.setStroke(Color.GREEN);
        for (int i = 0; i < points.length; i=i+2) {
            gc.fillArc(Point.Remap(points[i], -5, 5, 0, (float)fernCanvas.getWidth()),
                    Point.Remap(points[i+1], 0, 10, (float)fernCanvas.getHeight(), 0),
                    1, 1, 0, 360, ArcType.ROUND);
        }
    }

    private void setDefault(){
        e1Text.setText("0");
        e2Text.setText("0");
        e3Text.setText("0");
        e4Text.setText("0");
        f1Text.setText("0");
        f2Text.setText("1.6");
        f3Text.setText("1.6");
        f4Text.setText("0.44");
        pointsText.setText("50000");
    }

    private float getValue(TextField field){
        try
        {
            return Float.parseFloat(field.getText());
        }
        catch(NumberFormatException nfe)
        {
            field.setText("0");
            return 0;
        }
    }


    @Deprecated
    private void drawOld(){
        GraphicsContext gc = fernCanvas.getGraphicsContext2D();
        gc.clearRect(0,0,fernCanvas.getWidth(),fernCanvas.getHeight());
        gc.setFill(Color.GREEN);
        gc.setStroke(Color.GREEN);
        Point tmp = new Point(0, 0);
        int iterations = 50000;
        float buffor[] = new float[iterations*2];
        for (int i = 0; i <= iterations; i++) {
           gc.fillArc(tmp.Remap(tmp.getX(), -5, 5, 0, (float)fernCanvas.getWidth()),
                    tmp.Remap(tmp.getY(), 0, 10, (float)fernCanvas.getHeight(), 0),
                    1, 1, 0, 360, ArcType.ROUND);
            tmp = FernAlgorithm(ThreadLocalRandom.current().nextInt(0, 100 + 1), tmp.getX(), tmp.getY());
        }
    }

    @Deprecated
    private Point FernAlgorithm(int p, float xn, float yn) {
            float x, y;
            if (p <= 2) {
                x = 0 ;
                y = 0.16f * yn ;
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



