within AixLib.Fluid.HeatPumps.Examples;
model HeatPump "Example for the reversible heat pump model."
 extends Modelica.Icons.Example;

  replaceable package Medium_sin = AixLib.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package Medium_sou = AixLib.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  AixLib.Fluid.Sources.MassFlowSource_T                sourceSideMassFlowSource(
    use_T_in=true,
    m_flow=1,
    nPorts=1,
    redeclare package Medium = Medium_sou,
    T=275.15) "Ideal mass flow source at the inlet of the source side"
              annotation (Placement(transformation(extent={{-54,-80},{-34,-60}})));

  AixLib.Fluid.Sources.Boundary_pT                  sourceSideFixedBoundary(
                                                                         nPorts=
       1, redeclare package Medium = Medium_sou)
          "Fixed boundary at the outlet of the source side"
          annotation (Placement(transformation(extent={{-11,11},{11,-11}},
        rotation=0,
        origin={-81,3})));
  Modelica.Blocks.Sources.Ramp TsuSourceRamp(
    duration=500,
    startTime=500,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the source side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-94,-90},{-74,-70}})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={2,-76})));
  AixLib.Fluid.HeatPumps.HeatPump heatPump(
    refIneFre_constant=1,
    useBusConnectorOnly=true,
    CEva=100,
    GEvaOut=5,
    CCon=100,
    GConOut=5,
    dpEva_nominal=0,
    dpCon_nominal=0,
    VCon=0.4,
    use_conCap=false,
    redeclare package Medium_con = Medium_sin,
    redeclare package Medium_eva = Medium_sou,
    use_refIne=false,
    use_rev=true,
    redeclare model PerDataMainHP =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (
         dataTable=
            AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
    redeclare model PerDataRevHP =
        AixLib.DataBase.Chiller.PerformanceData.LookUpTable2D (
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
           AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
    VEva=0.04,
    use_evaCap=false,
    scalingFactor=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    mFlow_conNominal=0.5,
    mFlow_evaNominal=0.5,
    use_autoCalc=false,
    TAmbEva_nominal=273.15,
    TAmbCon_nominal=288.15,
    TCon_start=303.15) annotation (Placement(transformation(
        extent={{-24,-29},{24,29}},
        rotation=270,
        origin={2,-21})));

  Modelica.Blocks.Sources.BooleanStep     booleanStep(startTime=1800,
      startValue=true)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-4,84})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTAct(
    final m_flow_nominal=heatPump.m1_flow_nominal,
    final tau=1,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final tauHeaTra=1200,
    final allowFlowReversal=heatPump.allowFlowReversalCon,
    final transferHeat=false,
    redeclare final package Medium = Medium_sin,
    final T_start=303.15,
    final TAmb=291.15) "Temperature at sink inlet" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={54,-64})));
  Modelica.Blocks.Logical.Hysteresis hysHeating(
    pre_y_start=true,
    uLow=273.15 + 30,
    uHigh=273.15 + 35)
    annotation (Placement(transformation(extent={{66,58},{56,68}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={7,29})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/3600,
    amplitude=3000,
    offset=3000)
    annotation (Placement(transformation(extent={{76,26},{84,34}})));
  AixLib.Fluid.Movers.SpeedControlled_Nrpm
                                    pumSou(
    redeclare final AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
    final allowFlowReversal=true,
    final addPowerToMedium=false,
    redeclare final package Medium = Medium_sin,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Fan or pump at source side of HP" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,12})));

  AixLib.Fluid.MixingVolumes.MixingVolume Room(
    nPorts=2,
    final use_C_flow=false,
    final m_flow_nominal=heatPump.m1_flow_nominal,
    final V=5,
    final allowFlowReversal=true,
    redeclare package Medium = Medium_sin,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Volume of Condenser" annotation (Placement(transformation(
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
        origin={86,6})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={92,20})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        origin={45,63},
        rotation=180)));
  AixLib.Fluid.Sources.Boundary_pT   sinkSideFixedBoundary(      nPorts=1,
      redeclare package Medium = Medium_sin)
    "Fixed boundary at the outlet of the sink side" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={88,-64})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-66,38})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{24,48},{14,58}})));
  Modelica.Blocks.Logical.Hysteresis hysCooling(
    pre_y_start=false,
    uLow=273.15 + 15,
    uHigh=273.15 + 19)
    annotation (Placement(transformation(extent={{58,40},{48,50}})));
  Controls.Interfaces.VapourCompressionMachineControlBus sigBus1 annotation (Placement(
        transformation(extent={{-34,22},{-4,56}}), iconTransformation(extent={{
            -22,30},{-4,56}})));
