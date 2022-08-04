within AixLib.Fluid.HeatExchangers.Radiators.BaseClasses;
class CalcExcessTemp
  "different choices of calculating the excess temperature of the radiator"

  constant Integer ari=1 "arithmetic calculation";
  constant Integer log=2 "logarithmic calculation";
  constant Integer exp=3 "exponential calculation";

  type Temp
    extends Integer;
    annotation (Evaluate=true, choices(
        choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.ari
          "arithmetic calculation",
        choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.log
          "logarithmic calculation",
        choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.exp
          "exponential calculation"));
  end Temp;

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Variable to determine the different choice to calculate the excess
  temperature of a radiator.
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>October, 2016&#160;</i> by Peter Remmen:<br/>
    Transfer to AixLib.
  </li>
  <li>
    <i>October 7, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>
"));
end CalcExcessTemp;
