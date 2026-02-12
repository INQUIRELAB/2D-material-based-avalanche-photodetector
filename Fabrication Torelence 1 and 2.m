%% Responsivity (Ideal / T-3 / T-4) + smooth solid lines (NO markers)
% + inset PNG (transparent) + thin BLACK FRAME (inset)
% + YELLOW boundary frame (your shade) that encloses: plot + ticks + tick labels + xlabel + ylabel
% (axes/ticks remain BLACK)

clc; clear; close all;

%% -------------------- Data --------------------
lambda_m = [ ...
    8.0000E-6; 7.8000E-6; 7.6000E-6; 7.4000E-6; 7.2000E-6; 7.0000E-6; ...
    6.8000E-6; 6.6000E-6; 6.4000E-6; 6.2000E-6; 6.0000E-6; 5.8000E-6; ...
    5.6000E-6; 5.4000E-6; 5.2000E-6; 5.0000E-6; 4.8000E-6; 4.6000E-6; ...
    4.4000E-6; 4.2000E-6; 4.0000E-6; 3.8000E-6; 3.6000E-6; 3.4000E-6; ...
    3.2000E-6; 3.0000E-6 ];

lambda_um = lambda_m * 1e6;

R_10um = [ ...
    4.2559; 4.3533; 4.3760; 4.4071; 4.4350; 4.4597; 4.4851; 4.5038; ...
    4.5211; 4.5396; 4.5584; 4.5720; 4.5825; 4.5967; 4.6093; 4.6204; ...
    4.6296; 4.6364; 4.6443; 4.6517; 4.6586; 4.6643; 4.6694; 13.150; ...
    6.9916; 6.8358 ];

R_T3 = [ ...
    4.0903; 4.1864; 4.2153; 4.2460; 4.2810; 4.3075; 4.3361; 4.3616; ...
    4.3824; 4.4026; 4.4248; 4.4394; 4.4567; 4.4742; 4.4886; 4.5022; ...
    4.5142; 4.5256; 4.5365; 4.5463; 4.5552; 4.5628; 4.5698; 11.019; ...
    6.7749; 6.6450 ];

R_T4 = [ ...
    4.5815; 4.6951; 4.7279; 4.7630; 4.7969; 4.8261; 4.8556; 4.8855; ...
    4.9087; 4.9344; 4.9510; 4.9658; 4.9837; 4.9979; 5.0109; 5.0234; ...
    5.0347; 5.0452; 5.0550; 5.0630; 5.0698; 5.0768; 5.0845; 14.082; ...
    7.4763; 7.3229 ];

%% -------------------- Smooth guide curves (display-only; data unchanged) --------------------
[x, idx] = sort(lambda_um, 'ascend');
R10 = R_10um(idx);
RT3 = R_T3(idx);
RT4 = R_T4(idx);

xq   = linspace(min(x), max(x), 600);
R10q = interp1(x, R10, xq, 'makima');
RT3q = interp1(x, RT3, xq, 'makima');
RT4q = interp1(x, RT4, xq, 'makima');

%% -------------------- Nature-style preset --------------------
fontName = 'Helvetica';
if ~any(strcmp(listfonts, fontName))
    fontName = 'Arial';
end
side = 6;
fig = figure('Color','w','Units','inches','Position',[1 1 side side]);

%% -------------------- Colors --------------------
blk        = [0 0 0];                 % Ideal
T3_color   = [153 153 255]/255;       % lavender/blue
T4_color   = [255   0   0]/255;       % red

% Your requested yellow boundary shade
boundaryYellow = [0.93 0.69 0.13];

%% -------------------- Plot (smooth SOLID LINES ONLY) --------------------
hIdeal = plot(xq, R10q, '-', 'LineWidth', 2, 'Color', blk); hold on;
hT3    = plot(xq, RT3q, '-', 'LineWidth', 2, 'Color', T3_color);
hT4    = plot(xq, RT4q, '-', 'LineWidth', 2, 'Color', T4_color);

ax = gca;
ax.FontName = fontName;
ax.FontSize = 16;

box on;
ax.LineWidth = 1;
ax.Layer = 'top';
grid off;

% Keep axes/ticks BLACK
ax.XColor = 'k';
ax.YColor = 'k';

% Peak values (use original data, not interpolated)
peak_T3 = max(R_T3);
peak_T4 = max(R_T4);

% Guide lines
yline(13.15,   'k--', 'LineWidth', 1);
yline(peak_T3, 'k--', 'LineWidth', 1);
yline(peak_T4, 'k--', 'LineWidth', 1);
xline(3.4,     'k--', 'LineWidth', 1);

ylabel('Responsivity, R (A/W)', 'FontName', fontName, 'FontSize', 20);
xlabel('Wavelength, \lambda (\mum)', 'FontName', fontName, 'FontSize', 20);

xlim([3 8]);

lgd = legend([hIdeal hT3 hT4], ...
    {'Ideal', 'Tolerance-3 (+5%)', 'Tolerance-4 (-5%)'}, ...
    'Location','northeast', 'FontSize', 10, 'NumColumns', 2);
lgd.FontName = fontName;

set(findall(fig,'Type','text'),'FontName',fontName);

%% -------------------- Inset image (transparent PNG) + thin black frame --------------------
insetFile = fullfile(pwd,'Picture2.png');   % change if needed

% Right-middle, shifted a bit left AND a bit LOWER
insetPos = [0.60 0.33 0.28 0.22];

axInset = axes('Parent',fig,'Units','normalized','Position',insetPos);
set(axInset,'Color','none');
axis(axInset,'off');

if isfile(insetFile)
    [img, ~, alpha] = imread(insetFile);
    imshow(img, 'Parent', axInset);
    if ~isempty(alpha)
        hIm = findobj(axInset,'Type','image');
        set(hIm,'AlphaData', double(alpha)/255);
    end
else
    axis(axInset,[0 1 0 1]); axis(axInset,'off');
    text(axInset,0.5,0.5,{'Inset image not found','Picture2.png'}, ...
        'HorizontalAlignment','center','FontName',fontName,'FontSize',10);
end

uistack(axInset,'top');
annotation(fig,'rectangle', insetPos, 'Color','k', 'LineWidth', 0.8);

%% -------------------- YELLOW boundary that includes xlabel/ylabel/tick labels --------------------
drawnow;  % finalize layout

pos = ax.Position;     % [left bottom width height] in normalized figure units
ti  = ax.TightInset;   % [left bottom right top] extra space for labels/ticks

pad = 0.00; % set 0.01 for a little extra margin outside labels

framePos = [pos(1)-ti(1)-pad, ...
            pos(2)-ti(2)-pad, ...
            pos(3)+ti(1)+ti(3)+2*pad, ...
            pos(4)+ti(2)+ti(4)+2*pad];

annotation(fig,'rectangle', framePos, 'Color', boundaryYellow, 'LineWidth', 2.0);

%% -------------------- Export (vector PDF) --------------------
set(fig,'Renderer','painters');
exportgraphics(fig, 'Responsivity_T3_T4_with_Inset.pdf', 'ContentType', 'vector');
