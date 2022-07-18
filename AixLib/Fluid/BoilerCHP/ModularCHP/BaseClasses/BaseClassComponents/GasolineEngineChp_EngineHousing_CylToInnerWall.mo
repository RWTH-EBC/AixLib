within AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents;
model GasolineEngineChp_EngineHousing_CylToInnerWall

  parameter Modelica.Units.SI.ThermalConductance GInnWall=lambda*A_WInn/dInn
    "Thermal conductance of the inner engine wall"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.Units.SI.Thickness dInn=0.005
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.Units.SI.ThermalConductivity lambda=44.5
    "Thermal conductivity of the engine block material"
    annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.Units.SI.Area A_WInn
    "Area of heat transporting surface from cylinder wall to outer engine block"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Real z=4
  annotation (Dialog(tab="Structure", group="Engine Properties"));

  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
        transformation(rotation=0, extent={{96,-10},{116,10}})));
  Modelica.Blocks.Interfaces.RealInput T(unit="K") annotation (Placement(
        transformation(rotation=0, extent={{-118,-40},{-94,-16}}),
        iconTransformation(extent={{-108,-40},{-88,-20}})));
  Modelica.Blocks.Interfaces.RealInput T1(unit="K") annotation (Placement(
        transformation(rotation=0, extent={{-118,4},{-94,28}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-98,30})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature meanTempCylWall
    annotation (Placement(transformation(extent={{-76,-22},{-56,-2}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    innerThermalConductor1(G=GInnWall/2) annotation (Placement(transformation(
          extent={{-32,-22},{-12,-2}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowEngine
    annotation (Placement(transformation(extent={{12,-22},{32,-2}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempInnerWall
    annotation (Placement(transformation(extent={{-32,6},{-12,26}})));
  Modelica.Blocks.Nonlinear.VariableLimiter heatLimit(strict=true)
    annotation (Placement(transformation(extent={{12,-54},{28,-38}})));
  Modelica.Blocks.Sources.RealExpression maximumEngineHeat
    annotation (Placement(transformation(extent={{-34,-50},{-14,-30}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-24,-60},{-14,-50}})));

equation
  connect(heatFlowEngine.Q_flow,heatLimit. u) annotation (Line(points={{22,-22},
          {22,-30},{-46,-30},{-46,-46},{10.4,-46}},     color={0,0,127}));
  connect(innerThermalConductor1.port_b,heatFlowEngine. port_a)
    annotation (Line(points={{-12,-12},{12,-12}},  color={191,0,0}));
  connect(heatFlowEngine.port_b, tempInnerWall.port) annotation (Line(points={{
          32,-12},{36,-12},{36,16},{-12,16}}, color={191,0,0}));
  connect(T, meanTempCylWall.T) annotation (Line(points={{-106,-28},{-88,-28},{
          -88,-12},{-78,-12}}, color={0,0,127}));
  connect(heatLimit.y, y) annotation (Line(points={{28.8,-46},{54,-46},{54,0},
          {106,0}}, color={0,0,127}));
  connect(meanTempCylWall.port, innerThermalConductor1.port_a)
    annotation (Line(points={{-56,-12},{-32,-12}}, color={191,0,0}));
  connect(tempInnerWall.T, T1)
    annotation (Line(points={{-34,16},{-106,16}}, color={0,0,127}));
  connect(maximumEngineHeat.y, heatLimit.limit1) annotation (Line(points={{
          -13,-40},{-2,-40},{-2,-39.6},{10.4,-39.6}}, color={0,0,127}));
  connect(const.y, heatLimit.limit2) annotation (Line(points={{-13.5,-55},{-2,
          -55},{-2,-52.4},{10.4,-52.4}}, color={0,0,127}));
  annotation (Icon(graphics={ Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),
        Text(
          extent={{-40,50},{42,32}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          textString="Cylinder
to engine"),
        Line(
          points={{60,0},{96,0},{96,10},{116,0},{96,-10},{96,0}},
          color={238,46,47},
          thickness=1),
        Text(
          extent={{62,14},{94,-2}},
          lineColor={238,46,47},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="Q_Cyl",
          fontSize=20)}), Documentation(revisions="<html><ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
end GasolineEngineChp_EngineHousing_CylToInnerWall;
