% -------------------- Data --------------------
wavelength = 3:0.2:8;   % um (26 points)

i_n = [ ...
3.1696067363e-12
3.0896669640e-12
5.9416233393e-12
2.9610725050e-12
2.9498740783e-12
2.9248525096e-12
2.8977641939e-12
2.8702535363e-12
2.8405323130e-12
2.8140591417e-12
2.7727070584e-12
2.7595240978e-12
2.7217676940e-12
2.6683451410e-12
2.6382109230e-12
2.5966055172e-12
2.5458222689e-12
2.4966497500e-12
2.4511215344e-12
2.3750324807e-12
2.3459672033e-12
2.2902544248e-12
2.2282971364e-12
2.1684444609e-12
2.1125845625e-12
2.0255644167e-12 ];

detectivity = [ ...
2.0744e9
2.1281e9
1.1066e9
2.2205e9
2.2289e9
2.2480e9
2.2690e9
2.2907e9
2.3147e9
2.3365e9
2.3713e9
2.3827e9
2.4157e9
2.4641e9
2.4922e9
2.5322e9
2.5827e9
2.6335e9
2.6824e9
2.7684e9
2.8027e9
2.8709e9
2.9507e9
3.0321e9
3.1123e9
3.2460e9 ];

% -------------------- Smooth guide curves --------------------
xq = linspace(min(wavelength), max(wavelength), 600);
Dq = interp1(wavelength, detectivity, xq, 'makima');
Nq = interp1(wavelength, i_n,         xq, 'makima');

% -------------------- Nature-style preset --------------------
fontName = 'Helvetica';
if ~any(strcmp(listfonts, fontName))
    fontName = 'Arial';
end

% Portrait figure: width 6 in, height 6.05 in
figure('Color','w','Units','inches','Position',[1 1 6 6.05]);

ax = gca;
ax.FontName = fontName;
ax.FontSize = 16;
box on;
ax.LineWidth = 1;
ax.Layer = 'top';
grid off;

% -------------------- LEFT axis: Detectivity --------------------
yyaxis left
hDline = plot(xq, Dq, '-', 'LineWidth', 2.5); hold on;
hDpts  = plot(wavelength, detectivity, 'o', 'LineWidth', 1.5, ...
              'MarkerSize', 6, 'LineStyle', 'none');
ylabel('Detectivity, D^* (cm Hz^{1/2} W^{-1})', ...
       'FontName', fontName, 'FontSize', 20);

% -------------------- RIGHT axis: Noise current --------------------
yyaxis right
hNline = plot(xq, Nq, '-', 'LineWidth', 2); hold on;
hNpts  = plot(wavelength, i_n, 's', 'LineWidth', 1.2, ...
              'MarkerSize', 6, 'LineStyle', 'none');
ylabel('Noise current, i_n (A)', ...
       'FontName', fontName, 'FontSize', 20);

% -------------------- X label / limits --------------------
xlabel('Wavelength (\mum)', 'FontName', fontName, 'FontSize', 20);
xlim([3 8]);

% -------------------- Legend --------------------
lgd = legend([hDline hNline], ...
    {'Detectivity, D^*', 'Noise current, i_n'}, ...
    'Location','north', 'FontSize', 12, 'NumColumns', 1);
lgd.FontName = fontName;

% -------------------- Export (vector PDF) --------------------
set(gcf,'Renderer','painters');
exportgraphics(gcf, 'Detectivity_and_Noise_6x6_05.pdf', ...
               'ContentType', 'vector');
