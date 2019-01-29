within AixLib.Fluid.BoilerCHP.ModularCHP;
model CHP_PowerUnitToHeatingModulate
  "Model of engine combustion, its power output and heat transfer to the cooling circle and ambient"
  import AixLib;

  replaceable package Medium_Fuel =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                    constrainedby
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

  replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                           constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

  replaceable package Medium_HeatingCircuit =
      DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                 property_T=356, X_a=0.50)   constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (
      __Dymola_choicesAllMatching=true);

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  parameter Fluid.BoilerCHP.ModularCHP.EngineMaterialData EngMat=
      Fluid.BoilerCHP.ModularCHP.EngineMaterial_CastIron()
    "Thermal engine material data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
    annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));

  parameter Modelica.SIunits.Temperature T_ambient=298.15
    "Default ambient temperature"
    annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
    "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
  Modelica.SIunits.Temperature T_Ret=tempReturnFlow.T
    "Coolant return temperature" annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.SIunits.Temperature T_Sup=tempSupplyFlow.T
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

  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flowCoo=0.5
    "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
          "Engine Cooling Circle"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flowHeaCir=
      CHPEngineModel.m_floCooNominal
    "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.ThermalConductance GCoolChannel=15
    "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
    annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.ThermalConductance GCooHex=30000
    "Thermal conductance of the coolant heat exchanger at nominal flow"
    annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.Area A_surExhHea=100
    "Surface for exhaust heat transfer"
    annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Boolean ConTec=true
    "Is condensing technology used and should latent heat be considered?"
    annotation (Dialog(tab="Advanced", group="Latent heat use"));
  parameter Boolean useGenHea=true
    "Is the thermal loss energy of the elctric machine used?"
    annotation (Dialog(tab="Advanced", group="Generator heat use"));
  parameter Boolean allowFlowReversalExhaust=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Boolean allowFlowReversalCoolant=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    mExh_flow_small=0.001
    "Small exhaust mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    mCool_flow_small=0.005
    "Small coolant mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));

  AixLib.Fluid.BoilerCHP.ModularCHP.CHP_PowerUnitModulate
                                                  cHP_PowerUnit(
    redeclare package Medium_Fuel = Medium_Fuel,
    redeclare package Medium_Air = Medium_Air,
    redeclare package Medium_Exhaust = Medium_Exhaust,
    CHPEngineModel=CHPEngineModel,
    EngMat=EngMat,
    T_ambient=T_ambient,
    p_ambient=p_ambient,
    m_flow=m_flowCoo,
    GCoolChannel=GCoolChannel,
    ConTec=ConTec,
    useGenHea=useGenHea,
    allowFlowReversalExhaust=allowFlowReversalExhaust,
    allowFlowReversalCoolant=allowFlowReversalCoolant,
    mExh_flow_small=mExh_flow_small,
    mCool_flow_small=mCool_flow_small,
    A_surExhHea=A_surExhHea,
    mEng=mEng,
    redeclare package Medium_Coolant = Medium_Coolant,
    inductionMachine(s_til=0.16),
    T_CoolRet=tempReturnFlow.T,
    T_CoolSup=tempSupplyFlow.T)
    annotation (Placement(transformation(extent={{-24,0},{24,48}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow   coolantPump(
    m_flow_small=mCool_flow_small,
    redeclare package Medium = Medium_Coolant,
    dp_nominal=CHPEngineModel.dp_Coo,
    allowFlowReversal=allowFlowReversalCoolant,
    m_flow_nominal=m_flowCoo,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-60,-2},{-38,22}})));
  Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
    nPorts=1,
    redeclare package Medium = Medium_Coolant,
    p=300000,
    T=298.15)
    annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupply(
    m_flow_small=mCool_flow_small,
    redeclare package Medium = Medium_Coolant,
    m_flow_nominal=m_flowCoo)
    annotation (Placement(transformation(extent={{40,2},{56,18}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantReturn(
    m_flow_small=mCool_flow_small,
    redeclare package Medium = Medium_Coolant,
    m_flow_nominal=m_flowCoo)
    annotation (Placement(transformation(extent={{-40,-48},{-56,-32}})));
  Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if
        onOff_ControllerCHP.pumpControl.y then m_flowCoo else mCool_flow_small)
    annotation (Placement(transformation(extent={{-80,22},{-60,42}})));

  AixLib.Fluid.HeatExchangers.ConstantEffectiveness             coolantHex(
    allowFlowReversal1=allowFlowReversalCoolant,
    allowFlowReversal2=allowFlowReversalCoolant,
    m2_flow_nominal=CHPEngineModel.m_floCooNominal,
    m1_flow_small=mCool_flow_small,
    m2_flow_small=mCool_flow_small,
    redeclare package Medium1 = Medium_Coolant,
    m1_flow_nominal=m_flowCoo,
    redeclare package Medium2 = Medium_HeatingCircuit,
    dp1_nominal(displayUnit="kPa") = 10000,
    dp2_nominal(displayUnit="kPa") = 10000,
    eps=0.9)
    annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
  Modelica.Fluid.Sources.MassFlowSource_T heatingReturnFlow(
    nPorts=1,
    use_T_in=true,
    m_flow=m_flowHeaCir,
    redeclare package Medium = Medium_HeatingCircuit)
    annotation (Placement(transformation(extent={{-110,-74},{-90,-54}})));
  Modelica.Fluid.Sources.FixedBoundary heatingSupplyFlow(
                               nPorts=1, redeclare package Medium =
        Medium_HeatingCircuit)
    annotation (Placement(transformation(extent={{110,-74},{90,-54}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempReturnFlow(
    m_flow_small=mCool_flow_small,
    m_flow_nominal=CHPEngineModel.m_floCooNominal,
    redeclare package Medium = Medium_HeatingCircuit)
    annotation (Placement(transformation(extent={{-56,-72},{-40,-56}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
    m_flow_small=mCool_flow_small,
    m_flow_nominal=CHPEngineModel.m_floCooNominal,
    redeclare package Medium = Medium_HeatingCircuit)
    annotation (Placement(transformation(extent={{40,-72},{56,-56}})));

  Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=if
        onOff_ControllerCHP.cHPIsOnOff.y then 303.15 else 293.15)
    annotation (Placement(transformation(extent={{-144,-70},{-124,-50}})));
  parameter Modelica.SIunits.Mass mEng=80
    "Total engine mass for heat capacity calculation of the motor block"
    annotation (Dialog(tab="Engine Cooling Circle"));
  AixLib.Fluid.BoilerCHP.ModularCHP.OnOff_ControllerCHP onOff_ControllerCHP
    annotation (Placement(transformation(rotation=0, extent={{-76,64},{-44,96}})));
equation
  connect(coolantPump.port_b, cHP_PowerUnit.port_Return) annotation (Line(
        points={{-38,10},{-28,10},{-28,10.08},{-19.2,10.08}},
                                                        color={0,127,255}));
  connect(tempCoolantReturn.port_b, coolantPump.port_a) annotation (Line(points={{-56,-40},
          {-76,-40},{-76,10},{-60,10}},         color={0,127,255}));
  connect(fixedPressureLevel.ports[1], coolantPump.port_a) annotation (Line(
        points={{-92,10},{-60,10}},                 color={0,127,255}));
  connect(massFlowCoolant.y, coolantPump.m_flow_in)
    annotation (Line(points={{-59,32},{-49,32},{-49,24.4}},
                                                         color={0,0,127}));
  connect(tempCoolantSupply.port_b, coolantHex.port_a1) annotation (Line(points={{56,10},
          {74,10},{74,-40},{20,-40}},         color={0,127,255}));
  connect(coolantHex.port_b1, tempCoolantReturn.port_a)
    annotation (Line(points={{-20,-40},{-40,-40}}, color={0,127,255}));
  connect(heatingReturnFlow.ports[1],tempReturnFlow. port_a)
    annotation (Line(points={{-90,-64},{-56,-64}}, color={0,127,255}));
  connect(coolantHex.port_a2, tempReturnFlow.port_b)
    annotation (Line(points={{-20,-64},{-40,-64}}, color={0,127,255}));
  connect(coolantHex.port_b2, tempSupplyFlow.port_a)
    annotation (Line(points={{20,-64},{40,-64}}, color={0,127,255}));
  connect(tempSupplyFlow.port_b,heatingSupplyFlow. ports[1])
    annotation (Line(points={{56,-64},{90,-64}}, color={0,127,255}));
  connect(cHP_PowerUnit.port_Supply, tempCoolantSupply.port_a) annotation (Line(
        points={{19.2,10.08},{29.6,10.08},{29.6,10},{40,10}},
                                                          color={0,127,255}));
  connect(heatingReturnFlow.T_in, tempFlowHeating.y)
    annotation (Line(points={{-112,-60},{-123,-60}}, color={0,0,127}));
  connect(onOff_ControllerCHP.modularCHPControlBus, cHP_PowerUnit.sigBusCHP)
    annotation (Line(
      points={{-44,80},{-0.24,80},{-0.24,47.76}},
      color={255,204,51},
      thickness=0.5));
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
<p>- </p>
<p>- </p>
<p><br>Caution: </p>
<p>- if the prime coolant cirlce of the power unit is using a gasoline medium instead of a liquid fluid, you may need to adjust (raise) the nominal mass flow and pressure drop of the cooling to heating heat exchanger to run the model, because of a background calculation for the nominal flow.</p>
</html>"));
end CHP_PowerUnitToHeatingModulate;
