within AixLib.Building.Benchmark.Transfer.Transfer_TBA;
model Full_Transfer_TBA
  TBA_Pipe OpenPlanOffice
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_warm_in
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_warm_out
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
equation
  connect(OpenPlanOffice.Fluid_in, Fluid_warm_in)
    annotation (Line(points={{74,40},{74,-60},{-100,-60}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out, Fluid_warm_out)
    annotation (Line(points={{86,40},{86,-80},{-100,-80}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_TBA;
