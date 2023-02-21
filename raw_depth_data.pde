import org.openkinect.freenect.*;   // Including OpenKinect Library by Dan Shiffman
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect2 kinect2;   // Making a Kinect Library
PImage img;        // Instantiate PImage object as 'img'

int skip = 4;      // skip variable is used in nested for-loops to skip a certain number of pixels when required to change the resolution of the check

float minThresh = 300;        // Variables for z-axis threshold
float maxThresh = 1500;
int leftEdge = 0;             // Variables for x-axis threshold
int rightEdge = 0;
int topEdge = 0;              // Variables for y-axis threshold
int bottomEdge = 0;


// ----------------------------------------- MAIN SETUP FUNCTION ---------------------------------------------//

void setup() {
  
  size(512,424);   // Setting the size
  kinect2 = new Kinect2(this);  // Connecting object
  
  kinect2.initDepth();      // Start depth feed
  kinect2.initDevice();     // Start device
  
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);   // Create an RGB image equal to the Kinect's depth camera resoltuion
}

// ----------------------------------------- MAIN DRAW LOOP ---------------------------------------------------//

void draw() {
  
  background(0);
  
  img.loadPixels();    // Load up the pixels
  
  int[] depth = kinect2.getRawDepth();   // Array called 'depth' to contain rawDepthValues received from the depth camera
  
  // The pixel grid is x by y pixels with x columns and y rows. The pixel given by (x1,y1) is a (x1 + y1 * width) in the one-dimensional array that saves all pixel values
  
  for (int x = 0; x < kinect2.depthWidth; x++) {      // For all columns
    for (int y = 0; y < kinect2.depthHeight; y++) {    // For all rows
      int offset = x + y * kinect2.depthWidth;         // Save offest using formula (x + y * width) for that pixel
      int d = depth[offset];        // Update the array 'depth[]' with the value of d at index 'offset'
      
      if (d > minThresh && d < maxThresh) {          // If depth is between n and m
        img.pixels[offset] = color(255, 0, 150);     // Colour is purple
      }
      else { // Else, 
        img.pixels[offset] = color(0, 0, 0);   // Colour is black
      }
      
    }
  }
  
  img.updatePixels();         // Update the pixels
  image(img, 0, 0);           // Draw the image at (0,0)
  
}
