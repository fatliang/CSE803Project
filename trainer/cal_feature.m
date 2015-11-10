function [bValid hist segment_img] = cal_feature(img,mask,array_segment,ind)
%return the feature histogram of region array_segment(ind) and the segment
%image
%bValid returns whether the region is valid
size_img = size(img);
threshold = size_img(1)*size_img(2)/40;
segment = (mask == array_segment(ind));
area = sum(sum(segment));

if area < threshold || array_segment(ind) == 0
    bValid = 0;
    hist = [];
    segment_img = zeros(size_img);
    return;
end

bValid = 1;
%do closing
segment = dilate(segment,5);
segment = erode(segment,5);

%calculate histogram
hist = cal_feature_hist(img,segment);
%show the image
segment_img = zeros(size_img);
for i = 1:size_img(1)
    for j = 1:size_img(2)
        if segment(i,j) == 1
            segment_img(i,j,:) = img(i,j,:);
        end
    end
end
segment_img = uint8(segment_img);
