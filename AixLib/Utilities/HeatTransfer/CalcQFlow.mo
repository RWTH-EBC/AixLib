within AixLib.Utilities.HeatTransfer;
block CalcQFlow
  "Calculate Q_flow from m_flow, deltaT and specific heat capacity"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.SpecificHeatCapacity cp
    "Gain with specific heat capacity"
    annotation (Dialog(group="Fluid properties"));

  Modelica.Blocks.Interfaces.RealInput m_flow(quantity="MassFlowRate", unit="kg/s")
    "Mass flow rate"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput T_a(quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") "Temperature (minuend in substraction)"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}})));
  Modelica.Blocks.Interfaces.RealInput T_b(
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") "Temperature (subtrahend in substraction)"
    annotation (Placement(transformation(extent={{-140,-90},{-100,-50}})));

  Modelica.Blocks.Math.Add deltaT(k2=-1)
    annotation (Placement(transformation(extent={{-68,-52},{-40,-24}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-24,-12},{0,12}})));
  Modelica.Blocks.Math.Gain specHeaCap(final k=cp)
    annotation (Placement(transformation(extent={{40,-16},{72,16}})));

  Modelica.Blocks.Interfaces.RealOutput Q_flow(final quantity="HeatFlowRate",
      final unit="W") "Q_flow calculated from m_flow, deltaT and cp"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
equation
  connect(deltaT.y, product.u2) annotation (Line(points={{-38.6,-38},{-32,-38},{
          -32,-7.2},{-26.4,-7.2}}, color={0,0,127}));
  connect(product.y, specHeaCap.u)
    annotation (Line(points={{1.2,0},{36.8,0}}, color={0,0,127}));
  connect(specHeaCap.y, Q_flow)
    annotation (Line(points={{73.6,0},{110,0}}, color={0,0,127}));
  connect(T_a, deltaT.u1) annotation (Line(points={{-120,-10},{-90,-10},{-90,-29.6},
          {-70.8,-29.6}}, color={0,0,127}));
  connect(T_b, deltaT.u2) annotation (Line(points={{-120,-70},{-90,-70},{-90,-46.4},
          {-70.8,-46.4}}, color={0,0,127}));
  connect(product.u1, m_flow) annotation (Line(points={{-26.4,7.2},{-80,7.2},{-80,
          60},{-120,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{58,24},{84,-24}},
          lineColor={28,108,200},
          textString="Q"),
        Text(
          extent={{-84,84},{-58,36}},
          lineColor={28,108,200},
          textString="m"),
        Text(
          extent={{-68,-14},{-42,-62}},
          lineColor={28,108,200},
          textString="T"),
        Text(
          extent={{-36,34},{-10,-14}},
          lineColor={28,108,200},
          textString="c"),
        Text(
          extent={{-12,8},{0,-14}},
          lineColor={28,108,200},
          textString="p"),
        Polygon(
          points={{-80,-24},{-66,-50},{-92,-50},{-80,-24}},
          lineColor={28,108,200},
          lineThickness=1),
        Ellipse(
          extent={{-74,80},{-68,74}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{66,26},{72,20}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CalcQFlow;
