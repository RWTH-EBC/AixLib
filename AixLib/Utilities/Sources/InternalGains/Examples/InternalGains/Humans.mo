within AixLib.Utilities.Sources.InternalGains.Examples.InternalGains;
model Humans "Simulation to check the human models"
  extends Modelica.Icons.Example;
  AixLib.Utilities.Sources.InternalGains.Humans.HumanSensibleHeatTemperatureDependent
    humanSensibleHeat
             annotation (Placement(transformation(extent={{-24,-20},{22,32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempRoom annotation(Placement(transformation(extent={{-84,42},{-64,62}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T = 293.15) annotation(Placement(transformation(extent = {{78, 4}, {58, 24}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table = [0, 0; 28740, 0; 28800, 1; 43200, 1; 43260, 0; 46800, 0; 46860, 1; 64800, 1; 64860, 0; 86400, 0]) annotation(Placement(transformation(extent = {{-82, -26}, {-62, -6}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 2, freqHz = 1 / (24 * 3600), offset = 273.15 + 20, phase(displayUnit = "deg") = -3.1415926535898) annotation(Placement(transformation(extent={{-70,18},{-82,30}})));
  Modelica.Blocks.Interfaces.RealOutput HeatOut annotation(Placement(transformation(extent = {{58, -74}, {78, -54}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorConv annotation (Placement(transformation(extent={{38,12},{52,26}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorRad annotation (Placement(transformation(extent={{26,-4},{40,10}})));
  Modelica.Blocks.Math.MultiSum sumQ_flows(nu=2) annotation (Placement(transformation(extent={{34,-70},{46,-58}})));
equation

  connect(varTempRoom.port, humanSensibleHeat.TRoom) annotation (Line(points={{-64,52},{-44,52},{-44,29.4},{-21.7,29.4}},
                                                     color={191,0,0}));
  connect(sine.y, varTempRoom.T) annotation(Line(points={{-82.6,24},{-92,24},{-92,52},{-86,52}},          color = {0, 0, 127}));
  connect(combiTimeTable.y[1], humanSensibleHeat.schedule) annotation (Line(
        points={{-61,-16},{-42,-16},{-42,3.14},{-21.93,3.14}}, color={0,0,127}));
  connect(heatFlowSensorConv.port_a, humanSensibleHeat.convHeat) annotation (Line(points={{38,19},{19.7,19}},                 color={191,0,0}));
  connect(heatFlowSensorConv.port_b, fixedTemp.port) annotation (Line(points={{52,19},{56,19},{56,14},{58,14}}, color={191,0,0}));
  connect(fixedTemp.port, heatFlowSensorRad.port_b) annotation (Line(points={{58,14},{54,14},{54,3},{40,3}}, color={191,0,0}));
  connect(heatFlowSensorRad.port_a, humanSensibleHeat.radHeat) annotation (Line(points={{26,3},{24,3},{24,3.4},{19.7,3.4}}, color={191,0,0}));
  connect(heatFlowSensorConv.Q_flow, sumQ_flows.u[1]) annotation (Line(points={{45,12},{46,12},{46,-50},{30,-50},{30,-61.9},{34,-61.9}}, color={0,0,127}));
  connect(heatFlowSensorRad.Q_flow, sumQ_flows.u[2]) annotation (Line(points={{33,-4},{32,-4},{32,-42},{26,-42},{26,-66.1},{34,-66.1}}, color={0,0,127}));
  connect(sumQ_flows.y, HeatOut) annotation (Line(points={{47.02,-64},{68,-64}}, color={0,0,127}));
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
