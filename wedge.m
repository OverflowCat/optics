clear;
close all;
I0 = 1;
times = 0;

lambda = 6e-5; % 波长，为 600nm
scratch_depth = 1/3 * lambda; % 划痕深度
scratch_width = 0.0001;

for theta = 0.1:0.005:0.4 % 劈尖夹角
    times = times + 1;
    length = .001; % 劈尖长度
    xmax = 0.001 * cos(theta); % ?
    [x, y] = meshgrid(0:0.00001:xmax, 0:0.00001:0.001); % 生成网格，x 为横坐标，y 为纵坐标
    z = x * tan(theta);
    % 我们现在表面有划痕了！假设划痕在中央，宽度为 1/1000 的元件宽度
    % 我们假设划痕的深度为 1/3 波长
    % 添加划痕影响
    scratch_center = length / 2; % 划痕中心位置
    scratch_start = scratch_center - scratch_width / 2; % 划痕开始位置
    scratch_end = scratch_center + scratch_width / 2; % 划痕结束位置
    scratch_area = x > scratch_start & x < scratch_end; % 定义划痕区域

    scratch_length = 0.0005; % 划痕的长度，例如 0.5 毫米
    scratch_y_center = 0.0005; % 划痕沿 y 轴的中心位置，例如在 0.5 毫米处
    scratch_y_start = scratch_y_center - scratch_length / 2;
    scratch_y_end = scratch_y_center + scratch_length / 2;
    scratch_area_y = y > scratch_y_start & y < scratch_y_end;
    scratch_area = scratch_area & scratch_area_y;

    h = x * tan(theta); % 在 x 处的高度
    k = 2 * pi / lambda; % 波数
    Delta = 2 * h; % 光程差
    Delta(scratch_area) = Delta(scratch_area) + scratch_depth; % 在划痕区域增加厚度
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
