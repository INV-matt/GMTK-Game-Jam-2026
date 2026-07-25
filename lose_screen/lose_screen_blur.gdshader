shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;
uniform float strength = 0.0;

void fragment() {
  vec4 col = texture(screen_texture, SCREEN_UV);
  float avg = (col.r + col.g + col.b) / 3.0;
  vec3 grey_col = vec3(avg);
  
  COLOR.rgb = grey_col;
  COLOR.a = strength;
}
