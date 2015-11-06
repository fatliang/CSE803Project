function res = connect(p,i,j)
%connect i and j in union find
res = p;
if length(res) < i || length(res) < j
  return;
elseif (find_ancestor(res,i) ~= find_ancestor(res,j))
  res(find_ancestor(res,i)) = find_ancestor(res,j);
end
