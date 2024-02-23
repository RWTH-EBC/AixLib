within AixLib.Fluid.Chillers.Examples;
model Chiller "Example for the reversible chiller model."
 extends Modelica.Icons.Example;

  replaceable package Medium_sin = AixLib.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package Medium_sou = AixLib.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  AixLib.Fluid.Sources.MassFlowSource_T sinkSideMassFlowSource(
    use_T_in=true,
    m_flow=1,
    redeclare package Medium = Medium_sin,
    T=275.15,
    nPorts=1) "Ideal mass flow source at the inlet of the sink side"
    annotation (Placement(transformation(extent={{-54,-58},{-34,-38}})));

  Sources.Boundary_pT                sinkSideFixedBoundary(          redeclare
      package                                                                          Medium =
                       Medium_sin, nPorts=1)
    "Fixed boundary at the outlet of the sink side" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-86,62})));
  Modelica.Blocks.Sources.Ramp TsuSinkRamp(
    duration=500,
    startTime=500,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the sink side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-94,-76},{-74,-56}})));
  AixLib.Fluid.Chillers.Chiller chiller(
    refIneFre_constant=1,
    CEva=100,
    GEvaOut=5,
    CCon=100,
    GConOut=5,
    dpEva_nominal=0,
    dpCon_nominal=0,
    mFlow_conNominal=0.5,
    mFlow_evaNominal=0.5,
    use_conCap=false,
    use_evaCap=false,
    redeclare package Medium_con = Medium_sin,
    redeclare package Medium_eva = Medium_sou,
    use_refIne=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare model PerDataMainChi =
        AixLib.DataBase.Chiller.PerformanceData.LookUpTable2D (
          dataTable=
            AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
    redeclare model PerDataRevChi =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (
         smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
            AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
    use_rev=true,
    use_autoCalc=false,
    VEva=0.4,
    VCon=0.04,
    TAmbEva_nominal=288.15,
    TAmbCon_nominal=273.15,
    TEva_start=303.15) annotation (Placement(transformation(
        extent={{-24,-29},{24,29}},
        rotation=90,
        origin={2,1})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTAct(
    final m_flow_nominal=chiller.m2_flow_nominal,
    final tau=1,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final tauHeaTra=1200,
    final allowFlowReversal=chiller.allowFlowReversalCon,
    final transferHeat=false,
    redeclare final package Medium = Medium_sou,
    T_start=303.15,
    final TAmb=291.15) "Temperature at source outlet" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={54,-38})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/3600,
    amplitude=500,
    offset=500,
    phase=3.1415926535898)
    annotation (Placement(transformation(extent={{76,56},{84,64}})));
  AixLib.Fluid.Movers.SpeedControlled_Nrpm
                                    pumSou(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare final AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
    final allowFlowReversal=true,
    final addPowerToMedium=false,
    redeclare final package Medium = Medium_sou)
    "Fan or pump at source side of HP" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,34})));

  AixLib.Fluid.MixingVolumes.MixingVolume Room(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPorts=2,
    final use_C_flow=false,
    final m_flow_nominal=chiller.m2_flow_nominal,
    final V=5,
    final allowFlowReversal=true,
    redeclare package Medium = Medium_sou) "Volume of Condenser" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={86,2})));

  Modelica.Blocks.Sources.Constant nIn(k=100) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={50,56})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateEva
    "Heat flow rate of the evaporator"
                                      annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=270,
        origin={96,26})));
  Modelica.Blocks.Math.Gain gain(k=1)  annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={96,52})));
  Sources.Boundary_pT                sourceSideFixedBoundary(nPorts=1,
      redeclare package Medium = Medium_sou)
    "Fixed boundary at the outlet of the source side" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={88,-38})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={54,-6})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=270,
        origin={-3,-53})));
  Modelica.Blocks.Logical.Hysteresis hysCooling(
    pre_y_start=false,
    uHigh=273.15 + 17,
    uLow=273.15 + 14)
    annotation (Placement(transformation(extent={{46,-98},{34,-86}})));
  Modelica.Blocks.Sources.BooleanStep     booleanStep(
      startValue=true, startTime=1800)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=0,
        origin={32,-54})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        origin={24,-76},
        rotation=180)));
  Modelica.Blocks.Logical.Hysteresis hysHeating(
    pre_y_start=true,
    uLow=273.15 + 25,
    uHigh=273.15 + 30)
    annotation (Placement(transformation(extent={{46,-82},{34,-70}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{10,-78},{0,-88}})));
