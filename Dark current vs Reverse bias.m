%% IV curve: current converted from A to nA and plotted vs voltage

% Voltage data (V)
V = [ ...
    0.0000  1.0000  2.0000  3.0000  4.0000  5.0000  6.0000  7.0000  8.0000  9.0000 ...
   10.0000 11.0000 12.0000 13.0000 14.0000 15.0000 16.0000 17.0000 18.0000 19.0000 20.0000];

% Current data (A)
I = [ ...
    2.1773e-8  2.5397e-8  2.6052e-8  2.4893e-8  2.9338e-8  2.5542e-8 ...
    3.1633e-8  3.1133e-8  3.3268e-8  3.7543e-8  4.2309e-8  4.7733e-8 ...
    4.6901e-8  5.6764e-8  6.7446e-8  7.2532e-8  8.0575e-8  9.3877e-8 ...
    1.1063e-7  1.3230e-7  1.6054e-7];

% Convert current from A to nA
I_nA = I * 1e9;   % 1 A = 1e9 nA

% Plot I (nA) vs V
figure;
plot(V, I_nA, 'o-', 'LineWidth', 1.8);
grid on;

% Make axes tick labels bigger
set(gca, 'FontSize', 16, 'FontWeight', 'bold');   % axes numbers

% Axis labels and title with bigger, bold font
xlabel('Reverse Bias (V)', 'FontSize', 18, 'FontWeight', 'bold');
ylabel('Dark Current (nA)', 'FontSize', 18, 'FontWeight', 'bold');

