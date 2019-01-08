within AixLib.Fluid.BoilerCHP.Examples;
model ModularCHP_ExhaustHeatExchangerStartStop
  "Example that illustrates use of modular CHP exhaust heat exchanger submodel"
  import AixLib;
  extends Modelica.Icons.Example;

  package Medium_Exhaust =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus;

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "Needed engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  constant Modelica.SIunits.MassFraction Xi_Exh[:] = {0.73,0.05,0.08,0.14};
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
  parameter Modelica.SIunits.Temperature T_ExhPowUniOut=CHPEngData.T_ExhPowUniOut
                                                               "Outlet temperature of exhaust gas flow"
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
  Modelica.SIunits.SpecificHeatCapacity meanCpExh=1200
    "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature"
   annotation (Dialog(group = "Thermal"));
  Modelica.SIunits.HeatFlowRate Q_flowExhHea=senMasFloExh.m_flow*meanCpExh*(
      senTExhHot.T - T_ExhPowUniOut)
    "Calculated exhaust heat from fixed exhaust outlet temperature";

  Medium_Exhaust.ThermodynamicState state1 = Medium_Exhaust.setState_pTX(senTExhHot.port_b.p,T_LogMeanExh,senTExhHot.port_b.Xi_outflow);
  Modelica.SIunits.SpecificEnthalpy h1_in = Medium_Exhaust.specificEnthalpy(state1);
  Modelica.SIunits.DynamicViscosity eta1_in = Medium_Exhaust.dynamicViscosity(state1);
  Modelica.SIunits.Density rho1_in = Medium_Exhaust.density_phX(state1.p,h1_in,state1.X);
  Modelica.SIunits.Velocity v1_in = senMasFloExh.m_flow/(Modelica.Constants.pi*rho1_in*d_iExh^2/4);
  Modelica.SIunits.ThermalConductivity lambda1_in = Medium_Exhaust.thermalConductivity(state1);
  Modelica.SIunits.ReynoldsNumber Re1_in = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(v1_in,rho1_in,eta1_in,d_iExh);

  Modelica.SIunits.Temperature T_LogMeanExh
    "Mean logarithmic temperature of exhaust gas";
  Real QuoT_ExhInOut=senTExhHot.T/senTExhCold.T
  "Quotient of exhaust gas in and outgoing temperature";

  inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
    annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));
  Sensors.TemperatureTwoPort senTExhCold(
    redeclare final package Medium = Medium_Exhaust,
    final tau=tau,
    final m_flow_nominal=0.023,
    final initType=initType,
    final T_start=T1_start,
    final transferHeat=transferHeat,
    final TAmb=T_ambient,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=true,
    final m_flow_small=0.0001)
    "Temperature sensor of cold side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Sensors.MassFlowRate senMasFloExh(redeclare final package Medium =
        Medium_Exhaust, final allowFlowReversal=true)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{50,50},{70,30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ambientLoss(G=G_Amb)
    annotation (Placement(transformation(extent={{-50,-42},{-70,-22}})));
  Modelica.Fluid.Vessels.ClosedVolume volExhaust(
    redeclare final package Medium = Medium_Exhaust,
    final m_flow_nominal=0.023,
    final p_start=p1_start,
    final T_start=T_ExhPowUniOut,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
    use_portsData=false,
    final m_flow_small=0.0001,
    V=VExhHex,
    nPorts=2)                          "Fluid volume"
    annotation (Placement(transformation(extent={{-20,40},{-40,20}})));
  FixedResistances.HydraulicDiameter
                                pressureDropExhaust(
    redeclare final package Medium = Medium_Exhaust,
    final show_T=false,
    final allowFlowReversal=true,
    final m_flow_nominal=0.023,
    dh=d_iExh,
    rho_default=1.18,
    mu_default=1.82*10^(-5),
    length=l_ExhHex)               "Pressure drop"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Utilities.HeatTransfer.HeatConvPipeInsideDynamic heatConvExhaustPipeInside(
    length=l_ExhHex,
    d_i=d_iExh,
    A_sur=A_surExhHea,
    c=1200,
    rho=rho1_in,
    lambda=lambda1_in,
    eta=eta1_in)                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,0})));
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
    annotation (Placement(transformation(extent={{-110,-42},{-90,-22}})));
  Sensors.TemperatureTwoPort senTExhHot(
    redeclare final package Medium = Medium_Exhaust,
    final tau=tau,
    final m_flow_nominal=0.023,
    final initType=initType,
    final T_start=T1_start,
    final transferHeat=transferHeat,
    final TAmb=T_ambient,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=true,
    final m_flow_small=0.0001)
    "Temperature sensor of cold side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Sources.RealExpression realExpT_Exh(y=T_ExhPowUniOut)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-106,14})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=
        C_ExhHex, T(fixed=true, start=298.15))
    annotation (Placement(transformation(extent={{-30,-32},{-10,-52}})));
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
    rising=3,
    width=100,
    falling=3,
    period=600)
    annotation (Placement(transformation(extent={{-158,50},{-138,70}})));
