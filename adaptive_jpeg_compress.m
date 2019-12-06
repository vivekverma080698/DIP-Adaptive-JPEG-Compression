function [ quantansied_img, Q_mat_img ] = adaptive_jpeg_compress( img )
% std_decom  = std_jpeg_compress_decompress( img );

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

quantansied_img = zeros(m,n);
Q_mat_img = zeros(m,n);

for i = 1:8:m
    for j = 1:8:n
        subimage = img(i:i+8-1,j:j+8-1);
        dct = dct2(subimage);
        DCTvalue = dct;
        min_dct = min(DCTvalue(:));
        max_dct = max(DCTvalue(:)) ;      
        DCTvalues = double(randi([int8(min_dct),int8(max_dct)],8,8));

        init_Q = Q_matrix;
        testV = cell(11,1);
        testV{1} = (init_Q)-5;
        testV{2} = (init_Q)-4;
        testV{3} = (init_Q)-3;
        testV{4} = (init_Q)-2;
        testV{5} = (init_Q)-1;
        testV{6} = (init_Q);
        testV{7} = (init_Q)+5;
        testV{8} = (init_Q)+4;
        testV{9} = (init_Q)+3;
        testV{10} = (init_Q)+2;
        testV{11} = (init_Q)+1;

        AMSE1 = zeros(11,1);
        for k = 1:11
            AMSE1(k) = sum(sum((DCTvalues./testV{k} - DCTvalues./Q_matrix).^2));
        end
        [~,ind1] = max(AMSE1);
        NQdash = testV{ind1};

        AMSE2 = zeros(11,1);
        for k = 1:11
            AMSE2(k) = sum(sum((DCTvalues./NQdash - DCTvalues./testV{k}).^2));
        end
%         
        minv= 200000;
        for k = 1:11
            if(AMSE2(k) < minv)
                minv = AMSE2(k);
                ind2 = k;
            end
        end
        
%        [~,ind2] = min(AMSE2);
        
        NQ = testV{ind2};
        quantised_subimage = dct./NQ;
        
        quantised_subimage = round(quantised_subimage);
        quantansied_img(i:i+8-1,j:j+8-1) = quantised_subimage;
        Q_mat_img(i:i+8-1,j:j+8-1 ) = NQ;

    end
end
%decompressed = (int16(decompressed)+128);
end

