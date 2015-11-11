clear all
path(path, '../sift/');
path(path, '../func/');
samplePath = './samples/';
dataPath = './data/';
className = 'Apple';
tmpFileName = 'scaledImg.jpg';
classDir = [samplePath className '/'];
classDataDir = [dataPath className '/'];
fileList = dir(classDir);
numFile = length(fileList);

for i = 1:numFile
  file = fileList(i);
  if file.isdir ~= 1
    fileName = file.name;
    filePath = [classDir fileName];
    img = imread(filePath);
    size_img = size(img);
    scale_factor = sqrt(1e5/(size_img(1)*size_img(2)));
    img = imresize(img,min(scale_factor,1));
    imwrite(img,tmpFileName,'jpg');
    [im, des, loc] = sift(tmpFileName);
    img_mark = mark_keypoints(img,loc);
    imshow(img_mark);
    dataFileName = [classDataDir fileName '.mat'];
    save(dataFileName, 'des', 'className');       
  end
end
