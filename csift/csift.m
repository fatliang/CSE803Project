function [des loc] = csift(filename)
outputfilename = 'csift_res';
cmd = ['colorDescriptor ' filename ' --detector harrislaplace --descriptor transformedcolorhistogram --outputFormat binary --output ' outputfilename];
system(cmd)
[des loc] = readBinaryDescriptors(outputfilename);
tmp = loc(:,1);
loc(:,1) = loc(:,2);
loc(:,2) = tmp;