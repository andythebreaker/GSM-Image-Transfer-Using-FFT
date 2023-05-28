function [output] = add_noise(input,r)
    [m, n, z] = size(input);
        %% FT image
    F_img = fft2(input);
    F_mag = fftshift(F_img);
    
        %% Creat a filter
    filter_1 = zeros(m,n);
    r = r-2;
    filter_1(r:m-r,r:n-r) =1;  % create circle filter and center it
    
        %% Add noise
    noise_fil = filter_1+1 ==1;

    rng(1)
    noise = 500*rand(m,n); 
    noise_fil = noise.*noise_fil;
    F_mag = F_mag + noise_fil;
    
        %% IFT image
    fil_img = ifftshift(F_mag);
    result = real(ifft2(fil_img)); 
    output = real(result);
end