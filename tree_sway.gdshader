shader_type canvas_item;

// 风力参数
uniform float wind_speed : hint_range(0.1, 5.0) = 2.0;
uniform float wind_strength : hint_range(1.0, 50.0) = 20.0;

void vertex() {
    // 注意：UV.y是从上(0.0)到下(1.0)
    float height_threshold = 0.7; // 现在是上面70%会动
    
    // 只有当UV.y小于阈值时才应用摆动（上部）
    if(UV.y < height_threshold) {
        // 计算渐变系数（从上到下递减）
        float gradient = (height_threshold - UV.y) / height_threshold;
        gradient = gradient * gradient; // 使过渡更平滑
        
        // 基础风力
        float base_wind = sin(TIME * wind_speed + UV.x * 2.0);
        float secondary_wind = sin(TIME * (wind_speed * 0.5) + UV.x * 1.5) * 0.5;
        float wind = (base_wind + secondary_wind) * wind_strength;
        
        // 应用位移，上部摆动更大
        VERTEX.x += wind * gradient;
    }
}

void fragment() {
    // 直接使用原始纹理颜色，不添加任何效果
    COLOR = texture(TEXTURE, UV);
}