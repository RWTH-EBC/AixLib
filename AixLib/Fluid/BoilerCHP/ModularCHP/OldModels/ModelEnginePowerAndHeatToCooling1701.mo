within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model ModelEnginePowerAndHeatToCooling1701
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
                                 property_T=356, X_a=0.50)   constrainedby
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

  AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing
    engineToCoolant(
    z=CHPEngineModel.z,
    eps=CHPEngineModel.eps,
    m_Exh=cHPCombustionEngine.m_Exh,
    T_Amb=T_ambient,
    redeclare package Medium3 = Medium_Exhaust,
    dCyl=CHPEngineModel.dCyl,
    hStr=CHPEngineModel.hStr,
    mEng=CHPEngineModel.mEng,
    meanCpExh=cHPCombustionEngine.meanCpExh,
    dInn=CHPEngineModel.dInn,
    cylToInnerWall(maximumEngineHeat(y=cHPCombustionEngine.Q_therm), heatLimit(
          strict=true)),
    T_Com=cHPCombustionEngine.T_Com,
    GEngToAmb=0.23,
    nEng=cHPCombustionEngine.nEng,
    T_ExhPowUniOut=exhaustHeatExchanger.senTExhCold.T,
    lambda=EngMat.lambda,
    rhoEngWall=EngMat.rhoEngWall,
    c=EngMat.c,
    EngMatData=EngMat)
    "A physikal model for calculating the thermal, mass and mechanical output of an ice powered CHP"
    annotation (Placement(transformation(extent={{2,6},{30,34}})));

  AixLib.Fluid.FixedResistances.Pipe
    engineHeatTransfer(
    redeclare package Medium = Medium_Coolant,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=CHPEngineModel.dp_Coo, m_flow_nominal=m_flow),
    Heat_Loss_To_Ambient=true,
    alpha=engineHeatTransfer.alpha_i,
    eps=0,
    isEmbedded=true,
    use_HeatTransferConvective=false,
    p_a_start=system.p_start,
    p_b_start=system.p_start,
    alpha_i=GCoolChannel/(engineHeatTransfer.perimeter*engineHeatTransfer.length),
    diameter=CHPEngineModel.dCoo,
    allowFlowReversal=allowFlowReversalCoolant)
    annotation (Placement(transformation(extent={{-34,-70},{-10,-46}})));

  inner Modelica.Fluid.System system(p_ambient=p_ambient, T_ambient=T_ambient)
    annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));
  Modelica.Fluid.Sources.FixedBoundary coolantSupplyFlow(redeclare package
      Medium = Medium_Coolant, nPorts=1)
    annotation (Placement(transformation(extent={{110,-68},{90,-48}})));
  Modelica.Fluid.Sources.MassFlowSource_T coolantReturnFlow(
    nPorts=1,
    use_T_in=false,
    redeclare package Medium = Medium_Coolant,
    m_flow=m_flow,
    T=T_CoolRet)
    annotation (Placement(transformation(extent={{-110,-68},{-90,-48}})));

  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHPCombustionEngine2901
    cHPCombustionEngine(
    redeclare package Medium1 = Medium_Fuel,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium3 = Medium_Exhaust,
    T_Amb=T_ambient,
    CHPEngData=CHPEngineModel,
    T_logEngCool=exhaustHeatExchanger.senTCoolCold.T,
    T_ExhCHPOut=exhaustHeatExchanger.senTExhCold.T,
    inertia(phi(fixed=false), w(fixed=false, displayUnit="rad/s")))
    annotation (Placement(transformation(extent={{-42,22},{-10,54}})));
  Modelica.Fluid.Sources.FixedBoundary outletExhaustGas(
    redeclare package Medium = Medium_Exhaust,
    p=p_ambient,
    nPorts=1)
    annotation (Placement(transformation(extent={{112,38},{92,58}})));

  parameter Modelica.SIunits.Temperature T_ambient=298.15
    "Default ambient temperature"
    annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
    "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.SIunits.Temperature T_CoolRet=350.15
    "Coolant return temperature" annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.SIunits.Temperature T_CoolSup=tempCoolantSupplyFlow.T
    "Coolant supply temperature" annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.SIunits.Power Q_Therm=if (engineHeatTransfer.heatPort_outside.Q_flow+exhaustHeatExchanger.pipeCoolant.heatPort_outside.Q_flow)>10
  then engineHeatTransfer.heatPort_outside.Q_flow+exhaustHeatExchanger.pipeCoolant.heatPort_outside.Q_flow
  else 1 "Thermal power output of the CHP unit";
  Modelica.SIunits.Power P_Mech=cHPCombustionEngine.P_eff "Mechanical power output of the CHP unit";
  Modelica.SIunits.Power P_El=-inductionMachineGenerator.P_E "Electrical power output of the CHP unit";
  Modelica.SIunits.Power P_Fuel=m_Fuel*Medium_Fuel.H_U "CHP fuel expenses";
  Modelica.SIunits.Power Q_TotUnused=cHPCombustionEngine.Q_therm-engineToCoolant.actualHeatFlowEngine.Q_flow+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total heat error of the CHP unit";
 // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
  Modelica.SIunits.MassFlowRate m_CO2=cHPCombustionEngine.m_CO2Exh "CO2 emission output rate";
  Modelica.SIunits.MassFlowRate m_Fuel=if (cHPCombustionEngine.m_Fue)>0.0001 then cHPCombustionEngine.m_Fue else 0.0001 "Fuel consumption rate of CHP unit";
  type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
  SpecificEmission b_CO2=3600000000*m_CO2/(Q_Therm+P_El) "Specific CO2 emissions per kWh (heat and power)";
  SpecificEmission b_e=3600000000*m_Fuel/(Q_Therm+P_El) "Specific fuel consumption per kWh (heat and power)";
  Real FueUtiRate = (Q_Therm+P_El)/P_Fuel "Fuel utilization rate of the CHP unit";
  Real PowHeatRatio = P_El/Q_Therm "Power to heat ration of the CHP unit";
  Real eta_Therm = Q_Therm/P_Fuel "Thermal efficiency of the CHP unit";
  Real eta_Mech = P_Mech/P_Fuel "Mechanical efficiency of the CHP unit";
  Real eta_El = P_El/P_Fuel "Mechanical efficiency of the CHP unit";

  Modelica.Blocks.Interfaces.RealOutput heatLossesToAmbient annotation (
      Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-106,-30})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupplyFlow(redeclare
      package Medium = Medium_Coolant)
    annotation (Placement(transformation(extent={{54,-68},{74,-48}})));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow=
      CHPEngineModel.m_floCooNominal
    "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.ThermalConductance GCoolChannel=45
    "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
    annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambientTemperature(T=
        T_ambient)
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-62,-8},{-78,8}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.ExhaustHeatExchanger2901
    exhaustHeatExchanger(
    pipeCoolant(
      p_a_start=system.p_start,
      p_b_start=system.p_start,
      use_HeatTransferConvective=false,
      isEmbedded=true,
      diameter=CHPEngineModel.dCoo,
      allowFlowReversal=allowFlowReversalCoolant),
    TAmb=T_ambient,
    pAmb=p_ambient,
    T_ExhPowUniOut=CHPEngineModel.T_ExhPowUniOut,
    meanCpExh=cHPCombustionEngine.meanCpExh,
    redeclare package Medium3 = Medium_Exhaust,
    redeclare package Medium4 = Medium_Coolant,
    d_iExh=CHPEngineModel.dExh,
    dp_CooExhHex=CHPEngineModel.dp_Coo,
    heatConvExhaustPipeInside(
      length=exhaustHeatExchanger.l_ExhHex,
      c=cHPCombustionEngine.meanCpExh,
      m_flow=cHPCombustionEngine.exhaustFlow.m_flow_in),
    volExhaust(V=exhaustHeatExchanger.VExhHex),
    CHPEngData=CHPEngineModel,
    M_Exh=cHPCombustionEngine.MM_Exh,
    allowFlowReversal1=allowFlowReversalExhaust,
    allowFlowReversal2=allowFlowReversalCoolant,
    m1_flow_small=mExh_flow_small,
    m2_flow_small=mCool_flow_small,
    ConTec=ConTec,
    Q_Gen=inductionMachineGenerator.Q_Therm)
    annotation (Placement(transformation(extent={{48,-12},{72,12}})));

  parameter Boolean ConTec=false
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
    mExh_flow_small=0.0001
    "Small exhaust mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    mCool_flow_small=0.0001
    "Small coolant mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHP_StarterGenerator2901
    inductionMachineGenerator(CHPEngData=CHPEngineModel, useHeat=useGenHea)
    annotation (Placement(transformation(extent={{-64,58},{-40,82}})));
  Modelica.Blocks.Sources.BooleanPulse onOffStep(
    startTime(displayUnit="h") = 0,
    width=12.5,
    period(displayUnit="h") = 86400)
    annotation (Placement(transformation(extent={{-108,62},{-92,78}})));

