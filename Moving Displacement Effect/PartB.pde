//Processing 3.5.3
import peasy.*;
import controlP5.*;

PShader displacement;
PFont font;
PeasyCam cam;
ControlP5 control;
PShape icos;
int subd,currentColorMap=0;
float displace;
Slider subdivision,displacementS;
Button uv, earth, moon;
PImage[] displacementMaps = new PImage [3];
PImage[] colorMaps = new PImage[3];

void setup() {
    size(1300,800,P3D);
    cam = new PeasyCam(this, 100);
    cam.setMinimumDistance(300);
    cam.setMaximumDistance(1200);
   
    font = createFont("Arial Bold",48);
    control = new ControlP5(this);
    control.setAutoDraw(false);
    
    displacement = loadShader("fragment.glsl","vertex.glsl");
    colorMaps[0] = loadImage("uvmap.jpg");
    colorMaps[1] = loadImage("globe.jpg");
    colorMaps[2] = loadImage("moon.jpg");
    
    displacementMaps[0] =  colorMaps[0];
    displacementMaps[1] =  colorMaps[1];
    displacementMaps[2] =  colorMaps[2];
       
    
    //controls
    subdivision = control.addSlider("SubdivisionLevel").setPosition(100, 40).setSize(300, 40).setRange(1, 6);
    uv =  control.addButton("uvChecker").setPosition(100, 90).setSize(70,40);
    earth = control.addButton("Earth").setPosition(210, 90).setSize(70,40);
    moon = control.addButton("Moon").setPosition(320, 90).setSize(70,40);
     
}

void draw() {
    background(115);
    lights();
    textFont(font,36);
    
    shader(displacement);
    
    translate(40,50); //always put before the object
    rotateY(millis()*0.0005);
    icos = createIcosahedron(subd);
    icos.scale(100);
    shape(icos);
    
    //map each color map to its displacement map
    if(currentColorMap==0){
      displacement.set("colorMap", colorMaps[currentColorMap]);
      displacement.set("displacementMap",displacementMaps[currentColorMap]);
    } else if(currentColorMap==1){
      displacement.set("colorMap", colorMaps[currentColorMap]);
      displacement.set("displacementMap",displacementMaps[currentColorMap]);
    } else if(currentColorMap==2){
      displacement.set("colorMap", colorMaps[currentColorMap]);
      displacement.set("displacementMap",displacementMaps[currentColorMap]);
    }
    
    displacement.set("count",frameCount);
    //get value from slider
    subd = int(subdivision.getValue());
    
    resetShader();
    inFront();

}

void inFront(){
    hint(DISABLE_DEPTH_TEST);
    cam.beginHUD();
    control.draw();
    cam.endHUD();
    hint(ENABLE_DEPTH_TEST);
}

void mousePressed(){
  if (mouseX >= 0 && mouseX <= 420 && mouseY >=0 && mouseY <=400) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}

void uvChecker(){
  currentColorMap = 0;
}

void Earth(){
  currentColorMap = 1;
}

void Moon(){
  currentColorMap = 2;
}
