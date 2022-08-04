within AixLib.Obsolete.Year2019.Fluid.HeatPumps.Examples;
model HeatPumpSimple
  "Example for the simple heat pump model in order to compare to detailed one."
 extends AixLib.Obsolete.BaseClasses.ObsoleteModel;
 import AixLib;

 extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=1000)
    "Pulse signal for the on/off input of the heat pump"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  AixLib.Fluid.Sources.MassFlowSource_T sourceSideMassFlowSource(
    use_T_in=true,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=1,
    nPorts=1,
    T=275.15) "Ideal mass flow source at the inlet of the source side"
    annotation (Placement(transformation(extent={{-44,4},{-24,24}})));

  AixLib.Fluid.Sources.Boundary_pT sourceSideFixedBoundary(redeclare package Medium =
               Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
    "Fixed boundary at the outlet of the source side"
    annotation (Placement(transformation(extent={{-46,-18},{-26,2}})));
  AixLib.Fluid.Sources.Boundary_pT sinkSideFixedBoundary(redeclare package Medium =
               Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
    "Fixed boundary at the outlet of the sink side"
    annotation (Placement(transformation(extent={{96,4},{76,24}})));
  AixLib.Fluid.Sources.MassFlowSource_T sinkSideMassFlowSource(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.5,
    use_m_flow_in=true,
    nPorts=1,
    T=308.15) "Ideal mass flow source at the inlet of the sink side"
    annotation (Placement(transformation(extent={{20,-58},{40,-38}})));

  Modelica.Blocks.Sources.Ramp TsuSourceRamp(
    duration=1000,
    startTime=1000,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the source side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.Pulse massFlowPulse(
    amplitude=0.5,
    period=1000,
    offset=0,
    startTime=0,
    width=51)
    "Pulse signal for the mass flow input of the sink side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package Medium =
               Modelica.Media.Water.ConstantPropertyLiquidWater,
      m_flow_nominal=0.01)
    "Temperature sensor at the outlet of the sink side"
    annotation (Placement(transformation(extent={{42,4},{62,24}})));
  Modelica.Blocks.Interfaces.RealOutput Pel
    "Power consumption of the heat pump"
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Modelica.Blocks.Interfaces.RealOutput T_Co_out
    "Temperature at the outlet of the sink side of the heat pump"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  AixLib.Obsolete.Year2019.Fluid.HeatPumps.HeatPumpSimple heatPump(
    tablePower=[0.0,273.15,283.15; 308.15,1100,1150; 328.15,1600,1750],
    tableHeatFlowCondenser=[0.0,273.15,283.15; 308.15,4800,6300; 328.15,4400,5750],
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    VolumeEvaporator=0.004,
    VolumeCondenser=0.004) "Simple heat pump based on manufacturing data" annotation (Placement(transformation(extent={{-2,4},{18,24}})));

equation
  connect(TsuSourceRamp.y, sourceSideMassFlowSource.T_in) annotation (Line(
      points={{-59,10},{-54,10},{-54,18},{-46,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(massFlowPulse.y, sinkSideMassFlowSource.m_flow_in) annotation (Line(
      points={{-59,-50},{18,-50},{18,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sinkSideFixedBoundary.ports[1], temperature.port_b) annotation (Line(
      points={{76,14},{62,14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature.T, T_Co_out) annotation (Line(
      points={{52,25},{52,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(booleanPulse.y, heatPump.OnOff)
    annotation (Line(points={{-59,50},{8,50},{8,22}}, color={255,0,255}));
  connect(sourceSideMassFlowSource.ports[1], heatPump.port_a_source)
    annotation (Line(points={{-24,14},{-12,14},{-12,21},{-1,21}}, color={0,127,
          255}));
  connect(heatPump.port_b_source, sourceSideFixedBoundary.ports[1]) annotation (
     Line(points={{-1,7},{-12.5,7},{-12.5,-8},{-26,-8}}, color={0,127,255}));
  connect(heatPump.Power, Pel) annotation (Line(points={{8,5},{10,5},{10,-6},{
          10,-10},{110,-10}}, color={0,0,127}));
  connect(heatPump.port_a_sink, sinkSideMassFlowSource.ports[1]) annotation (
      Line(points={{17,7},{28,7},{28,-8},{54,-8},{54,-48},{40,-48}}, color={0,
          127,255}));
  connect(heatPump.port_b_sink, temperature.port_a) annotation (Line(points={{
          17,21},{34,21},{34,14},{42,14}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=3600),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Simple test set-up for the HeatPumpSimple model. The heat pump is
  turned on and off while the source temperature increases linearly.
  Outputs are the electric power consumption of the heat pump and the
  supply temperature.
</p>
</html>",
      revisions="<html><ul>
  <li>May 19, 2017, by Mirko Engelpracht:<br/>
    Added missing documentation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/391\">issue 391</a>).
  </li>
  <li>December 10, 2013, by Ole Odendahl:<br/>
    Formatted documentation appropriately.
  </li>
</ul>
</html>
"));
end HeatPumpSimple;
