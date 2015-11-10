function res = dilate(img, side_length)
%img is binary image
%side_length should be odd
img = logical(img);
size_img = size(img);
res = zeros(size_img);
side_length_half = (side_length-1)/2;

img = [zeros(side_length_half, size_img(2));img;zeros(side_length_half, size_img(2))];
img = img';
img = [zeros(side_length_half, size_img(1)+2*side_length_half);img;zeros(side_length_half, size_img(1)+2*side_length_half)];
img = img';

for i = 1:size_img(1)
  for j = 1:size_img(2)
    res(i,j) = (sum(sum(img(i:i+side_length-1,j:j+side_length-1))) > 0);
  end
end
