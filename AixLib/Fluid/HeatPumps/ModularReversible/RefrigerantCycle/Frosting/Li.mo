within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting;
model Li "Frosting suppression based on Li et al."
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.PartialIcingFactor;

  Modelica.Blocks.Math.UnitConversions.To_degC TOdaDegC
    "Outdoor air temperatur in degC"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Math.Gain relHumInPer(final k=100)
    "Relative humidity in percent"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.ZhuFrostingZone zhuFroZon
    "Frosting zone"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
protected
  Real KQ2=-0.311*TOdaDegC.y - 0.043*TOdaDegC.y^2 - 0.005*TOdaDegC.y^3 + (0.783
       - 1.072*10^(-4)*TOdaDegC.y^3)*relHumInPer.y^0.846 + 2.647
    "Correction at frosting conditions";
equation
 if zhuFroZon.zon > 1 then
    iceFac = (100-KQ2)/100;
  else
    iceFac = 1.0;
  end if;
  connect(TOdaDegC.u, sigBus.TEvaInMea) annotation (Line(points={{-62,30},{-80,30},
          {-80,0},{-101,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(relHumInPer.u, sigBus.relHum) annotation (Line(points={{-62,-30},{-80,
          -30},{-80,0},{-101,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(zhuFroZon.TOda, sigBus.TEvaInMea) annotation (Line(points={{-62,4},{-80,
          4},{-80,0},{-101,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(zhuFroZon.relHum, sigBus.relHum) annotation (Line(points={{-62,-4},{-80,
          -4},{-80,0},{-101,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>
This model implements frosting surpression following Li et al.
As the frosting surpression is not dependent on the heating or cooling mode, but rather just on the ambient conditions, this model should not be used together with a defrost control.
<h4>References</h4>
<p>
Li, Z., Wei, W., Wang, W., Sun, Y., Wang, S., Lin, Y., ... and Deng, S. (2023). A method for sizing air source heat pump considering the joint effect of outdoor air temperature and relative humidity. Journal of Building Engineering, 65, 105815.
<a href=\"https://doi.org/10.1016/j.jobe.2022.105815\">https://doi.org/10.1016/j.jobe.2022.105815</a>.
</p>
</html>"));
end Li;
