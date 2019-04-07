# EnergyPlus Optimization
A framework to couple Matlab with EnergyPlus and solve simulation-based optimization problems.

## Installation

1. __Create environment variables__
  * Set environment variable _ENERGYPLUS_ and point it to the location of the E+ installed folder (e.g. C:\EnergyPlusV8-9-0\).
  * Replace set program_path=%~dp0 with  set program_path="%ENERGYPLUS%".
  * Replace set input_path=ExampleFiles\ with  set input_path=%program_path%IO\Input\.
  * Replace set output_path=ExampleFiles\Outputs\ with set output_path=%program_path%IO\Output\. 

* __Alter the batch file__. 


