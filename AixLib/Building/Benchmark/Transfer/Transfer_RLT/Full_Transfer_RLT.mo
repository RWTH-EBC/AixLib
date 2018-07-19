within AixLib.Building.Benchmark.Transfer.Transfer_RLT;
model Full_Transfer_RLT
  RLT OpenPlanOffice
    annotation (Placement(transformation(extent={{60,72},{80,52}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Modelica.Media.Air.MoistAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Modelica.Media.Air.MoistAir)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0.01)
    annotation (Placement(transformation(extent={{-30,52},{-10,72}})));
equation
  connect(OpenPlanOffice.Fluid_out_warm, Fluid_out_hot) annotation (Line(points
        ={{62,52},{62,0},{-80,0},{-80,0},{-80,40},{-100,40}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_in_warm, Fluid_in_hot) annotation (Line(points={
          {66,52},{66,20},{-58,20},{-80,20},{-80,80},{-100,80}}, color={0,127,
          255}));
  connect(OpenPlanOffice.Fluid_out_cold, Fluid_out_cold)
    annotation (Line(points={{74,52},{74,-80},{-100,-80}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_in_cold, Fluid_in_cold)
    annotation (Line(points={{78,52},{78,-40},{-100,-40}}, color={0,127,255}));
  connect(realExpression.y, OpenPlanOffice.X_w1) annotation (Line(points={{-9,
          62},{10,62},{10,90},{70,90},{70,72}}, color={0,0,127}));
  connect(OpenPlanOffice.Air_in, Air_in) annotation (Line(points={{60.2,68.6},{
          -2,68.6},{-2,80},{-40,80},{-40,100}}, color={0,127,255}));
  connect(OpenPlanOffice.Air_out, Air_out) annotation (Line(points={{80,68.6},{
          80,88},{40,88},{40,100}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_RLT;
