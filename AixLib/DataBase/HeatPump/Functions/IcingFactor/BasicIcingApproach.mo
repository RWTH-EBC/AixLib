within AixLib.DataBase.HeatPump.Functions.IcingFactor;
function BasicIcingApproach
  "A function which utilizes the outdoor air temperature and current heat flow from the evaporator"
  extends PartialBaseFct;
algorithm
  //Just a placeholder for a future icing function
  //Efficiency factor (0..1) to estimate influence of icing. 0 means no heat is transferred through heat exchanger (fully frozen); 1 means no icing/frosting.
  iceFac :=1;

  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This function can be used to implement a simple icing approach, e.g.
  based on outdoor air temperature or time based.
</p>
</html>"));
end BasicIcingApproach;
