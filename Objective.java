// Objective.java
import java.awt.Rectangle;
import java.awt.Color;

public class Objective implements ObjectInterface {
    
    private final int OBJECT_SIZE = 25; // Slightly larger to differentiate
    private final int objectGrav = 4; // Slightly slower
    private int objectX;
    private int objectY;
    
    public Objective(int startX) {
        this.objectX = startX;
        this.objectY = 0; // Starts at the top
    }

   @Override
    public int getObjectX() {
        return objectX;
    }
    
    @Override 
    public int getObjectY(){
        return objectY;
    }

    @Override 
    public int get_OBJECT_SIZE (){
        return OBJECT_SIZE;
    }
    @Override 
    public int getObjectGrav (){
        return objectGrav;
    }
    
    @Override
    public Color getColor() {
        return Color.BLUE; 
    }
    
    @Override
    public Rectangle getBounds() {
        return new Rectangle(objectX, objectY, OBJECT_SIZE, OBJECT_SIZE);
    }
    @Override
    public int getScoreValue() {
        return 5; // Score for dodging successfully
    }
    @Override
    public void updatePosition() {
        this.objectY += objectGrav;
    }
}
