within AixLib.Fluid.HeatPumps.Examples;
model HeatPumpDetailed
  "Example for the detailed heat pump model in order to compare to simple one."

 extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=1000)
    "Pulse signal for the on/off input of the heat pump"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Sources.MassFlowSource_T                sourceSideMassFlowSource(
    use_T_in=true,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=1,
    nPorts=1,
    T=275.15) "Ideal mass flow source at the inlet of the source side"
              annotation (Placement(transformation(extent={{-44,4},{-24,24}})));

  Sources.FixedBoundary                sourceSideFixedBoundary(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
      nPorts=1) "Fixed boundary at the outlet of the source side"
          annotation (Placement(transformation(extent={{-46,-18},{-26,2}})));
  Sources.FixedBoundary                sinkSideFixedBoundary(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
    "Fixed boundary at the outlet of the sink side"
    annotation (Placement(transformation(extent={{96,4},{76,24}})));
  Sources.MassFlowSource_T                sinkSideMassFlowSource(
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
  Sensors.TemperatureTwoPort                temperature(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=
       heatPump.mFlow_conNominal)
    "Temperature sensor at the outlet of the sink side"
    annotation (Placement(transformation(extent={{42,4},{62,24}})));
  Modelica.Blocks.Interfaces.RealOutput Pel
    "Power consumption of the heat pump"
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Modelica.Blocks.Interfaces.RealOutput T_Co_out
    "Temperature at the outlet of the sink side of the heat pump"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  .AixLib.Fluid.HeatPumps.HeatPumpDetailed heatPump(
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    P_eleOutput=true,
    CorrFlowCo=false,
    CorrFlowEv=false,
    dataTable=AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
        tableQdot_con=[0,0,10; 35,4800,6300; 55,4400,5750],
        tableP_ele=[0,0,10; 35,1100,1150; 55,1600,1750],
        mFlow_conNom=0.01,
        mFlow_evaNom=0.01),
    capCalcType=2,
    HPctrlType=false)
    "Detailed heat pump mainly based on manufacturing data"
    annotation (Placement(transformation(extent={{-6,0},{24,20}})));
  Modelica.Blocks.Sources.Ramp NRamp(
    height=3000,
    duration=2600,
    offset=1300,
    startTime=500)
    "Ramp signal for the temperature input of the source side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-2,56},{18,76}})));
equation
  connect(TsuSourceRamp.y, sourceSideMassFlowSource.T_in) annotation (Line(
      points={{-59,10},{-54,10},{-54,18},{-46,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(massFlowPulse.y, sinkSideMassFlowSource.m_flow_in) annotation (Line(
      points={{-59,-50},{20,-50},{20,-40}},
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

  connect(heatPump.P_eleOut, Pel) annotation (Line(
      points={{4,1},{4,-10},{110,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanPulse.y, heatPump.onOff_in) annotation (Line(
      points={{-59,50},{4,50},{4,19}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sourceSideMassFlowSource.ports[1], heatPump.port_evaIn) annotation (
     Line(
      points={{-24,14},{-14,14},{-14,17},{-4,17}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sourceSideFixedBoundary.ports[1], heatPump.port_evaOut) annotation (
     Line(
      points={{-26,-8},{-12,-8},{-12,3},{-4,3}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatPump.port_conOut, temperature.port_a) annotation (Line(
      points={{22,17},{28,17},{28,14},{42,14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatPump.port_conIn, sinkSideMassFlowSource.ports[1]) annotation (
      Line(
      points={{22,3},{36,3},{36,-18},{50,-18},{50,-48},{40,-48}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(NRamp.y, heatPump.N_in)
    annotation (Line(points={{19,66},{8,66},{8,19}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=3600),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Simple test set-up for the HeatPumpDetailed model. The heat pump is turned on and off while the source temperature increases linearly. Outputs are the electric power consumption of the heat pump and the supply temperature. </p>
<p>Besides using the default simple table data, the user should also test tabulated data from <a href=\"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a> or polynomial functions.</p>
</html>",
      revisions="<html>
 <ul>
  <li>
  May 19, 2017, by Mirko Engelpracht:<br/>
  Added missing documentation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/391\">issue 391</a>).
  </li>
  <li>
  October 17, 2016, by Philipp Mehrfeld:<br/>
  Implemented especially for comparison to simple heat pump model.
  </li>
 </ul>
</html>
"));
end HeatPumpDetailed;
