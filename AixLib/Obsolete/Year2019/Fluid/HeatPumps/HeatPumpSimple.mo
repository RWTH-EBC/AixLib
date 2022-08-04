within AixLib.Obsolete.Year2019.Fluid.HeatPumps;
model HeatPumpSimple
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;
  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  Modelica.Fluid.Interfaces.FluidPort_a
                    port_a_source(redeclare package Medium = Medium)
                    "Heat pump inlet on the source side"   annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                    port_b_source(redeclare package Medium = Medium)
                    "Heat pump outlet on the source side"  annotation(Placement(transformation(extent = {{-100, -80}, {-80, -60}})));
  Modelica.Fluid.Interfaces.FluidPort_a
                    port_a_sink(redeclare package Medium = Medium)
                    "Heat pump inlet on the sink side"     annotation(Placement(transformation(extent = {{80, -80}, {100, -60}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                    port_b_sink(redeclare package Medium = Medium)
                    "Heat pump outlet on the sink side"    annotation(Placement(transformation(extent = {{80, 60}, {100, 80}})));
  AixLib.Fluid.MixingVolumes.MixingVolume volumeEvaporator(
    V=VolumeEvaporator,
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=0.01) "Water volume of the evaporator on the source side"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-60})));
  AixLib.Fluid.MixingVolumes.MixingVolume volumeCondenser(
    V=VolumeCondenser,
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=0.01) "Water volume of the condenser on the sink side"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-30})));
  AixLib.Fluid.Sensors.TemperatureTwoPort temperatureSinkOut(redeclare package Medium =
               Medium, m_flow_nominal=0.01)
    "Temperature sensor at outlet on the sink side" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,50})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff
                    "On Off input signal of the heat pump"      annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {0, 80})));
  AixLib.Fluid.Sensors.TemperatureTwoPort temperatureSourceIn(redeclare package
                                                                                Medium =
               Medium, m_flow_nominal=0.01)
    "Temperature sensor at inlet on the source side" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,36})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatFlowCondenser
                    "Heat flow on the sink side" annotation(Placement(transformation(extent={{-4,-4},
            {4,4}},                                                                                                    origin={48,-40})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatFlowEvaporator
                    "Heat flow on the source side" annotation(Placement(transformation(extent={{4,-4},{
            -4,4}},                                                                                                    origin={-46,-50})));
  Modelica.Blocks.Tables.CombiTable2Ds PowerTable(table=tablePower)
    "Calculates electric power based on temperature in source and sink"
    annotation (Placement(transformation(extent={{-52,20},{-32,40}})));
  Modelica.Blocks.Tables.CombiTable2Ds HeatFlowCondenserTable(table=
        tableHeatFlowCondenser)
    "Calculates heat flow based on temperature in source and sink"
    annotation (Placement(transformation(extent={{-52,-12},{-32,8}})));
  Modelica.Blocks.Logical.Switch SwitchHeatFlowCondenser
                    "Switch to deactivate heat flow when off" annotation(Placement(transformation(extent = {{14, -20}, {34, 0}})));
  Modelica.Blocks.Sources.Constant constZero2(k = 0)
                    "Zero heat flow, when heat pump off" annotation(Placement(transformation(extent = {{-26, -28}, {-6, -8}})));
  Modelica.Blocks.Logical.Switch SwitchPower
                    "Switch to deactivate Power when off" annotation(Placement(transformation(extent = {{14, 12}, {34, 32}})));
  Modelica.Blocks.Sources.Constant constZero1(k = 0)
                    "Zero power, when heat pump off" annotation(Placement(transformation(extent = {{-26, 4}, {-6, 24}})));
  Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
                    "Calculates evaporator heat flow with total energy balance" annotation(Placement(transformation(extent = {{10, -60}, {-10, -40}})));
  Modelica.Blocks.Interfaces.RealOutput Power "Connector of Real output signal" annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
  parameter Modelica.Units.SI.Volume VolumeEvaporator=0.01 "Volume im m3";
  parameter Modelica.Units.SI.Volume VolumeCondenser=0.01 "Volume im m3";
  parameter Real tablePower[:, :] = fill(0.0, 0, 2)
    "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])";
  parameter Real tableHeatFlowCondenser[:, :] = fill(0.0, 0, 2)
    "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])";
  Modelica.Blocks.Math.Gain gain(k=-1)   annotation(Placement(transformation(extent = {{-18, -60}, {-38, -40}})));
equation
  connect(temperatureSourceIn.port_a, port_a_source) annotation(Line(points = {{-80, 46}, {-80, 70}, {-90, 70}}, color = {0, 127, 255}));
  connect(temperatureSinkOut.port_b, port_b_sink) annotation(Line(points = {{80, 60}, {80, 70}, {90, 70}}, color = {0, 127, 255}));
  connect(HeatFlowEvaporator.port, volumeEvaporator.heatPort) annotation(Line(points={{-50,-50},
          {-70,-50}},                                                                                            color = {191, 0, 0}));
  connect(HeatFlowCondenser.port, volumeCondenser.heatPort) annotation(Line(points={{52,-40},
          {70,-40}},                                                                                         color = {191, 0, 0}));
  connect(OnOff, SwitchHeatFlowCondenser.u2) annotation(Line(points = {{0, 80}, {0, -10}, {12, -10}}, color = {255, 0, 255}));
  connect(HeatFlowCondenserTable.y, SwitchHeatFlowCondenser.u1) annotation(Line(points = {{-31, -2}, {12, -2}}, color = {0, 0, 127}));
  connect(constZero2.y, SwitchHeatFlowCondenser.u3) annotation(Line(points = {{-5, -18}, {12, -18}}, color = {0, 0, 127}));
  connect(SwitchHeatFlowCondenser.y, HeatFlowCondenser.Q_flow) annotation(Line(points={{35,-10},
          {40,-10},{40,-40},{44,-40}},                                                                                                color = {0, 0, 127}));
  connect(constZero1.y, SwitchPower.u3) annotation(Line(points = {{-5, 14}, {12, 14}}, color = {0, 0, 127}));
  connect(SwitchPower.u2, SwitchHeatFlowCondenser.u2) annotation(Line(points = {{12, 22}, {0, 22}, {0, -10}, {12, -10}}, color = {255, 0, 255}));
  connect(PowerTable.y, SwitchPower.u1) annotation(Line(points = {{-31, 30}, {12, 30}}, color = {0, 0, 127}));
  connect(SwitchPower.y, Power) annotation(Line(points = {{35, 22}, {38, 22}, {38, -70}, {0, -70}, {0, -90}}, color = {0, 0, 127}));
  connect(SwitchPower.y, feedbackHeatFlowEvaporator.u2) annotation(Line(points = {{35, 22}, {38, 22}, {38, -70}, {0, -70}, {0, -58}}, color = {0, 0, 127}));
  connect(SwitchHeatFlowCondenser.y, feedbackHeatFlowEvaporator.u1) annotation(Line(points = {{35, -10}, {40, -10}, {40, -50}, {8, -50}}, color = {0, 0, 127}));
  connect(gain.y, HeatFlowEvaporator.Q_flow) annotation(Line(points={{-39,-50},{
          -42,-50}},                                                                            color = {0, 0, 127}));
  connect(gain.u, feedbackHeatFlowEvaporator.y) annotation(Line(points = {{-16, -50}, {-9, -50}}, color = {0, 0, 127}));
  connect(temperatureSourceIn.port_b, volumeEvaporator.ports[1]) annotation (
      Line(
      points={{-80,26},{-80,-58}},
      color={0,127,255}));
  connect(port_a_sink, volumeCondenser.ports[1]) annotation (Line(
      points={{90,-70},{80,-68},{80,-32}},
      color={0,127,255}));
  connect(volumeCondenser.ports[2], temperatureSinkOut.port_a) annotation (Line(
      points={{80,-28},{80,40}},
      color={0,127,255}));

  connect(temperatureSourceIn.T, PowerTable.u2) annotation (Line(
      points={{-69,36},{-66,36},{-66,24},{-54,24}},
      color={0,0,127}));
  connect(temperatureSourceIn.T, HeatFlowCondenserTable.u2) annotation (Line(
      points={{-69,36},{-66,36},{-66,-8},{-54,-8}},
      color={0,0,127}));
  connect(temperatureSinkOut.T, PowerTable.u1) annotation (Line(
      points={{69,50},{-62,50},{-62,36},{-54,36}},
      color={0,0,127}));
  connect(temperatureSinkOut.T, HeatFlowCondenserTable.u1) annotation (Line(
      points={{69,50},{-62,50},{-62,4},{-54,4}},
      color={0,0,127}));
  connect(volumeEvaporator.ports[2], port_b_source) annotation (Line(
      points={{-80,-62},{-80,-70},{-90,-70}},
      color={0,127,255}));
  annotation (obsolete = "Obsolete model - use AixLib.Fluid.HeatPumps.HeatPump instead", Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {249, 249, 249},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 80}, {-60, -80}}, lineColor = {0, 0, 255}, fillColor = {170, 213, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{60, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {255, 170, 213},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-100, 20}, {100, -20}}, lineColor = {0, 0, 255}, textString = "%name")}), Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simple model of an on/off-controlled heat pump. The refrigerant
  circuit is a black-box model represented by tables which calculate
  the electric power and heat flows of the condenser depending on the
  source and sink temperature.
</p>
<h4>
  <span style=\"color:#008000\">Example</span>
</h4>
<p>
  <a href=
  \"AixLib.Fluid.HeatPumps.Examples.HeatPumpSimple\">AixLib.Fluid.HeatPumps.Examples.HeatPumpSimple</a>
</p>
<ul>
  <li>May 15, 2017, by Christian Behm:<br/>
    Added missing documentation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/373\">issue 373</a>).
  </li>
  <li>November, 2014, by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class
  </li>
  <li>November 25, 2013, by Kristian Huchtemann:<br/>
    Implemented
  </li>
</ul>
</html>"));
end HeatPumpSimple;
