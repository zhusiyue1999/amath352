clear all;
%% task 1
%

n = 11;
SUM = 0;
for i = 1:n
    SUM = SUM + i;
end

save CP0_T1.dat SUM -ascii

%%
%

r = RandStream('mt19937ar','Seed',1234);
A = r.randn(10,10);
out = A(7:10,7:10)
save CP0_T2.dat out -ascii