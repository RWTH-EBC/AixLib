within AixLib.Fluid.HeatPumps.ModularReversible.Controls.Defrost.BaseClasses;
model OptimalDefrostWangEtAl "Optimal defrost time according to Wang et al."

  Real epsNL(
    min=0,
    max=100) = -0.311*TOdaDegC.y - 0.043*TOdaDegC.y^2 - 0.005*TOdaDegC.y^3 + (0.783
     - 1.072*10^(-4)*TOdaDegC.y^3)*relHumInPer.y^0.846 + 2.647
    "Icing Factor triggering defrost Wang";
  Modelica.Blocks.Interfaces.RealInput TOda "Outdoor air temperature" annotation (
     Placement(transformation(extent={{-140,20},{-100,60}}), iconTransformation(
          extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput relHum
    "Input relative humidity of outdoor air" annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}),iconTransformation(
          extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Math.UnitConversions.To_degC TOdaDegC
    "Outdoor air temperatur in degC"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Math.Gain relHumInPer(final k=100)
    "Relative humidity in percent"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Interfaces.RealOutput minIceFac(
    min=0,
    max=1)
    "Minimal allowed icing Factor to trigger the defrost" annotation (
     Placement(transformation(extent={{100,-20},{140,20}}),  iconTransformation(
          extent={{100,-20},{140,20}})));
  Modelica.Blocks.Sources.RealExpression minIceFac_internal(final y=(100 -
        epsNL)/100) "Relative humidity in percent"
    annotation (Placement(transformation(extent={{10,-10},{60,10}})));
equation

  connect(TOdaDegC.u, TOda)
    annotation (Line(points={{-82,40},{-120,40}}, color={0,0,127}));
  connect(relHumInPer.u, relHum)
    annotation (Line(points={{-82,-40},{-120,-40}}, color={0,0,127}));
  connect(minIceFac_internal.y, minIceFac)
    annotation (Line(points={{62.5,0},{120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-150,138},{150,98}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>Helper model to implement the optimal defrost icing factor by Wang et
al.
<h4>
  References
</h4>
<p>
  Wang, W., Zhang, S., Li, Z., Sun, Y., Deng, S., and Wu, X. (2020).
  Determination of the optimal defrosting initiating time point for an
  ASHP unit based on the minimum loss coefficient in the nominal output
  heating energy. Energy, 191, 116505. <a href=
  \"https://doi.org/10.1016/j.energy.2019.116505\">https://doi.org/10.1016/j.energy.2019.116505</a>.
</p>
</html>"));
end OptimalDefrostWangEtAl;
