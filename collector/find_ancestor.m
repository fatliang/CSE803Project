function res = find_ancestor(p,i)
%find the ancestor of i in p
if length(p) < i
  res = 0;
else
  while (p(i) ~= i)
    i = p(i);
  end
  res = i;
end