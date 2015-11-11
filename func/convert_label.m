function res = convert_label(labels,target)
res = strcmp(labels,target);
res = double(res);
res = res*2-1;