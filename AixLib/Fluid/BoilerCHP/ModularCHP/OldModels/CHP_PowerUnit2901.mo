within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model CHP_PowerUnit2901
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

  parameter Fluid.BoilerCHP.ModularCHP.EngineMaterialData EngMat=
      Fluid.BoilerCHP.ModularCHP.EngineMaterial_CastIron()
    "Thermal engine material data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

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

  Modelica.Fluid.Sources.FixedBoundary outletExhaustGas(
    redeclare package Medium = Medium_Exhaust,
    p=p_ambient,
    nPorts=1)
    annotation (Placement(transformation(extent={{112,16},{92,36}})));

  parameter Modelica.SIunits.Temperature T_ambient=298.15
    "Default ambient temperature"
    annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
    "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
  Modelica.SIunits.Temperature T_CoolRet=350.15
    "Coolant return temperature" annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.SIunits.Temperature T_CoolSup=exhaustHeatExchanger.senTCoolHot.T
    "Coolant supply temperature" annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.SIunits.Power Q_Therm=if (engineHeatTransfer.heatPort_outside.Q_flow+exhaustHeatExchanger.pipeCoolant.heatPort_outside.Q_flow)>10
  then engineHeatTransfer.heatPort_outside.Q_flow+exhaustHeatExchanger.pipeCoolant.heatPort_outside.Q_flow
  else 1 "Thermal power output of the CHP unit";
  Modelica.SIunits.Power P_Mech=gasolineEngineChp.cHPCombustionEngine.P_eff "Mechanical power output of the CHP unit";
  Modelica.SIunits.Power P_El=-inductionMachineGenerator.P_E "Electrical power output of the CHP unit";
  Modelica.SIunits.Power P_Fuel=m_Fuel*Medium_Fuel.H_U "CHP fuel expenses";
  Modelica.SIunits.Power Q_TotUnused=gasolineEngineChp.cHPCombustionEngine.Q_therm-gasolineEngineChp.engineToCoolant.actualHeatFlowEngine.Q_flow+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total heat error of the CHP unit";
 // Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
  Modelica.SIunits.MassFlowRate m_CO2=gasolineEngineChp.cHPCombustionEngine.m_CO2Exh "CO2 emission output rate";
  Modelica.SIunits.MassFlowRate m_Fuel=if (gasolineEngineChp.cHPCombustionEngine.m_Fue)>0.0001 then gasolineEngineChp.cHPCombustionEngine.m_Fue else 0.0001 "Fuel consumption rate of CHP unit";
  type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
  SpecificEmission b_CO2=if noEvent(abs(Q_Therm+P_El)>0) then 3600000000*m_CO2/(Q_Therm+P_El) else 0 "Specific CO2 emissions per kWh (heat and power)";
  SpecificEmission b_e=if noEvent(abs(Q_Therm+P_El)>0) then 3600000000*m_Fuel/(Q_Therm+P_El) else 0 "Specific fuel consumption per kWh (heat and power)";
  Real FueUtiRate = (Q_Therm+P_El)/P_Fuel "Fuel utilization rate of the CHP unit";
  Real PowHeatRatio = P_El/Q_Therm "Power to heat ration of the CHP unit";
  Real eta_Therm = Q_Therm/P_Fuel "Thermal efficiency of the CHP unit";
  Real eta_Mech = P_Mech/P_Fuel "Mechanical efficiency of the CHP unit";
  Real eta_El = P_El/P_Fuel "Mechanical efficiency of the CHP unit";

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
    meanCpExh=gasolineEngineChp.cHPCombustionEngine.meanCpExh,
    redeclare package Medium3 = Medium_Exhaust,
    redeclare package Medium4 = Medium_Coolant,
    d_iExh=CHPEngineModel.dExh,
    dp_CooExhHex=CHPEngineModel.dp_Coo,
    heatConvExhaustPipeInside(
      length=exhaustHeatExchanger.l_ExhHex,
      c=gasolineEngineChp.cHPCombustionEngine.meanCpExh,
      m_flow=gasolineEngineChp.cHPCombustionEngine.exhaustFlow.m_flow_in),
    volExhaust(V=exhaustHeatExchanger.VExhHex),
    CHPEngData=CHPEngineModel,
    M_Exh=gasolineEngineChp.cHPCombustionEngine.MM_Exh,
    allowFlowReversal1=allowFlowReversalExhaust,
    allowFlowReversal2=allowFlowReversalCoolant,
    m1_flow_small=mExh_flow_small,
    m2_flow_small=mCool_flow_small,
    ConTec=ConTec,
    Q_Gen=inductionMachineGenerator.Q_Therm,
    A_surExhHea=A_surExhHea,
    m2_flow_nominal=m_flow)
    annotation (Placement(transformation(extent={{40,-14},{68,14}})));

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
    annotation (Placement(transformation(extent={{-64,56},{-40,80}})));
  Modelica.Blocks.Interfaces.BooleanInput
                                       onOffStep
    annotation (Placement(transformation(extent={{-108,56},{-84,80}}),
        iconTransformation(extent={{-108,56},{-84,80}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_Return(redeclare package Medium =
        Medium_Coolant)
    annotation (Placement(transformation(extent={{-90,-68},{-70,-48}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Supply(redeclare package Medium =
        Medium_Coolant)
    annotation (Placement(transformation(extent={{70,-68},{90,-48}})));
  Modelica.Blocks.Interfaces.RealOutput electricalPower annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=90,
        origin={-40,108})));
  Modelica.Blocks.Interfaces.RealOutput fuelConsumption annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=90,
        origin={0,108})));
  Modelica.Blocks.Interfaces.RealOutput airConsumption annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=90,
        origin={40,108})));
  parameter Modelica.SIunits.Area A_surExhHea=50
    "Surface for exhaust heat transfer"
    annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng
    "Total engine mass for heat capacity calculation"
    annotation (Dialog(tab="Engine Cooling Circle"));
  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.gasolineEngineChp2901
    gasolineEngineChp(
    redeclare package Medium_Fuel = Medium_Fuel,
    redeclare package Medium_Air = Medium_Air,
    redeclare package Medium_Exhaust = Medium_Exhaust,
    CHPEngineModel=CHPEngineModel,
    EngMat=EngMat,
    T_ambient=T_ambient,
    mEng=mEng,
    cHPCombustionEngine(T_logEngCool=exhaustHeatExchanger.senTCoolCold.T,
        T_ExhCHPOut=exhaustHeatExchanger.senTExhCold.T),
    engineToCoolant(T_ExhPowUniOut=exhaustHeatExchanger.senTExhCold.T))
    annotation (Placement(transformation(rotation=0, extent={{-24,10},{10,44}})));
