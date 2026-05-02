function rxBits = qam16_demodulator(rxSymbols, N, k)
    % QAM16_DEMODULATOR Extracts bits from noisy 16-QAM symbols.
    % It uses vectorized thresholding instead of Euclidean distance for speed.
    %
    % Inputs:
    %   rxSymbols - Complex received (noisy) symbols
    %   N         - Total number of bits
    %   k         - Bits per symbol
    % Outputs:
    %   rxBits    - 1D array of demodulated binary data
    
    numSymbols = N / k;
    
    % Separate Real (In-Phase) and Imaginary (Quadrature) parts
    rxI = real(rxSymbols);
    rxQ = imag(rxSymbols);
    
    % --- I-Axis Demapping ---
    bitsI = zeros(2, numSymbols);
    bitsI(1, rxI >= 0) = 1;       % Decision boundary at 0
    bitsI(2, abs(rxI) < 2) = 1;   % Decision boundaries at -2 and 2
    
    % --- Q-Axis Demapping ---
    bitsQ = zeros(2, numSymbols);
    bitsQ(1, rxQ >= 0) = 1;
    bitsQ(2, abs(rxQ) < 2) = 1;
    
    % Reconstruct the bit matrix and reshape back to a 1D array
    rxBitsMatrix = [bitsI; bitsQ];
    rxBits = reshape(rxBitsMatrix, 1, N);
end