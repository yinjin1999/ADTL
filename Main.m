
% main function of EDMO

% Problem:  the choosed problem       % Algorithm:  the choosed Algorithm
% ft:  the frequence of change        % nt: the severity of change         
% gen: the current generation         % maxgen: the maxcurrent generation  
% N: population size                  % M: the multiobjective number     
% D: the decision vector number       % boundary: the boundary of decision vector  
% runtime: the run time of the whole evolutiotn
% number: the corresponding environment number

cd(fileparts(mfilename('fullpath')));
addpath(genpath(cd));
clc
clear
warning('off')

igd=zeros(21,19);


%testset={'DCF1','DCF2','DCF3','DCF4','DCF5','DCF6','DCF7','DCF8','DCF9','DCF10','DCP1','DCP2','DCP3','DCP4','DCP5','DCP6','DCP7','DCP8','DCP9'};
testset={'DCF5'};
for test=1
    Allsettings.functions=testset{test};

    for i=1:20
        Mode=0;
        % Allsettings.functions={'DCF1','DCF2','DCF3','DCF4','DCF5','DCF6','DCF7','DCF8','DCF9','DCF10','DCP1','DCP2','DCP3','DCP4','DCP5','DCP6','DCP7','DCP8','DCP9'};
                               % 'DCF2','DCF5','DCF7','DCP1','DCP2','DCP3'...                % 动态目标和静态约束 1
                               % 'DCF1','DCF4','DCP4','DCP5','DCP6'...                       % 静态目标和动态约束 2
                               % 'DCF3','DCF6','DCF8','DCF9','DCF10','DCP7','DCP8','DCP9'};  % 动态的目标和约束   3
        %Allsettings.functions ='DCF7';
        Allsettings.T_parameter  = [5 30 1800];    % 5 30 1800    10 30 1800    5 50 3000    10 50 3000                                       
        Allsettings.num_problem  = length(Allsettings.functions);     % length返回数组维度的长度，19
        Allsettings.popSize      = 100;                               % 种群大小为100
        Allsettings.time_rep     = 20;                                % 重复次数 
        Allsettings.dec          = 10;
        Allsettings.fe           = 0;
        Allsettings.maxfe        = (Allsettings.T_parameter(3)+60)*Allsettings.popSize;                  
        Allsettings.MaxIt        = Allsettings.T_parameter(3);                            
        Allsettings.ft           = Allsettings.T_parameter(2);
        Allsettings.nt           = Allsettings.T_parameter(1);
        Allsettings.preEvolution = 60;                                                                          
        Allsettings.maxgen       = Allsettings.preEvolution + 60*Allsettings.ft;
        Allsettings.space        = 100;
        % Allsettings.Problem    = Allsettings.functions{testFuncNo};

        [IniPopulation,boundary,V,N] = Individual(Allsettings,1);    % 产生权重向量和对不同的测试函数产生初始种群并计算目标函数值和约束违反值 
        Allsettings.W=V;
        True_PF = GeneratePF(Allsettings); 
%         DrawPF(True_PF,Allsettings.functions); 

        %FinalPop = M(Mode,Problem,IniPopulation,boundary,N,maxgen,ft,nt,V,PF,preEvolution); 
        tic;
        [FinalPop] = M_main(Mode,Allsettings,True_PF,IniPopulation,boundary);
        FinalPop(end,:)=[];                                    % 为什么把最后一个变空？？？
        runtime = toc;
        [Metric,ScoreIGD]= MetricCal(FinalPop,True_PF,runtime); 
%         metric = MetricCal(FinalPop,True_PF,runtime);        % 计算IGD、MS和运行时间，其中还有IGDplus、HV、R、RED都可以计算

%         DisplayMetric('M',Allsettings.functions,Allsettings.ft,Allsettings.nt,metric);

        igd(i,test)=metric.IGD;
        hv(i,test)=metric.HV;
        ms(i,test)=metric.MS;
        time(i,test)=runtime;

    end
    MIGD=mean(igd(1:20,test));
    MHV=mean(hv(1:20,test));
%     MMS=mean(ms(1:20,test));
%     MCPUtimes=mean(time(1:20,test));
%     MIGD=mean(igd);
%     MHV=mean(hv);
%     MMS=mean(ms);
%     MCPUtimes=mean(time);
    
    igd(21,test)=MIGD;
    hv(21,test)=MHV;
%     ms(21,test)=MMS;
%     time(21,test)=MCPUtimes;
   
end
   