equation

  connect(nIn.y, pumSou.Nrpm)
    annotation (Line(points={{50,51.6},{50,46}}, color={0,0,127}));
  connect(Room.heatPort,heatFlowRateEva. port)
    annotation (Line(points={{86,12},{96,12},{96,18}},color={191,0,0}));
  connect(sine.y, gain.u) annotation (Line(points={{84.4,60},{92,60},{92,56.8},
          {96,56.8}}, color={0,0,127}));
  connect(heatFlowRateEva.Q_flow, gain.y) annotation (Line(points={{96,34},{96,
          47.6}},                   color={0,0,127}));
  connect(Room.ports[1], pumSou.port_a) annotation (Line(points={{76,4},{76,26},
          {60,26},{60,34}},color={0,127,255}));
  connect(senTAct.port_b, sourceSideFixedBoundary.ports[1]) annotation (Line(
        points={{64,-38},{78,-38}},                   color={0,127,255}));
  connect(senTAct.port_b, Room.ports[2]) annotation (Line(points={{64,-38},{66,-38},
          {66,0},{76,0}},          color={0,127,255}));
  connect(chiller.nSet, booleanToReal.y) annotation (Line(points={{-2.83333,
          -26.84},{-3,-26.84},{-3,-45.3}}, color={0,0,127}));
          connect(sinkSideMassFlowSource.ports[1], chiller.port_a1) annotation (Line(
        points={{-34,-48},{-12.5,-48},{-12.5,-23}}, color={0,127,255}));
  connect(sinkSideFixedBoundary.ports[1], chiller.port_b1) annotation (Line(
        points={{-76,62},{-50,62},{-50,25},{-12.5,25}}, color={0,127,255}));
  connect(pumSou.port_b, chiller.port_a2)
    annotation (Line(points={{40,34},{16.5,34},{16.5,25}}, color={0,127,255}));
  connect(chiller.port_b2, senTAct.port_a) annotation (Line(points={{16.5,-23},{
          32,-23},{32,-38},{44,-38}},  color={0,127,255}));
  connect(chiller.iceFac_in, iceFac.y) annotation (Line(points={{34.8667,-17.24},
          {42,-17.24},{42,-6},{47.4,-6}}, color={0,0,127}));
  connect(TsuSinkRamp.y, sinkSideMassFlowSource.T_in) annotation (Line(points={
          {-73,-66},{-68,-66},{-68,-44},{-56,-44}}, color={0,0,127}));
  connect(hysHeating.y, not2.u)
    annotation (Line(points={{33.4,-76},{28.8,-76}}, color={255,0,255}));
  connect(senTAct.T, hysHeating.u)
    annotation (Line(points={{54,-49},{54,-76},{47.2,-76}}, color={0,0,127}));
  connect(hysCooling.u, senTAct.T)
    annotation (Line(points={{47.2,-92},{54,-92},{54,-49}}, color={0,0,127}));
  connect(booleanStep.y, chiller.modeSet) annotation (Line(points={{23.2,-54},{12,
          -54},{12,-40},{6.83333,-40},{6.83333,-26.84}}, color={255,0,255}));
  connect(logicalSwitch.y, booleanToReal.u) annotation (Line(points={{-0.5,-83},
          {-3,-83},{-3,-61.4}}, color={255,0,255}));
  connect(not2.y, logicalSwitch.u3) annotation (Line(points={{19.6,-76},{16,-76},
          {16,-79},{11,-79}}, color={255,0,255}));
  connect(hysCooling.y, logicalSwitch.u1) annotation (Line(points={{33.4,-92},{16,
          -92},{16,-87},{11,-87}}, color={255,0,255}));
  connect(booleanStep.y, logicalSwitch.u2) annotation (Line(points={{23.2,-54},{
          14,-54},{14,-83},{11,-83}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(Tolerance=1e-6, StopTime=3600),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Chillers/Examples/Chiller.mos"
        "Simulate and plot"),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Simple test set-up for the reversible chiller model. The chiller is
  turned on and off while the source temperature increases linearly.
  Outputs are the electric power consumption of the chiller and the
  supply temperature.
</p>
<p>
  Besides using the default simple table data, the user should also
  test tabulated data from <a href=
  \"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.Chiller</a> or
  polynomial functions.
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>May 22, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
</ul>
</html>"),
    __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump.mos" "Simulate and plot"),
    Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
end Chiller;
