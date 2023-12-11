clear;
close all;
I0 = 1;
times = 0;

lambda = 6e-5; % 波长，为 600nm

for theta = 0.1:0.005:0.4 % 劈尖夹角
    times = times + 1;
    length = .001; % 劈尖长度
    xmax = 0.001 * cos(theta); % ?
    [x, y] = meshgrid(0:0.00001:xmax, 0:0.00001:0.001); % 生成网格，x 为横坐标，y 为纵坐标
    z = x * tan(theta);
    % 球面凹陷参数
    r = lambda/3; % 球半径，例如 0.5 毫米
    x_0 = length / 2; % 球心 x 坐标
    y_0 = 0.0005; % 球心 y 坐标
    z_0 = -0.0001; % 球面凹陷深度

    % 确定球面区域
    inside_sphere = (x - x_0) .^ 2 + (y - y_0) .^ 2 <= r ^ 2;

    % 计算球面凹陷的深度
    z_sphere = z_0 - sqrt(r ^ 2 - (x - x_0) .^ 2 - (y - y_0) .^ 2);
    z_sphere(~inside_sphere) = 0; % 凹陷外的区域不受影响

    % 更新劈尖处的高度 h 以包括球面凹陷
    h = x * tan(theta) + z_sphere;

    k = 2 * pi / lambda; % 波数
    Delta = 2 * h; % 光程差
    I = I0 * 2 * (cos(Delta * k + pi) + 1);
    surf(x, y, z, I);
    set(gcf, 'color', 'white', [0.667, 0.667, 1]);
    shading interp; % 颜色插值
    colorbar;
    axis equal; % 等比例缩放
    set(gca, 'ZLim', [0, 0.0006]);
    set(gca, 'XLim', [0, 0.001]);
    xlabel('x/m'); ylabel('y/m'); zlabel('z/m');
    title(['劈尖夹角为', num2str(theta / pi * 180, 4), 'deg']);
    colormap gray;
    m(:, times) = getframe; % 把图像存入矩阵 m 中
end

movie(m, 2);
