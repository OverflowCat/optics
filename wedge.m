clear;
close all;
I0 = 1;
times = 0;

lambda = 6e-5; % 波长，为 600nm
defect_x = 0.0005; % 缺陷的 x 坐标
defect_y = 0.0005; % 缺陷的 y 坐标
defect_r = 0.0001; % 缺陷的半径
defect = lambda / 3;

for theta = 0.1:0.005:0.4 % 劈尖夹角
    times = times + 1;
    length = .001; % 劈尖长度
    xmax = 0.001 * cos(theta); % ?
    [x, y] = meshgrid(0:0.00001:xmax, 0:0.00001:0.001); % 生成网格，x 为横坐标，y 为纵坐标
    z = x * tan(theta);


    % defect 区域（矩形）处 h += defect
    h_defect = defect_height * (x > defect_x & x < defect_x + defect_width & y > defect_y & y < defect_y + defect_height);

    h = z + h_defect;


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
