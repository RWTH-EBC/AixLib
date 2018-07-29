within AixLib.Fluid.HeatPumps.Examples;
model HeatPump
  "Example for the detailed heat pump model in order to compare to simple one."
  import AixLib;

 extends Modelica.Icons.Example;

  Sources.MassFlowSource_T                sourceSideMassFlowSource(
    use_T_in=true,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=1,
    T=275.15,
    nPorts=1) "Ideal mass flow source at the inlet of the source side"
              annotation (Placement(transformation(extent={{-58,6},{-38,26}})));
  Sources.FixedBoundary                sourceSideFixedBoundary(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts
      =1)       "Fixed boundary at the outlet of the source side"
          annotation (Placement(transformation(extent={{-58,-28},{-38,-8}})));
  Sources.FixedBoundary                sinkSideFixedBoundary(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
    "Fixed boundary at the outlet of the sink side"
    annotation (Placement(transformation(extent={{110,8},{90,28}})));
  Sources.MassFlowSource_T                sinkSideMassFlowSource(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.5,
    use_m_flow_in=true,
    T=308.15,
    nPorts=1) "Ideal mass flow source at the inlet of the sink side"
              annotation (Placement(transformation(extent={{20,-58},{40,-38}})));
  Modelica.Blocks.Sources.Ramp TsuSourceRamp(
    duration=1000,
    startTime=1000,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the source side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-94,2},{-74,22}})));
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
    annotation (Placement(transformation(extent={{56,8},{76,28}})));
  Modelica.Blocks.Interfaces.RealOutput Pel
    "Power consumption of the heat pump"
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Modelica.Blocks.Interfaces.RealOutput T_Co_out
    "Temperature at the outlet of the sink side of the heat pump"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  AixLib.Fluid.HeatPumps.HeatPumpReal heatPumpReal(useSecurity=false,
      useDefrost=true)
    annotation (Placement(transformation(extent={{-20,0},{20,20}})));
equation

  connect(TsuSourceRamp.y,sourceSideMassFlowSource. T_in) annotation (Line(
      points={{-73,12},{-68,12},{-68,20},{-60,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(massFlowPulse.y,sinkSideMassFlowSource. m_flow_in) annotation (Line(
      points={{-59,-50},{20,-50},{20,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sinkSideFixedBoundary.ports[1],temperature. port_b) annotation (Line(
      points={{90,18},{76,18}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature.T,T_Co_out)  annotation (Line(
      points={{66,29},{66,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sinkSideMassFlowSource.ports[1], heatPumpReal.port_a2) annotation (
      Line(points={{40,-48},{28,-48},{28,0},{16.4,0}}, color={0,127,255}));
  connect(heatPumpReal.port_b1, temperature.port_a) annotation (Line(points={{
          16.2,20},{36,20},{36,18},{56,18}}, color={0,127,255}));
  connect(heatPumpReal.port_a1, sourceSideMassFlowSource.ports[1]) annotation (
      Line(points={{9.2,20},{10,20},{10,34},{10,34},{10,34},{-26,34},{-26,16},{
          -38,16}}, color={0,127,255}));
  connect(heatPumpReal.port_b2, sourceSideFixedBoundary.ports[1]) annotation (
      Line(points={{9.2,0},{8,0},{8,-18},{-38,-18}}, color={0,127,255}));
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
end HeatPump;
