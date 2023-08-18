uniform vec2 resolution;
uniform float time;

//header
#include "varial.hpp"

vec2 rotate2D(vec2 coord, float x) {
  float intr1 = sin(x);
  float intr2 = cos(x);
  vec2 final = mat2(intr2, -intr1, intr1, intr2)*coord;
    return final;
}

//voro
float voronoi(vec2 x){
  vec4 v1 = vec4(x, x.x * x.y, x.x + x.y);
  v1.yx += time * velocity;
  mat3 coeff = mat3(-0,-1,2,3,-3,1,1,2,1);
  float elem1 = length(0.5 - fract(v1.xyw *= coeff * 0.7));
  float elem2 = length(0.5 - fract(v1.xyw *= coeff * 0.4));
  float elem3 = length(0.5 - fract(v1.xyw *= coeff * 0.3));
  return pow(min(min(elem1, elem2), elem3), 6.0) * 5.0;
}

void main() {
  vec2 coord = gl_FragCoord.xy / resolution.xy;
  
  vec4 final;
  coord = rotate2D(coord, pi / 2.0);
  float fincaust = voronoi((coord) * 4.0);
  final.rgb += exp(fincaust) * intensity * vec3(0.431, 0.8, 1.0);
  gl_FragColor = final;
}