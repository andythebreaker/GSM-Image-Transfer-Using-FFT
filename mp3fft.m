clc;clear;close all;
% Specify the path to your MP3 file
mp3FilePath = 'c.mp3';

% Read the MP3 file
[y_2ch, Fs] = audioread(mp3FilePath);

%we are using only L audio ch
y=y_2ch(:,1);

% Take the FFT of the audio signal
Y = fftp3(y);

% Compute the frequency axis
N = length(Y); % Length of the FFT
f = (0:N-1)*(Fs/N); % Frequency range

% Compute the phase spectrum
phase = angle(Y);

% Plot the frequency spectrum
figure;
plot(f, abs(Y));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum');
figure;
plot(f, 20*log(abs(Y)));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum');

% Plot the phase spectrum
figure;
plot(f, phase);
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('Phase Spectrum');
