%% 3D plot: smooth surface ONLY (no black lines, no mesh lines)

clear; clc; close all;

%% Wavelength values (unchanged)
Ida0 = [ ...
    8.0000e-6, 7.8000e-6, 7.6000e-6, 7.4000e-6, 7.2000e-6, ...
    7.0000e-6, 6.8000e-6, 6.6000e-6, 6.4000e-6, 6.2000e-6, ...
    6.0000e-6, 5.8000e-6, 5.6000e-6, 5.4000e-6, 5.2000e-6, ...
    5.0000e-6, 4.8000e-6, 4.6000e-6, 4.4000e-6, 4.2000e-6, ...
    4.0000e-6, 3.8000e-6, 3.6000e-6, 3.4000e-6, 3.2000e-6, ...
    3.0000e-6 ];

wl_um = Ida0(:).' * 1e6;   % wavelength in micrometers (µm)

%% X axis values
x = [10, 1, 0.1];

%% Z data (triplets)
y30 = [425.83 4.2559 0.42574];
y32 = [435.32 4.3533 0.43530];
y34 = [437.60 4.3760 0.43760];
y36 = [440.58 4.4071 0.44060];
y38 = [443.48 4.4350 0.44351];
y40 = [445.97 4.4597 0.44596];
y42 = [448.49 4.4851 0.44852];
y44 = [450.38 4.5038 0.45035];
y46 = [452.22 4.5211 0.45221];
y48 = [453.98 4.5396 0.45395];
y50 = [455.82 4.5584 0.45585];
y52 = [457.20 4.5720 0.45723];
y54 = [458.22 4.5825 0.45827];
y56 = [459.72 4.5967 0.45970];
y58 = [460.98 4.6093 0.46096];
y60 = [462.06 4.6204 0.46202];
y62 = [462.78 4.6296 0.46279];
y64 = [463.66 4.6364 0.46368];
y66 = [464.42 4.6443 0.46445];
y68 = [465.12 4.6517 0.46515];
y70 = [465.86 4.6586 0.46586];
y72 = [466.42 4.6643 0.46642];
y74 = [466.96 4.6694 0.46694];
y76 = [475.89 13.1500 8.9422];
y78 = [471.24 6.9916 2.7778];
y80 = [470.89 6.8358 2.6165];

T = [ ...
    y30; y32; y34; y36; y38; y40; y42; y44; y46; y48; y50; y52; y54; ...
    y56; y58; y60; y62; y64; y66; y68; y70; y72; y74; y76; y78; y80];

% x=0.1 -> col3, x=1 -> col2, x=10 -> col1
Z = [T(:,3), T(:,2), T(:,1)];   % 26 x 3

%% Build surface grids (Y axis = wavelength, X axis = [0.1 1 10])
[X, Y] = meshgrid(x, wl_um);

%% -------------------- Plot styling (same as yours) --------------------
fontName = 'Helvetica';
if ~any(strcmp(listfonts, fontName))
    fontName = 'Arial';
end

side = 6; % inches
figure('Color','w','Units','inches','Position',[1 1 side side]);

% Force a smooth surface with NO edges whatsoever
hSurf = surf(X, Y, Z);
set(hSurf, 'EdgeColor','none', 'LineStyle','none');  % <- kills mesh lines
shading interp
box on

ax = gca;
ax.FontName = fontName;
ax.FontSize = 16;
ax.LineWidth = 1;
ax.Layer = 'top';

xl = xlabel('Power, P (\muW)', 'FontName', fontName, 'FontSize', 20);
yl = ylabel('Wavelength, \lambda (\mum)', 'FontName', fontName, 'FontSize', 20);
zl = zlabel('Responsivity, R (A/W)', 'FontName', fontName, 'FontSize', 20);

ylim([3 8]);

xl.RotationMode = 'auto';
yl.RotationMode = 'auto';
xl.HorizontalAlignment = 'center';
yl.HorizontalAlignment = 'center';

xl.Rotation = 20;
yl.Rotation = -20;

view(45, 25);
camorbit(90, 0, 'data', [0 0 1]);

grid off;

cb = colorbar;
cb.FontName = fontName;
cb.FontSize = 16;
cb.LineWidth = 1;
cb.Position(1) = cb.Position(1) -0.5;

% ---- decrease both width and height ----
scaleW = 0.7;
scaleH = 0.35;

oldW = cb.Position(3);
cb.Position(3) = oldW * scaleW;
cb.Position(1) = cb.Position(1) + (oldW - cb.Position(3));

oldH = cb.Position(4);
cb.Position(4) = oldH * scaleH;
cb.Position(2) = cb.Position(2) + (oldH - cb.Position(4))/2;

% ---- decrease colorbar width ----
scaleW2 = 0.6;
oldW2   = cb.Position(3);
cb.Position(3) = oldW2 * scaleW2;
cb.Position(1) = cb.Position(1) + (oldW2 - cb.Position(3));

% Legend (kept)
lgd = legend(hSurf, 'V_{rb}=11 V', 'Location','northwest');
lgd.FontName = fontName;
lgd.FontSize = 12;
lgd.LineWidth = 1;
lgd.Box = 'off';

set(findall(gcf,'Type','text'),'FontName',fontName);

%% Export (vector PDF)
set(gcf,'Renderer','painters');
exportgraphics(gcf, 'Responsivity_3D_Surface.pdf', 'ContentType', 'vector');
