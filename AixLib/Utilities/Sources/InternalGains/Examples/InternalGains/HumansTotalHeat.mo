within AixLib.Utilities.Sources.InternalGains.Examples.InternalGains;
model HumansTotalHeat
  "Simulation to check the human models for total heat"
  extends Modelica.Icons.Example;
  AixLib.Utilities.Sources.InternalGains.Humans.HumanTotalHeatTemperatureDependent
    humanTotalHeat
    annotation (Placement(transformation(extent={{-24,-20},{22,32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempRoom annotation(Placement(transformation(extent={{-84,42},{-64,62}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T = 293.15) annotation(Placement(transformation(extent={{82,4},{62,24}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table = [0, 0; 28740, 0; 28800, 1; 43200, 1; 43260, 0; 46800, 0; 46860, 1; 64800, 1; 64860, 0; 86400, 0]) annotation(Placement(transformation(extent = {{-82, -26}, {-62, -6}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 2, freqHz = 1 / (24 * 3600), offset = 273.15 + 20, phase(displayUnit = "deg") = -3.1415926535898) annotation(Placement(transformation(extent={{-68,18},{-80,30}})));
  Modelica.Blocks.Interfaces.RealOutput HeatOut annotation(Placement(transformation(extent = {{58, -74}, {78, -54}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorConv annotation (Placement(transformation(extent={{38,12},{52,26}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorRad annotation (Placement(transformation(extent={{26,-4},{40,10}})));
  Modelica.Blocks.Math.MultiSum sumQ_flows(nu=2) annotation (Placement(transformation(extent={{34,-70},{46,-58}})));
equation

  connect(varTempRoom.port, humanTotalHeat.TRoom) annotation (Line(points={{-64,52},{-44,52},{-44,29.4},{-21.7,29.4}},
                                                 color={191,0,0}));
  connect(sine.y, varTempRoom.T) annotation(Line(points={{-80.6,24},{-94,24},{-94,52},{-86,52}},          color = {0, 0, 127}));
  connect(combiTimeTable.y[1], humanTotalHeat.schedule) annotation (Line(points=
         {{-61,-16},{-42,-16},{-42,3.14},{-21.93,3.14}}, color={0,0,127}));
  connect(fixedTemp.port, heatFlowSensorRad.port_b) annotation (Line(points={{62,14},{54,14},{54,3},{40,3}}, color={191,0,0}));
  connect(heatFlowSensorConv.port_b, fixedTemp.port) annotation (Line(points={{52,19},{54,19},{54,14},{62,14}}, color={191,0,0}));
  connect(sumQ_flows.y, HeatOut) annotation (Line(points={{47.02,-64},{68,-64}}, color={0,0,127}));
  connect(humanTotalHeat.radHeat, heatFlowSensorRad.port_a) annotation (Line(points={{19.7,3.4},{22.85,3.4},{22.85,3},{26,3}}, color={95,95,95}));
  connect(humanTotalHeat.convHeat, heatFlowSensorConv.port_a) annotation (Line(points={{19.7,19},{38,19}}, color={191,0,0}));
  connect(heatFlowSensorConv.Q_flow, sumQ_flows.u[1]) annotation (Line(points={{45,12},{46,12},{46,-48},{28,-48},{28,-61.9},{34,-61.9}}, color={0,0,127}));
  connect(heatFlowSensorRad.Q_flow, sumQ_flows.u[2]) annotation (Line(points={{33,-4},{34,-4},{34,-46},{26,-46},{26,-66.1},{34,-66.1}}, color={0,0,127}));
  annotation (experiment(StopTime = 86400),Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Simulation to check the functionality of the human heat sources. It only consists of one human (VDI 2078). </p>
 <p>The timetable represents typical working hours with one hour lunch time. The room temperature follows a sine input varying between 18 and 22 degrees over a 24 hour time period.</p>
 </html>", revisions="<html>
 <ul>
 <li>March, 2019 by Martin Kremer:<br/>First Implementation</li>
 </ul>
 </html>"));
end HumansTotalHeat;
