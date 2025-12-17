import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Random;

public class DodgeGame extends JPanel implements ActionListener {

    // Game constants
    private final int PANEL_WIDTH = 500;
    private final int PANEL_HEIGHT = 700;
    private final int PLAYER_WIDTH = 60;
    private final int PLAYER_HEIGHT = 20;
    private final int OBJECT_SIZE = 20;


    private int playerX = PANEL_WIDTH / 2 - PLAYER_WIDTH / 2;
    private int playerY = PANEL_HEIGHT - 80;
    private int playerSpeed = 10;

    public boolean moveLeft = false;
    public boolean moveRight = false;

    private ArrayList<ObjectInterface> fallingObjects = new ArrayList<>();
    private Random random = new Random();
    private Timer gameTimer;
    private Timer spawnTimer;
    private int score =0;
    private boolean gameOver = false;
    
    private boolean objectiveMissed = false; 
    
    private Login loginScreen;
    
    // BUTTON PANEL (for mobile-style control)
    private  JPanel buttonPanel = new JPanel();
    private  JButton leftBtn = new JButton("◀ Left");
    private  JButton rightBtn = new JButton("Right ▶");
    private  JButton retryBtn = new JButton ("Retry?");
    


    public DodgeGame(Login loginScreen) {
        
        this.loginScreen= loginScreen;

        setPreferredSize(new Dimension(PANEL_WIDTH, PANEL_HEIGHT));
        setBackground(Color.BLACK);

        // Mouse movement control
        addMouseMotionListener(new MouseMotionAdapter() {
            public void mouseMoved(MouseEvent e) {
                playerX = e.getX() - PLAYER_WIDTH / 2;
            }
        });

        // Keyboard control
        setFocusable(true);
        addKeyListener(new KeyAdapter() {
            public void keyPressed(KeyEvent e) {
                if (e.getKeyCode() == KeyEvent.VK_LEFT) moveLeft = true;
                if (e.getKeyCode() == KeyEvent.VK_RIGHT) moveRight = true;
            }

            public void keyReleased(KeyEvent e) {
                if (e.getKeyCode() == KeyEvent.VK_LEFT) moveLeft = false;
                if (e.getKeyCode() == KeyEvent.VK_RIGHT) moveRight = false;
            }
        });

        // Main game loop (60 FPS)
        startGame();

    }
    
    private void startGame(){
        gameTimer = new Timer (16,this);
        gameTimer.start();
        
        spawnTimer = new  Timer(800, e -> {
            if (random.nextDouble ()<0.8){
                spawnObject (true);
            } else {
                spawnObject (false);
            }
        });
        spawnTimer.start();
    }

    private void spawnObject(boolean nextSpawnEne) {
        int x = random.nextInt(PANEL_WIDTH - OBJECT_SIZE);
        if (nextSpawnEne){
            fallingObjects.add (new Enemy (x));
        }else {
            fallingObjects.add(new Objective (x));
        }
    }
    // Bug fixed was modifying the wrong JPanel instance
    public void resetGame(){ //resets score, timers, buttons
        gameOver=false;
        objectiveMissed = false;
        score=0;
        fallingObjects.clear();
        playerX= PANEL_WIDTH/2 - PLAYER_WIDTH / 2 ;
        
        gameTimer.start();
        spawnTimer.start();
        
        buttonPanel.remove(retryBtn);
        buttonPanel.add(leftBtn, 0);
        buttonPanel.add(rightBtn, 1);
        buttonPanel.revalidate();
        buttonPanel.repaint();
    }

    @Override
    public void actionPerformed(ActionEvent e) {

        if (gameOver) return;

        // Move player via buttons
        if (moveLeft) playerX -= playerSpeed;
        if (moveRight) playerX += playerSpeed;

        // Limit player movement
        playerX = Math.max(0, Math.min(playerX, PANEL_WIDTH - PLAYER_WIDTH));

        Rectangle playerRect = new Rectangle(playerX, playerY, PLAYER_WIDTH, PLAYER_HEIGHT);
        
        // Move falling objects
        Iterator<ObjectInterface> it = fallingObjects.iterator();
        while (it.hasNext()) {
            ObjectInterface obj = it.next();
            obj.updatePosition();

            // Collision detection
            //i wanted to follow chatGPTs logic for consistency (That is why i used the intersects() menthod
            //the following commont is what i would have done for collision detection
            //obj.x >playerX && obj.x<playerX+PLAYER_WIDTH && obj.y >playerY && obj.y<playerY+PLAYER_HEIGHT
            if (obj.getBounds().intersects(playerRect)) {
                it.remove();
                if(obj instanceof Enemy) {
                    endGame();
                    return;
                }else if (obj instanceof Objective){
                    score +=obj.getScoreValue ();
                }
            }
            
            else if (obj.getBounds().y> PANEL_HEIGHT){
                if (obj instanceof Objective){
                    endGame();
                    return;
                }
                it.remove();
                score +=obj.getScoreValue();
            }
        }

        repaint();
    }
    
    private void endGame (){ //triggers all end changes 
        gameOver=true;
        gameTimer.stop();
        spawnTimer.stop();
        
        loginScreen.recordFinalScore(score);
        
        buttonPanel.removeAll();
        buttonPanel.add(retryBtn);
        buttonPanel.revalidate(); 
        buttonPanel.repaint();
        
        repaint();
    }

    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);

        // Draw player
        g.setColor(Color.GREEN);
        g.fillRect(playerX, playerY, PLAYER_WIDTH, PLAYER_HEIGHT);

        // Draw falling objects
        for (ObjectInterface obj : fallingObjects){
        g.setColor(obj.getColor());
        Rectangle bound = obj.getBounds ();
        g.fillRect(bound.x, bound.y, bound.width, bound.height);
        }

        // Draw score
        g.setColor(Color.WHITE);
        g.setFont(new Font("Arial", Font.BOLD, 20));
        g.drawString("Score: " + score, 20, 30);

        // Game Over message
        if (gameOver) {
            g.setColor(Color.YELLOW);
            g.setFont(new Font("Arial", Font.BOLD, 40));
            g.drawString("GAME OVER", 120, PANEL_HEIGHT / 2);
        }
    }
    
    public JPanel getButtonPanel() {
        buttonPanel.removeAll();

        leftBtn.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) { moveLeft = true; }
            public void mouseReleased(MouseEvent e) { moveLeft = false; }
        });

        rightBtn.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) { moveRight = true; }
            public void mouseReleased(MouseEvent e) { moveRight = false; }
        });

        retryBtn.addActionListener(e -> resetGame());

        buttonPanel.add(leftBtn);
        buttonPanel.add(rightBtn);

        return buttonPanel;
    }


    // Create window with buttons
    public static void main(String[] args) {
        JFrame frame = new JFrame("Dodge the Falling Objects");
        Login log = new Login(frame);
        
        /*
        DodgeGame gamePanel = new DodgeGame(log);

        leftBtn.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) { gamePanel.moveLeft = true; }
            public void mouseReleased(MouseEvent e) { gamePanel.moveLeft = false; }
        });

        rightBtn.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) { gamePanel.moveRight = true; }
            public void mouseReleased(MouseEvent e) { gamePanel.moveRight = false; }
        });
            
        retryBtn.addActionListener(e -> {
            gamePanel.resetGame();
        });

        buttonPanel.add(leftBtn);
        buttonPanel.add(rightBtn);
            
        frame.setLayout(new BorderLayout());
        frame.add(gamePanel, BorderLayout.CENTER);
        frame.add(buttonPanel, BorderLayout.SOUTH);
        */

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
        
        
    }
}
