shader_type canvas_item;

uniform sampler2D ping_tex;
uniform vec3 border_col = vec3(1.0, 1.0, 1.0);
uniform float urgency = 1.0;

vec4 get_col(sampler2D sampler, vec2 uv) {
  if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
    return vec4(1.0, 1.0, 1.0, 0.0);
  }
  
  return texture(sampler, uv);
}

void fragment() {
  float border_mult = 0.02;

  vec2 actual_uv = UV * 1.2 - vec2(.1, .1);
  
  vec4 texture_col = get_col(ping_tex, actual_uv);
  bool is_border = false;
  float border_dist = -1.0;
  
  if (texture_col.a <= 0.4) {
    for (int x = -9; x <= 9; x++) {
      for (int y = -9; y <= 9; y++) {
        vec4 other_col = get_col(ping_tex, actual_uv + vec2(float(x), float(y)) * border_mult);
      
        if (other_col.a > 0.0) {
          is_border = true;
          float dist = sqrt(float(x * x + y * y));
          
          if (dist < border_dist || border_dist < 0.0) {
            border_dist = dist;
          }
        }
      }
    }
  }
  
  if (is_border) {
    COLOR.rgb = border_col;
    COLOR.a = 1.0 - border_dist / (5.0 + 2.5 * sin(TIME * urgency));
  } else {
    COLOR = texture_col;
  }
}
