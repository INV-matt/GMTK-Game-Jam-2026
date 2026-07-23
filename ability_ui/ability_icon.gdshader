shader_type canvas_item;

uniform float progress = 0.0;

void fragment() {
  if (progress < 1.0) {
    float avg = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
    
    if (UV.y < 1.0 - progress) {
      COLOR.rgb = vec3(avg / 3.0);
    } else {
      COLOR.rgb = vec3(avg);
    }
  }
}
