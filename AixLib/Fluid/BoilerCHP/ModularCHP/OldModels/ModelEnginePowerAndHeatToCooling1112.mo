within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model ModelEnginePowerAndHeatToCooling1112
  "Model of engine combustion, its power output and heat transfer to the cooling circle and ambient"
  import AixLib;

  replaceable package Medium_Gasoline =
      DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
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

  replaceable package Medium_Coolant =
      DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                 property_T=356, X_a=0.50)   constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

  parameter DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  AixLib.Fluid.BoilerCHP.ModularCHP.EngineHousing1412EXPERIMENTAL
                                                                engineToCoolant(
    z=CHPEngineModel.z,
    eps=CHPEngineModel.eps,
    m_Exh=cHPGasolineEngine.m_Exh,
    lambda=CHPEngineModel.lambda,
    T_Amb=T_ambient,
    redeclare package Medium3 = Medium_Exhaust,
    dCyl=CHPEngineModel.dCyl,
    hStr=CHPEngineModel.hStr,
    mEng=CHPEngineModel.mEng,
    meanCpExh=cHPGasolineEngine.meanCpExh,
    T_ExhPowUniOut=CHPEngineModel.T_ExhPowUniOut,
    dInn=CHPEngineModel.dInn,
    rhoEngWall=CHPEngineModel.rhoEngWall,
    c=CHPEngineModel.c,
    cylToInnerWall(maximumEngineHeat(y=cHPGasolineEngine.Q_therm)),
    T_LogMeanCool=engineHeatTransfer.T_LogMeanCool,
    T_Com=cHPGasolineEngine.T_Com)
    "A physikal model for calculating the thermal, mass and mechanical output of an ice powered CHP"
    annotation (Placement(transformation(extent={{2,26},{30,54}})));

  AixLib.Fluid.BoilerCHP.ModularCHP.CHPCombustionHeatToCooling
    engineHeatTransfer(
    redeclare package Medium = Medium_Coolant,
    redeclare package Medium4 = Medium_Coolant,
    vol(V=CHPEngineModel.VEngCoo),
    T_start=coolantReturnFlow.T)
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

  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHPGasolineEngine1112
    cHPGasolineEngine(
    redeclare package Medium1 = Medium_Gasoline,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium3 = Medium_Exhaust,
    T_Amb=T_ambient,
    CHPEngData=CHPEngineModel,
    T_logEngCool=engineHeatTransfer.T_LogMeanCool)
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
    "Coolant supply temperature" annotation (Dialog(tab="Engine Cooling Circle"));

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

  Modelica.Blocks.Interfaces.RealOutput heatLossesToAmbient annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-108,-30})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempCoolantSupplyFlow(redeclare
      package Medium = Medium_Coolant)
    annotation (Placement(transformation(extent={{54,-68},{74,-48}})));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow=
      CHPEngineModel.m_floCooNom
    "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambientTemperature(T=
        T_ambient)
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-62,-8},{-78,8}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.ExhaustHeatExchanger exhaustHeatExchanger(
    TAmb=T_ambient,
    pAmb=p_ambient,
    T_ExhPowUniOut=CHPEngineModel.T_ExhPowUniOut,
    meanCpExh=cHPGasolineEngine.meanCpExh,
    volCoolant(V=CHPEngineModel.VExhCoo),
    redeclare package Medium3 = Medium_Exhaust,
    redeclare package Medium4 = Medium_Coolant,
    d_iExh=CHPEngineModel.dExh,
    heatFromExhaustGas(heatConvExhaustPipeInside(length=exhaustHeatExchanger.l_ExhHex,
          A_sur=exhaustHeatExchanger.A_surExhHea), volExhaust(V=
            exhaustHeatExchanger.VExhHex)),
    dp_CooExhHex=CHPEngineModel.dp_Coo)
    annotation (Placement(transformation(extent={{48,-12},{72,12}})));
   // VExhHex = CHPEngineModel.VExhHex,
equation
  connect(engineHeatTransfer.port_a, coolantReturnFlow.ports[1])
    annotation (Line(points={{-32,-58},{-90,-58}}, color={0,127,255}));
  connect(inletGasoline.m_flow_in,massFlowGas. y) annotation (Line(points={{-76,
          68.4},{-84,68.4},{-84,68},{-87,68}}, color={0,0,127}));
  connect(inletGasoline.ports[1], cHPGasolineEngine.port_Gasoline) annotation (
      Line(points={{-60,62},{-44,62},{-44,49.14},{-40,49.14}}, color={0,127,255}));
  connect(inletAir.ports[1], cHPGasolineEngine.port_Air) annotation (Line(
        points={{-60,34},{-44,34},{-44,45.24},{-40,45.24}}, color={0,127,255}));
  connect(massFlowAir.y,inletAir. m_flow_in) annotation (Line(points={{-87,40},{
          -84,40},{-84,40.4},{-76,40.4}},   color={0,0,127}));
  connect(coolantSupplyFlow.ports[1],tempCoolantSupplyFlow. port_b)
    annotation (Line(points={{90,-58},{74,-58}}, color={0,127,255}));
  connect(cHPGasolineEngine.port_Exhaust, engineToCoolant.port_EngineIn)
    annotation (Line(points={{-10.3,48.36},{-2,48.36},{-2,48.4},{4.8,48.4}},
        color={0,127,255}));
  connect(engineToCoolant.port_CoolingCircle, engineHeatTransfer.port_EngineHeat)
    annotation (Line(points={{30,40},{30,-20},{-28,-20},{-28,-48}}, color={191,0,
          0}));
  connect(heatFlowSensor.Q_flow, heatLossesToAmbient) annotation (Line(points={{-70,-8},
          {-70,-30},{-108,-30}},          color={0,0,127}));
  connect(engineToCoolant.port_EngineOut, exhaustHeatExchanger.port_a1)
    annotation (Line(points={{27.2,48.4},{40,48.4},{40,7.2},{48,7.2}}, color=
          {0,127,255}));
  connect(exhaustHeatExchanger.port_b1, outletExhaustGas.ports[1])
    annotation (Line(points={{72,7.2},{80,7.2},{80,48},{92,48}}, color={0,127,
          255}));
  connect(tempCoolantSupplyFlow.port_a, exhaustHeatExchanger.port_b2)
    annotation (Line(points={{54,-58},{40,-58},{40,-7.2},{48,-7.2}}, color={0,
          127,255}));
  connect(exhaustHeatExchanger.port_a2, engineHeatTransfer.port_b)
    annotation (Line(points={{72,-7.2},{80,-7.2},{80,-34},{20,-34},{20,-58},{
          -12,-58}}, color={0,127,255}));
  connect(ambientTemperature.port, heatFlowSensor.port_b)
    annotation (Line(points={{-92,0},{-78,0}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, engineToCoolant.port_Ambient)
    annotation (Line(points={{-62,0},{16,0},{16,26}}, color={191,0,0}));
  connect(exhaustHeatExchanger.port_b, engineToCoolant.port_Ambient)
    annotation (Line(points={{48,0},{16,0},{16,26}}, color={191,0,0}));
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
         __Dymola_Commands(file="Modelica://AixLib/Resources/Scripts/Dymola/Fluid/CHP/Examples/ModelEnginePowerAndHeatToCooling.mos" "Simulate and plot"));
end ModelEnginePowerAndHeatToCooling1112;
