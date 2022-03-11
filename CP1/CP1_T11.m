%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = 100;
total = 0;
out=[];
for i = 1
    for j = 1 : A(i)
        x = r.rand(1)
        y = r.rand(1)
        if y < x^2
            total = total + 1
        end
    end
    out(1, i) = total/A(i)*(1);
end

out
save CP1_T11.dat out -ascii