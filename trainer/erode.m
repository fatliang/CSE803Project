function res = erode(img, side_length)
%erode the binary image img
%side_length should be odd
%filter_box = ones(side_length, side_length);
size_img = size(img);
side_length_half = (side_length-1)/2;
img = [ones(side_length_half, size_img(2));img;ones(side_length_half, size_img(2))];
img = img';
img = [ones(side_length_half, size_img(1)+2*side_length_half);img;ones(side_length_half, size_img(1)+2*side_length_half)];
img = img';
res = zeros(size_img);
for i = 1:size_img(1)
    for j = 1:size_img(2)
       res(i,j) = prod(prod(img(i:i+side_length-1,j:j+side_length-1)));
    end
end
res = logical(res);