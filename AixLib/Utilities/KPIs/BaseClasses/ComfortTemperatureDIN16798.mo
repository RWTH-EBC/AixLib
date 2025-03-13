within AixLib.Utilities.KPIs.BaseClasses;
model ComfortTemperatureDIN16798
  "Comfort temperature based on DIN EN 16798-1"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput TAmb(
    final unit="K",
    displayUnit="degC",
    final min=0) "Ambient temperature (hourly averaged)"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput TCom(final unit="K", displayUnit="degC")
    "Comfort room temperature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput TComUppBou(final unit="K", displayUnit="degC")
    "Upper bound of comfort room temperature"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput TComLowBou(final unit="K", displayUnit="degC")
    "Lower bound of comfort room temperature"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
protected
  Modelica.Units.NonSI.Temperature_degC TAmb_degC=
    Modelica.Units.Conversions.to_degC(TAmb)
    "Ambient temperature in degC";
  Modelica.Units.NonSI.Temperature_degC TCom_degC=
    min(max(22, 18 + 0.25*TAmb_degC), 26)
    "Comfort room temperature in degC";
  Modelica.Units.SI.TemperatureDifference dTTol=2
    "Tolerance of temperature difference";
equation
  TCom = Modelica.Units.Conversions.from_degC(TCom_degC);
  TComLowBou = TCom - dTTol;
  TComUppBou = TCom + dTTol;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-80,-40},{-62,-40},{-40,-40},{40,40},{80,40}},
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(points={{-80,0},{-40,0},{40,80},{80,80}}, color={0,0,0}),
        Line(points={{-80,-80},{-40,-80},{40,0},{80,0}}, color={0,0,0})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model calculates the comfort temperature band based on ambiemt temperature according to DIN EN 16798-1.</p>
</html>"));
end ComfortTemperatureDIN16798;
