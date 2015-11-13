function [mask centers radii] = circle_seg(img)
%segment the image by circle detection
size_img = size(img);
size_mask = size_img(1:2);
rad_max = round(min(size_img(1:2))/2);
rad_min = round(rad_max/2);
[centers,radii] = imfindcircles(img,[rad_min rad_max],'ObjectPolarity','dark','Sensitivity',0.98);
num_regions = length(radii);
if num_regions == 0
  mask = ones(size_mask);
  return;
end
mask = zeros(size_mask);
for i = 1:size_mask(1)
  for j = 1:size_mask(2)
    %determine the region pixel (i,j) belongs to
    %closest center
    dist_min = 1;
    ind_min = 0;
    for k = 1:num_regions;
        dist = sqrt(sum(([j,i]-centers(k,:)).^2))/radii(k);
        if dist < 1 && dist < dist_min
            dist_min = dist;
            ind_min = k;
        end
    end
    mask(i,j) = ind_min;
  end
end