%% Responsivity vs Wavelength (Nature-style font, square PDF)
% + smooth curve + legend top-right
% + legend text centered inside the legend box
% + adds "T = 300 K" to legend
% + adds a RIGHT y-axis with Responsivity, R (A/W) using provided values

clear; close all; clc;

% ---------------- Data ----------------
% x axis: wavelength in um (3 to 8 with 0.2 step)
lambda_um = 3.0 : 0.2 : 8.0;

% left y axis data (26 points)  <-- kept as you provided
y_left = [114.7697135 115.0899252 141.4859511 55.99397131 53.20027049 50.87501721 ...
          48.84206511 46.94884174 45.28762954 43.7209403  42.49532041 40.95864314 ...
          39.87330895 39.06033254 38.03407624 37.17335898 36.48215847 35.85546796 ...
          35.23482308 34.79655383 34.28413671 33.88284608 33.60377551 33.32634201 ...
          33.11400119 32.76969906];

% right y axis data (26 points): Responsivity, R (A/W)
% NOTE: these values are in the order corresponding to 8 -> 3 µm in your earlier dataset,
% so we flip them to align with lambda_um = 3 -> 8 µm.
R_right_in = [4.2559,4.3533,4.3760,4.4071,4.4350,4.4597,4.4851,4.5038,4.5211,4.5396, ...
              4.5584,4.5720,4.5825,4.5967,4.6093,4.6204,4.6296,4.6364,4.6443,4.6517, ...
              4.6586,4.6643,4.6694,13.150,6.9916,6.8358];
R_right = fliplr(R_right_in);

% ---------------- Plot style ----------------
fontName = 'Helvetica';
if ~any(strcmp(listfonts, fontName))
    fontName = 'Arial';
end

side = 6; % inches (square figure + square PDF page)

% ---------------- Smoothing (display only) ----------------
lambda_f = linspace(min(lambda_um), max(lambda_um), 400);

% Smooth-looking curve (shape-preserving cubic interpolation)
yL_f = interp1(lambda_um, y_left,  lambda_f, 'pchip');
R_f  = interp1(lambda_um, R_right, lambda_f, 'pchip');

% ---------------- Plot ----------------
figure('Color','w','Units','inches','Position',[1 1 side side]);

ax = gca;
ax.FontName = fontName;
ax.FontSize = 16;

% Left axis
yyaxis left
hL = plot(lambda_f, yL_f, '-', 'LineWidth', 2); hold on
ylabel('EQE, \eta_e(%)', 'FontName', fontName, 'FontSize', 20); % <- change label if desired

% Right axis
yyaxis right
hR = plot(lambda_f, R_f, '-', 'LineWidth', 2);
ylabel('Responsivity, R (A/W)', 'FontName', fontName, 'FontSize', 20);

% X axis
xlabel('Wavelength, \lambda (\mum)', 'FontName', fontName, 'FontSize', 20);

grid off;

% Make sure both y-axes use the same font
ax.YAxis(1).FontName = fontName;
ax.YAxis(2).FontName = fontName;

% ---------------- Legend (top-right) ----------------
% Make legend purely "conditions" text (not tied to curve symbols)
set(hL, 'HandleVisibility', 'off');
set(hR, 'HandleVisibility', 'off');

d1 = plot(nan, nan, 'LineStyle','none', 'Marker','none', 'HandleVisibility','on');
d2 = plot(nan, nan, 'LineStyle','none', 'Marker','none', 'HandleVisibility','on');

lgd = legend([d1 d2], {'V_{rb} = 11 V', 'T = 300 K'}, ...
             'Location', 'northeast', 'FontSize', 12);
lgd.FontName = fontName;
lgd.AutoUpdate = 'off';

% Center legend text inside the legend box
lgd.Units = 'normalized';
lgd.ItemTokenSize = [0 0];              % remove symbol spacing so centering looks true
txt = findobj(lgd,'Type','Text');
set(txt,'HorizontalAlignment','center');

hold off;

% Make sure any stray text objects also use the same font
set(findall(gcf,'Type','text'),'FontName',fontName);

%% Square PDF export (vector, journal-friendly)
set(gcf,'Renderer','painters');
exportgraphics(gcf, 'Vrb11_lambda_plot.pdf', 'ContentType', 'vector');
