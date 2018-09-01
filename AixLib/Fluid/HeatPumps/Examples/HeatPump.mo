within AixLib.Fluid.HeatPumps.Examples;
model HeatPump
  "Example for the detailed heat pump model in order to compare to simple one."
  import AixLib;

 extends Modelica.Icons.Example;

  Sources.MassFlowSource_T                sourceSideMassFlowSource(
    use_T_in=true,
    m_flow=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=275.15,
    nPorts=1) "Ideal mass flow source at the inlet of the source side"
              annotation (Placement(transformation(extent={{-54,42},{-34,62}})));

  Sources.FixedBoundary                sourceSideFixedBoundary(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts
      =1)       "Fixed boundary at the outlet of the source side"
          annotation (Placement(transformation(extent={{-68,-56},{-48,-36}})));
  Sources.FixedBoundary                sinkSideFixedBoundary(
      redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
    "Fixed boundary at the outlet of the sink side"
    annotation (Placement(transformation(extent={{92,48},{72,68}})));
  Sources.MassFlowSource_T                sinkSideMassFlowSource(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.5,
    use_m_flow_in=true,
    T=308.15,
    nPorts=1) "Ideal mass flow source at the inlet of the sink side"
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,-32})));
  Modelica.Blocks.Sources.Ramp TsuSourceRamp(
    duration=1000,
    startTime=1000,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the source side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-94,20},{-74,40}})));
  Modelica.Blocks.Sources.Pulse massFlowPulse(
    amplitude=0.5,
    period=1000,
    offset=0,
    startTime=0,
    width=51)
    "Pulse signal for the mass flow input of the sink side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,-46})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={2,-70})));
  AixLib.Fluid.HeatPumps.HeatPump heatPump annotation (Placement(transformation(
        extent={{-24,-29},{24,29}},
        rotation=270,
        origin={2,-3})));
equation

  connect(TsuSourceRamp.y,sourceSideMassFlowSource. T_in) annotation (Line(
      points={{-73,30},{-68,30},{-68,56},{-56,56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(massFlowPulse.y,sinkSideMassFlowSource. m_flow_in) annotation (Line(
      points={{95,-46},{72,-46},{72,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_amb_internal.y, heatPump.T_amb_con) annotation (Line(points={{2,-59},
          {4,-59},{4,-29.64},{11.9083,-29.64}}, color={0,0,127}));
  connect(T_amb_internal.y, heatPump.T_amb_eva) annotation (Line(points={{2,-59},
          {2,-29.64},{-7.425,-29.64}}, color={0,0,127}));
  connect(sourceSideMassFlowSource.ports[1], heatPump.port_b2) annotation (Line(
        points={{-34,52},{-24,52},{-24,21},{-12.5,21}}, color={0,127,255}));
  connect(heatPump.port_a2, sourceSideFixedBoundary.ports[1]) annotation (Line(
        points={{-12.5,-27},{-48,-27},{-48,-46}}, color={0,127,255}));
  connect(heatPump.port_a1, sinkSideFixedBoundary.ports[1]) annotation (Line(
        points={{16.5,21},{45.25,21},{45.25,58},{72,58}}, color={0,127,255}));
  connect(sinkSideMassFlowSource.ports[1], heatPump.port_b1) annotation (Line(
        points={{50,-32},{34,-32},{34,-27},{16.5,-27}}, color={0,127,255}));
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
"), __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump.mos" "Simulate and plot"));
end HeatPump;
