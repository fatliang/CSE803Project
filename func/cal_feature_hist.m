function res = cal_feature_hist(img,mask)
%calculate the feature histogram of the region specified by mask
%currently, the feature only includes 8 bit color and 8 bit LBP
%
size_img = size(img);
res = zeros(1,2^16);
img_gray = rgb2gray(img);
for i = 2:size_img(1)-1
  for j = 2:size_img(2)-1
    %
    if mask(i,j) == 1
        %color
        %color_bi = convert_color(img(i,j,:));
        color_bi = de2bi(img_gray(i,j));
        %LBP
        pos = [i-1,j-1;i-1,j;i-1,j+1;i,j+1;i+1,j+1;i+1,j;i+1,j-1;i,j-1];
        neighbors = [];
        for k = 1:length(pos)
           neighbors = [neighbors, img_gray(pos(k,1),pos(k,2))];
        end
        LBP_bi = neighbors(end:-1:1) > img_gray(i,j);
        %feature
        %feature_bi = [uint32(LBP_bi), uint32(color_bi)];
        feature_bi = [uint32(LBP_bi)];
        feature = bi2de(feature_bi);
        res(feature) = res(feature+1)+1;
    end
  end
end
res = res/sum(res);
%for test
% figure();
% plot(res);
%

function res = convert_color(pixel,n_r,n_g,n_b)
%return the binary expression
%4 bit r, 4 bit g, 4 bit b
r_bi = de2bi(pixel(1),8);
g_bi = de2bi(pixel(2),8);
b_bi = de2bi(pixel(3),8);
%mix_bi = [r_bi(8:-1:8-n_r+1);g_bi(8:-1:8-n_g+1);b_bi(8:-1:8-n_b+1)];
%mix_bi = reshape(mix_bi,1,prod(size(mix_bi)));
mix_bi = [];
for i = 1:max([n_r,n_g,n_b])
  if i <= n_r
    mix_bi = [mix_bi, r_bi(8-i+1)];
  end
  
  if i <= n_g
    mix_bi = [mix_bi, g_bi(8-i+1)];
  end
  
  if i <= n_b
    mix_bi = [mix_bi, b_bi(8-i+1)];
  end
end

mix_bi = mix_bi(end:-1:1);
res = mix_bi;