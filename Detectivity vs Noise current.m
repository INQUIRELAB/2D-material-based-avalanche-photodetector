%% Detectivity and noise current versus wavelength at 11 V 
clear; 
clc; 
close all; 
 
% -------------------- Data -------------------- 
wavelength = 3:0.2:8;       % Wavelength in um, 26 points 
 
% Responsivity at 11 V, A/W 
R = [ ... 
    6.8358
    6.9916
    13.150
    4.6694
    4.6643
    4.6586
    4.6517
    4.6443
    4.6364
    4.6296
    4.6204
    4.6093
    4.5967
    4.5825
    4.5720
    4.5584
    4.5396
    4.5211
    4.5038
    4.4851
    4.4597
    4.4350
    4.4071
    4.3760
    4.3533
    4.2559 ].'; 
 
% Calculated noise-current spectral density at 11 V 
% Units: A Hz^(-1/2) 
% 
% Values are currently available from 3.0 to 7.0 um. 
% Replace the five NaN entries with the calculated values at: 
% 7.2, 7.4, 7.6, 7.8 and 8.0 um. 
i_n = [ ... 
    5.6456327344e-12 
    5.3420404536e-12 
    1.2725726260e-11 
    5.8489558794e-12 
    5.8162487096e-12 
    5.7403493749e-12 
    5.6638479961e-12 
    5.5805708699e-12 
    5.4935068235e-12 
    5.4182369479e-12 
    5.2994622602e-12 
    5.2601983376e-12 
    5.1469269233e-12 
    4.9993346536e-12 
    4.9206851166e-12 
    4.8123474514e-12 
    4.6773015196e-12 
    4.5459405589e-12 
    4.4306237311e-12 
    4.2216715337e-12 
    4.1668236348e-12 
    4.091141e-12
    3.966395e-12
    3.641890e-12
    3.500219e-12
    3.270119e-12 ].'; 
 
% -------------------- Detector area -------------------- 
% Detector dimensions: 5 um x 5 um 
% 
% 1 um = 1e-4 cm 
detectorWidth_cm  = 5e-4; 
detectorLength_cm = 5e-4; 
 
A_cm2 = detectorWidth_cm * detectorLength_cm; 
sqrtA_cm = sqrt(A_cm2); 
 
% -------------------- Detectivity calculation -------------------- 
% D* = R*sqrt(A)/i_n 
% Units: cm Hz^(1/2) W^(-1), or Jones 
detectivity = R .* sqrtA_cm ./ i_n; 
 
% Select only wavelengths for which i_n and D* are available 
valid = isfinite(i_n) & isfinite(detectivity); 
 
wavelengthValid  = wavelength(valid); 
noiseValid       = i_n(valid); 
detectivityValid = detectivity(valid); 
 
% -------------------- Smooth guide curves -------------------- 
xq = linspace(min(wavelengthValid), ... 
              max(wavelengthValid), 600); 
 
Dq = interp1(wavelengthValid, detectivityValid, ... 
             xq, 'makima'); 
 
Nq = interp1(wavelengthValid, noiseValid, ... 
             xq, 'makima'); 
 
% -------------------- Nature-style preset -------------------- 
fontName = 'Helvetica'; 
 
if ~any(strcmp(listfonts, fontName)) 
    fontName = 'Arial'; 
end 
 
% Portrait figure: width 6 in, height 6.05 in 
fig = figure( ... 
    'Color', 'w', ... 
    'Units', 'inches', ... 
    'Position', [1 1 6 6.05]); 
 
ax = axes(fig); 
hold(ax, 'on'); 
 
ax.FontName = fontName; 
ax.FontSize = 16; 
ax.LineWidth = 1; 
ax.Layer = 'top'; 
ax.Box = 'on'; 
ax.TickDir = 'in'; 
ax.XMinorTick = 'off'; 
ax.YMinorTick = 'off'; 
 
grid(ax, 'off'); 
 
% -------------------- LEFT axis: Detectivity -------------------- 
yyaxis(ax, 'left'); 
 
hDline = plot(ax, xq, Dq, '-', ... 
    'LineWidth', 2.5); 
 
hold(ax, 'on'); 
 
hDpts = plot(ax, wavelengthValid, detectivityValid, 'o', ... 
    'Color', hDline.Color, ... 
    'LineWidth', 1.5, ... 
    'MarkerSize', 6, ... 
    'LineStyle', 'none'); 
 
ylabel(ax, ... 
    'Detectivity, D^* (cm Hz^{1/2} W^{-1})', ... 
    'FontName', fontName, ... 
    'FontSize', 20); 
 
% Display detectivity using a 10^8 scale 
ax.YAxis(1).Exponent = 8; 
 
% -------------------- RIGHT axis: Noise current -------------------- 
yyaxis(ax, 'right'); 
 
hNline = plot(ax, xq, Nq, '-', ... 
    'LineWidth', 2.0); 
 
hold(ax, 'on'); 
 
hNpts = plot(ax, wavelengthValid, noiseValid, 's', ... 
    'Color', hNline.Color, ... 
    'LineWidth', 1.2, ... 
    'MarkerSize', 6, ... 
    'LineStyle', 'none'); 
 
ylabel(ax, ... 
    'Noise current, i_n (A Hz^{-1/2})', ... 
    'FontName', fontName, ... 
    'FontSize', 20); 
 
% Display noise current using a 10^-12 scale 
ax.YAxis(2).Exponent = -12; 
 
% -------------------- X-axis label and limits -------------------- 
xlabel(ax, ... 
    'Wavelength (\mum)', ... 
    'FontName', fontName, ... 
    'FontSize', 20); 
 
xlim(ax, [3 8]); 
xticks(ax, 3:0.5:8); 
 
% -------------------- Legend -------------------- 
lgd = legend( ... 
    [hDline, hNline], ... 
    {'Detectivity, D^*', 'Noise current, i_n'}, ... 
    'Location', 'northeast', ... 
    'FontSize', 10, ... 
    'NumColumns', 2); 
 
lgd.FontName = fontName; 
lgd.Box = 'off'; 
 
% Ensure all text uses the selected font 
set(findall(fig, 'Type', 'text'), ... 
    'FontName', fontName); 
 
% -------------------- Optional console output -------------------- 
resultsTable = table( ... 
    wavelength.', ... 
    R.', ... 
    i_n.', ... 
    detectivity.', ... 
    'VariableNames', { ... 
        'Wavelength_um', ... 
        'Responsivity_A_per_W', ... 
        'NoiseCurrent_A_per_sqrtHz', ... 
        'Detectivity_Jones'}); 
 
disp(resultsTable); 
 
% -------------------- Export: vector PDF -------------------- 
set(fig, 'Renderer', 'painters'); 
 
exportgraphics( ... 
    fig, ... 
    'Detectivity_and_Noise_11V.pdf', ... 
    'ContentType', 'vector'); 
 
% Optional high-resolution PNG export 
exportgraphics( ... 
    fig, ... 
    'Detectivity_and_Noise_11V.png', ... 
    'Resolution', 600);