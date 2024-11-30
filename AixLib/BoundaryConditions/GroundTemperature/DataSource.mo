within AixLib.BoundaryConditions.GroundTemperature;
type DataSource = enumeration(
    Constant "Use constant value",
    File "Use data from file with tabular data",
    Kusuda "Use Kusuda model for undisturbed ground temperature with selectable parameters",
    Sine "Use a sine model with selectable parameters")
  "Enumeration to define data source for the ground temperature"
      annotation(Documentation(info="<html>
 <p>
 Enumeration to define the data source used in AixLib.BoundaryConditions.GroundTemperature.Options.
 </p>
 </html>",
        revisions="<html>
 <ul>
 <li>
 April 21, 2023, by Philip Groesdonk:<br/>
 First implementation.
 </li>
 </ul>
 </html>"));
