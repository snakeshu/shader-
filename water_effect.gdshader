shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform vec4 water_color : source_color;
uniform sampler2D wave_noise : repeat_enable;

void fragment() {
    // 增加两个方向的流动
    vec2 flow_direction = vec2(1.0, 0.5); // 水流方向
    vec2 time_offset = TIME * vec2(0.05, 0.03); // 不同方向的流动速度
    
    // 创建两层水波，产生更自然的流动效果
    vec2 water_wave1 = texture(wave_noise, UV + time_offset).rg - 0.5;
    vec2 water_wave2 = texture(wave_noise, UV * 1.2 - time_offset * 0.8).rg - 0.5;
    vec2 water_wave = (water_wave1 + water_wave2) * 0.02;
    
    // 应用流动方向
    water_wave += flow_direction * TIME * 0.01;
    
    vec2 uv = vec2(SCREEN_UV.x, SCREEN_UV.y - UV.y) + water_wave;
    vec4 color = texture(screen_texture, uv);
    float mix_value = 1.0 - UV.y;

    float avg_color = (color.r + color.g + color.b) / 3.0;
    avg_color = pow(avg_color, 1.4);
    mix_value += avg_color;

    mix_value = clamp(mix_value, 0.0, 0.7);
    COLOR = mix(water_color, color, mix_value);
}