class NotificationFactory {
  
  NotificationFactory() {}
  
  Notification createNotification() {
    
    float rand1 = random(1); 
    float rand2 = random(1); 
    float wid = constrain(rand1 * 80., 90., 100.);
    float len = constrain(rand2 * 70., 60., 70.);
    float xpos = constrain(rand1 * width, 0, width-(2*wid));
    float ypos = constrain(rand2 * height, 0, height-(2*len));
    Notification notification = new Notification(xpos, ypos, wid, len);
    
    return notification;
  }
  
}
