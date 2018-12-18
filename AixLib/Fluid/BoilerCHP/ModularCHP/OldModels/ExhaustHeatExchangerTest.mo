within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model ExhaustHeatExchangerTest
  "Exhaust gas heat exchanger for engine combustion and its heat transfer to a cooling circle"

  extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
    m1_flow_nominal=0.023,
    m2_flow_nominal=0.5556,
    show_T=true,
    redeclare package Medium1 = Medium3,
    redeclare package Medium2 = Medium4);

  AixLib.Fluid.Sensors.TemperatureTwoPort senTExhHot(
    redeclare final package Medium = Medium1,
    final tau=tau,
    final m_flow_nominal=m1_flow_nominal,
    final initType=initType,
    final T_start=T1_start,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_small=m_flow_small)
    "Temperature sensor of hot side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTExhCold(
    redeclare final package Medium = Medium1,
    final tau=tau,
    final m_flow_nominal=m1_flow_nominal,
    final initType=initType,
    final T_start=T1_start,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_small=m_flow_small)
    "Temperature sensor of cold side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{30,50},{50,70}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFloExh(redeclare final package Medium =
        Medium1, final allowFlowReversal=allowFlowReversal1)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Fluid.Vessels.ClosedVolume     volExhaust(
    redeclare final package Medium = Medium1,
    final m_flow_nominal=m1_flow_nominal,
    final m_flow_small=m_flow_small,
    final p_start=p1_start,
    final T_start=T1_start,
    nPorts=2,
    V=0.002,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
    use_portsData=false) "Fluid volume"
    annotation (Placement(transformation(extent={{-50,60},{-30,40}})));
  AixLib.Fluid.FixedResistances.PressureDrop                pressureDrop(
    redeclare final package Medium = Medium1,
    final show_T=false,
    final allowFlowReversal=allowFlowReversal1,
    m_flow_nominal=m1_flow_nominal,
    deltaM=0.1,
    dp_nominal=15000) "Pressure drop"
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTCoolCold(
    redeclare final package Medium = Medium2,
    final tau=tau,
    final m_flow_nominal=m2_flow_nominal,
    final initType=initType,
    final T_start=T2_start,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal2,
    final m_flow_small=m_flow_small)
    "Temperature sensor of coolant cold side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTCoolHot(
    redeclare final package Medium = Medium2,
    final tau=tau,
    final m_flow_nominal=m2_flow_nominal,
    final initType=initType,
    final T_start=T2_start,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal2,
    final m_flow_small=m_flow_small)
    "Temperature sensor of coolant hot side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{-48,-70},{-28,-50}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFloCool(redeclare final package
      Medium = Medium2, final allowFlowReversal=allowFlowReversal2)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
  AixLib.Fluid.MixingVolumes.MixingVolume volCoolant(
    redeclare final package Medium = Medium2,
    final m_flow_nominal=m2_flow_nominal,
    final m_flow_small=m_flow_small,
    final allowFlowReversal=allowFlowReversal2,
    final p_start=p2_start,
    final T_start=T2_start,
    nPorts=2,
    V=0.001) "Fluid volume"
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
  Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate pressureDrop2(
    redeclare final package Medium = Medium2,
    final b=0,
    final m_flow_small=m_flow_small,
    final show_T=false,
    final show_V_flow=false,
    final allowFlowReversal=allowFlowReversal2,
    final dp_start=dp_start,
    final m_flow_start=m_flow_start,
    a=0) "Pressure drop"
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));

  parameter Modelica.SIunits.MassFlowRate m_flow_small=0.0001;
  parameter Modelica.SIunits.Time tau=1
    "Time constant of the temperature sensors at nominal flow rate"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Temperature T1_start=TAmb
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.SIunits.Temperature T2_start=TAmb
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p1_start=pAmb
    "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p2_start=pAmb
    "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Boolean transferHeat=false
    "If true, temperature T converges towards TAmb when no flow"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Temperature TAmb=298.15
    "Fixed ambient temperature for heat transfer"
    annotation (Dialog(group="Ambient Properties"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure pAmb=101325
    "Start value of pressure"
    annotation (Dialog(group="Ambient Properties"));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer, default 20 minutes"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=15000
    "Guess value of dp = port_a.p - port_b.p"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
    "Guess value of m_flow = port_a.m_flow"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.SIunits.Temperature T_ExhPowUniOut=383.15 "Outlet temperature of exhaust gas flow"
  annotation (Dialog(group="Thermal"));
  Modelica.SIunits.MassFlowRate m_Exh(min=0)=0.023
  "Mass flow rate of exhaust gas" annotation (Dialog(group = "Thermal"));
  Modelica.SIunits.SpecificHeatCapacity meanCpExh=1227.23
  "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature"
   annotation (Dialog(group = "Thermal"));
  Modelica.SIunits.HeatFlowRate Q_flowExhHea(min=0)=m_Exh*meanCpExh*(senTExhHot.T - T_ExhPowUniOut)
  "Calculated exhaust heat from fixed exhaust outlet temperature" annotation (Dialog(group = "Thermal"));
  Modelica.SIunits.ThermalConductance G_CalExhToHex "Calculated heat convection from exhaust gas to heat exchanger capacity";
  Modelica.SIunits.Temperature difTHex(min=0.1) = senTExhHot.T-heatCapacitor.T;

  /*  Modelica.SIunits.Temperature T_LogMeanExh
    "Mean logarithmic temperature of exhaust gas";
  Real QuoT_ExhInOut=senTExhCold.T/senTExhHot.T
    "Quotient of exhaust gas in and outgoing temperature";
  Modelica.SIunits.Temperature T_LogMeanCool
    "Mean logarithmic coolant temperature";
  Real QuoT_SupRet=senTCoolHot.T/senTCoolCold.T
  "Quotient of coolant supply and return temperature"; */

  inner Modelica.Fluid.System system(p_ambient=101325, T_ambient=298.15)
    annotation (Placement(transformation(extent={{88,-100},{100,-88}})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=4000, T(fixed=
          true, start=298.15))
    annotation (Placement(transformation(extent={{-40,-6},{-20,14}})));
  Modelica.Blocks.Sources.RealExpression calculatedExhaustHeatConvection(y=-
        G_CalExhToHex)
    annotation (Placement(transformation(extent={{-100,12},{-74,32}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ambientLoss(G=15)
    annotation (Placement(transformation(extent={{-60,-16},{-80,4}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_b
    annotation (Placement(transformation(extent={{-110,-16},{-90,4}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor coolantConductance(
      G=800) annotation (Placement(transformation(extent={{-6,-16},{14,4}})));
  replaceable package Medium3 =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus (
                               reference_X={0.73,0.06,0.09,0.12})
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (
      __Dymola_choicesAllMatching=true);
  replaceable package Medium4 =
      DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                      property_T=356, X_a=0.50) constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (
      __Dymola_choicesAllMatching=true);
  Modelica.Thermal.HeatTransfer.Components.Convection exhaustGasConvection
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-54,22})));

  Modelica.Fluid.Sources.MassFlowSource_T inletExhaust(
    redeclare package Medium = Medium1,
    use_X_in=false,
    m_flow=m_Exh,
    nPorts=1,
    T=959.15)
    annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
  Modelica.Fluid.Sources.FixedBoundary outletExhaust(          redeclare
      package Medium = Medium1,
    p=103125,
    T=298.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={130,60})));
  Modelica.Fluid.Sources.FixedBoundary outletCoolant(          redeclare
      package Medium = Medium2, nPorts=1)
    annotation (Placement(transformation(extent={{-140,-70},{-120,-50}})));
  Modelica.Fluid.Sources.MassFlowSource_T inletCoolant(
    redeclare package Medium = Medium2,
    m_flow=0.5556,
    T=357.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{140,-70},{120,-50}})));
equation

  if senTExhHot.T-heatCapacitor.T<=0 then
  G_CalExhToHex=0;
  else
  G_CalExhToHex = Q_flowExhHea/difTHex;
  end if;

 /* if abs(QuoT_ExhInOut-1)>0.0001 then
  T_LogMeanExh=(senTExhCold.T-senTExhHot.T)/Modelica.Math.log(QuoT_ExhInOut);
  else
  T_LogMeanExh=senTExhCold.T;
  end if; 
 */
 // if abs(QuoT_SupRet-1)>0.0001 then
 // T_LogMeanCool=(senTCoolHot.T-senTCoolCold.T)/Modelica.Math.log(QuoT_SupRet);
 // else
 // T_LogMeanCool=senTCoolCold.T;
 // end if;

  connect(senTCoolHot.port_b, pressureDrop2.port_a)
    annotation (Line(points={{-28,-60},{0,-60}}, color={0,127,255}));
  connect(pressureDrop.port_b,senTExhCold. port_a)
    annotation (Line(points={{0,60},{30,60}}, color={0,127,255}));
  connect(senTExhCold.port_b, senMasFloExh.port_a)
    annotation (Line(points={{50,60},{60,60}}, color={0,127,255}));
  connect(senTExhHot.port_b, volExhaust.ports[1]) annotation (Line(points={{-60,60},
          {-48,60},{-48,64},{-42,64},{-42,60}},     color={0,127,255}));
  connect(pressureDrop.port_a, volExhaust.ports[2]) annotation (Line(points={{-20,60},
          {-32,60},{-32,64},{-38,64},{-38,60}},     color={0,127,255}));
  connect(pressureDrop2.port_b, volCoolant.ports[1]) annotation (Line(points={{20,
          -60},{32,-60},{32,-64},{38,-64},{38,-60}}, color={0,127,255}));
  connect(senTCoolCold.port_a, volCoolant.ports[2]) annotation (Line(points={{60,
          -60},{48,-60},{48,-64},{42,-64},{42,-60}}, color={0,127,255}));
  connect(port_a1, senTExhHot.port_a)
    annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
  connect(senMasFloExh.port_b, port_b1)
    annotation (Line(points={{80,60},{100,60}}, color={0,127,255}));
  connect(port_a2, senTCoolCold.port_b)
    annotation (Line(points={{100,-60},{80,-60}}, color={0,127,255}));
  connect(senTCoolHot.port_a, senMasFloCool.port_a)
    annotation (Line(points={{-48,-60},{-60,-60}}, color={0,127,255}));
  connect(senMasFloCool.port_b, port_b2)
    annotation (Line(points={{-80,-60},{-100,-60}}, color={0,127,255}));
  connect(port_b,ambientLoss. port_b)
    annotation (Line(points={{-100,-6},{-80,-6}},
                                                color={191,0,0}));
  connect(coolantConductance.port_a, heatCapacitor.port) annotation (Line(
        points={{-6,-6},{-30,-6}},                   color={191,0,0}));
  connect(coolantConductance.port_b, volCoolant.heatPort) annotation (Line(
        points={{14,-6},{22,-6},{22,-50},{30,-50}},   color={191,0,0}));
  connect(ambientLoss.port_a, heatCapacitor.port)
    annotation (Line(points={{-60,-6},{-30,-6}},
                                               color={191,0,0}));
  connect(volExhaust.heatPort, exhaustGasConvection.fluid)
    annotation (Line(points={{-50,50},{-54,50},{-54,30}}, color={191,0,0}));
  connect(exhaustGasConvection.solid, heatCapacitor.port)
    annotation (Line(points={{-54,14},{-54,-6},{-30,-6}}, color={191,0,0}));
  connect(calculatedExhaustHeatConvection.y, exhaustGasConvection.Gc)
    annotation (Line(points={{-72.7,22},{-62,22}}, color={0,0,127}));
  connect(inletExhaust.ports[1], port_a1)
    annotation (Line(points={{-120,60},{-100,60}}, color={0,127,255}));
  connect(outletExhaust.ports[1], port_b1)
    annotation (Line(points={{120,60},{100,60}}, color={0,127,255}));
  connect(inletCoolant.ports[1], port_a2)
    annotation (Line(points={{120,-60},{100,-60}}, color={0,127,255}));
  connect(outletCoolant.ports[1], port_b2)
    annotation (Line(points={{-120,-60},{-100,-60}}, color={0,127,255}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-70,80},{70,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-99,64},{102,54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-99,-56},{102,-66}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end ExhaustHeatExchangerTest;
