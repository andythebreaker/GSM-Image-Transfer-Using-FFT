%=====================================================================
% Programmer: andythebreaker
% E-mail: e24074724@mail.ncku.edu.tw
% Date: 2023/05/28
%========================================================================
clc;clear;
close all;
addpath(genpath(pwd))

%% Load image  and add noise
% load clean image
img = imread('lena.jpg');
img = im2double(img);

% filter size
r = 20;
% add noise
noise_img = add_noise(img,r); 

%figure();
%subplot(1,2,1),imshow(img);title('original image')
%subplot(1,2,2),imshow(noise_img);title('noisy image')

%% Fourier transform the original image
F_oriimg(:,:,1) = fftd2(img(:,:,1));
F_oriimg(:,:,2) = fftd2(img(:,:,2));
F_oriimg(:,:,3) = fftd2(img(:,:,3));
% center shift (You can read Section: Periodicity and Center shifting)
F_orimg = fftshift(F_oriimg); 
% for displaying the power part by log scale
log_FToriimg = log(1+abs(F_orimg)); 
% normalize the power to 0-1
log_FToriimg = mat2gray(log_FToriimg); 

%figure();
%subplot(2,2,1),imshow(log_FToriimg);title('log FT original image')

%% Implement Fourier transform on noisy images
F_img = fft2(noise_img);
F_mag = fftshift(F_img);
log_FTimage = log(1+abs(F_mag));
log_FTimage = mat2gray(log_FTimage);

%figure();
%subplot(1,2,1),imshow(img);title('original image')
%subplot(1,2,2),imshow(noise_img);title('noisy image')
%figure();
%subplot(2,2,1),imshow(log_FToriimg);title('log FT original image')
%subplot(2,2,2),imshow(log_FTimage);title('log FT noisy image')

%% Creat a filter
% get the size of the input image
[m, n, z] = size(img); 
% create a rectangular filter at center
filter = zeros(m,n);
filter(r:m-r,r:n-r) =1;

%subplot(2,2,3),imshow(filter,[]);title('filter')

%% Filter out the denoised image
% FT image .* the filter
fil_img = F_mag.*filter; 

log_fil_img = log(1+abs(fil_img));
log_fil_img = mat2gray(log_fil_img);

%subplot(2,2,4),imshow(log_fil_img);title('after filter FT image')

%% Inverse Fourier transform
% unshift
fil_img = ifftshift(fil_img); 
% display the denoised image
result = real(ifft2(fil_img)); 
result = mat2gray(result);
%figure();
%subplot(1,2,1),imshow(noise_img);title('noisy image')
%subplot(1,2,2);imshow(result,[]);title('denoised image')

figure();
subplot(2,4,1),imshow(img);title('original image')
subplot(2,4,2),imshow(noise_img);title('noisy image')
%figure();
subplot(2,4,3),imshow(log_FToriimg);title('log FT original image')
subplot(2,4,4),imshow(log_FTimage);title('log FT noisy image')
subplot(2,4,5),imshow(filter,[]);title('filter')
subplot(2,4,6),imshow(log_fil_img);title('after filter FT image')
%figure();
subplot(2,4,7),imshow(noise_img);title('noisy image')
subplot(2,4,8);imshow(result,[]);title('denoised image')
