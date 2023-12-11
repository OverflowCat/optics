# 干涉测量仿真大作业

## Matlab

https://github.com/OverflowCat/optics/assets/20166026/896ba90b-bb04-49a1-a253-7a2b7dd6ff5b


<!-- lambda = 600e-9
h = 200e-9
theta = 27 deg

被检测平面 A:
A(x, y) = if x^2 + y^2 <= d^2 / 4 then h + h*cos(2 * pi / d * sqrt(x^2+y^2)) else 0

光强
I = (1+cos(2*pi * x / lambda)) / 2
位置 x 处的厚
h = x * tan(theta)
x 处光强序列
I_1 = h - 2 * A(x, y) -->

### 球形凹陷 / 突起

$$(R - h_0)^2 + r^2 = R^2$$

$$-2 R h_0 + h_0^2 + r^2 = 0$$

$$2 R h_0 = h_0^2 + r^2$$

$$R = \frac{\sqrt{h_0^2 + r^2}}{2h_0}$$

