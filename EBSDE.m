%% ========================================================================
%           Enhancement of Bernstain-Search Differential Evolution
%            Algorithm to Solve Constrained Engineering Problems
%
%                  Hoda Zamani, Mohammad H. Nadimi-Shahraki
%                   Shokooh Taghian, Mahdis Banaie-Dezfouli
%
%         International Journal of Computer Science Engineering (IJCSE)
%                   ISSN: 2319-7323   Vol. 9 No. 6 Nov-Dec 2020, 386-396
%                         DOI: 10.13140/RG.2.2.16902.40004
%            -----------------------------------------------------------
%                    Source codes developed in MATLAB R2016b
%                                Programmers:
%                 Hoda Zamani, Mohammad-Hossein Nadimi-Shahraki
%                E-Mail: zamanie_hoda@ymail.com,nadimi@ieee.org
%           -----------------------------------------------------------
%  Homepage: https://scholar.google.com/citations?user=sT0YnDIAAAAJ&hl=en
%  Homepage: https://scholar.google.com/citations?user=bpZOZWsAAAAJ&hl=en
% ========================================================================

function [bestP,solP,Convergance]  = EBSDE(N,D,Low,Up,Max_It,fhandle,fnonlin)
if N < 2 || N ~= floor(N), error('N must be an integer greater than or equal to 2.'); end
if D < 1 || D ~= floor(D), error('D must be a positive integer.'); end
if isscalar(Low), Low=repmat(Low,[1 D]); else, Low=reshape(Low,1,[]); end
if isscalar(Up), Up=repmat(Up,[1 D]); else, Up=reshape(Up,1,[]); end
if numel(Low) ~= D || numel(Up) ~= D
    error('Low and Up must be scalars or vectors with D elements.');
end
if any(Low >= Up), error('Every lower bound must be smaller than its upper bound.'); end
p = rand(N,D);
fitP = zeros(1,N);
fitTrial = zeros(1,N);
Convergance = zeros(1,Max_It);
for i = 1 : N
    for j = 1 : D
        p(i,j) = rand .* ( Up(j) - Low(j) ) + Low(j);
    end
    fitP (i)= ObjectiveFun(fhandle,fnonlin,p(i,:));
end
[~,j] = min( fitP );
bestP = p(j,:);
for t = 1 : Max_It
    M = zeros(N,D) ;
    for i = 1 : N, alpha = GetAlpha; u = randperm( D, ceil( alpha * D ) );  M(i,u) = 1;  end
    if rand^3 < rand
        F = rand( 1, D ).^3 .* abs( randn( 1, D ) ) .^ 3 ;
    else
        F = randn( N, 1 ) .^ 3 ;
    end
    while 1, L1 = randperm(N); L2 = randperm(N); if sum( L1 == 1:N, 2)==0 && sum( L1 == L2, 2)==0 && sum( L2 == 1:N , 2 )==0, break; end, end
    %% =Enhancement of Bernstain-Search Differential Evolution Algorithm===
    c1 = 2*exp(-(4*t/Max_It)^2);
    E =2-t*((2)/Max_It);
    %Logistic map
    x(1) = 0.7;
    Value  = 1;
    %Chebyshev map
    for i=1:N
        x(i+1)=cos(i*acos(x(i)));
        G(i,1)=((x(i)+1)*Value)/2;
    end
    Trial = G.*(bestP - p) +  F .*  M .* ( c1 .* E + ( 1 - c1 ) .* bestP + rand(N,D)   - p  ) +  bestP;
    Trial = Bound_Constraint( Trial, Low, Up, N, D );
    
   %% =====================================================================  
    for H = 1:N
        fitTrial (H)= ObjectiveFun(fhandle,fnonlin,Trial(H,:));
    end
    j = fitTrial < fitP;
    fitP(j) = fitTrial(j);
    p(j,:) = Trial(j,:);
    [solP,j] = min(fitP);
    bestP = p(j,:);
    Convergance(t) = solP;
end
end







