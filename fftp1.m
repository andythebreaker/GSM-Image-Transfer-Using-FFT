function X=fftp1(x)
%x = [0 1 4 9];
N = length(x);
W = exp(-1i * 2 * pi / N);
X = zeros(1, N);

for k = 0:(N - 1)
  for n = 0:(N - 1)
    X(k + 1) = X(k + 1) + x(n + 1) * W^(k * n);
  end
end
end