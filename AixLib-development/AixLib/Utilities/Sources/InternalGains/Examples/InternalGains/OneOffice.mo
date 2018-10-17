within AixLib.Utilities.Sources.InternalGains.Examples.InternalGains;
model OneOffice
  extends Modelica.Icons.Example;
  Utilities.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
    human_SensibleHeat_VDI2078(NrPeople=2)
    annotation (Placement(transformation(extent={{-10,40},{12,64}})));
  Utilities.Sources.InternalGains.Machines.Machines_DIN18599
    machines_SensibleHeat_DIN18599(NrPeople=2)
    annotation (Placement(transformation(extent={{-10,-6},{14,24}})));
  Utilities.Sources.InternalGains.Lights.Lights_relative lights
    annotation (Placement(transformation(extent={{-8,-46},{12,-22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature RoomTemp annotation(Placement(transformation(extent = {{-58, 40}, {-38, 60}})));
  Modelica.Blocks.Sources.Ramp Evolution_RoomTemp(duration = 36000, offset = 293.15, startTime = 4000, height = 0) annotation(Placement(transformation(extent = {{-100, 40}, {-80, 60}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(columns = {2, 3, 4, 5}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = [0, 0, 0.1, 0, 0; 36000, 0, 0.1, 0, 0; 36060, 1, 1, 0.3, 0.8; 72000, 1, 1, 0.3, 0.8; 72060, 0, 0.1, 0, 0; 86400, 0, 0.1, 0, 0]) annotation(Placement(transformation(extent = {{-80, -20}, {-60, 0}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T = 293.15) annotation(Placement(transformation(extent = {{62, 46}, {42, 66}})));
equation
  connect(RoomTemp.port, human_SensibleHeat_VDI2078.TRoom) annotation(Line(points = {{-38, 50}, {-28, 50}, {-28, 64}, {-8.9, 64}, {-8.9, 62.8}}, color = {191, 0, 0}));
  connect(Evolution_RoomTemp.y, RoomTemp.T) annotation(Line(points = {{-79, 50}, {-60, 50}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], human_SensibleHeat_VDI2078.Schedule) annotation(Line(points = {{-59, -10}, {-20, -10}, {-20, 50.68}, {-9.01, 50.68}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[2], machines_SensibleHeat_DIN18599.Schedule) annotation(Line(points = {{-59, -10}, {-20, -10}, {-20, 9}, {-8.8, 9}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[3], lights.Schedule) annotation(Line(points = {{-59, -10}, {-20, -10}, {-20, -34}, {-7, -34}}, color = {0, 0, 127}));
  connect(human_SensibleHeat_VDI2078.ConvHeat, fixedTemp.port) annotation(Line(points = {{10.9, 58}, {34, 58}, {34, 56}, {42, 56}}, color = {191, 0, 0}));
  connect(human_SensibleHeat_VDI2078.RadHeat, fixedTemp.port) annotation(Line(points = {{10.9, 50.8}, {36, 50.8}, {36, 56}, {42, 56}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(machines_SensibleHeat_DIN18599.ConvHeat, fixedTemp.port) annotation(Line(points = {{12.8, 18}, {38, 18}, {38, 56}, {42, 56}}, color = {191, 0, 0}));
  connect(machines_SensibleHeat_DIN18599.RadHeat, fixedTemp.port) annotation(Line(points = {{12.8, 0.3}, {38, 0.3}, {38, 56}, {42, 56}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(lights.ConvHeat, fixedTemp.port) annotation(Line(points = {{11, -26.8}, {38, -26.8}, {38, 56}, {42, 56}}, color = {191, 0, 0}));
  connect(lights.RadHeat, fixedTemp.port) annotation(Line(points = {{11, -40.96}, {38, -40.96}, {38, 56}, {42, 56}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  annotation (experiment(StopTime = 86400, Interval = 60, __Dymola_Algorithm = "Lsodar"), experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Simulation to test the functionalty of the internal gains in a modelled room. </p>
 </html>", revisions = "<html>
 <ul>
 <li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>August 12, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>"));
end OneOffice;
