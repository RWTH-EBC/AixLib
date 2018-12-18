within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model ExhaustHeatExchangerEXPERIMENTAL
  "Exhaust gas heat exchanger for engine combustion and its heat transfer to a cooling circle"

  extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
    m1_flow_nominal=0.023,
    m2_flow_nominal=0.5556,
    m1_flow_small=0.0001,
    m2_flow_small=0.0001,
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
    final m_flow_small=m1_flow_small)
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
    final m_flow_small=m1_flow_small)
    "Temperature sensor of cold side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{28,50},{48,70}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFloExh(redeclare final package Medium =
        Medium1, final allowFlowReversal=allowFlowReversal1)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{60,70},{80,50}})));
  Modelica.Fluid.Vessels.ClosedVolume     volExhaust(
    redeclare final package Medium = Medium1,
    final m_flow_nominal=m1_flow_nominal,
    final p_start=p1_start,
    final T_start=T1_start,
    nPorts=2,
    V=0.002,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
    use_portsData=false,
    final m_flow_small=m1_flow_small) "Fluid volume"
    annotation (Placement(transformation(extent={{-50,60},{-30,40}})));
  AixLib.Fluid.FixedResistances.PressureDrop pressureDropExhaust(
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
    final m_flow_small=m2_flow_small)
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
    final m_flow_small=m2_flow_small)
    "Temperature sensor of coolant hot side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{-48,-70},{-28,-50}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFloCool(redeclare final package
      Medium = Medium2, final allowFlowReversal=allowFlowReversal2)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
  AixLib.Fluid.MixingVolumes.MixingVolume volCoolant(
    redeclare final package Medium = Medium2,
    final m_flow_nominal=m2_flow_nominal,
    final allowFlowReversal=allowFlowReversal2,
    final p_start=p2_start,
    final T_start=T2_start,
    nPorts=2,
    V=0.001,
    final m_flow_small=m2_flow_small)
             "Fluid volume"
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
  FixedResistances.PressureDrop pressureDropCool(
    redeclare final package Medium = Medium2,
    final show_T=false,
    final allowFlowReversal=allowFlowReversal2,
    m_flow_nominal=m2_flow_nominal,
    dp_nominal=15000,
    deltaM=0.1) "Pressure drop"
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));

  Medium1.ThermodynamicState state1 = Medium1.setState_pTX(senTExhHot.port_b.p,T_LogMeanExh,senTExhHot.port_b.Xi_outflow);
  Modelica.SIunits.SpecificEnthalpy h1_in = Medium1.specificEnthalpy(state1);
  Modelica.SIunits.DynamicViscosity eta1_in = Medium1.dynamicViscosity(state1);
  Modelica.SIunits.Density rho1_in = Medium1.density_phX(state1.p,h1_in,state1.X);
  Modelica.SIunits.Velocity v1_in = senMasFloExh.m_flow/(Modelica.Constants.pi*rho1_in*d_iExh^2/4);
  Modelica.SIunits.ThermalConductivity lambda1_in = Medium1.thermalConductivity(state1);
  Modelica.SIunits.ReynoldsNumber Re1_in = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(v1_in,rho1_in,eta1_in,d_iExh);

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
  parameter Modelica.SIunits.Temperature T_ExhPowUniOut=383.15 "Outlet temperature of exhaust gas flow"
  annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Area A_surExhHea=3
    "Surface for exhaust heat transfer" annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.SIunits.Length d_iExh=0.06
    "Inner diameter of exhaust pipe"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.ThermalConductance G_Amb=10
    "Constant thermal conductance of material"
    annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.SIunits.ThermalConductance G_Cool=850
    "Constant thermal conductance of material"
    annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.SIunits.HeatCapacity C_ExhHex=4000
    "Heat capacity of exhaust heat exchanger(default= 4000 J/K)"
  annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure pAmb=101325
    "Start value of pressure"
    annotation (Dialog(group="Ambient Properties"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=15000
    "Guess value of dp = port_a.p - port_b.p"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer, default 20 minutes"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
    "Guess value of m_flow = port_a.m_flow"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  Modelica.SIunits.SpecificHeatCapacity meanCpExh=1227.23
    "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature"
   annotation (Dialog(group = "Thermal"));
  Modelica.SIunits.HeatFlowRate Q_flowExhHea=senMasFloExh.m_flow*meanCpExh*(
      senTExhHot.T - T_ExhPowUniOut)
    "Calculated exhaust heat from fixed exhaust outlet temperature";

  Modelica.SIunits.Temperature T_LogMeanExh
    "Mean logarithmic temperature of exhaust gas";
  Real QuoT_ExhInOut=senTExhHot.T/senTExhCold.T
  "Quotient of exhaust gas in and outgoing temperature";

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=
        C_ExhHex, T(fixed=true, start=298.15))
    annotation (Placement(transformation(extent={{-38,-12},{-18,8}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ambientLoss(G=G_Amb)
    annotation (Placement(transformation(extent={{-60,-22},{-80,-2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_b
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor coolantConductance(G=G_Cool)
             annotation (Placement(transformation(extent={{-6,-22},{14,-2}})));
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

  Utilities.HeatTransfer.HeatConvPipeInsideDynamic heatConvExhaustPipeInside(
    c=meanCpExh,
    rho=rho1_in,
    lambda=lambda1_in,
    eta=eta1_in,
    A_sur=A_surExhHea,
    d_i=d_iExh)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-54,20})));

equation

  if (QuoT_ExhInOut-1)>0.0001 then
  T_LogMeanExh=(senTExhHot.T-senTExhCold.T)/Modelica.Math.log(QuoT_ExhInOut);
  else
  T_LogMeanExh=senTExhHot.T;
  end if;

  connect(senTCoolHot.port_b, pressureDropCool.port_a)
    annotation (Line(points={{-28,-60},{0,-60}}, color={0,127,255}));
  connect(pressureDropExhaust.port_b, senTExhCold.port_a)
    annotation (Line(points={{0,60},{28,60}}, color={0,127,255}));
  connect(senTExhCold.port_b, senMasFloExh.port_a)
    annotation (Line(points={{48,60},{60,60}}, color={0,127,255}));
  connect(senTExhHot.port_b, volExhaust.ports[1]) annotation (Line(points={{-60,60},
          {-48,60},{-48,64},{-42,64},{-42,60}},     color={0,127,255}));
  connect(pressureDropExhaust.port_a, volExhaust.ports[2]) annotation (Line(
        points={{-20,60},{-32,60},{-32,64},{-38,64},{-38,60}}, color={0,127,255}));
  connect(pressureDropCool.port_b, volCoolant.ports[1]) annotation (Line(points=
         {{20,-60},{32,-60},{32,-64},{38,-64},{38,-60}}, color={0,127,255}));
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
    annotation (Line(points={{-100,0},{-90,0},{-90,-12},{-80,-12}},
                                                color={191,0,0}));
  connect(coolantConductance.port_a, heatCapacitor.port) annotation (Line(
        points={{-6,-12},{-28,-12}},                 color={191,0,0}));
  connect(coolantConductance.port_b, volCoolant.heatPort) annotation (Line(
        points={{14,-12},{22,-12},{22,-50},{30,-50}}, color={191,0,0}));
  connect(ambientLoss.port_a, heatCapacitor.port)
    annotation (Line(points={{-60,-12},{-28,-12}},
                                               color={191,0,0}));
  connect(heatConvExhaustPipeInside.m_flow, senMasFloExh.m_flow) annotation (
      Line(points={{-43.2,20.4},{70,20.4},{70,49}}, color={0,0,127}));
  connect(heatConvExhaustPipeInside.port_a, volExhaust.heatPort)
    annotation (Line(points={{-54,30},{-54,50},{-50,50}}, color={191,0,0}));
  connect(heatConvExhaustPipeInside.port_b, heatCapacitor.port)
    annotation (Line(points={{-54,10},{-54,-12},{-28,-12}}, color={191,0,0}));
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
end ExhaustHeatExchangerEXPERIMENTAL;
