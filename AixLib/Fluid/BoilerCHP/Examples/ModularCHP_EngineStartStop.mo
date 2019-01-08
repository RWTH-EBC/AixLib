within AixLib.Fluid.BoilerCHP.Examples;
model ModularCHP_EngineStartStop
  "Example that illustrates use of modular CHP engine submodel"
  import AixLib;
  extends Modelica.Icons.Example;

  replaceable package Medium_Gasoline =
      DataBase.CHP.ModularCHPEngineMedia.LiquidFuel_LPG             constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                annotation(choicesAllMatching=true);

  package Medium_Air =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir;

  package Medium_Exhaust =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus;

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  parameter Modelica.SIunits.Temperature T_ambient=298.15
    "Default ambient temperature"
    annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
    "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));

  Modelica.Blocks.Sources.RealExpression massFlowFuel(y=cHPGasolineEngine.m_Fue)
    annotation (Placement(transformation(extent={{-82,20},{-62,40}})));
  Modelica.Fluid.Sources.MassFlowSource_T inletFuel(
    redeclare package Medium = Medium_Gasoline,
    use_m_flow_in=true,
    nPorts=1,
    T=T_ambient)
    annotation (Placement(transformation(extent={{-50,16},{-34,32}})));
  Modelica.Blocks.Sources.RealExpression massFlowAir(y=cHPGasolineEngine.m_Air)
    annotation (Placement(transformation(extent={{-82,-8},{-62,12}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                        inletAir(
    redeclare package Medium = Medium_Air,
    use_m_flow_in=true,
    nPorts=1,
    use_T_in=false,
    T=T_ambient)
    annotation (Placement(transformation(extent={{-50,-12},{-34,4}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.CHPCombustionEngine
                                         cHPGasolineEngine(
    redeclare package Medium1 = Medium_Gasoline,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium3 = Medium_Exhaust,
    T_Amb=T_ambient,
    CHPEngData=CHPEngineModel,
    inertia(w(fixed=false, displayUnit="rad/s"), J=1),
    T_logEngCool=356.15,
    T_ExhCHPOut=383.15)
    annotation (Placement(transformation(extent={{-14,-12},{14,16}})));
  Modelica.Blocks.Sources.RealExpression realExpT_Exh(y=383.15)
    annotation (Placement(transformation(extent={{54,-16},{34,4}})));
  Modelica.Fluid.Sources.FixedBoundary outletExhaustGas(
    redeclare package Medium = Medium_Exhaust,
    p=p_ambient,
    nPorts=1)
    annotation (Placement(transformation(extent={{54,14},{34,34}})));
  inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
    annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=160,
    rising=10,
    width=100,
    falling=10,
    period=150)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
equation
  connect(massFlowFuel.y, inletFuel.m_flow_in) annotation (Line(points={{-61,30},
          {-56,30},{-56,30.4},{-50,30.4}}, color={0,0,127}));
  connect(massFlowAir.y, inletAir.m_flow_in) annotation (Line(points={{-61,2},{-56,
          2},{-56,2.4},{-50,2.4}}, color={0,0,127}));
  connect(inletAir.ports[1], cHPGasolineEngine.port_Air) annotation (Line(
        points={{-34,-4},{-28,-4},{-28,8.72},{-14,8.72}}, color={0,127,255}));
  connect(cHPGasolineEngine.exhaustGasTemperature, realExpT_Exh.y) annotation (
      Line(points={{14,7.6},{24,7.6},{24,-6},{33,-6}}, color={0,0,127}));
  connect(cHPGasolineEngine.port_Exhaust, outletExhaustGas.ports[1])
    annotation (Line(points={{13.72,12.08},{24,12.08},{24,24},{34,24}}, color={
          0,127,255}));
  connect(inletFuel.ports[1], cHPGasolineEngine.port_Fuel) annotation (Line(
        points={{-34,24},{-28,24},{-28,12.92},{-14,12.92}}, color={0,127,255}));
  connect(speed.w_ref, trapezoid.y)
    annotation (Line(points={{-62,70},{-79,70}}, color={0,0,127}));
  connect(speed.flange, cHPGasolineEngine.flange_a)
    annotation (Line(points={{-40,70},{0,70},{0,16}}, color={0,0,0}));
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
experiment(StopTime=300, Interval=0.1));
end ModularCHP_EngineStartStop;
