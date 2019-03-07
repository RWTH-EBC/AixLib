within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model CHP_PowerUnitCircuit2901
  "Model of engine combustion, its power output and heat transfer to the cooling circle and ambient"
  import AixLib;

  replaceable package Medium_Fuel =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.LiquidFuel_LPG      constrainedby
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

  replaceable package Medium_Coolant =
      DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                 property_T=356, X_a=0.50) constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
      AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
    "Thermal engine material data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
    annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

  parameter Modelica.SIunits.Temperature T_ambient=298.15
    "Default ambient temperature"
    annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
    "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.SIunits.Temperature T_CoolRet=350.15
    "Coolant return temperature" annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.SIunits.Temperature T_CoolSup=tempCoolantSupply.T
    "Coolant supply temperature"
    annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.SIunits.Power Q_Therm=cHP_PowerUnit.Q_Therm "Thermal power output of the CHP unit";
  Modelica.SIunits.Power P_Mech=cHP_PowerUnit.P_Mech "Mechanical power output of the CHP unit";
  Modelica.SIunits.Power P_El=cHP_PowerUnit.P_El "Electrical power output of the CHP unit";
  Modelica.SIunits.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
  Modelica.SIunits.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused "Total heat error of the CHP unit";
 // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
  Modelica.SIunits.MassFlowRate m_CO2=cHP_PowerUnit.m_CO2 "CO2 emission output rate";
  Modelica.SIunits.MassFlowRate m_Fuel=cHP_PowerUnit.m_Fuel "Fuel consumption rate of CHP unit";
  type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
  SpecificEmission b_CO2=cHP_PowerUnit.b_CO2 "Specific CO2 emissions per kWh (heat and power)";
  SpecificEmission b_e=cHP_PowerUnit.b_e "Specific fuel consumption per kWh (heat and power)";
  Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
  Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
  Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
  Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
  Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow=
      CHPEngineModel.m_floCooNominal
    "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.ThermalConductance GCoolChannel=45
    "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
    annotation (Dialog(tab="Engine Cooling Circle"));

  parameter Boolean ConTec=false
    "Is condensing technology used and should latent heat be considered?"
    annotation (Dialog(tab="Advanced", group="Latent heat use"));
  parameter Boolean useGenHea=true
    "Is the thermal loss energy of the elctric machine used?"
    annotation (Dialog(tab="Advanced", group="Generator heat use"));
  parameter Boolean allowFlowReversalExhaust=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Boolean allowFlowReversalCoolant=false
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    mExh_flow_small=0.0001
    "Small exhaust mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    mCool_flow_small=0.005
    "Small coolant mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));

  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_PowerUnit2801 cHP_PowerUnit(
    redeclare package Medium_Fuel = Medium_Fuel,
    redeclare package Medium_Air = Medium_Air,
    redeclare package Medium_Exhaust = Medium_Exhaust,
    redeclare package Medium_Coolant = Medium_Coolant,
    CHPEngineModel=CHPEngineModel,
    EngMat=EngMat,
    T_ambient=T_ambient,
    p_ambient=p_ambient,
    T_CoolRet=T_CoolRet,
    T_CoolSup=T_CoolSup,
    m_flow=m_flow,
    GCoolChannel=GCoolChannel,
    ConTec=ConTec,
    useGenHea=useGenHea,
    allowFlowReversalExhaust=allowFlowReversalExhaust,
    allowFlowReversalCoolant=allowFlowReversalCoolant,
    mExh_flow_small=mExh_flow_small,
    mCool_flow_small=mCool_flow_small)
    annotation (Placement(transformation(extent={{-24,-10},{24,38}})));
  AixLib.Fluid.Movers.BaseClasses.IdealSource coolantPump(
    redeclare package Medium = Medium_Coolant,
    control_m_flow=true,
    control_dp=true,
    dp_start=CHPEngineModel.dp_Coo,
    m_flow_small=mCool_flow_small)
    annotation (Placement(transformation(extent={{-64,-10},{-44,10}})));
  Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
    redeclare package Medium = Medium_Coolant,
    nPorts=1,
    p=300000,
    T=350.15)
    annotation (Placement(transformation(extent={{-112,-12},{-92,8}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
    redeclare package Medium = Medium_Coolant,
    m_flow_nominal=CHPEngineModel.m_floCooNominal,
    m_flow_small=mCool_flow_small)
    annotation (Placement(transformation(extent={{40,-8},{56,8}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
    redeclare package Medium = Medium_Coolant,
    m_flow_small=mCool_flow_small,
    m_flow_nominal=CHPEngineModel.m_floCooNominal)
    annotation (Placement(transformation(extent={{-48,-48},{-64,-32}})));
  Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if cHPIsOnOff.y
         then CHPEngineModel.m_floCooNominal else mCool_flow_small)
    annotation (Placement(transformation(extent={{-24,8},{-44,28}})));
  Modelica.Blocks.Interfaces.BooleanInput
                                       cHPOnOff
    annotation (Placement(transformation(extent={{-110,64},{-94,80}})));
  Modelica.Blocks.Sources.BooleanPulse cHPIsOnOff(
    startTime(displayUnit="h") = 0,
    period(displayUnit="h") = 86400,
    width=50)
    annotation (Placement(transformation(extent={{-106,38},{-90,54}})));
  AixLib.Fluid.Sources.PropertySource_T proSou(
    use_T_in=true,
    redeclare package Medium = Medium_Coolant,
    allowFlowReversal=allowFlowReversalCoolant)
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=350)
    annotation (Placement(transformation(extent={{-38,-34},{-18,-14}})));
equation
  connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
        points={{-44,0},{-28,0},{-28,0.08},{-19.2,0.08}},
                                                        color={0,127,255}));
  connect(tempCoolantReturn.port_b, coolantPump.port_a) annotation (Line(points=
         {{-64,-40},{-76,-40},{-76,0},{-64,0}}, color={0,127,255}));
  connect(fixedPressureLevel.ports[1], coolantPump.port_a) annotation (Line(
        points={{-92,-2},{-76,-2},{-76,0},{-64,0}}, color={0,127,255}));
  connect(massFlowCoolant.y, coolantPump.m_flow_in)
    annotation (Line(points={{-45,18},{-60,18},{-60,8}}, color={0,0,127}));
  connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
        points={{19.2,0.08},{29.6,0.08},{29.6,0},{40,0}}, color={0,127,255}));
  connect(cHPIsOnOff.y, cHP_PowerUnit.onOffStep) annotation (Line(points={{-89.2,
          46},{-54,46},{-54,30.32},{-23.04,30.32}}, color={255,0,255}));
  connect(tempCoolantReturn.port_a, proSou.port_b)
    annotation (Line(points={{-48,-40},{-10,-40}}, color={0,127,255}));
  connect(tempCoolantSupply.port_b, proSou.port_a) annotation (Line(points={{56,
          0},{76,0},{76,-40},{10,-40}}, color={0,127,255}));
  connect(proSou.T_in, realExpression.y) annotation (Line(points={{4,-28},{4,-28},
          {4,-26},{4,-26},{4,-24},{-17,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-50,58},{50,18}},
          lineColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString="CHP",
          textStyle={TextStyle.Bold}),
                              Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),                                       Text(
          extent={{-50,68},{50,28}},
          lineColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textStyle={TextStyle.Bold},
          textString="CHP
physikal"),
        Rectangle(
          extent={{-12,6},{12,-36}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,-16},{-10,-36},{-8,-30},{8,-30},{10,-36},{10,-16},{-10,-16}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,-26},{4,-32}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,-54},{-8,-64}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,-30},{-14,-54},{-10,-56},{0,-32},{-2,-30}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4.5,-15.5},{-8,-10},{0,4},{6,-4},{10,-4},{8,-8},{8,-12},{5.5,
              -15.5},{-4.5,-15.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-4.5,-13.5},{0,-4},{6,-10},{2,-14},{-4.5,-13.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
         __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
    Documentation(info="<html>
<p>Limitations:</p>
<p>- Transmissions between generator and engine are not considered </p>
<p>- </p>
</html>"));
end CHP_PowerUnitCircuit2901;
