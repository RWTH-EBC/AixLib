within AixLib.BoundaryConditions.InternalGains.Examples.InternalGains;
model OneOffice
  extends Modelica.Icons.Example;
  AixLib.BoundaryConditions.InternalGains.Humans.HumanSensibleHeatTemperatureDependent humanSensibleHeat(roomArea=20) annotation (Placement(transformation(extent={{-10,38},{12,62}})));
  AixLib.BoundaryConditions.InternalGains.Machines.MachinesDIN18599 machinesSensibleHeatDIN18599(nrPeople=2, areaSurfaceMachinesTotal=10) annotation (Placement(transformation(extent={{-10,-6},{14,24}})));
  AixLib.BoundaryConditions.InternalGains.Lights.LightsAreaSpecific lightsAreaSpecific(roomArea=20) annotation (Placement(transformation(extent={{-8,-46},{12,-22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature RoomTemp annotation(Placement(transformation(extent = {{-58, 40}, {-38, 60}})));
  Modelica.Blocks.Sources.Ramp Evolution_RoomTemp(duration = 36000, offset = 293.15, startTime = 4000, height = 0) annotation(Placement(transformation(extent = {{-100, 40}, {-80, 60}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(columns = {2, 3, 4, 5}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = [0, 0, 0.1, 0, 0; 36000, 0, 0.1, 0, 0; 36060, 1, 1, 0.3, 0.8; 72000, 1, 1, 0.3, 0.8; 72060, 0, 0.1, 0, 0; 86400, 0, 0.1, 0, 0]) annotation(Placement(transformation(extent = {{-80, -20}, {-60, 0}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T = 293.15) annotation(Placement(transformation(extent = {{62, 46}, {42, 66}})));
equation
  connect(RoomTemp.port, humanSensibleHeat.TRoom) annotation (Line(points={{-38,50},{-28,50},{-28,64},{-8.9,64},{-8.9,60.8}}, color={191,0,0}));
  connect(Evolution_RoomTemp.y, RoomTemp.T) annotation(Line(points = {{-79, 50}, {-60, 50}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[2], machinesSensibleHeatDIN18599.uRel) annotation (Line(points={{-59,-10},{-20,-10},{-20,9},{-10,9}}, color={0,0,127}));
  connect(combiTimeTable.y[3], lightsAreaSpecific.uRel) annotation (Line(points={{-59,-10},{-20,-10},{-20,-34},{-8,-34}}, color={0,0,127}));
  connect(machinesSensibleHeatDIN18599.convHeat, fixedTemp.port) annotation (Line(points={{12.8,18},{38,18},{38,56},{42,56}}, color={191,0,0}));
  connect(machinesSensibleHeatDIN18599.radHeat, fixedTemp.port) annotation (Line(
      points={{12.8,0},{38,0},{38,56},{42,56}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(lightsAreaSpecific.convHeat, fixedTemp.port) annotation (Line(points={{11,-26.8},{38,-26.8},{38,56},{42,56}}, color={191,0,0}));
  connect(lightsAreaSpecific.radHeat, fixedTemp.port) annotation (Line(
      points={{11,-41.2},{38,-41.2},{38,56},{42,56}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(combiTimeTable.y[1], humanSensibleHeat.uRel) annotation (Line(points={{-59,-10},{-28,-10},{-28,50},{-10,50}}, color={0,0,127}));
  connect(humanSensibleHeat.convHeat, fixedTemp.port) annotation (Line(points={{10.9,57.2},{26,57.2},{26,56},{42,56}}, color={191,0,0}));
  connect(humanSensibleHeat.radHeat, fixedTemp.port) annotation (Line(points={{10.9,42.8},{27.45,42.8},{27.45,56},{42,56}}, color={95,95,95}));
  annotation (experiment(StartTime = 0, StopTime = 86400, Tolerance=1e-6, Algorithm="dassl"),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/BoundaryConditions/InternalGains/Examples/OneOffice.mos"
                      "Simulate and plot"), Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simulation to test the functionalty of the internal gains in a
  modelled room.
</p>
<ul>
  <li>
    <i>May 07, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>August 12, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>"));
end OneOffice;
