import java.awt.Rectangle;
import java.awt.Color;
public interface ObjectInterface{

    int getObjectX ();
    int getObjectY();
    
    int get_OBJECT_SIZE ();
    int getObjectGrav ();
    Color getColor ();
    public Rectangle getBounds() ;
    public int getScoreValue() ;
    public void updatePosition() ;
}
