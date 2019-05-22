within AixLib.Fluid.Chillers.Examples;
model Chiller "Example for the reversible chiller model."
 extends Modelica.Icons.Example;
 import AixLib;
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

  AixLib.Fluid.Sources.FixedBoundary sinkSideFixedBoundary(          redeclare
      package Medium = Medium_sin, nPorts=1)
    "Fixed boundary at the outlet of the sink side" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-86,62})));
  Modelica.Blocks.Sources.Ramp TsuSinkRamp(
    duration=1000,
    startTime=1000,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the sink side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-94,-76},{-74,-56}})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=90,
        origin={0,62})));
  AixLib.Fluid.Chillers.Chiller chiller(
    refIneFre_constant=1,
    scalingFactor=1,
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
    redeclare model PerDataMainChi =
        AixLib.Fluid.Chillers.BaseClasses.PerformanceData.LookUpTable2D (
          dataTable=AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
    redeclare model PerDataRevChi =
        AixLib.Fluid.Chillers.BaseClasses.PerformanceData.LookUpTable2D (
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
           AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
    use_rev=true,
    VEva=0.4,
    VCon=0.04,
    TAmbCon_nominal=273.15,
    TAmbEva_nominal=288.15,
    TEva_start=303.15) annotation (Placement(transformation(
        extent={{-24,-29},{24,29}},
        rotation=90,
        origin={2,1})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTAct(
    final m_flow_nominal=chiller.mFlow_conNominal,
    final tau=1,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final tauHeaTra=1200,
    final allowFlowReversal=chiller.allowFlowReversalCon,
    final transferHeat=false,
    redeclare final package Medium = Medium_sou,
    final T_start=303.15,
    final TAmb=291.15) "Temperature at source outlet"
                                                   annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={54,-42})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/3600,
    amplitude=3000,
    offset=3000)
    annotation (Placement(transformation(extent={{76,56},{84,64}})));
  AixLib.Fluid.Movers.SpeedControlled_Nrpm
                                    pumSou(
    redeclare final AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
    final allowFlowReversal=true,
    final addPowerToMedium=false,
    redeclare final package Medium = Medium_sou)
    "Fan or pump at source side of HP" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,34})));

  AixLib.Fluid.MixingVolumes.MixingVolume Room(
    nPorts=2,
    final use_C_flow=false,
    final m_flow_nominal=chiller.mFlow_conNominal,
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
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={96,52})));
  AixLib.Fluid.Sources.FixedBoundary sourceSideFixedBoundary(nPorts=1,
      redeclare package Medium = Medium_sou)
    "Fixed boundary at the outlet of the source side" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={88,-42})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={54,-6})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=270,
        origin={-3,-53})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        origin={6,-80},
        rotation=180)));
  Modelica.Blocks.Logical.Hysteresis hys(
    pre_y_start=true,
    uLow=273.15 + 35,
    uHigh=273.15 + 40)
    annotation (Placement(transformation(extent={{36,-88},{20,-72}})));
  Modelica.Blocks.Sources.BooleanStep     booleanStep(startTime=10000,
      startValue=false)
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=270,
        origin={23,-53})));
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
        points={{64,-42},{78,-42}},                   color={0,127,255}));
  connect(senTAct.port_b, Room.ports[2]) annotation (Line(points={{64,-42},{66,
          -42},{66,0},{76,0}},     color={0,127,255}));
  connect(chiller.nSet, booleanToReal.y) annotation (Line(points={{-2.83333,
          -26.84},{-3,-26.84},{-3,-45.3}}, color={0,0,127}));
  connect(booleanToReal.u, not2.y) annotation (Line(points={{-3,-61.4},{-3,-80},
          {-0.6,-80}}, color={255,0,255}));
  connect(not2.u, hys.y)
    annotation (Line(points={{13.2,-80},{19.2,-80}}, color={255,0,255}));
  connect(hys.u, senTAct.T)
    annotation (Line(points={{37.6,-80},{54,-80},{54,-53}}, color={0,0,127}));
  connect(chiller.modeSet, booleanStep.y) annotation (Line(points={{6.83333,
          -26.84},{6.83333,-38},{23,-38},{23,-45.3}}, color={255,0,255}));
  connect(T_amb_internal.y, chiller.T_amb_con) annotation (Line(points={{0,53.2},
          {0,44},{-22.1667,44},{-22.1667,27.4}}, color={0,0,127}));
  connect(T_amb_internal.y, chiller.T_amb_eva) annotation (Line(points={{0,53.2},
          {0,44},{26.1667,44},{26.1667,27.4}}, color={0,0,127}));
  connect(sinkSideMassFlowSource.ports[1], chiller.port_a1) annotation (Line(
        points={{-34,-48},{-12.5,-48},{-12.5,-23}}, color={0,127,255}));
  connect(sinkSideFixedBoundary.ports[1], chiller.port_b1) annotation (Line(
        points={{-76,62},{-50,62},{-50,25},{-12.5,25}}, color={0,127,255}));
  connect(pumSou.port_b, chiller.port_a2)
    annotation (Line(points={{40,34},{16.5,34},{16.5,25}}, color={0,127,255}));
  connect(chiller.port_b2, senTAct.port_a) annotation (Line(points={{16.5,-23},
          {32,-23},{32,-42},{44,-42}}, color={0,127,255}));
  connect(chiller.iceFac_in, iceFac.y) annotation (Line(points={{34.8667,-17.24},
          {42,-17.24},{42,-6},{47.4,-6}}, color={0,0,127}));
  connect(TsuSinkRamp.y, sinkSideMassFlowSource.T_in) annotation (Line(points={
          {-73,-66},{-68,-66},{-68,-44},{-56,-44}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=20000),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Simple test set-up for the reversible chiller model. The chiller is turned on and off while the source temperature increases linearly. Outputs are the electric power consumption of the chiller and the supply temperature. </p>
<p>Besides using the default simple table data, the user should also test tabulated data from <a href=\"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.Chiller</a> or polynomial functions.</p>
</html>",
      revisions="<html>
<ul>
<li>
<i>May 22, 2019&nbsp;</i> by Julian Matthes: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
</li>
</ul>
</html>"),
    __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump.mos" "Simulate and plot"),
    Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
end Chiller;
