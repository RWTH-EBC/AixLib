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
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts
      =1) "Fixed boundary at the outlet of the source side"
          annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-86,40})));
  Modelica.Blocks.Sources.Ramp TsuSourceRamp(
    duration=1000,
    startTime=1000,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the source side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-94,-84},{-74,-64}})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-70})));
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
    use_comIne=false,
    comIneTime_constant=1,
    scalingFactor=1,
    redeclare model PerDataChi =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (
          dataTable=AixLib.DataBase.HeatPump.EN14511.Ochsner_GMLW_19()),
    use_revHP=false,
    VEva = 0.04,
    VCon = 0.04,
    CEva=100,
    GEva=5,
    CCon=100,
    GCon=5,
    dpEva_nominal=0,
    dpCon_nominal=0,
    use_EvaCap=true,
    use_ConCap=true,
    TCon_start=303.15,
    TAmbCon_nom=288.15,
    TAmbEva_nom=273.15)        annotation (Placement(transformation(
        extent={{-24,-29},{24,29}},
        rotation=270,
        origin={0,-21})));



  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-6,22})));

  AixLib.Fluid.Sensors.TemperatureTwoPort
                             senTAct(
    final transferHeat=true,
    final m_flow_nominal=heatPump.mFlow_conNominal,
    final tau=1,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final tauHeaTra=1200,
    redeclare final package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    final allowFlowReversal=heatPump.allowFlowReversalCon,
    final T_start=303.15,
    final TAmb=291.15)      "Temperature at sink  inlet"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={54,-64})));
  Modelica.Blocks.Logical.Hysteresis hys(
    pre_y_start=true,
    uLow=273.15 + 30,
    uHigh=273.15 + 40)
    annotation (Placement(transformation(extent={{62,50},{42,70}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{26,32},{6,52}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/3600,
    amplitude=3000,
    offset=3000)
    annotation (Placement(transformation(extent={{76,26},{84,34}})));
  AixLib.Fluid.Movers.SpeedControlled_Nrpm
                                    pumSou(
    redeclare final package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare final AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,

    final allowFlowReversal=true,
    final addPowerToMedium=false)
    "Fan or pump at source side of HP" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={48,14})));
  AixLib.Fluid.MixingVolumes.MixingVolume Room(
    nPorts=2,
    final use_C_flow=false,
    final m_flow_nominal=heatPump.mFlow_conNominal,
    final V=5,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    final allowFlowReversal=true) "Volume of Condenser" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={86,-20})));
  Modelica.Blocks.Sources.Constant nIn(k=100) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={48,36})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateCon
    "Heat flow rate of the condenser" annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=270,
        origin={94,6})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={96,22})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        origin={30,62},
        rotation=180)));
  AixLib.Fluid.Sources.FixedBoundary sinkSideFixedBoundary(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
    "Fixed boundary at the outlet of the sink side" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={88,-64})));
equation

  connect(TsuSourceRamp.y,sourceSideMassFlowSource. T_in) annotation (Line(
      points={{-73,-74},{-68,-74},{-68,-66},{-56,-66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_amb_internal.y, heatPump.T_amb_con) annotation (Line(points={{
          1.9984e-15,-59},{4,-59},{4,-47.64},{9.90833,-47.64}},
                                                color={0,0,127}));
  connect(T_amb_internal.y, heatPump.T_amb_eva) annotation (Line(points={{
          1.9984e-15,-59},{1.9984e-15,-47.64},{-9.425,-47.64}},
                                       color={0,0,127}));
  connect(booleanConstant.y, heatPump.modeSet) annotation (Line(points={{-6,17.6},
          {-4.83333,17.6},{-4.83333,6.84}},         color={255,0,255}));
  connect(sourceSideMassFlowSource.ports[1], heatPump.port_a2) annotation (Line(
        points={{-34,-70},{-24,-70},{-24,-45},{-14.5,-45}}, color={0,127,255}));
  connect(booleanToReal.y, heatPump.nSet) annotation (Line(points={{5,42},{
          4.83333,42},{4.83333,6.84}}, color={0,0,127}));
  connect(nIn.y, pumSou.Nrpm)
    annotation (Line(points={{48,31.6},{48,26}}, color={0,0,127}));
  connect(Room.heatPort, heatFlowRateCon.port)
    annotation (Line(points={{86,-10},{86,0},{94,0}}, color={191,0,0}));
  connect(sine.y, gain.u) annotation (Line(points={{84.4,30},{92,30},{92,26.8},
          {96,26.8}}, color={0,0,127}));
  connect(heatFlowRateCon.Q_flow, gain.y) annotation (Line(points={{94,12},{98,
          12},{98,17.6},{96,17.6}}, color={0,0,127}));
  connect(heatPump.port_b2, sourceSideFixedBoundary.ports[1])
    annotation (Line(points={{-14.5,3},{-76,3},{-76,40}}, color={0,127,255}));
  connect(heatPump.port_b1, senTAct.port_a) annotation (Line(points={{14.5,-45},
          {30,-45},{30,-64},{44,-64}}, color={0,127,255}));
  connect(Room.ports[1], pumSou.port_a) annotation (Line(points={{76,-18},{76,4},
          {58,4},{58,14}}, color={0,127,255}));
  connect(pumSou.port_b, heatPump.port_a1) annotation (Line(points={{38,14},{26,
          14},{26,3},{14.5,3}}, color={0,127,255}));
  connect(senTAct.T, hys.u) annotation (Line(points={{54,-53},{56,-53},{56,-6},
          {66,-6},{66,50},{72,50},{72,60},{64,60}}, color={0,0,127}));
  connect(hys.y, not2.u) annotation (Line(points={{41,60},{38,60},{38,62},{34.8,
          62}}, color={255,0,255}));
  connect(booleanToReal.u, not2.y) annotation (Line(points={{28,42},{20,42},{20,
          62},{25.6,62}}, color={255,0,255}));
  connect(senTAct.port_b, sinkSideFixedBoundary.ports[1]) annotation (Line(
        points={{64,-64},{72,-64},{72,-64},{78,-64}}, color={0,127,255}));
  connect(senTAct.port_b, Room.ports[2]) annotation (Line(points={{64,-64},{66,
          -64},{66,-22},{76,-22}}, color={0,127,255}));
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
