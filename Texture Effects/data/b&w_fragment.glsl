//mediump = medium precision
//fragment shader provides colour
//Code ref from https://processing.org/tutorials/pshader/ 
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
//reference texture 
uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;
//let user change lumcoeff
uniform float coeffR;
uniform float coeffG;
uniform float coeffB;
uniform float coeffA;

const vec4 lumcoeff = vec4(coeffR,coeffG,coeffB,coeffA);

void main() {
  //gl_FragColor is a special variable a fragment shader is responsible for setting
  //texture2D look up colour from the texture
  
  vec4 col = texture2D(texture, vertTexCoord.st);
  float lum = dot(normalize(lumcoeff), col);
  if(0.5<lum){
    gl_FragColor = vertColor; //render white
  }else{
    gl_FragColor = vec4(0,0,0,1); //render black
  }
}