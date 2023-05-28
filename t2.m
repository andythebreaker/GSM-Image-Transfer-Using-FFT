% Read the noisy image
noisyImage = imread('X.jpg');

% Display the original noisy image
figure;
imshow(noisyImage);
title('Noisy Image');

% Convert the image to double for further processing
noisyImage = im2double(noisyImage);

% Split the image into RGB color channels
redChannel = noisyImage(:,:,1);
greenChannel = noisyImage(:,:,2);
blueChannel = noisyImage(:,:,3);

% Apply FFT to each color channel
redFFT = fft2(redChannel);
greenFFT = fft2(greenChannel);
blueFFT = fft2(blueChannel);

% Shift the zero frequency component to the center of the spectrum
redShifted = fftshift(redFFT);
greenShifted = fftshift(greenFFT);
blueShifted = fftshift(blueFFT);

% Compute the magnitude spectrum of each color channel
redMagSpectrum = abs(redShifted);
greenMagSpectrum = abs(greenShifted);
blueMagSpectrum = abs(blueShifted);

% Compute the logarithm of the magnitude spectrum for visualization
logRedMagSpectrum = log(1 + redMagSpectrum);
logGreenMagSpectrum = log(1 + greenMagSpectrum);
logBlueMagSpectrum = log(1 + blueMagSpectrum);

% Display the magnitude spectrum of each color channel
figure;
subplot(1,3,1), imshow(logRedMagSpectrum, []);
title('Red Channel');
subplot(1,3,2), imshow(logGreenMagSpectrum, []);
title('Green Channel');
subplot(1,3,3), imshow(logBlueMagSpectrum, []);
title('Blue Channel');

% Threshold the magnitude spectrum of each color channel to remove noise
threshold = 0.0001 * max(redMagSpectrum(:));
redFilteredSpectrum = redMagSpectrum .* (redMagSpectrum > threshold);
greenFilteredSpectrum = greenMagSpectrum .* (greenMagSpectrum > threshold);
blueFilteredSpectrum = blueMagSpectrum .* (blueMagSpectrum > threshold);

% Create copies of the shifted images with filtered spectra
redFilteredShifted = redShifted .* (redMagSpectrum > threshold);
greenFilteredShifted = greenShifted .* (greenMagSpectrum > threshold);
blueFilteredShifted = blueShifted .* (blueMagSpectrum > threshold);

% Shift the filtered spectra back to the original positions
redFilteredImage = ifftshift(redFilteredShifted);
greenFilteredImage = ifftshift(greenFilteredShifted);
blueFilteredImage = ifftshift(blueFilteredShifted);

% Compute the inverse FFT to obtain the denoised color channels
redDenoised = real(ifft2(redFilteredImage));
greenDenoised = real(ifft2(greenFilteredImage));
blueDenoised = real(ifft2(blueFilteredImage));

% Merge the denoised color channels to form an RGB image
denoisedImage = cat(3, redDenoised, greenDenoised, blueDenoised);

% Display the denoised image
figure;
imshow(denoisedImage);
title('Denoised Image');
