%test of sift
%detect the key points of the whole image then use mask to exclude
%locations that are not in the target area
path(path,'../../func/');
path(path,'../');
tmp_filename = 'segment.jpg';
img = imread('app.jpg','jpg');
size_img = size(img);
scale_factor = sqrt(1e5/(size_img(1)*size_img(2)));
img = imresize(img,min(scale_factor,1));
size_img = size(img);
%segmentation
mask = doSegmentation(img);
array_segment = unique(mask);

threshold = size_img(1)*size_img(2)/40;
%calculate the sift of each region
for i = 1:length(array_segment)
    segment = (mask == array_segment(i));
    area = sum(sum(segment));
    if area > threshold && array_segment(i) ~= 0
        segment = dilate(segment,11);
        segment = erode(segment,11);
        segment_img = zeros(size_img);
        for i = 1:size_img(1)
            for j = 1:size_img(2)
                if segment(i,j) == 1
                    segment_img(i,j,:) = img(i,j,:);
                end
            end
        end
        segment_img = uint8(segment_img);
        imshow(segment_img);
        imwrite(segment_img,tmp_filename,'jpg');
        [im, des, loc] = sift('app.jpg');
        segment_mark = mark_keypoints(segment_img,loc);
        imshow(segment_mark);
    end
end