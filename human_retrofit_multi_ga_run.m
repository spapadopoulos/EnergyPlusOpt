populationSize = 30; %20
stallGenLimit = 200; %200
generations = 40; %50

FitnessFunction = @human_retrofit_multiobjective;
numberOfVariables = 4;

% cool_oc; heat_oc; cool_unoc; heat_unoc
lb = [22 17 27 14];
ub = [27 22 30 17];
Bound = [lb; ub];

options = gaoptimset('PopulationSize',populationSize,...
    'StallGenLimit', stallGenLimit,...
    'Generations', generations,...
    'PopulationSize',populationSize,...
    'PopInitRange', Bound,...
    'PlotFcns',{@gaplotpareto,@gaplotscorediversity});

tic
[zmulti,fval] = gamultiobj(FitnessFunction,numberOfVariables,[], [], [], [], lb, ub, options);
toc

save('..\output\optResult_baltimore.mat','zmulti','fval')