import codeanticode.gsvideo.*;

GSCapture cam;
GSMovieMaker mm;
int fps = 20;

boolean record = false;
int counter = 0;
String moviename;

void setup() {
  size(640, 480, JAVA2D);
  frameRate(fps);
  cam = new GSCapture(this, 640, 480); 

  /*
  Note about camera selection in Mac: 
   List functionality ( GSCapture.list[]; , etc.) still not working.
   
   But it is possible to select the camera, althouth it is a little
   tricky right now. Under 32 bits, GSVideo uses a capture plugin (osxvideosrc)
   that accepts a camera specification as a sequence grabber input device in 
   format "sgname:input#". For example:
   
   cam = new GSCapture(this, 640, 480, "USB Video Class Video:0");  
   
   Under 64 bits, GSVideo uses a different capture plugin (qtkitvideoserc)
   which only accepts a device index for the time being:
   
   cam = new GSCapture(this, 640, 480, "0");
   cam = new GSCapture(this, 640, 480, "1");  
   etc.
   
   Note that the index must be given as a string, to maintain consistency with
   the API.   
   */

  cam.start();  

  /*
  // You can get the resolutions supported by the
   // capture device using the resolutions() method.
   // It must be called after creating the capture 
   // object. */
  int[][] res = cam.resolutions();
  for (int i = 0; i < res.length; i++) {
    println(res[i][0] + "x" + res[i][1]);
  } 


  /*
  // You can also get the framerates supported by the
   // capture device: */
  String[] fps = cam.framerates();
  for (int i = 0; i < fps.length; i++) {
    println(fps[i]);
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    image(cam, 0, 0);
    // The following does the same, and is faster when just drawing the image
    // without any additional resizing, transformations, or tint.
    //set(0, 0, cam);
    //loadPixels();

    // Add window's pixels to movie
    if (record == true) {
      mm.addFrame(cam.pixels);

      println("Number of queued frames : " + mm.getQueuedFrames());
      println("Number of dropped frames: " + mm.getDroppedFrames());
    }
  }
}

void keyPressed() {
  if (key == ' ' && record == false) {
    println("start movie");
    //start moviemaker
    counter++;
    String moviename = new String(counter + ".ogg");

    // Save as THEORA in a OGG file as MEDIUM quality (all quality settings are WORST, LOW,
    // MEDIUM, HIGH and BEST):
    mm = new GSMovieMaker(this, width, height, moviename, GSMovieMaker.THEORA, GSMovieMaker.HIGH, fps);

    mm.setQueueSize(50, 10);

    mm.start();
    // Quit running the sketch once the file is written
    //exit();
    record = true;
  }

  if (key == 'x' && record == true) {
    println("stop movie");
    //finish movie record
    record = false;
    mm.finish();
  }
}

