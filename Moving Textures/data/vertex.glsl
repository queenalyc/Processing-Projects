
attribute vec4 position;
attribute vec4 texCoord; //texture coordinates stxy

uniform mat4 transform;

varying vec4 newTexCoord;
varying vec4 vertTexCoord;
varying vec4 vertColor;
varying vec4 rotateuv;

uniform int count;
float xtranslate;

void main(){
    //Getting position of object
    gl_Position = transform*position;
     
    //if outside of texture reset, else continue the calculations
    //calculate the speed of texture, count is from framecount
    xtranslate = (count%100)/100.0;
    vec4 newTexCoord = vec4(texCoord.s+xtranslate,texCoord.t,texCoord.xy);

    vertTexCoord = newTexCoord;

}