within AixLib.Fluid.Pools.obsolete;
model TestVapor
  Real h_vapor;
  parameter Real  m_vapor = 10;
  Real product;

  Modelica.Blocks.Sources.RealExpression realExpression(y=product)
    annotation (Placement(transformation(extent={{-62,44},{-42,64}})));

  Modelica.Blocks.Interfaces.RealOutput y1    "Value of Real output"
    annotation (Placement(transformation(extent={{-12,44},{8,64}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=4, offset=273.15)
    annotation (Placement(transformation(extent={{-62,4},{-42,24}})));
  Modelica.Blocks.Interfaces.RealOutput Temp "Connector of Real output signal"
    annotation (Placement(transformation(extent={{-28,6},{-8,26}})));
  Modelica.Blocks.Sources.Constant const(k=m_vapor)
    annotation (Placement(transformation(extent={{-60,-46},{-40,-26}})));
  Modelica.Blocks.Math.Gain gain(k=h_vapor)
    annotation (Placement(transformation(extent={{-22,-46},{-2,-26}})));
  Modelica.Blocks.Interfaces.RealOutput y2
                          "Output signal connector"
    annotation (Placement(transformation(extent={{14,-48},{34,-28}})));
equation
  product = m_vapor*h_vapor;
  h_vapor= AixLib.Media.Air.enthalpyOfCondensingGas(Temp);

  connect(realExpression.y, y1)
    annotation (Line(points={{-41,54},{-2,54}}, color={0,0,127}));
  connect(sine.y, Temp) annotation (Line(points={{-41,14},{-30,14},{-30,16},{-18,
          16}}, color={0,0,127}));
  connect(const.y, gain.u)
    annotation (Line(points={{-39,-36},{-24,-36}}, color={0,0,127}));
  connect(gain.y, y2) annotation (Line(points={{-1,-36},{12,-36},{12,-38},{24,
          -38}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestVapor;
