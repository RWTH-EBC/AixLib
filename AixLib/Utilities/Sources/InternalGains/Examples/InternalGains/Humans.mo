within AixLib.Utilities.Sources.InternalGains.Examples.InternalGains;
model Humans "Simulation to check the human models"
  extends Modelica.Icons.Example;
  Utilities.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
    human_SensibleHeat_VDI2078_1(RatioConvectiveHeat=0.6)
    annotation (Placement(transformation(extent={{-24,-20},{22,32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempRoom annotation(Placement(transformation(extent = {{-64, 42}, {-84, 62}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T = 293.15) annotation(Placement(transformation(extent = {{78, 4}, {58, 24}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table = [0, 0; 28740, 0; 28800, 1; 43200, 1; 43260, 0; 46800, 0; 46860, 1; 64800, 1; 64860, 0; 86400, 0]) annotation(Placement(transformation(extent = {{-82, -26}, {-62, -6}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 2, freqHz = 1 / (24 * 3600), offset = 273.15 + 20, phase(displayUnit = "deg") = -3.1415926535898) annotation(Placement(transformation(extent = {{-82, 18}, {-70, 30}})));
  Modelica.Blocks.Interfaces.RealOutput HeatOut annotation(Placement(transformation(extent = {{58, -74}, {78, -54}})));
equation
  //Connect human heat output
  human_SensibleHeat_VDI2078_1.productHeatOutput.y = HeatOut;
  connect(varTempRoom.port, human_SensibleHeat_VDI2078_1.TRoom) annotation(Line(points = {{-84, 52}, {-44, 52}, {-44, 29.4}, {-21.7, 29.4}}, color = {191, 0, 0}));
  connect(sine.y, varTempRoom.T) annotation(Line(points = {{-69.4, 24}, {-54, 24}, {-54, 52}, {-62, 52}}, color = {0, 0, 127}));
  connect(human_SensibleHeat_VDI2078_1.ConvHeat, fixedTemp.port) annotation(Line(points = {{19.7, 19}, {38.85, 19}, {38.85, 14}, {58, 14}}, color = {191, 0, 0}));
  connect(human_SensibleHeat_VDI2078_1.RadHeat, fixedTemp.port) annotation(Line(points = {{19.7, 3.4}, {39.85, 3.4}, {39.85, 14}, {58, 14}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(combiTimeTable.y[1], human_SensibleHeat_VDI2078_1.Schedule) annotation(Line(points = {{-61, -16}, {-42, -16}, {-42, 3.14}, {-21.93, 3.14}}, color = {0, 0, 127}));
  annotation (experiment(StopTime = 86400),Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Simulation to check the functionality of the human heat sources. It only consists of one human (VDI 2078). </p>
 <p>The timetable represents typical working hours with one hour lunch time. The room temperature follows a sine input varying between 18 and 22 degrees over a 24 hour time period.</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>May 31, 2013&nbsp;</i> by Ole Odendahl:<br/>Implemented, added documentation and formatted appropriately</li>
 </ul>
 </html>"));
end Humans;
