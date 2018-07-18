within AixLib.Building.Benchmark.Transfer.Transfer_RLT;
model Full_Transfer_RLT
  RLT OpenPlanOffice
    annotation (Placement(transformation(extent={{60,72},{80,52}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out[n](redeclare package Medium =
        Modelica.Media.Air.MoistAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in[n](redeclare package Medium =
        Modelica.Media.Air.MoistAir)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
equation
  connect(Air_out[1], OpenPlanOffice.Air_out) annotation (Line(points={{40,100},
          {40,80},{80,80},{80,68.6}}, color={0,127,255}));
  connect(OpenPlanOffice.Air_in, Air_in[1]) annotation (Line(points={{60.2,68.6},
          {30,68.6},{30,80},{-40,80},{-40,100}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out_warm, Fluid_out_warm) annotation (Line(
        points={{62,52},{62,52},{62,40},{-20,40},{-20,40},{-100,40}}, color={0,
          127,255}));
  connect(OpenPlanOffice.Fluid_in_warm, Fluid_in_warm)
    annotation (Line(points={{66,52},{66,0},{-100,0}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out_cold, Fluid_out_cold)
    annotation (Line(points={{74,52},{74,-40},{-100,-40}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_in_cold, Fluid_in_cold)
    annotation (Line(points={{78,52},{78,-80},{-100,-80}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_RLT;
