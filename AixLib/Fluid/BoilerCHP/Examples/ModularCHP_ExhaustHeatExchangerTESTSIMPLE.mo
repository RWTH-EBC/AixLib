within AixLib.Fluid.BoilerCHP.Examples;
model ModularCHP_ExhaustHeatExchangerTESTSIMPLE
  "Example that illustrates use of modular CHP exhaust heat exchanger submodel"
  import AixLib;
  extends Modelica.Icons.Example;

  replaceable package Medium_Exhaust =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                 annotation(choicesAllMatching=true);

  replaceable package Medium_Coolant = Modelica.Media.IdealGases.SingleGases.N2
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
  Modelica.Fluid.Sources.MassFlowSource_T exhaustFlow(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium_Exhaust,
    X=Xi_Exh,
    use_X_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Fluid.Sources.FixedBoundary outletExhaustGas(
    redeclare package Medium = Medium_Exhaust,
    p=p_ambient,
    T=T_ambient,
    nPorts=1)
    annotation (Placement(transformation(extent={{112,30},{92,50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        T_ambient)
    annotation (Placement(transformation(extent={{-88,-8},{-72,8}})));
  Modelica.Blocks.Sources.RealExpression realExpT_Exh(y=if max.y > 0.00011
         then T_ExhPowUniOut else exhaustHeatExchanger.heatCapacitor.T)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-106,14})));
  Modelica.Blocks.Math.Max max annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-118,48})));
  Modelica.Blocks.Sources.RealExpression massFlowExhaustMin(y=0.0001)
    annotation (Placement(transformation(
        extent={{11,-12},{-11,12}},
        rotation=180,
        origin={-147,30})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=0.023,
    rising(displayUnit="s") = 1,
    width(displayUnit="d") = 43200,
    falling=1,
    period(displayUnit="d") = 86400)
    annotation (Placement(transformation(extent={{-158,50},{-138,70}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.ExhaustHeatExchanger exhaustHeatExchanger(
    M_Exh=28,
    redeclare package Medium3 = Medium_Exhaust,
    Q_Gen=0,
    pipeCoolant(
      p_a_start=system.p_start,
      p_b_start=system.p_start - 15000,
      m_flow_start=0.001),
    heatConvExhaustPipeInside(m_flow=exhaustFlow.m_flow_in, c=1200),
    redeclare package Medium4 = Medium_Coolant)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
    allowFlowReversal=true,
    m_flow_nominal=CHPEngData.m_floCooNominal,
    m_flow_small=0.001,
    dp_nominal=CHPEngData.dp_Coo,
    redeclare package Medium = Medium_Coolant)
    annotation (Placement(transformation(extent={{76,-36},{54,-12}})));
  Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
    nPorts=1,
    p=300000,
    T=298.15,
    redeclare package Medium = Medium_Coolant)
    annotation (Placement(transformation(extent={{120,-34},{100,-14}})));
  Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if pumpControl.y
         then m_flowCoo else 0.001)
    annotation (Placement(transformation(extent={{92,-4},{72,16}})));
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
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
    redeclare package Medium = Medium_Coolant,
    m_flow_small=0.001,
    m_flow_nominal=CHPEngData.m_floCooNominal)
    annotation (Placement(transformation(extent={{42,-20},{26,-4}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
    redeclare package Medium = Medium_Coolant,
    m_flow_nominal=CHPEngData.m_floCooNominal,
    m_flow_small=0.001)
    annotation (Placement(transformation(extent={{-60,-38},{-76,-22}})));
equation

  connect(realExpT_Exh.y, exhaustFlow.T_in)
    annotation (Line(points={{-106,25},{-106,44},{-102,44}}, color={0,0,127}));
  connect(exhaustFlow.m_flow_in, max.y)
    annotation (Line(points={{-100,48},{-107,48}}, color={0,0,127}));
  connect(massFlowExhaustMin.y, max.u2) annotation (Line(points={{-134.9,30},{
          -134.9,42},{-130,42}},
                          color={0,0,127}));
  connect(max.u1, trapezoid.y) annotation (Line(points={{-130,54},{-134,54},{
          -134,60},{-137,60}}, color={0,0,127}));
  connect(exhaustFlow.ports[1], exhaustHeatExchanger.port_a1) annotation (Line(
        points={{-80,40},{-58,40},{-58,12},{-20,12}}, color={0,127,255}));
  connect(exhaustHeatExchanger.port_b1, outletExhaustGas.ports[1]) annotation (
      Line(points={{20,12},{58,12},{58,40},{92,40}}, color={0,127,255}));
  connect(exhaustHeatExchanger.port_Ambient, fixedTemperature.port) annotation (
     Line(points={{-20,0},{-72,0}},                     color={191,0,0}));
  connect(massFlowCoolant.y,coolantPump. m_flow_in)
    annotation (Line(points={{71,6},{65,6},{65,-9.6}},   color={0,0,127}));
  connect(fixedPressureLevel.ports[1], coolantPump.port_a)
    annotation (Line(points={{100,-24},{76,-24}}, color={0,127,255}));
  connect(timerIsOff.u,not1. y)
    annotation (Line(points={{4.6,85},{-5.3,85}},    color={255,0,255}));
  connect(timerIsOff.y,declarationTime. u)
    annotation (Line(points={{20.7,85},{30.6,85}},color={0,0,127}));
  connect(declarationTime.y,pumpControl. u1) annotation (Line(points={{46.7,85},
          {54,85},{54,74},{60,74}}, color={255,0,255}));
  connect(cHPIsOnOff.y, not1.u) annotation (Line(points={{-65.2,76},{-26,76},{
          -26,85},{-21.4,85}}, color={255,0,255}));
  connect(pumpControl.u2, not1.u) annotation (Line(points={{60,66},{-26,66},{
          -26,85},{-21.4,85}}, color={255,0,255}));
  connect(exhaustHeatExchanger.port_b2, tempCoolantReturn.port_a) annotation (
      Line(points={{-20,-12},{-40,-12},{-40,-30},{-60,-30}}, color={0,127,255}));
  connect(fixedPressureLevel1.ports[1], tempCoolantReturn.port_b)
    annotation (Line(points={{-100,-30},{-76,-30}}, color={0,127,255}));
  connect(coolantPump.port_b, tempCoolantSupply.port_a) annotation (Line(points
        ={{54,-24},{46,-24},{46,-12},{42,-12}}, color={0,127,255}));
  connect(exhaustHeatExchanger.port_a2, tempCoolantSupply.port_b)
    annotation (Line(points={{20,-12},{26,-12}}, color={0,127,255}));
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
</html>"),
experiment(StartTime=0, StopTime=300, Interval=0.1));
end ModularCHP_ExhaustHeatExchangerTESTSIMPLE;
