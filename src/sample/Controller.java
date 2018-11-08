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
            if(asmBtn.isSelected()){
                System.out.println("wykonuje asm");
            }else if(cBtn.isSelected()){
                System.out.println("wykonuje c");

            }
            GraphicsContext gc = fernCanvas.getGraphicsContext2D();
            gc.setFill(Color.GREEN);
            gc.setStroke(Color.GREEN);
            Point tmp = new Point(0, 0);
            int iterations = 50000;
            long startTime = System.currentTimeMillis();
            for (int i = 0; i <= iterations; i++) {
                gc.fillArc(tmp.Remap(tmp.x, -5, 5, 0, 630),
                        tmp.Remap(tmp.y, 0, 10, 464, 0),
                        1, 1, 0, 360, ArcType.ROUND);
                tmp = FernAlgorithm(ThreadLocalRandom.current().nextInt(0, 100 + 1), tmp.x, tmp.y);
            }
            long endTime = System.currentTimeMillis();
            asmTimeLabel.setText("Czas wykonania programu w ASM to: " + (endTime-startTime) + " ms");
            cTimeLabel.setText("Czas wykonania programu w C to: " + (endTime-startTime) + " ms");
            generateBtn.setDisable(false);
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



