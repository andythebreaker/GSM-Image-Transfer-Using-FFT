function y=ft3d2(x)
tmp(:,:,1) = fftd2(x(:,:,1));
tmp(:,:,2) = fftd2(x(:,:,2));
tmp(:,:,3) = fftd2(x(:,:,3));
y=tmp;
end