equation

    if (QuoT_ExhInOut-1)>0.0001 then
  T_LogMeanExh=(senTExhHot.T-senTExhCold.T)/Modelica.Math.log(QuoT_ExhInOut);
  else
  T_LogMeanExh=senTExhHot.T;
  end if;

  connect(ambientLoss.port_b, fixedTemperature.port)
    annotation (Line(points={{-70,-32},{-90,-32}}, color={191,0,0}));
  connect(realExpT_Exh.y, exhaustFlow.T_in)
    annotation (Line(points={{-106,25},{-106,44},{-102,44}}, color={0,0,127}));
  connect(ambientLoss.port_a, heatCapacitor.port)
    annotation (Line(points={{-50,-32},{-20,-32}}, color={191,0,0}));
  connect(senMasFloExh.m_flow, heatConvExhaustPipeInside.m_flow)
    annotation (Line(points={{60,29},{60,0.4},{-9.2,0.4}},  color={0,0,127}));
  connect(pressureDropExhaust.port_b, senTExhCold.port_a)
    annotation (Line(points={{10,40},{20,40}}, color={0,127,255}));
  connect(senTExhCold.port_b, senMasFloExh.port_a)
    annotation (Line(points={{40,40},{50,40}}, color={0,127,255}));
  connect(senMasFloExh.port_b, outletExhaustGas.ports[1])
    annotation (Line(points={{70,40},{92,40}}, color={0,127,255}));
  connect(exhaustFlow.ports[1], senTExhHot.port_a)
    annotation (Line(points={{-80,40},{-70,40}}, color={0,127,255}));
  connect(volExhaust.heatPort, heatConvExhaustPipeInside.port_a)
    annotation (Line(points={{-20,30},{-20,10}}, color={191,0,0}));
  connect(heatConvExhaustPipeInside.port_b, heatCapacitor.port)
    annotation (Line(points={{-20,-10},{-20,-32}}, color={191,0,0}));
  connect(pressureDropExhaust.port_a, volExhaust.ports[1]) annotation (Line(
        points={{-10,40},{-20,40},{-20,46},{-28,46},{-28,40}}, color={0,127,255}));
  connect(senTExhHot.port_b, volExhaust.ports[2]) annotation (Line(points={{-50,
          40},{-40,40},{-40,46},{-32,46},{-32,40}}, color={0,127,255}));
  connect(exhaustFlow.m_flow_in, max.y)
    annotation (Line(points={{-100,48},{-107,48}}, color={0,0,127}));
  connect(massFlowExhaustMin.y, max.u2) annotation (Line(points={{-134.9,30},{
          -134.9,42},{-130,42}},
                          color={0,0,127}));
  connect(max.u1, trapezoid.y) annotation (Line(points={{-130,54},{-134,54},{
          -134,60},{-137,60}}, color={0,0,127}));
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
experiment(StartTime=1, StopTime=300, Interval=0.1));
end ModularCHP_ExhaustHeatExchangerStartStop;
