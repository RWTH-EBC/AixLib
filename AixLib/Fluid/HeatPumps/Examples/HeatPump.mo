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
       1) "Fixed boundary at the outlet of the source side"
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
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_refIne=false,
    refIneFre_constant=1,
    scalingFactor=1,
    redeclare model PerDataChi =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (
          dataTable=AixLib.DataBase.HeatPump.EN14511.Ochsner_GMLW_19()),
    use_revHP=false,
    VEva=0.04,
    CEva=100,
    GEva=5,
    CCon=100,
    GCon=5,
    dpEva_nominal=0,
    dpCon_nominal=0,
    mFlow_conNominal=0.5,
    mFlow_evaNominal=0.5,
    use_EvaCap=false,
    use_ConCap=false,
    VCon=0.4,
    redeclare model PerDataHea =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D,
    TCon_start=303.15,
    TAmbCon_nom=288.15,
    TAmbEva_nom=273.15) annotation (Placement(transformation(
        extent={{-24,-29},{24,29}},
        rotation=270,
        origin={2,-21})));



  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-10,82})));

  AixLib.Fluid.Sensors.TemperatureTwoPort
                             senTAct(
    final m_flow_nominal=heatPump.mFlow_conNominal,
    final tau=1,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final tauHeaTra=1200,
    redeclare final package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    final allowFlowReversal=heatPump.allowFlowReversalCon,
    final T_start=303.15,
    final transferHeat=false,
    final TAmb=291.15)      "Temperature at sink  inlet"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={54,-64})));
  Modelica.Blocks.Logical.Hysteresis hys(
    pre_y_start=true,
    uLow=273.15 + 35,
    uHigh=273.15 + 40)
    annotation (Placement(transformation(extent={{64,50},{44,70}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{30,30},{10,50}})));
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
        origin={50,12})));

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
        origin={50,34})));
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
        origin={32,62},
        rotation=180)));
  AixLib.Fluid.Sources.FixedBoundary sinkSideFixedBoundary(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
    "Fixed boundary at the outlet of the sink side" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={88,-64})));
  AixLib.Controls.HeatPump.SecurityControls.SecurityControl securityControl(
    use_minLocTime=true,
    minLocTime(displayUnit="min") = 180,
    tableLow=[-100,0; 100,0],
    tableUpp=[-100,65; 100,65],
    pre_n_start=false,
    use_deFro=false,
    minIceFac=0,
    calcPel_deFro=0,
    use_minRunTime=true,
    minRunTime(displayUnit="min") = 180,
    use_runPerHou=true,
    maxRunPerHou=3) annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={-20,44})));
equation

  connect(TsuSourceRamp.y,sourceSideMassFlowSource. T_in) annotation (Line(
      points={{-73,-74},{-68,-74},{-68,-66},{-56,-66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_amb_internal.y, heatPump.T_amb_con) annotation (Line(points={{
          1.9984e-15,-59},{4,-59},{4,-47.64},{11.9083,-47.64}},
                                                color={0,0,127}));
  connect(T_amb_internal.y, heatPump.T_amb_eva) annotation (Line(points={{
          1.9984e-15,-59},{1.9984e-15,-47.64},{-7.425,-47.64}},
                                       color={0,0,127}));
  connect(sourceSideMassFlowSource.ports[1], heatPump.port_a2) annotation (Line(
        points={{-34,-70},{-24,-70},{-24,-45},{-12.5,-45}}, color={0,127,255}));
  connect(nIn.y, pumSou.Nrpm)
    annotation (Line(points={{50,29.6},{50,24}}, color={0,0,127}));
  connect(Room.heatPort, heatFlowRateCon.port)
    annotation (Line(points={{86,-10},{86,0},{94,0}}, color={191,0,0}));
  connect(sine.y, gain.u) annotation (Line(points={{84.4,30},{92,30},{92,26.8},
          {96,26.8}}, color={0,0,127}));
  connect(heatFlowRateCon.Q_flow, gain.y) annotation (Line(points={{94,12},{98,
          12},{98,17.6},{96,17.6}}, color={0,0,127}));
  connect(heatPump.port_b2, sourceSideFixedBoundary.ports[1])
    annotation (Line(points={{-12.5,3},{-62,3},{-62,40},{-76,40}},
                                                          color={0,127,255}));
  connect(heatPump.port_b1, senTAct.port_a) annotation (Line(points={{16.5,-45},
          {30,-45},{30,-64},{44,-64}}, color={0,127,255}));
  connect(Room.ports[1], pumSou.port_a) annotation (Line(points={{76,-18},{76,4},
          {60,4},{60,12}}, color={0,127,255}));
  connect(pumSou.port_b, heatPump.port_a1) annotation (Line(points={{40,12},{28,
          12},{28,3},{16.5,3}}, color={0,127,255}));
  connect(senTAct.T, hys.u) annotation (Line(points={{54,-53},{58,-53},{58,-8},
          {68,-8},{68,48},{74,48},{74,60},{66,60}}, color={0,0,127}));
  connect(hys.y, not2.u) annotation (Line(points={{43,60},{44,60},{44,62},{36.8,
          62}}, color={255,0,255}));
  connect(booleanToReal.u, not2.y) annotation (Line(points={{32,40},{32,62},{
          27.6,62}},      color={255,0,255}));
  connect(senTAct.port_b, sinkSideFixedBoundary.ports[1]) annotation (Line(
        points={{64,-64},{72,-64},{72,-64},{78,-64}}, color={0,127,255}));
  connect(senTAct.port_b, Room.ports[2]) annotation (Line(points={{64,-64},{66,
          -64},{66,-22},{76,-22}}, color={0,127,255}));
  connect(heatPump.sigBusHP, securityControl.sigBusHP) annotation (Line(
      points={{-7.90833,5.64},{-7.90833,22},{-36,22},{-36,74},{-28.28,74},{
          -28.28,57.5}},
      color={255,204,51},
      thickness=0.5));
  connect(booleanConstant.y, securityControl.modeSet) annotation (Line(points={
          {-10,77.6},{-16,77.6},{-16,68},{-22.4,68},{-22.4,57.6}}, color={255,0,
          255}));
  connect(booleanToReal.y, securityControl.nSet) annotation (Line(points={{9,40},
          {-2,40},{-2,62},{-17.6,62},{-17.6,57.6}}, color={0,0,127}));
  connect(securityControl.modeOut, heatPump.modeSet) annotation (Line(points={{
          -22.4,31},{-22.4,18.5},{-2.83333,18.5},{-2.83333,6.84}}, color={255,0,
          255}));
  connect(securityControl.nOut, heatPump.nSet) annotation (Line(points={{-17.6,
          31},{-17.6,6.84},{6.83333,6.84}}, color={0,0,127}));
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
