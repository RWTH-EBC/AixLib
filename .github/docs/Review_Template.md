# Check List

## The order

* [ ] model comment
* [ ] extend
* [ ] import (but should be avoid where possible)
* [ ] replacable package (e.g. Medium)
* [ ] parameter (only set a value, if it is almost a 100 % generic value)
* [ ] input connectors
* [ ] bidirectional connectors and busses
* [ ] variables
* [ ] component instances
* [ ] output connectors
* [ ] protected (within the protected part stick to the same order as above)

## Points to take care of

* [ ] Do all paramaters, variables, models, etc. have a description?
* [ ] Use "group" and "tab" annotations in order to achieve a good visualization window?
* [ ] Stick to the [Namespace Requirements](https://github.com/RWTH-EBC/AixLib/wiki/Namespaces) and especially to the [Variable Naming](https://github.com/RWTH-EBC/AixLib/wiki/Variable-Naming)
* [ ] Use units
* [ ] For fluid models: Instantiate the replaceable medium package always as  
  `replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model";`  
  instead of using directly a full media model like `AixLib.Media.Water`
* [ ] Absolute paths to classes! -> AixLib.Fluid.HeatExchangers.Radiator - Avoid: HeatExchangers.Radiator
* [ ] No Absolute paths to files! E.g. search for `C:` or `D:`. Replace with modelica://AixLib/...
* [ ] Is the [documentation correct](https://github.com/RWTH-EBC/AixLib/wiki/Documentation)?
* [ ] Icons ok? (Avoid images!)
* [ ] Stick to 80 characters per line (as long it makes sense)
* [ ] Check revised models/packages (F8 in Dymola)
* [ ] Add and run examples of new / revised models
* [ ] Add simulate-and-plot script as regression test for new models ([Link to wiki page](https://github.com/RWTH-EBC/AixLib/wiki/Unit-Tests))!

## What might be helpful?

### List of Changed Files

Open a (Windows) shell in the folder of your local repository:

`git diff --name-only SHA1 SHA2 > C:\any_path\myList.txt`

The expression `> C:\any_path\myList.txt` writes the list into a text file. Just leave this statement out in order to list the files directly in the shell.