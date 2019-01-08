within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model ModelEnginePowerAndHeatToCoolingHeatPorts
  "Model of engine combustion, its power output and heat transfer to the cooling circle and ambient"
  import AixLib.Fluid.BoilerCHP.ModularCHP;
  import AixLib;

  replaceable package Medium_Gasoline =
      DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                    constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                annotation(choicesAllMatching=true);

  replaceable package Medium_Air =
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir   constrainedby
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
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHPEngDataBaseRecord_MaterialData
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  EngineHousingToCoolingHeatPorts
                         engineToCoolant(
    z=CHPEngineModel.z,
    eps=CHPEngineModel.eps,
    m_Exh=cHPGasolineEngine.m_Exh,
    lambda=CHPEngineModel.lambda,
    T_Amb=T_ambient,
    redeclare package Medium3 = Medium_Exhaust,
    T_Com=cHPGasolineEngine.T_Com,
    dCyl=CHPEngineModel.dCyl,
    hStr=CHPEngineModel.hStr,
    mEng=CHPEngineModel.mEng,
    meanCpExh=cHPGasolineEngine.meanCpExh,
    T_ExhPowUniOut=CHPEngineModel.T_ExhPowUniOut,
    T_CoolSup=engineHeatTransfer.senTHot.T,
    T_CoolRet=engineHeatTransfer.senTCold.T,
    dInn=CHPEngineModel.dInn,
    rhoEngWall=CHPEngineModel.rhoEngWall,
    c=CHPEngineModel.c,
    cylToInnerWall(maximumEngineHeat(y=cHPGasolineEngine.Q_therm)))
    "A physikal model for calculating the thermal, mass and mechanical output of an ice powered CHP"
    annotation (Placement(transformation(extent={{2,20},{34,52}})));

  replaceable CHPCombustionHeatToCoolingHeatPorts
                                         engineHeatTransfer(
    redeclare package Medium = Medium_Coolant,
    redeclare package Medium4 = Medium_Coolant,
    vol(V=0.002),
    pressureDrop(a=0),
    T_start=coolantReturnFlow.T)
                       constrainedby CHPCombustionHeatToCooling(
    redeclare package Medium = Medium_Coolant,
    redeclare package Medium4 = Medium_Coolant,
    vol(V=0.002),
    pressureDrop(a=0))
    annotation (Placement(transformation(extent={{-32,-68},{-12,-48}})));

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
    T=350.15)
    annotation (Placement(transformation(extent={{-110,-68},{-90,-48}})));

  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.ExhaustHousingHeatPort
    exhaustToCoolant(
    maximumExhaustHeat(y=exhaustToCoolant.Q_ExhMax),
    m_Exh=cHPGasolineEngine.m_Exh,
    Q_ExhMax=cHPGasolineEngine.Q_therm - engineToCoolant.actualHeatFlowEngine.Q_flow,
    redeclare package Medium3 = Medium_Exhaust,
    T_ExhOut=CHPEngineModel.T_ExhPowUniOut,
    meanCpExh=cHPGasolineEngine.meanCpExh,
    T_CoolSup=exhaustHeatTransfer.senTHot.T,
    T_CoolRet=exhaustHeatTransfer.senTCold.T,
    Q_ExhToCool=cHPGasolineEngine.CHPEngData.Q_MaxHea - engineHeatTransfer.vol.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{46,20},{78,52}})));

  replaceable CHPCombustionHeatToCoolingHeatPorts
                                         exhaustHeatTransfer(
    redeclare package Medium = Medium_Coolant,
    redeclare package Medium4 = Medium_Coolant,
    pressureDrop(a=0),
    vol(V=0.001),
    T_start=coolantReturnFlow.T) constrainedby CHPCombustionHeatToCooling(
    redeclare package Medium = Medium_Coolant,
    redeclare package Medium4 = Medium_Coolant,
    pressureDrop(a=0),
    vol(V=0.001),
    T_start=coolantReturnFlow.T)
    annotation (Placement(transformation(extent={{10,-68},{30,-48}})));

  CHPGasolineEngine cHPGasolineEngine(
    redeclare package Medium1 = Medium_Gasoline,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium3 = Medium_Exhaust,
    T_Amb=T_ambient,
    CHPEngData=CHPEngineModel)
    annotation (Placement(transformation(extent={{-40,26},{-10,52}})));
  Modelica.Blocks.Sources.RealExpression massFlowGas(y=cHPGasolineEngine.m_Fue)
    annotation (Placement(transformation(extent={{-108,58},{-88,78}})));
  Modelica.Blocks.Sources.RealExpression massFlowAir(y=cHPGasolineEngine.m_Air)
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
    "Coolant return temperature" annotation (Dialog(tab="Engine Cooling Circle"));

  Modelica.Fluid.Sources.MassFlowSource_T
                                        inletGasoline(
    redeclare package Medium = Medium_Gasoline,
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
  parameter Modelica.SIunits.Temperature T_ExhaustPowUnitOut=CHPEngineModel.T_ExhPowUniOut
    "Exhaust gas temperature after exhaust heat exchanger";

  Modelica.Blocks.Interfaces.RealOutput heatLossesToAmbient annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-108,-28})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupplyFlow(redeclare
      package Medium = Medium_Coolant)
    annotation (Placement(transformation(extent={{54,-68},{74,-48}})));
  Modelica.Blocks.Interfaces.RealOutput output_EngPower annotation (Placement(
        transformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-25,107})));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow=0.5556
    "Fixed mass flow rate going out of the fluid port" annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        T_ambient)
    annotation (Placement(transformation(extent={{-112,-6},{-92,14}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-78,-4},{-62,12}})));
