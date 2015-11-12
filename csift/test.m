%test
path(path,'../func/');
[des loc] = csift('app.jpg');
img = imread('app.jpg');
size_img = size(img);
img_marked = mark_keypoints(img,loc,ones(size_img(1:2)));
imshow(img_marked);