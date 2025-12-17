import java.awt.*;
import java.util.HashMap;
import javax.swing.*;
import java.io.*;
import java.awt.event.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Random;

public class Login extends JPanel{
    JLabel greetingLabel = new JLabel("Login or Register");
    JButton logButton = new JButton("Login");
    JButton regButton = new JButton ("Register");
    
    private HashMap <String, String> userInfo = new HashMap<> ();
    private String currentUser;
    private JFrame mainFrame;
    
    private PrintWriter writer;
    
    String user;
    String pass;

    private JPasswordField passField = new JPasswordField(10);
    
    //catches the error and makes printWriter

    public Login(JFrame frame) {
        this.mainFrame = frame;
        
        try (BufferedReader reader = new BufferedReader(new FileReader("UserInfo.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 2) {
                    userInfo.put(parts[0], parts[1]);
                }
            }
        } catch (IOException e) {
            System.out.println("No existing user file found. Starting fresh.");
        }
        this.setPreferredSize(new Dimension(500, 700));
        this.setLayout(new FlowLayout());

      	//Your code goes below
        add(greetingLabel);
        add(logButton);
        add(regButton);
        
        //make register button
        regButton.addActionListener( e -> {
            registerUser();
        });
        
        logButton.addActionListener( e -> {
            loginUser();
        });
      	
    } 
    
    private void registerUser(){
        //First, get user info
       String user = JOptionPane.showInputDialog("Enter your name:");
                //ensure that the name is NOT empty:
            if (user != null && !user.trim().isEmpty()) {
            } else {
                //print the following message if the name is empty
                JOptionPane.showMessageDialog(null, "Name cannot be empty.");
            }
            String pass = JOptionPane.showInputDialog("Enter your password:");
                //ensure that the name is NOT empty:
            if (pass != null && !pass.trim().isEmpty()) {
                saveUser(user, pass);
                JOptionPane.showMessageDialog(null, "Hello, " + user + "!");
            } else {
                //print the following message if the name is empty
                JOptionPane.showMessageDialog(null, "Pass cannot be empty.");
            }
     }
     
     private void loginUser (){ //FIX formant showInputDialog not showing up for password
        String user = JOptionPane.showInputDialog("Username:");
        //String pass = new String(passField.getPassword());
        JPasswordField pf = new JPasswordField();
        int okCxl = JOptionPane.showConfirmDialog(null, pf, "Password" + user, JOptionPane.OK_CANCEL_OPTION, JOptionPane.PLAIN_MESSAGE);
        String pass = new String(pf.getPassword());
        
        if (userInfo.containsKey(user) && userInfo.get(user).equals(pass)) {
            this.currentUser = user;
            JOptionPane.showMessageDialog(this, "Login Successful! ");
            launchGame();
        } else {
            JOptionPane.showMessageDialog(this, "Error");
        }
    }
     
    private void launchGame() { // launchs game and resets GUI

        mainFrame.getContentPane().removeAll();
        
        DodgeGame game = new DodgeGame(this); 
        
        JPanel buttons = game.getButtonPanel();
        
        mainFrame.setLayout(new BorderLayout());
        mainFrame.add(game, BorderLayout.CENTER);
        mainFrame.add(buttons, BorderLayout.SOUTH); 
    
        mainFrame.pack();
        game.requestFocusInWindow();
        mainFrame.revalidate();
    } 
    // FIXED: score was not saving into UserInfo. 
    public void recordFinalScore(int score) { // puts score into txt file 
        try (PrintWriter writer = new PrintWriter(new FileWriter("UserInfo.txt", true))) {
            writer.println(currentUser + ",SCORE," + score);
            JOptionPane.showMessageDialog(null,
                "Score of " + score + " saved for " + currentUser);
        } catch (IOException e) {
            System.out.println("Error writing score: " + e.getMessage());
        }
    }

           /* String line;
            while (writer !=null) {
                String[] parts = line.split(",");
                // If this is the current player, update their score line
                if (parts[0].equals(currentUser)) {
                    writer.println(parts[0] + "," + parts[1] + "," + score);
                } else {
                    writer.println(line);
                }
            }
            writer.close();
            
            JOptionPane.showMessageDialog(null, "Score of " + score + " saved for " + currentUser);
            */

     
     public void saveUser (String user, String pass){ // will put userinfo into Userinfo.txt
        userInfo.put (user, pass);
        try (PrintWriter writer = new PrintWriter(new FileWriter("UserInfo.txt", true))){
            writer.println (user + "," + pass);
            writer.flush();
        //add(new JLabel("Welcome User"));
        //JLabel status = new JLabel("Login successful");
        } catch (IOException e){
            System.out.println("Error writing to file: " + e.getMessage());
        }
    }
    

    public static void main(String[] args) {
        JFrame frame = new JFrame("Dodge Game Launcher");
        Login loginPanel = new Login(frame);
        
        /*DodgeGame gamePanel = new DodgeGame(loginPanel);

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
        */
        
        frame.setContentPane(loginPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}
