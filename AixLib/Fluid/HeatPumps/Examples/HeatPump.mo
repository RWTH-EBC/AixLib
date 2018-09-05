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
              annotation (Placement(transformation(extent={{-54,-80},{-34,-60}})));

  Sources.FixedBoundary                sourceSideFixedBoundary(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=
       1)       "Fixed boundary at the outlet of the source side"
          annotation (Placement(transformation(extent={{-68,24},{-48,44}})));
  Sources.FixedBoundary                sinkSideFixedBoundary(
      redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
    "Fixed boundary at the outlet of the sink side"
    annotation (Placement(transformation(extent={{70,-62},{50,-42}})));
  Sources.MassFlowSource_T                sinkSideMassFlowSource(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.5,
    use_m_flow_in=true,
    T=308.15,
    nPorts=1) "Ideal mass flow source at the inlet of the sink side"
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,20})));
  Modelica.Blocks.Sources.Ramp TsuSourceRamp(
    duration=1000,
    startTime=1000,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the source side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-94,-84},{-74,-64}})));
  Modelica.Blocks.Sources.Pulse massFlowPulse(
    amplitude=0.5,
    period=1000,
    offset=0,
    startTime=0,
    width=51)
    "Pulse signal for the mass flow input of the sink side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={100,4})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={2,-70})));
  AixLib.Fluid.HeatPumps.HeatPump heatPump(
    redeclare model PerDataHea =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (
          dataTable=AixLib.DataBase.HeatPump.EN14511.Ochsner_GMLW_19()),
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    mFlow_conNominal=1,
    mFlow_evaNominal=1,
    dpEva_nominal=0,
    dpCon_nominal=0,
    use_comIne=false,
    comIneTime_constant=1,
    use_EvaCap=false,
    use_ConCap=false,
    CEva=0,
    GEva=0,
    CCon=0,
    GCon=0,
    scalingFactor=1,
    redeclare model PerDataChi =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (
          dataTable=AixLib.DataBase.HeatPump.EN14511.Ochsner_GMLW_19()),
    use_revHP=false,
    VEva = 0.04,
    VCon = 0.04)                     annotation (Placement(transformation(
        extent={{-24,-29},{24,29}},
        rotation=270,
        origin={2,-3})));
  Modelica.Blocks.Sources.Pulse pulse(period=500)
    annotation (Placement(transformation(extent={{-4,56},{16,76}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-32,62},{-12,82}})));

equation

  connect(TsuSourceRamp.y,sourceSideMassFlowSource. T_in) annotation (Line(
      points={{-73,-74},{-68,-74},{-68,-66},{-56,-66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(massFlowPulse.y,sinkSideMassFlowSource. m_flow_in) annotation (Line(
      points={{89,4},{74,4},{74,12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_amb_internal.y, heatPump.T_amb_con) annotation (Line(points={{2,-59},
          {4,-59},{4,-29.64},{11.9083,-29.64}}, color={0,0,127}));
  connect(T_amb_internal.y, heatPump.T_amb_eva) annotation (Line(points={{2,-59},
          {2,-29.64},{-7.425,-29.64}}, color={0,0,127}));
  connect(pulse.y, heatPump.nSet) annotation (Line(points={{17,66},{14,66},{14,
          24.84},{6.83333,24.84}}, color={0,0,127}));
  connect(booleanConstant.y, heatPump.modeSet) annotation (Line(points={{-11,72},
          {-11,50},{-2.83333,50},{-2.83333,24.84}}, color={255,0,255}));
  connect(heatPump.port_b2, sourceSideFixedBoundary.ports[1]) annotation (Line(
        points={{-12.5,21},{-30.25,21},{-30.25,34},{-48,34}}, color={0,127,255}));
  connect(sourceSideMassFlowSource.ports[1], heatPump.port_a2) annotation (Line(
        points={{-34,-70},{-24,-70},{-24,-27},{-12.5,-27}}, color={0,127,255}));
  connect(sinkSideMassFlowSource.ports[1], heatPump.port_a1) annotation (Line(
        points={{52,20},{36,20},{36,21},{16.5,21}}, color={0,127,255}));
  connect(sinkSideFixedBoundary.ports[1], heatPump.port_b1) annotation (Line(
        points={{50,-52},{34,-52},{34,-27},{16.5,-27}}, color={0,127,255}));
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
