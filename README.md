# Godot着色器特效集合

这个仓库收集了一些在Godot引擎中使用的着色器特效。

## 水波效果 (water_effect.gdshader)

这是一个可以创建流动水效果的着色器。

### 使用方法
1. 在Godot中创建一个ColorRect或Sprite2D节点
2. 添加ShaderMaterial
3. 将water_effect.gdshader添加到材质中
4. 设置以下参数：
   * water_color: 水的颜色
   * wave_noise: 波浪噪声纹理（需要启用repeat）

### 参数说明
* water_color: 水的基础颜色
* wave_noise: 用于生成水波的噪声纹理
* screen_texture: 屏幕纹理（自动提供）

### 效果说明
* 双层水波叠加
* 可配置的流动方向
* 自然的水波动画效果
* 支持透明度混合

### 性能优化建议
* 如果在移动设备上使用，建议降低水波强度和更新频率
* 可以调整flow_direction和time_offset来控制水流速度

## 树木摆动效果 (tree_sway.gdshader)

这是一个可以让树木自然摆动的着色器效果。

### 使用方法
1. 在Godot中创建一个Sprite2D节点
2. 添加ShaderMaterial
3. 将tree_sway.gdshader添加到材质中
4. 调整wind_speed和wind_strength参数来控制摆动效果

### 参数说明
* wind_speed: 控制摆动速度 (范围: 0.1-5.0)
* wind_strength: 控制摆动幅度 (范围: 1.0-50.0)

### 效果说明
* 树木上部自然摆动
* 底部保持稳定
* 平滑的过渡效果
* 可调节的风力参数

### 特点
* 只有上部70%的区域会产生摆动
* 摆动效果从上到下渐变过渡
* 包含主要和次要风力，使动作更自然
* 适合各种树木和植物模型