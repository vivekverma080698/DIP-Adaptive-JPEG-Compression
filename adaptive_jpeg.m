function [ compressedImg ] = adaptive_jpeg( img )
    [m,n] = size(img);
    % Calculating parameters for padding

    originalImg = img;
        
    padm = 8-mod(m,8);
    padn = 8-mod(n,8);
    if padm == 8
        padm = 0;
    end
    if padn == 8
        padn = 0;
    end

    % forming a new padded image
    img = padarray(img,[padm,padn],0,'post');

    std_compressed = std_jpeg_compress_decompress( img );


    [ quantansied_img, Q_mat_img ] = adaptive_jpeg_compress( img );
    [ compressedImg ] = adaptive_jpeg_decompress( quantansied_img, Q_mat_img );

    std_compressed = std_compressed(1:m,1:n);
    compressedImg = compressedImg(1:m,1:n);
    
    error1 = JPEG_compression_error(originalImg, std_compressed);
    error2 = JPEG_compression_error(originalImg, compressedImg);
    ratio = error1/error2;
    fprintf('Error Ratio :\n std_compression/adaptive compression\n', ratio);
    ratio

    figure;
    subplot(2,3,1)
    imshow(img);
    title('Original image');

    subplot(2,3,2)
    imshow(std_compressed);
    title('Standard quantisation');

    subplot(2,3,3)
    imshow(uint8(originalImg-std_compressed));
    title('Diff between  ORIGINAL and STD-QUANT ');

    subplot(2,3,4)
    imshow(compressedImg);
    title('Adaptive quantisation');

    subplot(2,3,5)
    imshow(uint8(originalImg- compressedImg));
    title('Diff between ORIGINAL and ADA-QUANT ');

    s1 = num2str(error1);
    s2 = num2str(error2);
    s3 = 'original  :';
    s4 = ' adaptive  :';
    s = strcat(s3,s1,s4,s2);
    ax = subplot(2, 3, 6);
    text(0.5,0.5, s);
    set ( ax, 'visible', 'off')

end

