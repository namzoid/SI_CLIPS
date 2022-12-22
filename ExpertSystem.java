import javax.swing.*;
import java.awt.*;
import java.text.BreakIterator;
import java.util.Locale;
import java.util.ResourceBundle;
import CLIPSJNI.*;
import java.awt.LayoutManager;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ExpertSystem extends JFrame {
	
	private static final long serialVersionUID = 1L;
	
	private Environment clips;
	private boolean isExecuting = false;
	private Thread executionThread;

	private JLabel displayLabel;
	private JButton nextButton;
	private JButton prevButton;
	private JButton restartButton;
	private JPanel choicesPanel;
	private ButtonGroup choicesButtons;
	private ResourceBundle resources;
	

   ExpertSystem() {
      resources = ResourceBundle.getBundle("resources.config",Locale.getDefault());

      // Create the main frame for the program
      JFrame frame = new JFrame(); 
      
      // Add an icon for the program
      ImageIcon icon = new ImageIcon("image.png");
      frame.setIconImage(icon.getImage());
      
      frame.setTitle("What should I eat?");
      
      frame.setSize(500, 350);
      frame.setResizable(false);
      
      LayoutManager layout = new GridLayout(3, 2);
      frame.setLayout(layout); 
      frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

      // Create the display panel and add the display label
      JPanel showPanel = new JPanel();
      
      displayLabel = new JLabel();
      displayLabel.setBorder(BorderFactory.createMatteBorder(1, 1, 1, 1, new Color(230, 126, 109)));
      displayLabel.setVerticalAlignment(JLabel.CENTER);
      
      // Set the properties for the display label
      displayLabel.setForeground(Color.BLACK);
      displayLabel.setFont(new Font("Roboto", Font.PLAIN, 15));
      
      showPanel.add(displayLabel);
    
      
      // Create the choices panel
      choicesPanel = new JPanel();
      choicesButtons = new ButtonGroup();
      
      // Create the button panel
      JPanel buttonsPanel = generateButtonsPanel();


      // Add the panels to the main frame
      frame.getContentPane().add(showPanel, BorderLayout.CENTER);
      frame.getContentPane().add(choicesPanel);
      frame.getContentPane().add(buttonsPanel);


      // Load the program and start running it
      load();
      run();

      
      // Make the frame visible
      frame.setVisible(true);
   }
   
   
   
    // Load CLIPS file
	private void load() {
  	  clips = new Environment();
  	  clips.load("clp.clp");
  	  clips.reset();
  	}
	
	

   public void run() {
	   isExecuting = true;

	   // Create a thread to run the program
	   executionThread = new Thread(() -> {
	     clips.run();

	     // Update the UI state when the program finishes running
	     SwingUtilities.invokeLater(() -> {
	       try {
	         nextUIState();
	       } catch (Exception e) {
	         e.printStackTrace();
	       }
	     });
	   });

	   executionThread.start();
	 }

   
 
 private void onActionPerformed(ActionEvent actEvent) throws Exception {
	   if (isExecuting) { return; }

	   String str = "(find-all-facts ((?f state-list)) TRUE)";
	   String currentID = clips.eval(str).get(0).getFactSlot("current").toString();
	   
	   // Handle the button click event
	   handleButtons(actEvent, currentID);
	 }
 
 
 
   private void nextUIState() throws Exception {
	   
	   String str = "(find-all-facts ((?f state-list)) TRUE)";
	   String currentID = clips.eval(str).get(0).getFactSlot("current").toString();
	   str = "(find-all-facts ((?f UI-state)) " + "(eq ?f:id " + currentID + "))";
	   PrimitiveValue fValue = clips.eval(str).get(0);

	   // Determine the visibility of the buttons
	   whatButton(fValue);

	   // Clear the current choices
	   choicesPanel.removeAll();
	   choicesButtons = new ButtonGroup();

	   // Display the buttons for the valid answers
	   PrimitiveValue acceptableAnswers = findFactSlot(fValue, "acceptable-answers");
	   String selected = findFactSlot(fValue, "response").toString();
	   showButtons(acceptableAnswers, selected);

	   
	   showText(fValue);

	   // Stop executing the program
       executionThread = null;
       isExecuting = false;
   }



   private void handleButtons(ActionEvent actEvent, String currentID) throws Exception {
	   // Check the action command of the button that was clicked
	   switch (actEvent.getActionCommand()) {
	     case "Next":
	       // Assert a next command with or without a selected answer
	       if (choicesButtons.getButtonCount() == 0) {
	         clips.assertString("(next " + currentID + ")");
	       } else {
	         clips.assertString("(next " + currentID + " " + choicesButtons.getSelection().getActionCommand() + ")");
	       }
	       run();
	       break;
	     case "Restart":
	       clips.reset();
	       run();
	       break;
	     case "Prev":
	       clips.assertString("(prev " + currentID + ")");
	       run();
	       break;
	   }
	 }



     private JPanel generateButtonsPanel() {
    	  JPanel buttonsPanel = new JPanel();

    	  // Set the background and text colors of the buttons
    	  
    	  // PREV button
    	  prevButton = new JButton(resources.getString("Prev"));
    	  prevButton.setActionCommand("Prev");
    	  prevButton.setBackground(Color.LIGHT_GRAY);
    	  prevButton.setForeground(Color.BLACK);
    	  buttonsPanel.add(prevButton);
    	  prevButton.addActionListener(new ActionListener() {
    		  @Override
    		  public void actionPerformed(ActionEvent actEvent) {
  		     try {
  		       onActionPerformed(actEvent);
  		     }
  		     catch (Exception exc) {
  		       exc.printStackTrace();
  		     }
  		   }
          });
    	  
    	 
    	  // NEXT button
    	  nextButton = new JButton(resources.getString("Next"));
    	  nextButton.setActionCommand("Next");
    	  nextButton.setBackground(Color.LIGHT_GRAY);
    	  nextButton.setForeground(Color.BLACK);
    	  buttonsPanel.add(nextButton);
    	  nextButton.addActionListener(new ActionListener() {
    		  @Override
    		  public void actionPerformed(ActionEvent actEvent) {
  		     try {
  		       onActionPerformed(actEvent);
  		     }
  		     catch (Exception exc) {
  		       exc.printStackTrace();
  		     }
  		   }
          });
    	  

    	  // RESTART button
    	  restartButton = new JButton(resources.getString("Restart"));
    	  restartButton.setActionCommand("Restart");
    	  restartButton.setBackground(Color.LIGHT_GRAY);
    	  restartButton.setForeground(Color.BLACK);
    	  buttonsPanel.add(restartButton);
    	  
    	  restartButton.addActionListener(new ActionListener() {
    		  @Override
    		  public void actionPerformed(ActionEvent actEvent) {
  		     try {
  		       onActionPerformed(actEvent);
  		     }
  		     catch (Exception exc) {
  		       exc.printStackTrace();
  		     }
  		   }
          });
    	  

    	  return buttonsPanel;
    	}


   
     private void whatButton(PrimitiveValue fValue) throws Exception {
    	  // Check the state of the program
    	 
    	  if (fValue.getFactSlot("state").toString().equals("initial")) {
      	    // Show the Next button    	    
      	    nextButton.setVisible(true);
      	    prevButton.setVisible(false);
      	    restartButton.setVisible(false);  
    	    
    	  } else if (fValue.getFactSlot("state").toString().equals("final")) {
      	    // Show the Previous and Restart buttons
      	    prevButton.setVisible(true);
      	    restartButton.setVisible(true);
      	    nextButton.setVisible(false);
	    
    	  } else {
    	    // Show the Previous and Next buttons  
    	    nextButton.setVisible(true);
    	    prevButton.setVisible(true);
    	    restartButton.setVisible(false);
    	  }
    	}




     private PrimitiveValue findFactSlot(PrimitiveValue fValue, String name) throws Exception {
       PrimitiveValue pValue = fValue.getFactSlot(name);
       return pValue;
     }

     
     private void showButtons(PrimitiveValue pValue, String selected) throws Exception {
    	    for (int i = 0; i < pValue.size(); i++) {
    	        PrimitiveValue bValue = pValue.get(i);
    	        
    	        boolean isSelected = bValue.toString().equals(selected);
    	        JRadioButton radioButton = new JRadioButton(resources.getString(bValue.toString()), isSelected);
    	        
    	        radioButton.setActionCommand(bValue.toString());
    	        //radioButton.setBackground(new Color(206, 238, 197));
    	        choicesPanel.add(radioButton);
    	        choicesButtons.add(radioButton);
    	    }
    	    choicesPanel.repaint();
    	}



     private void showText(PrimitiveValue fValue) throws Exception {
       String text = resources.getString(findFactSlot(fValue, "show").symbolValue());
       wrapDisplayText(displayLabel, text);
       
     }
     
     private void wrapDisplayText(JLabel label, String text) {
  	   // Get the font metrics and container width
  	   FontMetrics font = label.getFontMetrics(label.getFont());
  	   Container container = label.getParent();
  	   int containerWidth = container.getWidth();
  	   int textWidth = SwingUtilities.computeStringWidth(font, text);

  	   // Calculate the desired width for the wrapped text
  	   int widthGoal;
  	   if (textWidth <= containerWidth) { widthGoal = containerWidth; } 
  	   else {
  	     int lines = (int) ((textWidth + containerWidth) / containerWidth);
  	     widthGoal = (int) (textWidth / lines);
  	   }

  	   // Initialize variables to store the wrapped text
  	   StringBuffer trial = new StringBuffer();
  	   StringBuffer real = new StringBuffer("<html><center>");

  	   // Iterate through the words in the text
  	   BreakIterator boundary = BreakIterator.getWordInstance();
  	   boundary.setText(text);
  	   int start = boundary.first();
  	   for (int end = boundary.next(); end != BreakIterator.DONE; start = end, end = boundary.next()) {
  	     String word = text.substring(start, end);
  	     trial.append(word);
  	     int trialWidth = SwingUtilities.computeStringWidth(font, trial.toString());

  	     // Check if the current line is too long or if the desired width has been exceeded
  	     if (trialWidth > containerWidth || trialWidth > widthGoal) {
  	       // Reset the trial buffer and add a line break to the real buffer
  	       trial = new StringBuffer(word);
  	       real.append("<br>");
  	       real.append(word);
  	     } else {
  	       // Add the word to the real buffer
  	       real.append(word);
  	     }
  	   }

  	   // Close the HTML tags in the real buffer and set the label text
  	   real.append("</html>");
  	   label.setText(real.toString());
  	 }
     
     
     // Run the GUI
     public static void main(String args[]) {
         SwingUtilities.invokeLater(ExpertSystem::new);
      }

}