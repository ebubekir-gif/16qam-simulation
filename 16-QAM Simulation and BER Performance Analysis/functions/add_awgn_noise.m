function rxSymbols = add_awgn_noise(txSymbols, Ps, SNR_dB, k)
    % ADD_AWGN_NOISE Adds Additive White Gaussian Noise to a complex signal.
    %
    % Inputs:
    %   txSymbols - Complex transmitted symbols
    %   Ps        - Average signal power
    %   SNR_dB    - Desired Signal-to-Noise Ratio in dB
    %   k         - Number of bits per symbol
    % Outputs:
    %   rxSymbols - Noisy received symbols
    
    numSymbols = length(txSymbols);
    
    % Convert SNR from dB to linear scale
    SNR_lin = 10^(SNR_dB / 10);
    
    % Calculate noise variance (N0)
    N0 = Ps / (SNR_lin * k);
    
    % Generate complex Gaussian noise
    noise = sqrt(N0/2) * (randn(1, numSymbols) + 1j * randn(1, numSymbols));
    
    % Add noise to the transmitted signal
    rxSymbols = txSymbols + noise;
end