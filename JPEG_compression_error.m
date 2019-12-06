function [ error ] = JPEG_compression_error(img1, img2 )
    % Size of image
    [m,n] = size(img1);
    % Calculate the difference image
    error = img1-img2;
    % Calculate square error
    error = error.^2;
    % Calculate total error sum
    error = sum(sum(error));
    % calculate mean error
    error = error/(m*n); 
end

