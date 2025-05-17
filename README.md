# Godot着色器特效集合

这个仓库收集了一些在Godot引擎中使用的着色器特效。

## 水波效果 (water_effect.gdshader)

这是一个可以创建流动水效果的着色器。

### 使用方法

1. 在Godot中创建一个ColorRect或Sprite2D节点
2. 添加ShaderMaterial
3. 将water_effect.gdshader添加到材质中
4. 设置以下参数：
   - water_color: 水的颜色
   - wave_noise: 波浪噪声纹理（需要启用repeat）

### 参数说明

- water_color: 水的基础颜色
- wave_noise: 用于生成水波的噪声纹理
- screen_texture: 屏幕纹理（自动提供）

### 效果说明

- 双层水波叠加
- 可配置的流动方向
- 自然的水波动画效果
- 支持透明度混合

### 性能优化建议

- 如果在移动设备上使用，建议降低水波强度和更新频率
- 可以调整flow_direction和time_offset来控制水流速度