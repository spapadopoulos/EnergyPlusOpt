# EnergyPlus Optimization
A framework to couple Matlab with EnergyPlus and solve simulation-based optimization problems.

## Installation

* __Create environment variables__
  1. Set environment variable _ENERGYPLUS_ and point it to the location of the E+ installed folder (e.g. C:\EnergyPlusV8-9-0\).
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

We solve the problem using genetic algorithms 
  


