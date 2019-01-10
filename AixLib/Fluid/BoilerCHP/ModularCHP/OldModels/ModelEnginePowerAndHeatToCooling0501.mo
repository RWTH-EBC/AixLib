within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model ModelEnginePowerAndHeatToCooling0501
  "Model of engine combustion, its power output and heat transfer to the cooling circle and ambient"
  import AixLib;

  replaceable package Medium_Fuel =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.LiquidFuel_Diesel   constrainedby
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
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHPEngDataBaseRecord_MaterialData
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.EngineHousing0701 engineToCoolant(
    z=CHPEngineModel.z,
    eps=CHPEngineModel.eps,
    m_Exh=cHPCombustionEngine.m_Exh,
    lambda=CHPEngineModel.lambda,
    T_Amb=T_ambient,
    redeclare package Medium3 = Medium_Exhaust,
    dCyl=CHPEngineModel.dCyl,
    hStr=CHPEngineModel.hStr,
    mEng=CHPEngineModel.mEng,
    meanCpExh=cHPCombustionEngine.meanCpExh,
    T_ExhPowUniOut=CHPEngineModel.T_ExhPowUniOut,
    dInn=CHPEngineModel.dInn,
    rhoEngWall=CHPEngineModel.rhoEngWall,
    c=CHPEngineModel.c,
    cylToInnerWall(maximumEngineHeat(y=cHPCombustionEngine.Q_therm)),
    T_Com=cHPCombustionEngine.T_Com,
    GEngToAmb=0.23,
    nEng=cHPCombustionEngine.nEng)
    "A physikal model for calculating the thermal, mass and mechanical output of an ice powered CHP"
    annotation (Placement(transformation(extent={{2,16},{30,44}})));

  AixLib.Fluid.FixedResistances.Pipe
    engineHeatTransfer(
    redeclare package Medium = Medium_Coolant,
    diameter=0.03175,
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
    alpha_i=GCoolChannel/(engineHeatTransfer.perimeter*engineHeatTransfer.length))
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

  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHPCombustionEngine0501
    cHPCombustionEngine(
    redeclare package Medium1 = Medium_Fuel,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium3 = Medium_Exhaust,
    T_Amb=T_ambient,
    CHPEngData=CHPEngineModel,
    inertia(w(fixed=true, start=100)),
    T_logEngCool=exhaustHeatExchanger.senTCoolCold.T)
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

  Modelica.Blocks.Interfaces.RealOutput heatLossesToAmbient annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-108,-30})));
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
  AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.ExhaustHeatExchanger1001
    exhaustHeatExchanger(
    pipeCoolant(
      p_a_start=system.p_start,
      p_b_start=system.p_start,
      use_HeatTransferConvective=false,
      isEmbedded=true),
    TAmb=T_ambient,
    pAmb=p_ambient,
    T_ExhPowUniOut=CHPEngineModel.T_ExhPowUniOut,
    meanCpExh=cHPCombustionEngine.meanCpExh,
    redeclare package Medium3 = Medium_Exhaust,
    redeclare package Medium4 = Medium_Coolant,
    d_iExh=CHPEngineModel.dExh,
    dp_CooExhHex=CHPEngineModel.dp_Coo,
    heatConvExhaustPipeInside(length=exhaustHeatExchanger.l_ExhHex, c=
          cHPCombustionEngine.meanCpExh),
    volExhaust(V=exhaustHeatExchanger.VExhHex),
    CHPEngData=CHPEngineModel)
    annotation (Placement(transformation(extent={{48,-12},{72,12}})));
   // VExhHex = CHPEngineModel.VExhHex,
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticSpeedDependentTorque(w_nominal=160, tau_nominal=-100)
    annotation (Placement(transformation(extent={{-50,82},{-38,94}})));
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
  connect(heatFlowSensor.Q_flow, heatLossesToAmbient) annotation (Line(points={{-70,-8},
          {-70,-30},{-108,-30}},          color={0,0,127}));
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
  connect(exhaustHeatExchanger.port_b, engineToCoolant.port_Ambient)
    annotation (Line(points={{48,0},{16,0},{16,16}}, color={191,0,0}));
  connect(quadraticSpeedDependentTorque.flange, cHPCombustionEngine.flange_a)
    annotation (Line(points={{-38,88},{-25,88},{-25,52}}, color={0,0,0}));
  connect(engineToCoolant.exhaustGasTemperature, cHPCombustionEngine.exhaustGasTemperature)
    annotation (Line(points={{4.24,32.8},{-2,32.8},{-2,44.2},{-10,44.2}}, color=
         {0,0,127}));
  connect(engineHeatTransfer.heatPort_outside, engineToCoolant.port_CoolingCircle)
    annotation (Line(points={{-20.4,-52.4},{-20.4,-24},{30,-24},{30,30}}, color=
         {191,0,0}));
  connect(cHPCombustionEngine.port_Exhaust, exhaustHeatExchanger.port_a1)
    annotation (Line(points={{-10.3,48.36},{38,48.36},{38,7.2},{48,7.2}}, color=
         {0,127,255}));
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
end ModelEnginePowerAndHeatToCooling0501;
