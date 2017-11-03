within AixLib.Airflow.AirHandlingUnit.BaseClasses;
model volToMassFlow
  "calculation of the mass flow rate from the volume flow rate of air"
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Modelica.Blocks.Math.Gain volToSI(k=1/3600) "conversion to m3/s"
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
  Modelica.Blocks.Math.Gain volToMass(k=1.185)
    "multiplication with density (relative humidity 50% and 23°C)"
    annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
equation
  connect(u, volToSI.u)
    annotation (Line(points={{-108,0},{-74,0}}, color={0,0,127}));
  connect(volToSI.y, volToMass.u)
    annotation (Line(points={{-51,0},{-20,0}}, color={0,0,127}));
  connect(volToMass.y, y)
    annotation (Line(points={{3,0},{104,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end volToMassFlow;
