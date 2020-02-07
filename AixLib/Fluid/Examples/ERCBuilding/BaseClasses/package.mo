within AixLib.Fluid.Examples.ERCBuilding;
package BaseClasses
extends Modelica.Icons.BasesPackage;








  replaceable model ExtControl =
    AixLib.Fluid.BoilerCHP.BaseClasses.Controllers.ExternalControlNightDayHC
     constrainedby
  AixLib.Fluid.BoilerCHP.BaseClasses.Controllers.PartialExternalControl
    "ExternalControl"
    annotation (Dialog(tab="External Control"),choicesAllMatching=true);
end BaseClasses;
