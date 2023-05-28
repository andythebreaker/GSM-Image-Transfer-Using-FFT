x = [8 4 6 7 0 4];  % Input array
lower_bound = -0.4;  % Lower bound of the desired range
upper_bound = 0.4;   % Upper bound of the desired range

% Mapping calculation
min_x = min(x);
max_x = max(x);
mapped_x = ((x - min_x) / (max_x - min_x)) * (upper_bound - lower_bound) + lower_bound;

% Plotting
figure;
hold on;
plot(x, 'b', 'LineWidth', 2);
plot(mapped_x, 'r', 'LineWidth', 2);
hold off;

legend('Original x', 'Mapped x');
xlabel('Index');
ylabel('Value');
title('Mapping of x to -0.4~+0.4');
grid on;
