within AixLib.Fluid.BoilerCHP.Examples;
model ModularCHPSubsystems
  "Example that illustrates use of modular CHP engine submodel"
  extends Modelica.Icons.Example;

  replaceable package Medium_Gasoline =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.LiquidFuel_Petrol   constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                annotation(choicesAllMatching=true);

  replaceable package Medium_Air =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                               constrainedby
    DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                         annotation(choicesAllMatching=true);

  replaceable package Medium_Exhaust =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                 annotation(choicesAllMatching=true);

  parameter DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  parameter Modelica.SIunits.Temperature T_ambient=298.15
    "Default ambient temperature"
    annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
    "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));

  Modelica.Blocks.Sources.RealExpression massFlowGas(y=
        cHPGasolineEngineLIQUIDFUEL.m_Fue)
    annotation (Placement(transformation(extent={{-82,20},{-62,40}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                        inletGasoline(
    redeclare package Medium = Medium_Gasoline,
    use_m_flow_in=true,
    nPorts=1,
    T=T_ambient)
    annotation (Placement(transformation(extent={{-50,16},{-34,32}})));
  Modelica.Blocks.Sources.RealExpression massFlowAir(y=
        cHPGasolineEngineLIQUIDFUEL.m_Air)
    annotation (Placement(transformation(extent={{-82,-8},{-62,12}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                        inletAir(
    redeclare package Medium = Medium_Air,
    use_m_flow_in=true,
    nPorts=1,
    use_T_in=false,
    T=T_ambient)
    annotation (Placement(transformation(extent={{-50,-12},{-34,4}})));
  ModularCHP.CHPGasolineEngine
    cHPGasolineEngineLIQUIDFUEL(
    redeclare package Medium1 = Medium_Gasoline,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium3 = Medium_Exhaust,
    T_Amb=T_ambient,
    CHPEngData=CHPEngineModel,
    inertia(w(fixed=true, start=100)),
    T_logEngCool=629.3)
    annotation (Placement(transformation(extent={{-14,-12},{14,16}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticSpeedDependentTorque(w_nominal=160, tau_nominal=-100)
    annotation (Placement(transformation(extent={{-24,44},{-12,56}})));
  Modelica.Blocks.Sources.RealExpression realExpT_Exh(y=383.15)
    annotation (Placement(transformation(extent={{54,-16},{34,4}})));
  Modelica.Fluid.Sources.FixedBoundary outletExhaustGas(
    redeclare package Medium = Medium_Exhaust,
    p=p_ambient,
    nPorts=1)
    annotation (Placement(transformation(extent={{54,14},{34,34}})));
  inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
    annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));
equation
  connect(massFlowGas.y, inletGasoline.m_flow_in) annotation (Line(points={{-61,
          30},{-56,30},{-56,30.4},{-50,30.4}}, color={0,0,127}));
  connect(massFlowAir.y, inletAir.m_flow_in) annotation (Line(points={{-61,2},{-56,
          2},{-56,2.4},{-50,2.4}}, color={0,0,127}));
  connect(inletGasoline.ports[1], cHPGasolineEngineLIQUIDFUEL.port_Gasoline)
    annotation (Line(points={{-34,24},{-28,24},{-28,12.92},{-14,12.92}}, color={
          0,127,255}));
  connect(inletAir.ports[1], cHPGasolineEngineLIQUIDFUEL.port_Air) annotation (
      Line(points={{-34,-4},{-28,-4},{-28,8.72},{-14,8.72}}, color={0,127,255}));
  connect(cHPGasolineEngineLIQUIDFUEL.flange_a, quadraticSpeedDependentTorque.flange)
    annotation (Line(points={{0,16},{-6,16},{-6,50},{-12,50}}, color={0,0,0}));
  connect(cHPGasolineEngineLIQUIDFUEL.exhaustGasTemperature, realExpT_Exh.y)
    annotation (Line(points={{14,7.6},{24,7.6},{24,-6},{33,-6}}, color={0,0,127}));
  connect(cHPGasolineEngineLIQUIDFUEL.port_Exhaust, outletExhaustGas.ports[1])
    annotation (Line(points={{13.72,12.08},{24,12.08},{24,24},{34,24}}, color={0,
          127,255}));
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The simulation illustrates the behavior of <a href=\"AixLib.Fluid.BoilerCHP.CHP\">AixLib.Fluid.BoilerCHP.CHP</a> in different conditions.
Inlet and outlet temperature as well as the electrical and thermal power of the
CHP can be observed.
Change the inlet water temperature profile to see the reaction timing. </p>
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
experiment(StopTime=35000, Interval=60));
end ModularCHPSubsystems;
