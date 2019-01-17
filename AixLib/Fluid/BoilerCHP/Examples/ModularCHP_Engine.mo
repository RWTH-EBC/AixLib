within AixLib.Fluid.BoilerCHP.Examples;
model ModularCHP_Engine
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

  AixLib.Fluid.BoilerCHP.ModularCHP.CHPCombustionEngine cHPGasolineEngine(
    redeclare package Medium1 = Medium_Gasoline,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium3 = Medium_Exhaust,
    T_Amb=T_ambient,
    CHPEngData=CHPEngineModel,
    inertia(w(
        fixed=true,
        start=0,
        displayUnit="rad/s"), J=1),
    T_logEngCool=363.15,
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
  AixLib.Fluid.BoilerCHP.ModularCHP.CHP_StarterGenerator
    cHP_ASMGeneratorCURRENT(inertia(w(fixed=false)))
    annotation (Placement(transformation(extent={{-42,58},{-20,80}})));
  Modelica.Blocks.Sources.BooleanPulse onOffSignal(           startTime=0, period=
        10)
    annotation (Placement(transformation(extent={{-118,62},{-100,80}})));
equation
  connect(cHPGasolineEngine.exhaustGasTemperature, realExpT_Exh.y) annotation (
      Line(points={{14,-2.48},{24,-2.48},{24,-6},{33,-6}},
                                                       color={0,0,127}));
  connect(cHPGasolineEngine.port_Exhaust, outletExhaustGas.ports[1])
    annotation (Line(points={{13.72,2},{24,2},{24,24},{34,24}},         color={
          0,127,255}));
  connect(onOffSignal.y, cHPGasolineEngine.isOn) annotation (Line(points={{
          -99.1,71},{-90,71},{-90,2},{-13.72,2}}, color={255,0,255}));
  connect(cHP_ASMGeneratorCURRENT.isOn, cHPGasolineEngine.isOn) annotation (
      Line(points={{-41.78,69},{-90,69},{-90,2},{-13.72,2}}, color={255,0,255}));
  connect(cHP_ASMGeneratorCURRENT.flange_a, cHPGasolineEngine.flange_a)
    annotation (Line(points={{-20,69},{-10,69},{-10,70},{0,70},{0,16}}, color={
          0,0,0}));
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
end ModularCHP_Engine;
