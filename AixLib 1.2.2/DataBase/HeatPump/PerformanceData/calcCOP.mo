within AixLib.DataBase.HeatPump.PerformanceData;
model calcCOP
  "To calculate the COP or EER of a device, this model ensures no integration failure will happen"

  parameter Modelica.Units.SI.Power lowBouPel
    "If P_el falls below this value, COP will not be calculated";
  parameter Modelica.Units.SI.Time aveTime=60 "Time span for average";

 Modelica.Blocks.Interfaces.RealInput Pel(final unit="W", final displayUnit=
        "kW")
    "Input for all electrical power consumed by the system"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput QHeat(final unit="W", final displayUnit=
        "kW")
    "Input for all heating power delivered to the system"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput y_COP "Output for calculated COP value"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  AixLib.Utilities.Math.MovingAverage movAve(final aveTime=aveTime)
    "To calculate the moving average of the output values";
equation
  //Check if any of the two sums are lower than the given threshold. If so, set COP to zero
  if Pel < lowBouPel or QHeat < Modelica.Constants.eps then
    movAve.u = 0;
  else
    movAve.u = QHeat/Pel;
  end if;
  connect(movAve.y, y_COP);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-82,0},{-12,0}},
          color={28,108,200},
          thickness=0.5),
        Text(
          extent={{-92,32},{-2,12}},
          lineColor={28,108,200},
          lineThickness=0.5,
          textString="QHeat"),
        Text(
          extent={{-92,-8},{-2,-28}},
          lineColor={28,108,200},
          lineThickness=0.5,
          textString="Pel"),
        Line(points={{-6,6},{22,6}}, color={28,108,200}),
        Line(points={{-6,-6},{22,-6}}, color={28,108,200}),
        Text(
          extent={{12,8},{102,-12}},
          lineColor={28,108,200},
          lineThickness=0.5,
          textString="COP")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This model is used to calculate the COP or the EER of a device. As
  the electrical power could get negative, a lower boundary is used to
  avoid division by zero. A moving average ensure a stable calculation
  of the COP or EER.
</p>
</html>"));
end calcCOP;
