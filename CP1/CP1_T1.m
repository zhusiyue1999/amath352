%%
%

clear all; close all;
r = RandStream('mt19937ar','Seed',1234);
A = [100 1000 10000];
out=[];
for i = 1:3
    total = 0;
    for j = 1 : A(i)
        x = r.rand(1);
        y = r.rand(1);
        if y < x^2
            total = total + 1;
        end
    end
    out(1, i) = total/A(i)*(1);
end

out
save CP1_T1.dat out -ascii