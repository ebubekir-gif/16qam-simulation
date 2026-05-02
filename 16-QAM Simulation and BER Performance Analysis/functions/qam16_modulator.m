function [txSymbols, Ps] = qam16_modulator(dataBits)
    % QAM16_MODULATOR Maps binary data to 16-QAM symbols using Gray coding.
    % 
    % Inputs:
    %   dataBits - 1D array of binary data (0s and 1s)
    % Outputs:
    %   txSymbols - 1D array of complex 16-QAM symbols
    %   Ps        - Average signal power
    
    k = 4; % Bits per symbol
    N = length(dataBits);
    
    % Reshape bits into 4-bit columns.
    % Bits 1 & 2 -> In-Phase (I), Bits 3 & 4 -> Quadrature (Q)
    bitMatrix = reshape(dataBits, k, N/k);
    
    % Look-Up Table (LUT) for Gray mapping
    % [0 0]-> -3 | [0 1]-> -1 | [1 0]-> 3 | [1 1]-> 1
    lut = [-3, -1, 3, 1]; 
    
    % Convert binary pairs to decimal indices (1 to 4)
    idxI = 2 * bitMatrix(1,:) + bitMatrix(2,:) + 1;
    idxQ = 2 * bitMatrix(3,:) + bitMatrix(4,:) + 1;
    
    % Map to ideal amplitudes
    symI = lut(idxI);
    symQ = lut(idxQ);
    txSymbols = symI + 1j * symQ;
    
    % Calculate Average Signal Power
    Ps = mean(abs(txSymbols).^2); 
end