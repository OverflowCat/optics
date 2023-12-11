% 第4章 光的干涉仿真
clear
Lambda=500*(1e-9);
A = [1,1]; % 球面波振幅
ymax = 0.00025; % 设置y的范围
xmax = ymax; % 设置x的范围
ny = 10000; % 取点的个数为1000
ys = linspace(xmax/2, xmax*3/2, ny); % 使用linspace函数生成-ymax～ymax之间的等间距数组
xs = linspace(xmax/2, xmax*3/2, ny); % 使用linspace函数生成-xmax～xmax之间的等间距数组
hs = linspace(0.1+xmax*0.1, 0.1+xmax*3*0.1, ny);
zs = sqrt(xs.*xs+hs.*hs);

[H, Y] = meshgrid(hs, ys); % 使用meshgrid函数生成网格
E = 0; % 初始化光波复振幅和

r1 = 2*H+Lambda/2;


h_0 = 200e-9;
r = ymax / 10;
R = (r^2 + h_0^2) / (2 * h_0);

h = h_0;

r1(1000:5000, 1000:5000) = r1(1000:5000, 1000:5000) + 2 * 0.5*(1e-9) * h;

E1 = 1 .* exp(1i * r1 * 2 * pi / Lambda); % 每个球面波源的复振幅
E = 1+ E1; % 球面波复振幅叠加

I = abs(E).^2; % 计算每个点的光
NCLevels = 255;
Br = I * NCLevels / max(max(I)); % 计算每个点的相对光强，并赋予一个色度值

% 使用image函数绘制干涉图样
image(zs, ys, Br);
colormap(gray(NCLevels)); % 使用灰度色图
title('球面波与球面波干涉图形');
xlabel('x/m');
ylabel('y/m');

% 结果讨论
% 建立平面直角坐标系之后，将两个点光源的距离设定为1m，
% 两个点光源到接收屏的距离设定为2m，
% 运行MATLAB代码，观察仿真结果，如图4-35所示。
% 可以看到，球面波与球面波在两个点光源的连线方向上的干涉条纹是一簇同心圆环。
