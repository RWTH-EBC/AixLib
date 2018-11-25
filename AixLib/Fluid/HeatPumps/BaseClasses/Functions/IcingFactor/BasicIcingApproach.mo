within AixLib.Fluid.HeatPumps.BaseClasses.Functions.IcingFactor;
function BasicIcingApproach
  "A function which utilizes the outdoor air temperature and current heat flow from the evaporator"
  extends PartialBaseFct;
algorithm
  //Just a placeholder for a future icing function
  iceFac :=1;

  annotation (Documentation(revisions="<html>
 <li><i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)</li>
</html>"));
end BasicIcingApproach;
