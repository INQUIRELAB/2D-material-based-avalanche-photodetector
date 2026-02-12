%% Responsivity (Ideal / Tolerances) + smooth solid lines (NO markers)
% + inset PNG (transparent) + thin BLACK FRAME (inset)
% + GREEN boundary frame that encloses: plot + ticks + tick labels + xlabel + ylabel
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

R_10_5um = [ ...
    3.8544; 3.9433; 3.9617; 3.9829; 4.0065; 4.0276; 4.0478; 4.0602; ...
    4.0848; 4.0974; 4.1120; 4.1231; 4.1340; 4.1457; 4.1561; 4.1654; ...
    4.1743; 4.1825; 4.1882; 4.1931; 4.2026; 4.2071; 4.2133; 11.699; ...
    6.4047; 6.2619 ];

R_9_5um = [ ...
    4.7559; 4.8616; 4.8995; 4.9419; 4.9779; 5.0111; 5.0434; 5.0713; ...
    5.0936; 5.1134; 5.1351; 5.1530; 5.1703; 5.1851; 5.1995; 5.2125; ...
    5.2251; 5.2336; 5.2436; 5.2541; 5.2609; 5.2673; 5.2743; 14.567; ...
    7.7226; 7.5623 ];

%% -------------------- Smooth guide curves (display-only; data unchanged) --------------------
[x, idx] = sort(lambda_um, 'ascend');
R10  = R_10um(idx);
R105 = R_10_5um(idx);
R95  = R_9_5um(idx);

xq    = linspace(min(x), max(x), 600);
R10q  = interp1(x, R10,  xq, 'makima');
R105q = interp1(x, R105, xq, 'makima');
R95q  = interp1(x, R95,  xq, 'makima');

%% -------------------- Nature-style preset --------------------
fontName = 'Helvetica';
if ~any(strcmp(listfonts, fontName))
    fontName = 'Arial';
end

side = 6; % inches (square)
fig = figure('Color','w','Units','inches','Position',[1 1 side side]);

%% -------------------- Colors --------------------
blk       = [0 0 0];
T1_blue   = [0 102 255]/255;
T2_orange = [237 125 49]/255;

% CHANGED: boundary color to GREEN
boundaryGreen = [0 0.6 0];   % you can tweak this green if you want

%% -------------------- Main plot (SOLID LINES ONLY) --------------------
hIdeal = plot(xq, R10q,  '-', 'LineWidth', 2.5, 'Color', blk); hold on;
hT1    = plot(xq, R105q, '-', 'LineWidth', 2.5, 'Color', T1_blue);
hT2    = plot(xq, R95q,  '-', 'LineWidth', 2.5, 'Color', T2_orange);

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

% Guide lines (black dashed)
yline(11.7,  'k--', 'LineWidth', 1.5);
yline(13.15, 'k--', 'LineWidth', 1.5);
yline(14.57, 'k--', 'LineWidth', 1.5);
xline(3.4,   'k--', 'LineWidth', 1.5);

ylabel('Responsivity, R (A/W)', 'FontName', fontName, 'FontSize', 20);
xlabel('Wavelength, \lambda (\mum)', 'FontName', fontName, 'FontSize', 20);

xlim([3 8]);

lgd = legend([hIdeal hT1 hT2], ...
    {'Ideal', 'Tolerance-1 (+5%)', 'Tolerance-2 (-5%)'}, ...
    'Location','northeast', 'FontSize', 10, 'NumColumns', 2);
lgd.FontName = fontName;

set(findall(fig,'Type','text'),'FontName',fontName);

%% -------------------- Inset image (transparent PNG) + thin black frame --------------------
insetFile = fullfile(pwd,'Picture1.png');

% [x y w h] in normalized FIGURE units
insetPos = [0.60 0.38 0.28 0.22];

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
    text(axInset,0.5,0.5,{'Inset image not found','Picture1.png'}, ...
        'HorizontalAlignment','center','FontName',fontName,'FontSize',10);
end

uistack(axInset,'top');

% Thin black frame around inset
annotation(fig,'rectangle', insetPos, 'Color','k', 'LineWidth', 0.8);

%%%% -------------------- GREEN boundary that includes xlabel/ylabel/tick labels --------------------
% Use TightInset to expand from the axes Position to include labels.
drawnow;  % make sure layout is finalized

pos = ax.Position;     % [left bottom width height] in normalized figure units
ti  = ax.TightInset;   % [left bottom right top] extra space needed for labels/ticks

pad = 0.00; % increase to 0.01 if you want more breathing space outside labels

framePos = [pos(1)-ti(1)-pad, ...
            pos(2)-ti(2)-pad, ...
            pos(3)+ti(1)+ti(3)+2*pad, ...
            pos(4)+ti(2)+ti(4)+2*pad];

annotation(fig,'rectangle', framePos, 'Color', boundaryGreen, 'LineWidth', 2.0);

%% -------------------- Export (vector PDF) --------------------
set(fig,'Renderer','painters');
exportgraphics(fig, 'Responsivity_with_Inset.pdf', 'ContentType', 'vector');
