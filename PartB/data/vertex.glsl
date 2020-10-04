//Displacement vertex shader code is by http://www.ozone3d.net/tutorials/vertex_displacement_mapping_p03.php
//Adapted into webgl format for Processing by Queena Low Ying Ci
uniform mat4 texMatrix;
uniform mat4 transform;

attribute vec4 vertex;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertTexCoord;
uniform sampler2D displacementMap;
uniform int count;

void main(){
    float displaceStrength;
    vertTexCoord = texMatrix*vec4(texCoord,1.0,1.0);

    vec4 dv = texture2D(displacementMap, vertTexCoord.st);
    float df = 0.30*dv.r+0.59*dv.g+0.11*dv.b;
    
    displaceStrength = sin(radians(count));
    if(displaceStrength<=0){
        displaceStrength = -sin(radians(count));
    }
    vec4 newVertexPos = vertex + vec4(normal*df*displaceStrength,0.0);

    gl_Position = transform * newVertexPos;
}