equation


  connect(sourceSideMassFlowSource.ports[1], heatPump.port_a2) annotation (Line(
        points={{-34,-70},{-24,-70},{-24,-45},{-12.5,-45}}, color={0,127,255}));
  connect(nIn.y, pumSou.Nrpm)
    annotation (Line(points={{50,29.6},{50,24}}, color={0,0,127}));
  connect(Room.heatPort, heatFlowRateCon.port)
    annotation (Line(points={{86,-10},{86,0}},        color={191,0,0}));
  connect(sine.y, gain.u) annotation (Line(points={{84.4,30},{92,30},{92,24.8}},
                      color={0,0,127}));
  connect(heatFlowRateCon.Q_flow, gain.y) annotation (Line(points={{86,12},{86,
          14},{92,14},{92,15.6}},   color={0,0,127}));
  connect(heatPump.port_b2, sourceSideFixedBoundary.ports[1]) annotation (Line(
        points={{-12.5,3},{-70,3}},                   color={0,127,255}));
  connect(heatPump.port_b1, senTAct.port_a) annotation (Line(points={{16.5,-45},
          {30,-45},{30,-64},{44,-64}}, color={0,127,255}));
  connect(Room.ports[1], pumSou.port_a) annotation (Line(points={{76,-18},{76,4},
          {60,4},{60,12}}, color={0,127,255}));
  connect(pumSou.port_b, heatPump.port_a1) annotation (Line(points={{40,12},{28,
          12},{28,3},{16.5,3}}, color={0,127,255}));
  connect(senTAct.T, hysHeating.u) annotation (Line(points={{54,-53},{54,-54},{
          54,-54},{54,-54},{54,-8},{70,-8},{70,63},{67,63}}, color={0,0,127}));
  connect(hysHeating.y, not2.u)
    annotation (Line(points={{55.5,63},{51,63}}, color={255,0,255}));
  connect(senTAct.port_b, sinkSideFixedBoundary.ports[1]) annotation (Line(
        points={{64,-64},{72,-64},{72,-64},{78,-64}}, color={0,127,255}));
  connect(senTAct.port_b, Room.ports[2]) annotation (Line(points={{64,-64},{66,
          -64},{66,-22},{76,-22}}, color={0,127,255}));
  connect(TsuSourceRamp.y, sourceSideMassFlowSource.T_in) annotation (Line(
        points={{-73,-80},{-66,-80},{-66,-66},{-56,-66}}, color={0,0,127},
        smooth=Smooth.None));
  connect(logicalSwitch.u1, not2.y) annotation (Line(points={{25,57},{36,57},{
          36,63},{39.5,63}}, color={255,0,255}));
  connect(hysCooling.y, logicalSwitch.u3) annotation (Line(points={{47.5,45},{
          36,45},{36,49},{25,49}}, color={255,0,255}));
  connect(senTAct.T, hysCooling.u) annotation (Line(points={{54,-53},{54,-54},{
          54,-54},{54,-54},{54,-54},{54,-54},{54,-8},{70,-8},{70,45},{59,45}},
        color={0,0,127}));
  connect(booleanStep.y, logicalSwitch.u2) annotation (Line(points={{-4,77.4},{
          -4,66},{32,66},{32,53},{25,53}}, color={255,0,255}));
  connect(logicalSwitch.y, booleanToReal.u)
    annotation (Line(points={{13.5,53},{7,53},{7,35}}, color={255,0,255}));
  connect(booleanStep.y, sigBus1.modeSet) annotation (Line(points={{-4,77.4},{-10,
          77.4},{-10,39.085},{-18.925,39.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(iceFac.y, sigBus1.iceFacMea) annotation (Line(points={{-57.2,38},{-34,
          38},{-34,39.085},{-18.925,39.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanToReal.y, sigBus1.nSet) annotation (Line(points={{7,23.5},{-18.925,
          23.5},{-18.925,39.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus1, heatPump.sigBus) annotation (Line(
      points={{-19,39},{-19,16},{-10,16},{-10,2.76},{-7.425,2.76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(Tolerance=1e-6, StopTime=3600),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump.mos"
        "Simulate and plot"),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Simple test set-up for the HeatPumpDetailed model. The heat pump is
  turned on and off while the source temperature increases linearly.
  Outputs are the electric power consumption of the heat pump and the
  supply temperature.
</p>
<p>
  Besides using the default simple table data, the user should also
  test tabulated data from <a href=
  \"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a> or
  polynomial functions.
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"),
    __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump.mos" "Simulate and plot"),
    Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
end HeatPump;
