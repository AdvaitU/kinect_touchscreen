class Notification {
  
  public PImage notification;
  private float xpos;
  private float ypos;
  private float wid;
  private float len;
  private boolean active;
  
  Notification(float xp, float yp, float w, float l) {
    xpos = xp;
    ypos = yp;
    wid = w;
    len = l;
    notification = loadImage("notification.png");
    active = false;
  }
  
  float getXPos() {
    return xpos;
  }
  
  float getYPos() {
    return ypos;
  }
  
  float getWidth() {
    return wid;
  }
  
  float getLength() {
    return len;
  }
  
  boolean getActive() {
    return active;
  }
  
  void drawNotification() {
    image(notification, xpos, ypos, wid, len);
    active = true;
  }
  
  boolean checkIfClicked() 
  {
    // check mouse is in range of the notification
    return (mouseX >= xpos) && (mouseX <= xpos + wid) && (mouseY >= ypos) && (mouseY <= ypos + len);
  }
  
  void onClick() { 
    active = false;
  }
}
