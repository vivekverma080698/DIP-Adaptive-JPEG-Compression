%% An Adaptive JPEG Compression- Encryption System Using Optimized Local Quantization Matrices
%%
%clc;
%clear all;
close all;

img = imread('lenna.png');
img = rgb2gray(img);
%original_img = img;
img = im2int16(img);
% %img = int16(img);
% 
adaptive_jpeg( img );

img = imread('rice.png');
img = rgb2gray(img);
%original_img = img;
img = im2int16(img);
%img = int16(img);
adaptive_jpeg( img );


img = imread('cameraman.tif');
%img = rgb2gray(img);
%original_img = img;
img = im2int16(img);
%img = int16(img);
adaptive_jpeg( img );





% adaptive_jpeg_compress_decompress( img );

% com =  std_jpeg_compress_decompress( img );
% error = JPEG_compression_error(img, com)
% 
% figure;
% subplot(2,2,1)
% imshow(original_img)
% title('original')
% 
% subplot(2,2,2)
% imshow(com)
% title('compress')
% 
% subplot(2,2,3)
% imshow(uint8(img-com))

