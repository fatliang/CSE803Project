function res = mark_keypoints(img,loc,mask)
size_loc = size(loc);
size_img = size(img);
res = img;
loc = round(loc);
for i = 1:size_loc(1)
  if loc(i,1) > 0 && loc(i,2) > 0 && loc(i,1) <= size_img(1) && loc(i,2) <= size_img(2) && mask(loc(i,1),loc(i,2)) == 1   
    res(loc(i,1)-1:loc(i,1)+1,loc(i,2)-1:loc(i,2)+1,1:3) = 255 * zeros(3,3,3);
  end
end
res = uint8(res);