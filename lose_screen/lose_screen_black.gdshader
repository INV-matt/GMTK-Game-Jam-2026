shader_type canvas_item;

uniform float strength = 1.0;

void fragment() {
  float ydist = abs(0.5 - UV.y) * 2.0;
  COLOR.rgb = vec3(0);
  COLOR.a = (1.0 - smoothstep(0.55, 0.9, ydist)) * strength;
}
