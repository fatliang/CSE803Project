%the trainer program
path(path,'../func/');
path(path,'../libsvm/');
fileDir = '../collector/data';
fileList = what(fileDir);
fileList = fileList.mat;
data = [];
labels = {};
for i = 1:length(fileList)
  fileName = fileList(i);
  filePath = [fileDir '/' char(fileName(1))];
  load(filePath);
  data = [data; hist];
  labels{i} = name;
end

labels_binary = convert_label(labels,'Apple');
labels_binary = labels_binary';
SVMApple = svmtrain(labels_binary,data,'-t 7 -b 1 -g 1');
%SVMApple = fitcsvm(data,labels,'KernelFunction','rbf','Standardize',true,'ClassNames',{'Reject','Apple'});

%test
img = imread('Banana21.jpg','jpg');
%preprocessing
size_img = size(img);
scale_factor = sqrt(1e5/(size_img(1)*size_img(2)));
img = imresize(img,min(scale_factor,1));
size_img = size(img);
%segmentation
mask = doSegmentation(img);
array_segment = unique(mask);

for i = 1:length(array_segment)
  [bValid hist_feature segment_img] = cal_feature(img,mask,array_segment,i);
  if bValid == 1
      [label_rec, accuracy, prob] = svmpredict(0,hist_feature, SVMApple);
      label_rec
      imshow(segment_img);
  end
end