equation
  connect(engineHeatTransfer.port_a, coolantReturnFlow.ports[1])
    annotation (Line(points={{-34.48,-58},{-90,-58}},
                                                   color={0,127,255}));
  connect(coolantSupplyFlow.ports[1],tempCoolantSupplyFlow. port_b)
    annotation (Line(points={{90,-58},{74,-58}}, color={0,127,255}));
  connect(heatFlowSensor.Q_flow, heatLossesToAmbient) annotation (Line(points={{-70,-8},
          {-70,-30},{-106,-30}},          color={0,0,127}));
  connect(exhaustHeatExchanger.port_b1, outletExhaustGas.ports[1]) annotation (
      Line(points={{72,7.2},{80,7.2},{80,48},{92,48}}, color={0,127,255}));
  connect(tempCoolantSupplyFlow.port_a, exhaustHeatExchanger.port_b2)
    annotation (Line(points={{54,-58},{40,-58},{40,-7.2},{48,-7.2}}, color={0,
          127,255}));
  connect(exhaustHeatExchanger.port_a2, engineHeatTransfer.port_b) annotation (
      Line(points={{72,-7.2},{80,-7.2},{80,-34},{20,-34},{20,-58},{-9.52,-58}},
        color={0,127,255}));
  connect(ambientTemperature.port, heatFlowSensor.port_b)
    annotation (Line(points={{-92,0},{-78,0}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, engineToCoolant.port_Ambient)
    annotation (Line(points={{-62,0},{16,0},{16,6}},  color={191,0,0}));
  connect(engineToCoolant.exhaustGasTemperature, cHPCombustionEngine.exhaustGasTemperature)
    annotation (Line(points={{4.24,22.8},{-2,22.8},{-2,32.88},{-10,32.88}},
                                                                          color=
         {0,0,127}));
  connect(engineHeatTransfer.heatPort_outside, engineToCoolant.port_CoolingCircle)
    annotation (Line(points={{-20.08,-51.28},{-20.08,-24},{30,-24},{30,20}},
                                                                          color=
         {191,0,0}));
  connect(cHPCombustionEngine.port_Exhaust, exhaustHeatExchanger.port_a1)
    annotation (Line(points={{-10.32,38},{38,38},{38,7.2},{48,7.2}},      color=
         {0,127,255}));
  connect(inductionMachineGenerator.flange_a, cHPCombustionEngine.flange_a)
    annotation (Line(points={{-40,70},{-26,70},{-26,54}}, color={0,0,0}));
  connect(inductionMachineGenerator.isOn, onOffStep.y)
    annotation (Line(points={{-63.76,70},{-91.2,70}}, color={255,0,255}));
  connect(exhaustHeatExchanger.port_Ambient, engineToCoolant.port_Ambient)
    annotation (Line(points={{48,0},{16,0},{16,6}}, color={191,0,0}));
  connect(cHPCombustionEngine.isOn, onOffStep.y) annotation (Line(points={{-41.68,
          38},{-76,38},{-76,70},{-91.2,70}},        color={255,0,255}));
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
end ModelEnginePowerAndHeatToCooling1701;
