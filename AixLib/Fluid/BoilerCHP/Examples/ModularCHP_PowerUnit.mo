within AixLib.Fluid.BoilerCHP.Examples;
model ModularCHP_PowerUnit
  "Model of engine combustion, its power output and heat transfer to the cooling circle and ambient"
  import AixLib;
  extends Modelica.Icons.Example;

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

  replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                             constrainedby
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

  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.EngineHousing1601 engineToCoolant(
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
    cylToInnerWall(maximumEngineHeat(y=cHPCombustionEngine.Q_therm)),
    T_Com=cHPCombustionEngine.T_Com,
    GEngToAmb=0.23,
    nEng=cHPCombustionEngine.nEng,
    T_ExhPowUniOut=exhaustHeatExchanger.senTExhCold.T,
    lambda=EngMat.lambda,
    rhoEngWall=EngMat.rhoEngWall,
    c=EngMat.c,
    EngMatData=EngMat)
    "A physikal model for calculating the thermal, mass and mechanical output of an ice powered CHP"
    annotation (Placement(transformation(extent={{2,16},{30,44}})));

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
    diameter=CHPEngineModel.dCoo)
    annotation (Placement(transformation(extent={{-32,-68},{-12,-48}})));
                                 /* constrainedby 
    CHPCombustionHeatToCoolingHeatPorts(
    redeclare package Medium = Medium_Coolant,
    redeclare package Medium4 = Medium_Coolant,
    T_start=coolantReturnFlow.T) */
