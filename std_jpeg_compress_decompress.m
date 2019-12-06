function [ std_decom ] = std_jpeg_compress_decompress( img )
img = img - 127;
[m,n] = size(img);
Q_matrix = [    16, 11, 10, 16, 24, 40, 51, 61 ;
                12, 12, 14, 19, 26, 58, 60, 55 ;
                14, 13, 16, 24, 40, 57, 69, 56 ;
                14, 17, 22, 29, 51, 87, 80, 62 ;
                18, 22, 37, 56, 68, 109, 103, 77 ;
                24, 35, 55, 64, 81, 104, 113, 92 ;
                49, 64, 78, 87, 103, 121, 120, 101 ;
                72, 92, 95, 98, 112, 100, 103, 99   ];

std_decom = zeros(m,n);

for i = 1:8:m
    for j = 1:8:n
        std_decom(i:i+8-1,j:j+8-1) = img(i:i+8-1,j:j+8-1);
        std_decom(i:i+8-1,j:j+8-1) = dct2(std_decom(i:i+8-1,j:j+8-1));
        std_decom(i:i+8-1,j:j+8-1) = std_decom(i:i+8-1,j:j+8-1)./Q_matrix;
        std_decom(i:i+8-1,j:j+8-1) = round(std_decom(i:i+8-1,j:j+8-1));
        std_decom(i:i+8-1,j:j+8-1) = std_decom(i:i+8-1,j:j+8-1).*Q_matrix;
        std_decom(i:i+8-1,j:j+8-1) = idct2(std_decom(i:i+8-1,j:j+8-1));
    end
end
std_decom = (int16(std_decom)+127);
end

