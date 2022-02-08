function F=fitness(x)
F=0;
for i=1:30
    F=F+x(i)^2;
end