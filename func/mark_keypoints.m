function res = mark_keypoints(img,loc)
size_loc = size(loc);
res = img;
loc = round(loc);
for i = 1:size_loc(1)
  res(loc(i,1)-1:loc(i,1)+1,loc(i,2)-1:loc(i,2)+1,1:3) = 255 * ones(3,3,3);
end
res = uint8(res);