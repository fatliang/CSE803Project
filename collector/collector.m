clear all
path(path, '../sift/');
path(path, '../csift/');
path(path, '../func/');
samplePath = './samples/';
dataPath = './data/';
className = 'Broccoli';
tmpFileName = 'scaledImg.jpg';
classDir = [samplePath className '/'];
classDataDir = [dataPath className '/'];
%
%create folders
mkdir([classDataDir 'sift']);
mkdir([classDataDir 'csift']);
%
fileList = dir(classDir);
numFile = length(fileList);

for i = 1:numFile
  file = fileList(i);
  if file.isdir ~= 1
    fileName = file.name;
    filePath = [classDir fileName];
    filePath
    img = imread(filePath);
    size_img = size(img);
    scale_factor = sqrt(1e5/(size_img(1)*size_img(2)));
    img = imresize(img,min(scale_factor,1));
    imwrite(img,tmpFileName,'jpg');
    
    %sift
    [im, des, loc] = sift(tmpFileName);
    img_mark = mark_keypoints(img,loc,ones(size_img(1:2)));
    imshow(img_mark);
    dataFileName = [classDataDir 'sift/' fileName '_sift' '.mat'];
    save(dataFileName, 'des', 'className');
    
    %csift
    [des_c, loc_c] = csift(tmpFileName);
    dataFileName_c = [classDataDir 'csift/' fileName '_csift' '.mat'];
    save(dataFileName_c, 'des_c', 'className');
  end
end
