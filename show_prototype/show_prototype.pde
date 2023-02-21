/*
* Prototype of game
*/

// Variables
color backgroundColor = color(188, 220, 255);

int totalNotifications = 20;
int notificationCounter = 0;

float seconds = 0;
float startingRate = 70;
float minRate = 50.;
float maxRate = 100.;
float rateMultiplier = 5;
float rate;

float timer;
String timerText;

NotificationFactory notificationFactory;
ArrayList<Notification> notifications;

void setup() {
  size(600, 500);   
  noStroke();

  notifications = new ArrayList<Notification>();
  notificationFactory = new NotificationFactory();
  
  // setup notifications
  for(int i=0; i < totalNotifications; i++) {
    Notification newNotification = notificationFactory.createNotification();
    notifications.add(newNotification);
  }
}

void draw() {
  
  // check if game is over
  if(gameOver())
  {
    textSize(20);
    text("Game over!", 200, 200);
    noLoop(); // break out of the draw loop 
  }
  
  // set up background + existing notifications
  background(backgroundColor);
  
  displayTimer();

  // draw existing notifications
  for(Notification notification : notifications) 
  {
    if(notification.getActive()) {
      notification.drawNotification();
    }
  }
  
  // draw new ones!
  
  // this needs work lol
  seconds = int((millis() * frameRate) / 1000);
  int denominator = getNumActive() + 1;
  rate = constrain(int((startingRate / denominator) * rateMultiplier), minRate, maxRate);  
  if(seconds % rate == 0) {   
    notifications.get(notificationCounter).drawNotification();
    notificationCounter++;
  }
 
   // reset if counter goes above maximum 
   if(notificationCounter == notifications.size()) {
     notificationCounter = 0; 
   }

}

void mousePressed() {
    
  for(Notification notification : notifications) 
  {
    if(notification.checkIfClicked()) 
    {
      notification.onClick();
    }
  }
}

int getNumActive() 
{
  // there's a better way to do this but I can't think of it atm
  int numActive = 0;
  for(Notification notification : notifications) 
  {
    numActive = notification.getActive() ? numActive + 1 : numActive;
  }
  
  return numActive;
}

boolean gameOver() 
{
  return getNumActive() == notifications.size();
}

void displayTimer()
{
  // timer 
  int seconds = (millis() / 1000) % 60;
  int minutes = (millis() / 1000) / 60;
  String secondsFormat = (seconds < 10) ? "0" + seconds : str(seconds);
  timerText = "Timer: " + minutes + ":" + secondsFormat;
  
  textSize(20);
  textAlign(CENTER, BOTTOM);
  text(timerText, width * 0.1, height * 0.05);

}
