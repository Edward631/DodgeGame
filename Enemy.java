import java.awt.Rectangle;
import java.awt.Color;
public class Enemy implements ObjectInterface  {

    private final int OBJECT_SIZE = 20;
    private final int objectGrav = 7; // Gravity/speed
    private int objectX;
    private int objectY;
    
    public Enemy(int startX) {
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
        return  OBJECT_SIZE;
    }
    @Override 
    public int getObjectGrav (){
        return objectGrav;
    }
    
    @Override
    public Color getColor (){
        return Color.RED;
    }
    
    @Override
    public Rectangle getBounds() {
        return new Rectangle(objectX, objectY, OBJECT_SIZE, OBJECT_SIZE);
    }
    @Override
    public int getScoreValue() {
        return 1; // Score for dodging successfully
    }
    @Override
    public void updatePosition() {
        this.objectY += objectGrav;
    }
}
