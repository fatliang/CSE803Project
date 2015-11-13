img = imread('fry.jpg');
%img_edge = edge(rgb2gray(img),'canny',[],sqrt(4));
[centers,radii] = imfindcircles(img,[100,300],'ObjectPolarity','dark','Sensitivity',0.98);
close all;
figure();
imshow(img);
h = viscircles(centers,radii);
%figure();
%imshow(img_edge);