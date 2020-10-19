function out=stretch(vector)
vector=double(vector);
% makes vector range from 0 to 1
out=(vector-min(vector(:))) / (max(vector(:)) - min(vector(:)));
end 
