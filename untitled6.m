B = imread('8.jpg');
A=rot90(B);
%A=B;
[L,N] = superpixels(A,50);
BW = boundarymask(L);
L=onewaymg(L,BW);
imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',67)
outputImage = zeros(size(A),'like',A);
idx = label2idx(L);
numRows = size(A,1);
numCols = size(A,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    outputImage(redIdx) = mean(A(redIdx));
    outputImage(greenIdx) = mean(A(greenIdx));
    outputImage(blueIdx) = mean(A(blueIdx));
end
figure
imshow(outputImage,'InitialMagnification',67)