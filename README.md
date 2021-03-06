# EnergyPlus Optimization
A framework to couple Matlab with EnergyPlus and solve simulation-based optimization problems.

## Installation

* __Create environment variables__
  1. Set environment variable _ENERGYPLUS_ and point it to the location of the E+ installed folder (e.g. C:\EnergyPlusV8-9-0\ ).
  2. Create IO folder in E+ installation with two subfolders "Input" and "Output".
  3. Copy building.idf in the Input folder.

* __Alter the batch file__. 
  1. Find RunEPlus batch file in E+ installation.
  2. Replace set program_path=%~dp0 with  set program_path="%ENERGYPLUS%".
  3. Replace set input_path=ExampleFiles\ with  set input_path=%program_path%IO\Input\.
  4. Replace set output_path=ExampleFiles\Outputs\ with set output_path=%program_path%IO\Output\
  
## Functions

__idfread(filename)__ -- Reads and parses IDF file in a structure array.

__idfwrite(filename)__ -- Write IDF file from structure array.

__runep(filename, epwfilename)__ -- Runs E+ process directly in Matlab given .IDF and .EPW (weather) files. 


## Case study

__Problem definition:__ We try to optimize HVAC heating and cooling set points in office spaces with respect to _energy savings_ and _occupants' thermal comfort_.

* __HVAC_opt_multiobjective.m__ -- We formulate the objetive functions as the output of EnergyPlus simulation 

* __ga_run.m__ -- We solve the problem using a genetic algorithm solver (i.e. NSGA-II)

The figure below is an illustration of the optimization process:

![alt text](https://github.com/spapadopoulos/EnergyPlusOpt/blob/master/optimization_flowchart.png "Optimization Flowchart")
  
For detailed problem formulation and case study results see [here](https://www.sciencedirect.com/science/article/pii/S036013231930232X?dgcid=author).

## Potential extensions

The framework can be applied in a variety of single or multi-objective building energy optimization problems, such as retrofit optimization with respect to energy and first costs, or blind opening and visual comfort to name a few.



