%% Set optimization parameters

populationSize = 30; 
stallGenLimit = 200;
generations = 40;

FitnessFunction = @HVAC_opt_multiobjective;
numberOfVariables = 4;

%% Decision variables (HVAC set points): cooling_occupied, heating_occupied, cooling_unoccupied, heating_unoccupied
lb = [22 17 27 14];
ub = [27 22 30 17];
Bound = [lb; ub];

options = gaoptimset('PopulationSize',populationSize,...
    'StallGenLimit', stallGenLimit,...
    'Generations', generations,...
    'PopulationSize',populationSize,...
    'PopInitRange', Bound,...
    'PlotFcns',{@gaplotpareto,@gaplotscorediversity});

%% Run solver
tic
[zmulti,fval] = gamultiobj(FitnessFunction,numberOfVariables,[], [], [], [], lb, ub, options);
toc

%% Save results
save('..\output\optResult_baltimore.mat','zmulti','fval')