equation
  connect(engineHeatTransfer.port_a, coolantReturnFlow.ports[1])
    annotation (Line(points={{-32,-58},{-90,-58}}, color={0,127,255}));
  connect(engineHeatTransfer.port_b, exhaustHeatTransfer.port_a)
    annotation (Line(points={{-12,-58},{10,-58}}, color={0,127,255}));
  connect(inletGasoline.m_flow_in,massFlowGas. y) annotation (Line(points={{-76,
          68.4},{-84,68.4},{-84,68},{-87,68}}, color={0,0,127}));
  connect(inletGasoline.ports[1], cHPGasolineEngine.port_Gasoline) annotation (
      Line(points={{-60,62},{-44,62},{-44,49.14},{-40,49.14}}, color={0,127,255}));
  connect(inletAir.ports[1], cHPGasolineEngine.port_Air) annotation (Line(
        points={{-60,34},{-44,34},{-44,45.24},{-40,45.24}}, color={0,127,255}));
  connect(massFlowAir.y,inletAir. m_flow_in) annotation (Line(points={{-87,40},{
          -84,40},{-84,40.4},{-76,40.4}},   color={0,0,127}));
  connect(outletExhaustGas.ports[1], exhaustToCoolant.port_HeatExchangerOut)
    annotation (Line(points={{92,48},{84,48},{84,45.6},{74.8,45.6}}, color={0,127,
          255}));
  connect(engineToCoolant.port_EngineOut, exhaustToCoolant.port_HeatExchangerIn)
    annotation (Line(points={{30.8,45.6},{49.2,45.6}}, color={0,127,255}));
  connect(exhaustHeatTransfer.port_b, tempCoolantSupplyFlow.port_a)
    annotation (Line(points={{30,-58},{54,-58}}, color={0,127,255}));
  connect(coolantSupplyFlow.ports[1],tempCoolantSupplyFlow. port_b)
    annotation (Line(points={{90,-58},{74,-58}}, color={0,127,255}));
  connect(cHPGasolineEngine.mechanicalPower, output_EngPower)
    annotation (Line(points={{-25,53.56},{-25,107}}, color={0,0,127}));
  connect(cHPGasolineEngine.port_Exhaust, engineToCoolant.port_EngineIn)
    annotation (Line(points={{-10.3,48.36},{-2,48.36},{-2,45.6},{5.2,45.6}},
        color={0,127,255}));
  connect(engineToCoolant.port_CoolingCircle, engineHeatTransfer.port_EngineHeat)
    annotation (Line(points={{34,36},{34,-20},{-28,-20},{-28,-48}}, color={191,0,
          0}));
  connect(fixedTemperature.port, heatFlowSensor.port_a)
    annotation (Line(points={{-92,4},{-78,4}}, color={191,0,0}));
  connect(engineToCoolant.port_Ambient, heatFlowSensor.port_b)
    annotation (Line(points={{18,20},{18,4},{-62,4}}, color={191,0,0}));
  connect(exhaustToCoolant.port_Ambient, heatFlowSensor.port_b)
    annotation (Line(points={{62,20},{62,4},{-62,4}}, color={191,0,0}));
  connect(exhaustToCoolant.port_CoolingCircle, exhaustHeatTransfer.port_EngineHeat)
    annotation (Line(points={{78,36},{78,-28},{14,-28},{14,-48}}, color={191,
          0,0}));
  connect(heatFlowSensor.Q_flow, heatLossesToAmbient) annotation (Line(points=
         {{-70,-4},{-70,-28},{-108,-28}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
         __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/ModularCHP_Skript.mos" "Simulate and plot"));
end ModelEnginePowerAndHeatToCoolingHeatPorts;
