%fill connected component by raster scan
%4 connected neighbor
%this algorithm in fact is a variation of union find!!!!!
function res = raster_scan_4(img)
%suppose that img is a binary image
%0 to represent background and 1 for foreground
img_size = size(img);
res = zeros(img_size);
parent = zeros(0);
t = 0;%the counter of different connected components
%scan by each row
for i = 1:img_size(1)
  for j = 1:img_size(2)
    %for the first row
    if i == 1
      if img(i,j) == 1  
        if j > 1 && img(i,j-1) == 1
          res(i,j) = res(i,j-1);
        else
          t = t+1;
          res(i,j) = t;
          parent = [parent,t];
        end
      end
    else
      if img(i,j) == 1
        %first check the upper row
        if img(i-1,j) == 1 || j > 1 && img(i,j-1) == 1
            if img(i-1,j) == 1
              res(i,j) = res(i-1,j);
            else
              res(i,j) = res(i,j-1);
            end
            %union find algorithm
            if j > 1 && img(i,j-1) == 1
               parent = connect_parent(parent,res(i,j), res(i,j-1));
            end
        else
            %none of the upper or left neighbors are foreground
            t = t+1;
            res(i,j) = t;
            parent = [parent,t];
        end
      end
    end
  end
end

for i = 1:img_size(1)
    for j = 1:img_size(2)
      if res(i,j) ~= 0
          res(i,j) = find_ancestor(parent,res(i,j));
      end
    end
end
