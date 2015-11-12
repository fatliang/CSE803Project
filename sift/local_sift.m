function res = local_sift(des,loc,mask)
size_loc = size(loc);
size_img = size(mask);
loc = round(loc);
res = [];
for i = 1:size_loc(1)
  if loc(i,1) > 0 && loc(i,2) > 0 && loc(i,1) <= size_img(1) && loc(i,2) <= size_img(2) && mask(loc(i,1),loc(i,2)) == 1   
    res = [res; des(i,:)];
  end
end