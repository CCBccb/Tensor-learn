clear all;clc;

rand('seed',0); randn('seed',0);
N1 = 30; N2 = 30; N3 = 30; N4 = 30; % tensor dimension
R=10; % tensor rank

% randomly generate factor matrices
A_org = max(0,randn(N1,R));
B_org = max(0,randn(N2,R));
C_org = max(0,randn(N3,R));
D_org = max(0,randn(N4,R));

% get tensor M using the above factor matrices
M = ktensor({A_org,B_org,C_org,D_org});
M = arrange(M);
Mtrue = full(ktensor(M));

sn = 60; % signal to noise ratio
% -- add noise --
N = tensor(max(0,randn(N1,N2,N3,N4)));
M = Mtrue + 10^(-sn/20) * norm(Mtrue)*N/norm(N);

opts.maxit = 1000; % max number of iterations
opts.tol = 1e-4; % stopping tolerance
t0 = tic;
[D,A,Out] = ncp(M,R,opts);
time = toc(t0);
H1=D{1};
H2=D{2};
H3=D{3};
M = ktensor({H1,H2,H3});