/*                       constrainedby OldModels.CHPCombustionHeatToCooling(
    redeclare package Medium = Medium_Coolant,
    redeclare package Medium4 = Medium_Coolant,
    vol(V=0.002),
    pressureDrop(a=0)) */

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

  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHPCombustionEngine1601
    cHPCombustionEngine(
    redeclare package Medium1 = Medium_Fuel,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium3 = Medium_Exhaust,
    T_Amb=T_ambient,
    CHPEngData=CHPEngineModel,
    T_logEngCool=exhaustHeatExchanger.senTCoolCold.T,
    T_ExhCHPOut=exhaustHeatExchanger.senTExhCold.T,
    inertia(w(fixed=false, displayUnit="rad/s"), phi(fixed=false)))
    annotation (Placement(transformation(extent={{-40,26},{-10,52}})));
  Modelica.Blocks.Sources.RealExpression massFlowFuel(y=cHPCombustionEngine.m_Fue)
    annotation (Placement(transformation(extent={{-108,58},{-88,78}})));
  Modelica.Blocks.Sources.RealExpression massFlowAir(y=cHPCombustionEngine.m_Air)
    annotation (Placement(transformation(extent={{-108,30},{-88,50}})));
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
  else 1 "Thermal output power of the CHP unit";
  Modelica.SIunits.Power P_Mech=cHPCombustionEngine.P_eff "Mechanical output power of the CHP unit";
  Modelica.SIunits.Power P_Fuel=m_Fuel*Medium_Fuel.H_U "CHP fuel expenses";
  Modelica.SIunits.Power Q_TotUnused=cHPCombustionEngine.Q_therm-engineToCoolant.actualHeatFlowEngine.Q_flow+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total heat error of the CHP unit";
  Modelica.SIunits.Power Q_ExhUnused=exhaustHeatExchanger.volExhaust.ports_H_flow[1]+exhaustHeatExchanger.volExhaust.ports_H_flow[2]+exhaustHeatExchanger.volExhaust.heatPort.Q_flow "Total exhaust heat error";
  Modelica.SIunits.MassFlowRate m_CO2=cHPCombustionEngine.m_CO2Exh "CO2 emission output rate";
  Modelica.SIunits.MassFlowRate m_Fuel=if (cHPCombustionEngine.m_Fue)>0.0001 then cHPCombustionEngine.m_Fue else 0.0001 "Fuel consumption rate of CHP unit";
  type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);
  SpecificEmission b_CO2=3600000000*m_CO2/(Q_Therm+P_Mech) "Specific CO2 emissions per kWh (heat and power)";
  SpecificEmission b_e=3600000000*m_Fuel/(Q_Therm+P_Mech) "Specific fuel consumption per kWh (heat and power)";
  Real FueUtiRate = (Q_Therm+P_Mech)/P_Fuel "Fuel utilization rate of the CHP unit";
  Real PowHeatRatio = P_Mech/Q_Therm "Power to heat ration of the CHP unit";
  Real eta_Therm = Q_Therm/P_Fuel "Thermal efficiency of the CHP unit";
  Real eta_Mech = P_Mech/P_Fuel "Mechanical efficiency of the CHP unit";

  Modelica.Fluid.Sources.MassFlowSource_T inletFuel(
    redeclare package Medium = Medium_Fuel,
    use_m_flow_in=true,
    nPorts=1,
    T=T_ambient)
    annotation (Placement(transformation(extent={{-76,54},{-60,70}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                        inletAir(
    redeclare package Medium = Medium_Air,
    use_m_flow_in=true,
    nPorts=1,
    use_T_in=false,
    T=T_ambient)
    annotation (Placement(transformation(extent={{-76,26},{-60,42}})));

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
  AixLib.Fluid.BoilerCHP.ModularCHP.ExhaustHeatExchanger exhaustHeatExchanger(
    pipeCoolant(
      p_a_start=system.p_start,
      p_b_start=system.p_start,
      use_HeatTransferConvective=false,
      isEmbedded=true,
      diameter=CHPEngineModel.dCoo),
    TAmb=T_ambient,
    pAmb=p_ambient,
    T_ExhPowUniOut=CHPEngineModel.T_ExhPowUniOut,
    meanCpExh=cHPCombustionEngine.meanCpExh,
    redeclare package Medium3 = Medium_Exhaust,
    redeclare package Medium4 = Medium_Coolant,
    d_iExh=CHPEngineModel.dExh,
    dp_CooExhHex=CHPEngineModel.dp_Coo,
    heatConvExhaustPipeInside(length=exhaustHeatExchanger.l_ExhHex, c=
          cHPCombustionEngine.meanCpExh,
      m_flow=cHPCombustionEngine.exhaustFlow.m_flow_in),
    volExhaust(V=exhaustHeatExchanger.VExhHex),
    CHPEngData=CHPEngineModel,
    M_Exh=cHPCombustionEngine.MM_Exh,
    ConTec=ConTec,
    Q_Gen=0)
    annotation (Placement(transformation(extent={{48,-12},{72,12}})));
   // VExhHex = CHPEngineModel.VExhHex,
  parameter Boolean ConTec=false
    "Is condensing technology used and should latent heat be considered?"
    annotation (Dialog(tab="Advanced", group="Latent heat use"));
  Modelica.Mechanics.Rotational.Sources.Speed speed(phi(fixed=false))
    annotation (Placement(transformation(extent={{-70,84},{-50,104}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=160,
    falling=10,
    rising=3,
    width=1000,
    period=1500)
    annotation (Placement(transformation(extent={{-110,84},{-90,104}})));
equation
  connect(engineHeatTransfer.port_a, coolantReturnFlow.ports[1])
    annotation (Line(points={{-32.4,-58},{-90,-58}},
                                                   color={0,127,255}));
  connect(inletFuel.m_flow_in, massFlowFuel.y) annotation (Line(points={{-76,68.4},
          {-84,68.4},{-84,68},{-87,68}}, color={0,0,127}));
  connect(inletFuel.ports[1], cHPCombustionEngine.port_Fuel) annotation (Line(
        points={{-60,62},{-44,62},{-44,49.14},{-40,49.14}}, color={0,127,255}));
  connect(inletAir.ports[1], cHPCombustionEngine.port_Air) annotation (Line(
        points={{-60,34},{-44,34},{-44,45.24},{-40,45.24}}, color={0,127,255}));
  connect(massFlowAir.y,inletAir. m_flow_in) annotation (Line(points={{-87,40},{
          -84,40},{-84,40.4},{-76,40.4}},   color={0,0,127}));
  connect(coolantSupplyFlow.ports[1],tempCoolantSupplyFlow. port_b)
    annotation (Line(points={{90,-58},{74,-58}}, color={0,127,255}));
  connect(exhaustHeatExchanger.port_b1, outletExhaustGas.ports[1]) annotation (
      Line(points={{72,7.2},{80,7.2},{80,48},{92,48}}, color={0,127,255}));
  connect(tempCoolantSupplyFlow.port_a, exhaustHeatExchanger.port_b2)
    annotation (Line(points={{54,-58},{40,-58},{40,-7.2},{48,-7.2}}, color={0,
          127,255}));
  connect(exhaustHeatExchanger.port_a2, engineHeatTransfer.port_b) annotation (
      Line(points={{72,-7.2},{80,-7.2},{80,-34},{20,-34},{20,-58},{-11.6,-58}},
        color={0,127,255}));
  connect(ambientTemperature.port, heatFlowSensor.port_b)
    annotation (Line(points={{-92,0},{-78,0}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, engineToCoolant.port_Ambient)
    annotation (Line(points={{-62,0},{16,0},{16,16}}, color={191,0,0}));
  connect(exhaustHeatExchanger.port_Ambient, engineToCoolant.port_Ambient)
    annotation (Line(points={{48,0},{16,0},{16,16}}, color={191,0,0}));
  connect(engineToCoolant.exhaustGasTemperature, cHPCombustionEngine.exhaustGasTemperature)
    annotation (Line(points={{4.24,32.8},{-2,32.8},{-2,44.2},{-10,44.2}}, color=
         {0,0,127}));
  connect(engineHeatTransfer.heatPort_outside, engineToCoolant.port_CoolingCircle)
    annotation (Line(points={{-20.4,-52.4},{-20.4,-24},{30,-24},{30,30}}, color=
         {191,0,0}));
  connect(cHPCombustionEngine.port_Exhaust, exhaustHeatExchanger.port_a1)
    annotation (Line(points={{-10.3,48.36},{38,48.36},{38,7.2},{48,7.2}}, color=
         {0,127,255}));
  connect(speed.w_ref,trapezoid. y)
    annotation (Line(points={{-72,94},{-89,94}}, color={0,0,127}));
  connect(speed.flange, cHPCombustionEngine.flange_a)
    annotation (Line(points={{-50,94},{-25,94},{-25,52}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
         __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/CHP_OverviewScript.mos" "QuickOverviewSimulateAndPlot"),
    Documentation(info="<html>
<p>Limitations:</p>
<p>- Transmissions between generator and engine are not considered </p>
<p>- </p>
</html>"));
end ModularCHP_PowerUnit;
