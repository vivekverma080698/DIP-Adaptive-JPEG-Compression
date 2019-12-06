function [ decompressed ] = adaptive_jpeg_decompress( quantised, Q_mat_image )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

    [m,n] = size(quantised);
    decompressed = zeros(m,n);
    
    for i=1:8:m
        for j=1:8:n
            decompressed_subimage = quantised(i:i+8-1,j:j+8-1).*Q_mat_image(i:i+8-1,j:j+8-1);
            decompressed(i:i+8-1,j:j+8-1) = idct2(decompressed_subimage);
        end
    end
decompressed = (int16(decompressed)+127);
end