equation
  connect(exhaustHeatExchanger.port_b1, outletExhaustGas.ports[1]) annotation (
      Line(points={{68,8.4},{80,8.4},{80,26},{92,26}}, color={0,127,255}));
  connect(exhaustHeatExchanger.port_a2, engineHeatTransfer.port_b) annotation (
      Line(points={{68,-8.4},{80,-8.4},{80,-34},{20,-34},{20,-58},{-9.52,-58}},
        color={0,127,255}));
  connect(ambientTemperature.port, heatFlowSensor.port_b)
    annotation (Line(points={{-92,0},{-78,0}}, color={191,0,0}));
  connect(port_Return, engineHeatTransfer.port_a)
    annotation (Line(points={{-80,-58},{-34.48,-58}},  color={0,127,255}));
  connect(port_Supply, exhaustHeatExchanger.port_b2) annotation (Line(points={{80,-58},
          {40,-58},{40,-8.4}},                color={0,127,255}));
  connect(inductionMachineGenerator.isOn, onOffStep)
    annotation (Line(points={{-63.76,68},{-96,68}},  color={255,0,255}));
  connect(inductionMachineGenerator.flange_a, gasolineEngineChp.flange_a)
    annotation (Line(points={{-40,68},{-7,68},{-7,43.66}}, color={0,0,0}));
  connect(gasolineEngineChp.airFlow, airConsumption) annotation (Line(points={{5.41,
          43.83},{5.41,66},{40,66},{40,108}},
                                           color={0,0,127}));
  connect(fuelConsumption, gasolineEngineChp.fuelFlow) annotation (Line(points={{0,108},
          {0,76},{0,43.83},{-0.03,43.83}},  color={0,0,127}));
  connect(gasolineEngineChp.isOn, onOffStep) annotation (Line(points={{-24,25.64},
          {-76,25.64},{-76,68},{-96,68}}, color={255,0,255}));
  connect(gasolineEngineChp.port_Exhaust, exhaustHeatExchanger.port_a1)
    annotation (Line(points={{10,25.98},{28,25.98},{28,8.4},{40,8.4}}, color={0,
          127,255}));
  connect(gasolineEngineChp.port_Ambient, heatFlowSensor.port_a)
    annotation (Line(points={{-7,11.7},{-7,0},{-62,0}}, color={191,0,0}));
  connect(exhaustHeatExchanger.port_Ambient, heatFlowSensor.port_a)
    annotation (Line(points={{40,0},{-62,0}}, color={191,0,0}));
  connect(gasolineEngineChp.port_CoolingCircle, engineHeatTransfer.heatPort_outside)
    annotation (Line(points={{10,12.04},{10,-18},{-20.08,-18},{-20.08,-51.28}},
        color={191,0,0}));
  connect(inductionMachineGenerator.electricPower, electricalPower) annotation (
     Line(points={{-52,81.44},{-52,86},{-40,86},{-40,108}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-50,58},{50,18}},
          lineColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString="CHP",
          textStyle={TextStyle.Bold}),
                              Rectangle(
          extent={{-80,80},{80,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),                                       Text(
          extent={{-50,68},{50,28}},
          lineColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textStyle={TextStyle.Bold},
          textString="CHP
physical"),
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
end CHP_PowerUnit2901;
