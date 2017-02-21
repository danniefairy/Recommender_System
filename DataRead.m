function d = DataRead(filename)

data = load(filename);
m = size(data);
d = zeros(943,1682);

for i=1:m(1)
    d(data(i,1),data(i,2)) = data(i,3);
    
end

end