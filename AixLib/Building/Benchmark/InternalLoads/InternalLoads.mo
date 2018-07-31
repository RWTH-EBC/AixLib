within AixLib.Building.Benchmark.InternalLoads;
model InternalLoads
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(tableOnFile=true)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  InternalLoads_Power internalLoads_Power
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  InternalLoads_Water internalLoads_Water
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Interfaces.RealOutput Water_Room[5] "Output signal connector"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b AddPower[5]
    annotation (Placement(transformation(extent={{84,50},{104,70}})));
equation
  connect(combiTimeTable.y, internalLoads_Power.u1) annotation (Line(points={{
          -59,0},{-40,0},{-40,60},{-10,60}}, color={0,0,127}));
  connect(internalLoads_Water.u1, combiTimeTable.y) annotation (Line(points={{
          -10,-60},{-40,-60},{-40,0},{-59,0}}, color={0,0,127}));
  connect(internalLoads_Water.y1, Water_Room)
    annotation (Line(points={{10,-60},{100,-60}}, color={0,0,127}));
  connect(internalLoads_Power.AddPower, AddPower)
    annotation (Line(points={{10,60},{94,60}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalLoads;
