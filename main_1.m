clear all;
close all;
clc;
%%
[F,P]=uigetfile('.jpg');
I=imread(strcat(P,F));
[m n z]=size(I);
if z==3
    I=rgb2gray(I);
end
imshow(I);
title('Gray Image')
pause(.5)
%%
blur_filter=fspecial('gaussian',[12 12],2);
I_blurred=imfilter(I,blur_filter,'replicate','conv');
I_mask=I-I_blurred;
k=1;
I_enhanced=I+k*I_mask;
I_enhanced(find(I_enhanced<0))=0;
I_enhanced(find(I_enhanced>255))=255;
imagesc(I_enhanced,[0 255]);
title('Enhanced Image');
I=I_enhanced;pause(.5)
%% STEP:
% SEGMENTATION
threshold = graythresh(I);
BW1=im2bw(I,threshold); 
% BW1=im2bw(I,0.67);
BW1=1-BW1; 
imshow(BW1);
title('Segmented Image');
pause(.5)
%%
isBlack = (BW1 == 0);
numBlack = sum(isBlack);
numPix   = size(isBlack,1);
denBlack = numBlack/numPix;
plot(denBlack);title('PIXEL DISTRIBUTION')
pause(.5)
%% STEP:4
% Noise Removal
BW1 = bwlabel(BW1,4);
BW1 = bwareaopen(BW1,10);
imshow(BW1)
title ('Noise Removed Image (areaopen)')
pause(.5)
%
% Morphological operations on binary images
BW1=bwmorph(BW1, 'clean');
imshow(BW1);
title('noise removed Image')
pause(.5)
%
% Edge detect using mask
edgeFilter=[-1 -1 -1 ; -1 8 -1 ; -1 -1 -1];
edgeFilter=[-1 -1 -1 ; -1 8 -1 ; -1 -1 -1];
I2=imfilter(BW1, edgeFilter);
imshow(I2);
title('EDGE DETECTION');
pause(.5)
%%
% Convert matrix to grayscale image
BW1=mat2gray(BW1); 
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(BW1), hy, 'replicate');
Ix = imfilter(double(BW1), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
imshow(gradmag,[]);
title('Gradient Magnitude');
pause(.5)
%%
L = watershed(gradmag);
Lrgb = label2rgb(L);
imshow(Lrgb);
title('Watershed transform');
pause(.5)
%%
imshow(uint8(L))
title('SEGMENTED IMAGE');
pause(.5)