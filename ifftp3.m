function x = ifftp3(y)
    N = length(y);
    k = iwary(N);
    x = (1/N) * k' * y; % Transpose k and divide by N
end