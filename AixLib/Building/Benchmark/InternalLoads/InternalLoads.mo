within AixLib.Building.Benchmark.InternalLoads;
model InternalLoads
  InternalLoads_Power internalLoads_Power
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  InternalLoads_Water internalLoads_Water
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Interfaces.RealOutput Water_Room[5] "Output signal connector"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b AddPower[5]
    annotation (Placement(transformation(extent={{84,50},{104,70}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
                                                        tableOnFile=true,
    final fileName=
        "D:/aku-bga/AixLib/AixLib/Building/Benchmark/InternalLoads/InternalLoads_v1.mat",
    tableName="final",
    timeScale=1,
    columns={2,3,4,5,6,7,8,9,10,11})
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

equation
  connect(internalLoads_Water.y1, Water_Room)
    annotation (Line(points={{10,-60},{100,-60}}, color={0,0,127}));
  connect(internalLoads_Power.AddPower, AddPower)
    annotation (Line(points={{10,60},{94,60}}, color={191,0,0}));
  connect(internalLoads_Power.u1, combiTimeTable1.y) annotation (Line(points={{
          -10,60},{-40,60},{-40,0},{-59,0}}, color={0,0,127}));
  connect(internalLoads_Water.u1, combiTimeTable1.y) annotation (Line(points={{
          -10,-60},{-40,-60},{-40,0},{-59,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalLoads;
