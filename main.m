%% ======================================================================== 
%           Enhancement of Bernstain-Search Differential Evolution 
%            Algorithm to Solve Constrained Engineering Problems
%
%                  Hoda Zamani, Mohammad H. Nadimi-Shahraki
%                   Shokooh Taghian,Mahdis Banaie-Dezfouli
% 
%         International Journal of Computer Science Engineering (IJCSE)
%                   ISSN : 2319-7323   Vol. 9 No. 6 Nov-Dec 2020, 386-396
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

clear;
clc;
close all;

% Uncomment the next line for a repeatable demonstration.
% rng(1,'twister');
format shortG;
format compact;
fprintf('==================================================================================\n');
fprintf(' Enhancement of Bernstain-Search Differential Evolution Algorithm to Solve Constrained Engineering Problems\n ')
fprintf('                    International Journal of Computer Science Engineering (IJCSE)\n ')                     
fprintf('                        ISSN : 2319-7323   Vol. 9 No. 6 Nov-Dec 2020\n')  
fprintf('                             DOI: 10.13140/RG.2.2.16902.40004\n')
fprintf('               ------------------------------------------------------------------\n');
SearchAgents = 100;     %   Number of search agents
nvars = 4;              %   The number of decision variables 
Max_iteration = 2000;   %   The maximum number of iterations 
%% Parameter Setting
runs  = 30;
lb = [0.1 0.1 0.1 0.1];
ub = [2 10 10 2];
dim = length(lb);
fhandle = @Cost_Function;
fnonlin = @constraint;
fprintf('            The engineering problem name: Welded beam design optimization \n') 
for run = 1:runs

    [EBSDE_gbest,EBSDE_gbestval,EBSDE_Convergance] = EBSDE(SearchAgents,dim,lb,ub,Max_iteration,fhandle,fnonlin);
    fprintf('EBSDE algorithm run = %d, Result = %.12g\n', run, EBSDE_gbestval)
    WBP_EBSDE.Best_score(run) = EBSDE_gbestval;
    WBP_EBSDE.Best_pos(run,:) = EBSDE_gbest;
    WBP_EBSDE.Convergance(run,:) = EBSDE_Convergance;
    save 'WBP_EBSDE_Results'
end
[FinalResult,indx] = min([WBP_EBSDE.Best_score]);
fprintf('--------------------------------------\n');
fprintf('The final result of EBSDE algorithm  = %.12g\n',FinalResult)
fprintf('                               %s\n', datestr(now));
fprintf('==================================================================================\n'); 
Convergance = WBP_EBSDE.Convergance(indx,:);
semilogy(Convergance,'Color','r')
title('Objective space')
xlabel('Iterations');
ylabel('Best score obtained so far'); 
axis tight
grid on
box on
legend('EBSDE algorithm')
 




