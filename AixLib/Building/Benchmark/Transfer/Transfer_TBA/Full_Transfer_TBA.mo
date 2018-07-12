within AixLib.Building.Benchmark.Transfer.Transfer_TBA;
model Full_Transfer_TBA
  TBA_Pipe OpenPlanOffice(wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_warm_in(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_warm_out(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_TBA_OpenPlanOffice
    annotation (Placement(transformation(extent={{70,90},{90,110}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
equation
  connect(OpenPlanOffice.Fluid_in, Fluid_warm_in)
    annotation (Line(points={{74,40},{74,-40},{-100,-40}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out, Fluid_warm_out)
    annotation (Line(points={{86,40},{86,-80},{-100,-80}}, color={0,127,255}));
  connect(OpenPlanOffice.HeatPort_TBA_OpenPlanOffice,
    HeatPort_TBA_OpenPlanOffice)
    annotation (Line(points={{80,60},{80,100}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_TBA;
