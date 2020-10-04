//Processing 3.5.3
import peasy.*;
import controlP5.*;

PShader materialbw, img2D, materialemboss;
PeasyCam cam;
ControlP5 control;
PShape icos;
int subd;
Slider subdivision;
Button img1, img2, img3, emboss, bnw;
PImage uvmap, main, globe, moon;
int button=1;
int effect=1;
ColorPicker cp, cp2;
float coeffR = 255;
float coeffG = 128;
float coeffB = 0.0;
float coeffA = 0.0;

void setup() {
    size(1300,800,P3D);
    cam = new PeasyCam(this, 100);
    cam.setMinimumDistance(300);
    cam.setMaximumDistance(700);

    control = new ControlP5(this);
    control.setAutoDraw(false);

    materialbw = loadShader("b&w_fragment.glsl","vertex.glsl");
    materialemboss = loadShader("emboss_fragment.glsl","vertex.glsl");
    textureWrap(REPEAT);
      
    //controls
    subdivision = control.addSlider("SubdivisionLevel").setPosition(100, 40).setSize(300, 40).setRange(1, 6);
    img1 = control.addButton("uvChecker").setPosition(100, 90).setSize(70,40);
    img2 = control.addButton("Globe").setPosition(210, 90).setSize(70,40);
    img3 = control.addButton("Moon").setPosition(320, 90).setSize(70,40);
    bnw = control.addButton("BlacknWhite").setPosition(170, 150).setSize(150,40);
    emboss = control.addButton("Emboss").setPosition(170, 270).setSize(150,40);
    cp = control.addColorPicker("BlacknWhite_rgba").setPosition(110, 200).setColorValue(color(coeffR, coeffG, coeffB, coeffA));
    cp2 = control.addColorPicker("Emboss_rgba").setPosition(110, 320).setColorValue(color(coeffR, coeffG, coeffB, coeffA));

    
}

void draw() {
    background(115);
    lights();

    pushMatrix();
    translate(40,50); //always put before the object
    rotateY(millis()*0.0005);
    icos = createIcosahedron(subd,main);
    icos.scale(100);
    shape(icos);
    popMatrix();
    
    //get value from slider
    subd = int(subdivision.getValue());
    resetShader();
    inFront();

    //changing images by clicking on button
    if(button==1){
      uvmap = loadImage("uvmap.jpg");
      main = uvmap;
    } else if(button==2){
      globe = loadImage("globe.jpg");
      main = globe;
    } else if(button==3){
      moon = loadImage("moon.jpg");
      main = moon;
    }
    
    if(effect==1){
        shader(materialbw);
    }else if(effect==2){
        shader(materialemboss);
    }

    materialbw.set("count", frameCount);
    materialemboss.set("count", frameCount);
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
  button = 1;
}

void Globe(){
  button = 2;
}

void Moon(){
  button = 3;
}

public void controlEvent(ControlEvent e){
    if(e.isFrom(cp)){
        coeffR = e.getArrayValue(0);
        coeffG = e.getArrayValue(1);
        coeffB = e.getArrayValue(2);
        coeffA = e.getArrayValue(3);

        materialbw.set("coeffR",coeffR);
        materialbw.set("coeffG",coeffG);
        materialbw.set("coeffB",coeffB);
        materialbw.set("coeffA",coeffA);

        
    } else if(e.isFrom(cp2)){
        coeffR = e.getArrayValue(0);
        coeffG = e.getArrayValue(1);
        coeffB = e.getArrayValue(2);
        coeffA = e.getArrayValue(3);

        materialemboss.set("coeffR",coeffR);
        materialemboss.set("coeffG",coeffG);
        materialemboss.set("coeffB",coeffB);
        materialemboss.set("coeffA",coeffA);
    }
}

void BlacknWhite(){
    effect=1;
}
void Emboss(){
    effect=2;
}
