% Read the noisy image
noisyImage = imread('X.jpg');

% Convert the image to grayscale if necessary
if size(noisyImage, 3) == 3
    noisyImage = rgb2gray(noisyImage);
end

% Display the original noisy image
figure;
imshow(noisyImage);
title('Noisy Image');

% Convert the image to double for further processing
noisyImage = im2double(noisyImage);

% Apply FFT to the image
fftImage = fft2(noisyImage);

% Shift the zero frequency component to the center of the spectrum
fftShifted = fftshift(fftImage);

% Compute the magnitude spectrum of the shifted image
magSpectrum = abs(fftShifted);

% Compute the logarithm of the magnitude spectrum for visualization
logMagSpectrum = log(1 + magSpectrum);

% Display the magnitude spectrum
figure;
imshow(logMagSpectrum, []);
title('Magnitude Spectrum');
%%
% Threshold the magnitude spectrum to remove noise
threshold = 0.0001 * max(magSpectrum(:));
filteredSpectrum = magSpectrum .* (magSpectrum > threshold);

% Create a copy of the shifted image with filtered spectrum
filteredShifted = fftShifted .* (magSpectrum > threshold);

% Shift the filtered spectrum back to the original position
filteredImage = ifftshift(filteredShifted);

% Compute the inverse FFT to obtain the denoised image
denoisedImage = real(ifft2(filteredImage));

% Display the denoised image
figure;
imshow(denoisedImage);
title('Denoised Image');
