function res = doSegmentation(img)

img_edge = edge(rgb2gray(img),'canny',[],sqrt(4));
%do closing
img_edge = dilate(img_edge,5);
img_edge = erode(img_edge,5);
%
res = raster_scan_4(1-img_edge);
