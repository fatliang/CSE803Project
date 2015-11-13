%jseg segmentation
function res = jseg(img_path)
cmd = ['segwin -i ' img_path ' -t 6 -o tmp.jseg.jpg 0.8 -r9 tmp.jseg.map.gif -m 0.92 -q 600'];
[stat, res] = system(cmd)
disp(stat);
disp(res);
res = imread('tmp.jseg.map.gif','gif');
