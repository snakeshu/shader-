shader_type canvas_item;

uniform vec4 lightning_color : source_color = vec4(1.0, 0.2, 1.0, 1.0); // 紫色闪电
uniform float time_offset : hint_range(0.0, 100.0) = 0.0; // 时间偏移，用于动画
uniform float thickness : hint_range(0.0, 0.1) = 0.02; // 闪电粗细
uniform float roughness : hint_range(0.0, 5.0) = 3.0; // 闪电的曲折程度
uniform float flash_speed : hint_range(0.1, 5.0) = 2.0; // 闪烁速度

// 随机函数
float random(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// 噪声函数
float noise(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void fragment() {
    // 计算时间变化
    float time = TIME + time_offset;
    
    // 生成闪电的主干路径
    vec2 uv = UV;
    float spine = abs(uv.x - 0.5 + noise(vec2(uv.y * roughness + time * flash_speed, time)) * 0.3);
    
    // 创建闪电形状
    float lightning = smoothstep(thickness, 0.0, spine);
    
    // 添加分支
    float branch1 = smoothstep(thickness * 0.5, 0.0, 
        abs(uv.x - 0.5 + noise(vec2(uv.y * roughness * 2.0 + time, time * 0.5)) * 0.2));
    float branch2 = smoothstep(thickness * 0.5, 0.0, 
        abs(uv.x - 0.5 + noise(vec2(uv.y * roughness * 1.5 - time, time * 0.7)) * 0.2));
    
    // 合并主干和分支
    lightning = max(lightning, branch1 * 0.6);
    lightning = max(lightning, branch2 * 0.4);
    
    // 添加闪烁效果
    float flicker = 0.8 + 0.2 * sin(time * flash_speed * 10.0);
    
    // 最终颜色
    COLOR = lightning_color;
    COLOR.a = lightning * flicker;
    
    // 添加发光效果
    float glow = smoothstep(thickness * 2.0, 0.0, spine);
    COLOR.rgb += glow * 0.5;
}