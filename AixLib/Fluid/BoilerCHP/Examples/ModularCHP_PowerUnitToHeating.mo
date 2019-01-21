within AixLib.Fluid.BoilerCHP.Examples;
model ModularCHP_PowerUnitToHeating
  "Example that illustrates use of modular CHP exhaust heat exchanger submodel"
  import AixLib;
  extends Modelica.Icons.Example;

  replaceable package Medium_Exhaust =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                 annotation(choicesAllMatching=true);

  replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "Needed engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  constant Modelica.SIunits.MassFraction Xi_Exh[:] = {0.73,0.05,0.08,0.14};
  constant Modelica.SIunits.MolarMass M_H2O=0.01802
    "Molar mass of water";
  constant Modelica.SIunits.MolarMass M_Exh=0.02846
    "Molar mass of the exhaust gas";

    //Antoine-Parameters needed for the calculation of the saturation vapor pressure xSat_H2OExhDry
  constant Real A=11.7621;
  constant Real B=3874.61;
  constant Real C=229.73;

  parameter Boolean ConTec=false
    "Is condensing technology used and should latent heat be considered?"
    annotation (Dialog(tab="Advanced", group="Condensing technology"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flowCoo=2
    "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
          "Engine Cooling Circle"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flowHeaCir=
      CHPEngData.m_floCooNominal
    "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.Time tau=1
    "Time constant of the temperature sensors at nominal flow rate"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Temperature T1_start=T_ambient
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p1_start=p_ambient
    "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Boolean transferHeat=false
    "If true, temperature T converges towards TAmb when no flow"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Temperature T_ExhPowUniOut=873.15 "Outlet temperature of exhaust gas flow"
  annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Area A_surExhHea=50
    "Surface for exhaust heat transfer" annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.SIunits.HeatCapacity C_ExhHex=4000
    "Heat capacity of exhaust heat exchanger(default= 4000 J/K)"
  annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_ambient=101325
    "Start value of pressure"
    annotation (Dialog(group="Ambient Properties"));
  parameter Modelica.SIunits.Temperature T_ambient=298.15
    "Fixed ambient temperature for heat transfer"
    annotation (Dialog(group="Ambient Properties"));
  parameter Modelica.SIunits.Volume VExhHex=0.005
    "Exhaust gas volume inside the exhaust heat exchanger" annotation(Dialog(tab="Calibration parameters",group="Engine parameters"));
  parameter Modelica.SIunits.ThermalConductance G_Amb=5
    "Constant thermal conductance of material"
    annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer, default 20 minutes"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Length l_ExhHex=1
    "Length of the exhaust pipe inside the exhaust heat exchanger" annotation (
      Dialog(tab="Calibration parameters", group="Engine parameters"));
  parameter Modelica.SIunits.Length d_iExh=CHPEngData.dExh
    "Inner diameter of exhaust pipe"
    annotation (Dialog(group="Nominal condition"));

  inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
    annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.CHP_PowerUnit cHP_PowerUnit(redeclare
      package Medium_Coolant = Medium_Coolant, m_flow=m_flowCoo)
    annotation (Placement(transformation(extent={{-20,-20},{20,18}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
    allowFlowReversal=true,
    m_flow_small=0.001,
    dp_nominal=CHPEngData.dp_Coo,
    redeclare package Medium = Medium_Coolant,
    m_flow_nominal=m_flowCoo)
    annotation (Placement(transformation(extent={{-80,-24},{-58,0}})));
  Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if pumpControl.y
         then m_flowCoo else 1)
    annotation (Placement(transformation(extent={{-96,6},{-76,26}})));
  Modelica.Blocks.Sources.BooleanPulse cHPIsOnOff(
    startTime(displayUnit="h") = 0,
    period(displayUnit="h") = 86400,
    width=50)
    annotation (Placement(transformation(extent={{-82,68},{-66,84}})));
  Modelica.Blocks.Logical.Timer timerIsOff
    annotation (Placement(transformation(extent={{6,78},{20,92}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-20,78},{-6,92}})));
  Modelica.Blocks.Logical.LessThreshold declarationTime(threshold=2400)
    annotation (Placement(transformation(extent={{32,78},{46,92}})));
  Modelica.Blocks.Logical.Or pumpControl
    annotation (Placement(transformation(extent={{62,64},{82,84}})));
  Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel1(
    redeclare package Medium = Medium_Coolant,
    p=300000,
    T=298.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{110,-22},{90,-2}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
    redeclare package Medium = Medium_Coolant,
    m_flow_small=0.001,
    m_flow_nominal=CHPEngData.m_floCooNominal)
    annotation (Placement(transformation(extent={{38,-20},{54,-4}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
    redeclare package Medium = Medium_Coolant,
    m_flow_nominal=CHPEngData.m_floCooNominal,
    m_flow_small=0.001)
    annotation (Placement(transformation(extent={{-42,-20},{-26,-4}})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness             coolantHex(
    redeclare package Medium1 = Medium_Coolant,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    m2_flow_nominal=CHPEngData.m_floCooNominal,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    eps=0.9,
    dp1_nominal(displayUnit="kPa") = 10000,
    dp2_nominal(displayUnit="kPa") = 10000,
    m1_flow_nominal=2)
    annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
  Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
    nPorts=1,
    use_T_in=true,
    m_flow=m_flowHeaCir,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
  Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                               nPorts=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    allowFlowReversal=true,
    m_flow_nominal=CHPEngData.m_floCooNominal,
    m_flow_small=0.001)
    annotation (Placement(transformation(extent={{-56,-72},{-40,-56}})));

  Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    allowFlowReversal=true,
    m_flow_nominal=CHPEngData.m_floCooNominal,
    m_flow_small=0.001)
    annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

  Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=if cHPIsOnOff.y
         then 350 else 313.15)
    annotation (Placement(transformation(extent={{-144,-70},{-124,-50}})));
equation

  connect(massFlowCoolant.y,coolantPump. m_flow_in)
    annotation (Line(points={{-75,16},{-69,16},{-69,2.4}},
                                                         color={0,0,127}));
  connect(timerIsOff.u,not1. y)
    annotation (Line(points={{4.6,85},{-5.3,85}},    color={255,0,255}));
  connect(timerIsOff.y,declarationTime. u)
    annotation (Line(points={{20.7,85},{30.6,85}},color={0,0,127}));
  connect(declarationTime.y,pumpControl. u1) annotation (Line(points={{46.7,85},
          {54,85},{54,74},{60,74}}, color={255,0,255}));
  connect(cHPIsOnOff.y, not1.u) annotation (Line(points={{-65.2,76},{-26,76},{-26,
          85},{-21.4,85}}, color={255,0,255}));
  connect(pumpControl.u2, not1.u) annotation (Line(points={{60,66},{-26,66},{-26,
          85},{-21.4,85}}, color={255,0,255}));
  connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
        points={{16,-12.02},{28,-12.02},{28,-12},{38,-12}}, color={0,127,255}));
  connect(coolantPump.port_b, tempCoolantReturn.port_a) annotation (Line(points={{-58,-12},
          {-42,-12}},                               color={0,127,255}));
  connect(cHP_PowerUnit.port_Return, tempCoolantReturn.port_b) annotation (Line(
        points={{-16,-12.02},{-22,-12.02},{-22,-12},{-26,-12}}, color={0,127,255}));
  connect(cHP_PowerUnit.onOffStep, not1.u) annotation (Line(points={{-19.2,11.92},
          {-52,11.92},{-52,76},{-26,76},{-26,85},{-21.4,85}}, color={255,0,255}));
  connect(heatingReturnFlow.ports[1],tempReturnFlow. port_a)
    annotation (Line(points={{-90,-64},{-56,-64}}, color={0,127,255}));
  connect(coolantHex.port_a2,tempReturnFlow. port_b)
    annotation (Line(points={{-20,-64},{-40,-64}}, color={0,127,255}));
  connect(coolantHex.port_b2,tempSupplyFlow. port_a)
    annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
  connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
    annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
  connect(heatingReturnFlow.T_in,tempFlowHeating. y)
    annotation (Line(points={{-112,-60},{-123,-60}}, color={0,0,127}));
  connect(coolantPump.port_a, coolantHex.port_b1) annotation (Line(points={{-80,
          -12},{-90,-12},{-90,-40},{-20,-40}}, color={0,127,255}));
  connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points=
         {{54,-12},{70,-12},{70,-40},{20,-40}}, color={0,127,255}));
  connect(fixedPressureLevel1.ports[1], coolantHex.port_a1) annotation (Line(
        points={{90,-12},{70,-12},{70,-40},{20,-40}}, color={0,127,255}));
  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>The simulation illustrates the behavior of <a href=\"AixLib.Fluid.BoilerCHP.CHP\">AixLib.Fluid.ModularCHP.CHPCombustionEngine</a> in different conditions. Fuel and engine model as well as the mechanical and thermal output of the power unit can be observed. Change the engine properties to see its impact to the calculated engine combustion. </p>
</html>",
        revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with
AixLib</li>
<li><i>April 16, 2014 &nbsp;</i> by Ana Constantin:<br/>Formated
documentation.</li>
<li>by Pooyan Jahangiri:<br/>First implementation.</li>
</ul>
</html>"));
end ModularCHP_PowerUnitToHeating;
