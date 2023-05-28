function X = fftp2(x)
%x = [0 1 4 9];
N = length(x);
W = exp(-1i * 2 * pi / N);
X = zeros(1, N);

k = 0:(N - 1);
n = 0:(N - 1);
[K, N] = meshgrid(k, n);
X = sum(x .* (W .^ (K .* N)), 2);

end