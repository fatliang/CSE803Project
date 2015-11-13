function res = merge_region(mask, threshold)
%merge the regions if the circularity of merged region is threshold times greater than both/or either of the individual regions
%mask is the result of connected component analysis

%first re-order the presentation of mask
mask = mask+1;
size_mask = size(mask);
%mask = reorder_region(mask);
%
stats = regionprops('table',mask,'Area','Perimeter');
region_area = stats.Area;
region_perimeter = stats.Perimeter;
region_circu = (region_area*4*pi)./(region_perimeter.^2);

%merge the regions
%find the neighbors of the region with smallest area
while(1)
  [Y, I] = sort(region_area);
  I(Y == 0) = [];
  num_region = length(I);
  %find neighbors of each region
  %only consider the neighbors that are greater than the current idx
  %TODO
  region_neighbor = cell(1,length(Y));
  
  for i = 1:size_mask(1)
    for j = 1:size_mask(2)
          
      if i > 1 && region_area(mask(i-1,j)) > region_area(mask(i,j))
        region_neighbor{mask(i,j)} = [region_neighbor{mask(i,j)}, mask(i-1,j)];
        
      end
      
      if j > 1 && region_area(mask(i,j-1)) > region_area(mask(i,j))
        region_neighbor{mask(i,j)} = [region_neighbor{mask(i,j)}, mask(i,j-1)];
      
      end
      
      if i < size_mask(1) && region_area(mask(i+1,j)) > region_area(mask(i,j))
        region_neighbor{mask(i,j)} = [region_neighbor{mask(i,j)}, mask(i+1,j)];
        
      end
      
      if j < size_mask(2) && region_area(mask(i,j+1)) > region_area(mask(i,j))
        region_neighbor{mask(i,j)} = [region_neighbor{mask(i,j)}, mask(i,j+1)];
 
      end
      
      region_neighbor{mask(i,j)} = unique(region_neighbor{mask(i,j)});
            
    end
  end
  %
  bFlag = 0;
  for i = 1:num_region
    
    ind_cur = I(i);
    
    %find neighbor
    for j = [region_neighbor{ind_cur}]
       if length(j) == 0
         continue;
       end
       region1 = (mask == ind_cur);
       region2 = (mask == j);
       region_merged = region1 + region2;
       stats = regionprops('table',region_merged,'Area','Perimeter');
       circu_merged = stats.Area*4*pi/(stats.Perimeter.^2);
       if circu_merged > 2*region_circu(ind_cur) && 2*circu_merged > region_circu(j)
         %merge the two areas
         mask = mask.*uint8(1-region2) + uint8(region2)*ind_cur;
         bFlag = 1;
         break;
       end
    end
    
    if bFlag == 1
      break;
    end
  end
  
  
  if bFlag == 0
    break;
  end
  
  stats = regionprops('table',mask,'Area','Perimeter');
  region_area = stats.Area;
  region_perimeter = stats.Perimeter;
  region_circu = (region_area*4*pi)./(region_perimeter.^2);

end
res = mask;



function res = reorder_region(mask)

region_idx = unique(mask);
num_region = length(region_idx);
table_idx = zeros(max(region_idx));
for i = 1:num_region
    table_idx(region_idx(i)) = i;
end

size_mask = size(mask);

for i = 1:size_mask(1)
  for j = 1:size_mask(2)
    mask(i,j) = table_idx(mask(i,j));
  end
end
res = mask;

