within AixLib.Fluid.BoilerCHP.ModularCHP;
model ExhaustHeatExchanger
  "Exhaust gas heat exchanger for engine combustion and its heat transfer to a cooling circle"
  import AixLib;

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
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
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
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFloCool(redeclare final package
      Medium = Medium2, final allowFlowReversal=allowFlowReversal2)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));

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
  parameter Modelica.SIunits.Area A_surExhHea=50
    "Surface for exhaust heat transfer" annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.SIunits.Length d_iExh=0.06
    "Inner diameter of exhaust pipe"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.Volume VExhHex=l_ExhHex/4*Modelica.Constants.pi*
      d_iExh^2
    "Exhaust gas volume inside the exhaust heat exchanger" annotation(Dialog(tab="Calibration parameters",group="Engine parameters"));
  parameter Modelica.SIunits.ThermalConductance G_Amb=5
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
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ambientLoss(G=G_Amb)
    annotation (Placement(transformation(extent={{-46,-22},{-66,-2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_b
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  replaceable package Medium3 =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (
      __Dymola_choicesAllMatching=true);
  replaceable package Medium4 =
      DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                      property_T=356, X_a=0.50) constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (
      __Dymola_choicesAllMatching=true);

  AixLib.Fluid.BoilerCHP.ModularCHP.heatFromExhaustGas heatFromExhaustGas(
    T1_start=T1_start,
    p1_start=p1_start,
    d_iExh=d_iExh,
    TAmb=TAmb,
    pAmb=pAmb,
    heatConvExhaustPipeInside(
      c=meanCpExh,
      rho=rho1_in,
      lambda=lambda1_in,
      eta=eta1_in,
      A_sur=A_surExhHea),
    redeclare package Medium1 = Medium3,
    allowFlowReversal1=allowFlowReversal1,
    m1_flow_nominal=m1_flow_nominal,
    m1_flow_small=m1_flow_small,
    m_flow=senMasFloExh.m_flow,
    l_Exh=l_ExhHex) annotation (Placement(transformation(rotation=0, extent={{-42,
            32},{-8,66}})));

  parameter Modelica.SIunits.Length l_ExhHex=1
    "Length of the exhaust pipe inside the exhaust heat exchanger" annotation (
      Dialog(tab="Calibration parameters", group="Engine parameters"));
  parameter Modelica.SIunits.PressureDifference dp_CooExhHex=15000
    "Pressure drop at nominal mass flow rate inside the coolant circle "
    annotation (Dialog(group="Nominal condition"));
  AixLib.Fluid.FixedResistances.Pipe pipeCoolant(
    redeclare package Medium = Medium2,
    p_b_start=system.p_start - 15000,
    isEmbedded=true,
    Heat_Loss_To_Ambient=true,
    withInsulation=false,
    use_HeatTransferConvective=false,
    eps=0,
    alpha=pipeCoolant.alpha_i,
    alpha_i=G_Cool/(pipeCoolant.perimeter*pipeCoolant.length),
    diameter=0.03175,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          m_flow_nominal=m2_flow_nominal, dp_nominal=0))
    annotation (Placement(transformation(extent={{32,-70},{12,-50}})));

equation

  if (QuoT_ExhInOut-1)>0.0001 then
  T_LogMeanExh=(senTExhHot.T-senTExhCold.T)/Modelica.Math.log(QuoT_ExhInOut);
  else
  T_LogMeanExh=senTExhHot.T;
  end if;

  connect(senTExhCold.port_b, senMasFloExh.port_a)
    annotation (Line(points={{48,60},{60,60}}, color={0,127,255}));
  connect(port_a1, senTExhHot.port_a)
    annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
  connect(senMasFloExh.port_b, port_b1)
    annotation (Line(points={{80,60},{100,60}}, color={0,127,255}));
  connect(port_a2, senTCoolCold.port_b)
    annotation (Line(points={{100,-60},{80,-60}}, color={0,127,255}));
  connect(senTCoolHot.port_a, senMasFloCool.port_a)
    annotation (Line(points={{-40,-60},{-60,-60}}, color={0,127,255}));
  connect(senMasFloCool.port_b, port_b2)
    annotation (Line(points={{-80,-60},{-100,-60}}, color={0,127,255}));
  connect(port_b,ambientLoss. port_b)
    annotation (Line(points={{-100,0},{-90,0},{-90,-12},{-66,-12}},
                                                color={191,0,0}));
  connect(senTExhHot.port_b, heatFromExhaustGas.ports) annotation (Line(points={{-60,60},
          {-56,60},{-56,56.48},{-42,56.48}},          color={0,127,255}));
  connect(heatFromExhaustGas.port_b1, senTExhCold.port_a) annotation (Line(
        points={{-8,56.48},{6,56.48},{6,60},{28,60}},  color={0,127,255}));
  connect(senTCoolCold.port_a, pipeCoolant.port_a)
    annotation (Line(points={{60,-60},{32.4,-60}}, color={0,127,255}));
  connect(senTCoolHot.port_b, pipeCoolant.port_b)
    annotation (Line(points={{-20,-60},{11.6,-60}}, color={0,127,255}));
  connect(ambientLoss.port_a, heatCapacitor.port)
    annotation (Line(points={{-46,-12},{0,-12}}, color={191,0,0}));
  connect(heatFromExhaustGas.port_b, heatCapacitor.port)
    annotation (Line(points={{-25,33.7},{-25,-12},{0,-12}}, color={191,0,0}));
  connect(heatCapacitor.port, pipeCoolant.heatPort_outside) annotation (Line(
        points={{0,-12},{20.4,-12},{20.4,-54.4}}, color={191,0,0}));
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
end ExhaustHeatExchanger;
