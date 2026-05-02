% =========================================================================
% 16-QAM Simulation and BER Analysis (From Scratch)
% =========================================================================

clc; clear; close all;

% Add functions folder to path
addpath('functions');

%% 1. Simulation Parameters
N = 1000000;         % Total number of bits to transmit (must be multiple of 4)
SNR_dB = 0:1:15;     % Signal-to-Noise Ratio range in dB
M = 16;              % Modulation order
k = log2(M);         % Bits per symbol (4 for 16-QAM)

%% 2. Data Generation
% Generate random binary data
dataBits = randi([0 1], 1, N);

%% 3. Modulation
% Map bits to complex 16-QAM symbols
[txSymbols, Ps] = qam16_modulator(dataBits);

%% 4. Channel (AWGN) and Receiver
BER = zeros(1, length(SNR_dB)); % Array to store Bit Error Rates
rxSymbols_plot = [];            % Array to store symbols for the scatter plot

for i = 1:length(SNR_dB)
    
    % --- Add AWGN Noise ---
    rxSymbols = add_awgn_noise(txSymbols, Ps, SNR_dB(i), k);
    
    % Save noisy symbols for SNR = 10 dB to plot later
    if SNR_dB(i) == 10
        rxSymbols_plot = rxSymbols;
    end
    
    % --- Demodulation ---
    rxBits = qam16_demodulator(rxSymbols, N, k);
    
    % --- Error Analysis ---
    % Calculate Bit Error Rate (BER)
    errors = sum(dataBits ~= rxBits);
    BER(i) = errors / N;
    
end

%% 5. Visualization

% Plot 1: Constellation Diagram
figure('Name', '16-QAM Constellation', 'Color', 'w');
% Plot only first 5000 points to avoid graphical lag
plot(real(rxSymbols_plot(1:5000)), imag(rxSymbols_plot(1:5000)), 'b.', 'MarkerSize', 4);
hold on;
% Plot ideal symbols
[idealI, idealQ] = meshgrid([-3, -1, 1, 3], [-3, -1, 1, 3]);
plot(idealI(:), idealQ(:), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
title('16-QAM Received Signal (SNR = 10 dB)');
xlabel('In-Phase (Real Axis)');
ylabel('Quadrature (Imaginary Axis)');
legend('Noisy Signal', 'Ideal Symbols', 'Location', 'best');
grid on; axis square; axis([-5 5 -5 5]);

% Plot 2: BER vs SNR Logarithmic Curve
figure('Name', 'BER Curve', 'Color', 'w');
semilogy(SNR_dB, BER, 'bo-', 'LineWidth', 2, 'MarkerSize', 6, 'MarkerFaceColor', 'b');
title('16-QAM Bit Error Rate (BER) Curve');
xlabel('SNR (dB)');
ylabel('BER (Bit Error Rate)');
grid on;
set(gca, 'YScale', 'log'); 
axis([min(SNR_dB) max(SNR_dB) 1e-5 1]);