clear;
close all;
I0 = 1;
times = 0;

lambda = 6e-5; % 波长，为 600nm
defect_x = 0.0004; % 缺陷的 x 坐标
defect_y = 0.0004; % 缺陷的 y 坐标
defect = lambda / 3;

r = 5 * defect; % 劈尖半径
R = (r ^ 2 + defect ^ 2) / (2 * defect);

for theta = 0.1:0.005:0.4 % 劈尖夹角
    times = times + 1;
    length = .001; % 劈尖长度
    xmax = 0.001 * cos(theta); % ?
    [x, y] = meshgrid(0:0.00001:xmax, 0:0.00001:0.001); % 生成网格，x 为横坐标，y 为纵坐标
    z = x * tan(theta);

    x_ = x - defect_x;
    y_ = y - defect_y;

    % 计算缺陷对应的高度变化
    inside_defect = (x_ .^ 2 + y_ .^ 2) <= r ^ 2;
    defect_height = sqrt(R ^ 2 - x_ .^ 2 - y_ .^ 2) - sqrt(R ^ 2 - r ^ 2);
    defect_height(~inside_defect) = 0; % 只在缺陷区域内应用高度变化
    % defect 区域（圆形）处 h += defect_height
    h = z + defect_height; % 凹陷

    k = 2 * pi / lambda; % 波数
    Delta = 2 * h; % 光程差
    I = I0 * 2 * (cos(Delta * k + pi / 2) + 1);
    surf(x, y, z, I);
    % set(gcf, 'color', 'white', [0.667, 0.667, 1]);
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
