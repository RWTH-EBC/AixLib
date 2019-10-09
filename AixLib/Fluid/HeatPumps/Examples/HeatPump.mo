within AixLib.Fluid.HeatPumps.Examples;
model HeatPump
  "Example for the detailed heat pump model in order to compare to simple one."
 extends Modelica.Icons.Example;
 import AixLib;
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
              annotation (Placement(transformation(extent={{-68,-72},{-48,-52}})));

  AixLib.Fluid.Sources.FixedBoundary                sourceSideFixedBoundary(
                                                                         nPorts=
       1, redeclare package Medium = Medium_sou)
          "Fixed boundary at the outlet of the source side"
          annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-80,0})));
  Modelica.Blocks.Sources.Ramp TsuSourceRamp(
    duration=1000,
    startTime=1000,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the source side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-100,-68},{-80,-48}})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-70})));
  AixLib.Fluid.HeatPumps.HeatPump heatPump(
    refIneFre_constant=1,
    scalingFactor=1,
    useBusConnectorOnly=true,
    VEva=0.04,
    CEva=100,
    GEvaOut=5,
    CCon=100,
    GConOut=5,
    dpEva_nominal=0,
    dpCon_nominal=0,
    mFlow_conNominal=0.5,
    mFlow_evaNominal=0.5,
    VCon=0.4,
    use_conCap=false,
    use_evaCap=false,
    redeclare package Medium_con = Medium_sin,
    redeclare package Medium_eva = Medium_sou,
    use_revHP=true,
    redeclare model PerDataHea =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (
          dataTable=AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
    redeclare model PerDataChi =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
           AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
    use_refIne=false,
    TAmbCon_nominal=288.15,
    TAmbEva_nominal=273.15,
    TCon_start=303.15,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                       annotation (Placement(transformation(
        extent={{-23.5,-27.5},{23.5,27.5}},
        rotation=270,
        origin={-0.5,-23.5})));



  Modelica.Blocks.Sources.BooleanStep     booleanStep(startTime=10000,
      startValue=true)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,50})));

  AixLib.Fluid.Sensors.TemperatureTwoPort
                             senTAct(
    final m_flow_nominal=heatPump.mFlow_conNominal,
    final tau=1,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final tauHeaTra=1200,
    final allowFlowReversal=heatPump.allowFlowReversalCon,
    final transferHeat=false,
    redeclare final package Medium = Medium_sin,
    final T_start=303.15,
    final TAmb=291.15) "Temperature at sink inlet"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,-60})));
  Modelica.Blocks.Logical.Hysteresis hys(
    pre_y_start=true,
    uLow=273.15 + 35,
    uHigh=273.15 + 40)
    annotation (Placement(transformation(extent={{62,50},{42,70}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{22,50},{2,70}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1/3600,
    amplitude=3000,
    offset=3000)
    annotation (Placement(transformation(extent={{98,34},{86,46}})));
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
        origin={50,0})));

  AixLib.Fluid.MixingVolumes.MixingVolume Room(
    nPorts=2,
    final use_C_flow=false,
    final m_flow_nominal=heatPump.mFlow_conNominal,
    final V=5,
    final allowFlowReversal=true,
    redeclare package Medium = Medium_sin,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                  "Volume of Condenser" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-20})));

  Modelica.Blocks.Sources.Constant nIn(k=100) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={50,24})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateCon
    "Heat flow rate of the condenser" annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=270,
        origin={80,4})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={80,22})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        origin={32,60},
        rotation=180)));
  AixLib.Fluid.Sources.FixedBoundary sinkSideFixedBoundary(      nPorts=1,
      redeclare package Medium = Medium_sin)
    "Fixed boundary at the outlet of the sink side" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,-60})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,20})));
  AixLib.Controls.Interfaces.HeatPumpControlBus sigBusHP1 annotation (Placement(
        transformation(extent={{-12,6},{12,34}}), iconTransformation(extent={{
            -32,4},{8,44}})));
equation

  connect(TsuSourceRamp.y,sourceSideMassFlowSource. T_in) annotation (Line(
      points={{-79,-58},{-70,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sourceSideMassFlowSource.ports[1], heatPump.port_a2) annotation (Line(
        points={{-48,-62},{-24,-62},{-24,-47},{-14.25,-47}},color={0,127,255}));
  connect(nIn.y, pumSou.Nrpm)
    annotation (Line(points={{50,19.6},{50,12}}, color={0,0,127}));
  connect(Room.heatPort, heatFlowRateCon.port)
    annotation (Line(points={{80,-10},{80,-2}},       color={191,0,0}));
  connect(sine.y, gain.u) annotation (Line(points={{85.4,40},{80,40},{80,26.8}},
                      color={0,0,127}));
  connect(heatFlowRateCon.Q_flow, gain.y) annotation (Line(points={{80,10},{80,
          17.6}},                   color={0,0,127}));
  connect(heatPump.port_b2, sourceSideFixedBoundary.ports[1])
    annotation (Line(points={{-14.25,0},{-70,0}},         color={0,127,255}));
  connect(heatPump.port_b1, senTAct.port_a) annotation (Line(points={{13.25,-47},
          {30,-47},{30,-60},{40,-60}}, color={0,127,255}));
  connect(Room.ports[1], pumSou.port_a) annotation (Line(points={{70,-18},{70,0},
          {60,0}},         color={0,127,255}));
  connect(pumSou.port_b, heatPump.port_a1) annotation (Line(points={{40,0},{28,
          0},{28,-7.10543e-15},{13.25,-7.10543e-15}},
                                color={0,127,255}));
  connect(senTAct.T, hys.u) annotation (Line(points={{50,-49},{58,-49},{58,-8},
          {68,-8},{68,60},{64,60}},                 color={0,0,127}));
  connect(hys.y, not2.u) annotation (Line(points={{41,60},{36.8,60}},
                color={255,0,255}));
  connect(booleanToReal.u, not2.y) annotation (Line(points={{24,60},{27.6,60}},
                          color={255,0,255}));
  connect(senTAct.port_b, sinkSideFixedBoundary.ports[1]) annotation (Line(
        points={{60,-60},{70,-60}},                   color={0,127,255}));
  connect(senTAct.port_b, Room.ports[2]) annotation (Line(points={{60,-60},{66,
          -60},{66,-22},{70,-22}}, color={0,127,255}));
  connect(heatPump.sigBusHP, sigBusHP1) annotation (Line(
      points={{-9.4375,-0.235},{-9.4375,13.38},{0,13.38},{0,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(iceFac.y, sigBusHP1.iceFac) annotation (Line(points={{-39,20},{-38,20},
          {-38,20.07},{0.06,20.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanStep.y, sigBusHP1.mode) annotation (Line(points={{-39,50},{-20,
          50},{-20,30},{0.06,30},{0.06,20.07}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanToReal.y, sigBusHP1.N) annotation (Line(points={{1,60},{0,60},
          {0,20.07},{0.06,20.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=3600, Tolerance=1e-06),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Simple test set-up for the HeatPumpDetailed model. The heat pump is turned on and off while the source temperature increases linearly. Outputs are the electric power consumption of the heat pump and the supply temperature. </p>
<p>Besides using the default simple table data, the user should also test tabulated data from <a href=\"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a> or polynomial functions.</p>
</html>",
      revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"),
    __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/HeatPump.mos" "Simulate and plot"),
    Icon(coordinateSystem(extent={{-100,-100},{100,80}})));
end HeatPump;
