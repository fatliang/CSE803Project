%cluster
Num_cluster = 200;
fileDir = '../collector/data/';
classList = {'Apple','Banana','Broccoli','Burger','Frenchfry','Pasta','Pizza','Salad'};
Num_class = length(classList);
des_sift = [];

%first sift
for i = 1:Num_class
   dirPath = [fileDir char(classList(i)) '/sift/'];
   fileList = what(dirPath);
   fileList = fileList.mat;
   
   for j = 1:length(fileList)
       fileName = fileList(j);
       filePath = [dirPath char(fileName(1))];
       load(filePath);
       des_sift = [des_sift; des];
   end
   
end

[idx center sumDist Dist] = kmeans(des_sift,Num_cluster);
