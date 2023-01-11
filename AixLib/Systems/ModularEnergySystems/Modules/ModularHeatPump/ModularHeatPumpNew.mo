within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump;
model ModularHeatPumpNew

   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = AixLib.Media.Water,
                           final m_flow_nominal=QNom/MediumCon.cp_const/DeltaTCon);
 parameter Boolean HighTemp=false "High temperature HP"
   annotation(choices(checkBox=true), Dialog(descriptionLabel=true, group="General machine information"));

 parameter Modelica.Units.SI.Temperature THotMax= if HighTemp==false then  273.15+55  else 273.15+90 "Max. value of THot to force shutdown"
 annotation (Dialog(tab="Advanced", group="General machine information"));
  parameter Modelica.Units.SI.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.HeatFlowRate QNom=150000 "Nominal heat flow"
   annotation (Dialog(group="Nominal condition"));
  parameter Real PLRMin=0.4 "Limit of PLR; less =0"
   annotation (Dialog(group="General machine information"));

  parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="Advanced",group="General machine information"));

    parameter Modelica.Units.SI.Temperature T_Start_Condenser=293.15 "Initial temperature condenser"
    annotation (Dialog(tab="Advanced"));

    parameter Boolean TSourceInternal=true
                                          "Use internal TSource?"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));
      parameter Boolean dTvar=true "Use external THot?"
                                                       annotation (Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

   parameter Modelica.Units.SI.Temperature TSource=TSourceNom "Temperature of heat source"
   annotation (Dialog(enable=TSourceInternal,tab="Advanced",group="General machine information"));

parameter  Modelica.Units.SI.MassFlowRate m_flow_nominal=QNom/MediumCon.cp_const/DeltaTCon;

   replaceable package MediumEvap = AixLib.Media.Water
                                     constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat source"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));

               parameter Modelica.Units.SI.Pressure dpExternal=12000
                                                                "Additional system pressure difference";

parameter Modelica.Units.SI.Pressure dpInternal=25000
                                                     "Additional system pressure difference";
 AixLib.Fluid.HeatPumps.HeatPump heatPump(
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    refIneFre_constant=0.02,
    nthOrder=3,
    use_non_manufacturer=true,
    use_rev=false,
    use_autoCalc=true,
    Q_useNominal=QNom,
    use_refIne=true,
<<<<<<< HEAD
=======
    refIneFre_constant=5,
    nthOrder=3,
>>>>>>> issue1147_moduleEnergySystem
    useBusConnectorOnly=true,
    dpCon_nominal=dpInternal,
    use_conCap=false,
    dpEva_nominal=25000,
    use_evaCap=false,
    tauSenT=0,
    transferHeat=false,
    allowFlowReversalEva=false,
    allowFlowReversalCon=false,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    TCon_start=T_Start_Condenser,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    show_TPort=false,
    THotMax=THotMax,
    THotNom=THotNom,
    TSourceNom=TSourceNom,
    QNom=QNom,
    PLRMin=PLRMin,
    HighTemp=HighTemp,
    DeltaTCon=DeltaTCon,
    DeltaTEvap=DeltaTEvap,
    TSource=TSourceNom,
    TSourceInternal=TSourceInternal,
    THotExternal=THotExternal)
    annotation (Placement(transformation(extent={{-8,-18},{12,6}})));

  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.BooleanExpression mode(y=true)
    annotation (Placement(transformation(extent={{44,92},{28,106}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort
                             senTHot(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(4180*DeltaTCon),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={32,0})));

  AixLib.Fluid.Sensors.TemperatureTwoPort
                             senTCold(
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=QNom/(4180*DeltaTCon),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-12},{10,12}},
        rotation=0,
        origin={-48,10})));

  Fluid.Sensors.MassFlowRate        senMasFloHP(redeclare package Medium =
        Media.Water)        annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={72,0})));
  Modelica.Blocks.Sources.RealExpression m_flowCon(y=QNom/MediumCon.cp_const/
        DeltaTCon) "massflow condenser"
    annotation (Placement(transformation(extent={{242,56},{116,84}})));
  BaseClasses.HeatPump_Sources.Liquid heatSource(TSourceNom=TSourceNom)
    "Liquid heat source"
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-122,30},{-102,50}})));
  BaseClasses.HeatPumpHotWaterFeedback heatPumpHotWaterFeedback(
    EnableFeedback=true,
    PLRMin=PLRMin,
    THotNom=THotNom,
    QNom=QNom,
    DeltaTCon=DeltaTCon)
    annotation (Placement(transformation(extent={{-8,22},{12,42}})));
  Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominal,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per,
    addPowerToMedium=false,
    m_flow_start=m_flow_nominal)
    annotation (Placement(transformation(extent={{-78,-52},{-58,-32}})));
  AixLib.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=30,
    yMax=1,
    Td=1,
    yMin=0.2)
    annotation (Placement(transformation(extent={{-128,92},{-108,112}})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus annotation (
      Placement(transformation(extent={{-14,84},{16,118}}),
        iconTransformation(extent={{-108,-52},{-90,-26}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{62,62},{40,84}})));
  AixLib.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    yMax=1,
    Td=1,
    yMin=0.01)
    annotation (Placement(transformation(extent={{-186,62},{-166,82}})));
  Modelica.Blocks.Sources.RealExpression tColdNom1(y=THotNom - DeltaTCon)
    "Nominal TCold"
    annotation (Placement(transformation(extent={{-276,58},{-214,86}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-184,16},{-164,36}})));
  Modelica.Blocks.Sources.BooleanExpression THotVar(y=dTvar)
    annotation (Placement(transformation(extent={{-292,18},{-272,38}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-172,142},{-152,162}})));
  Modelica.Blocks.Sources.RealExpression tColdNom2(y=THotNom)
    "Nominal TCold"
    annotation (Placement(transformation(extent={{-258,124},{-196,152}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-172,174},{-152,194}})));
  Modelica.Blocks.Sources.RealExpression tColdNom3(y=THotNom - DeltaTCon)
    "Nominal TCold"
    annotation (Placement(transformation(extent={{-156,210},{-94,238}})));
  Modelica.Blocks.Sources.RealExpression tColdNom4(y=DeltaTCon)
    "Nominal TCold"
    annotation (Placement(transformation(extent={{-318,164},{-256,192}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-48,168},{-28,188}})));
protected
               replaceable package MediumCon = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat sink";

 parameter Modelica.Units.SI.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
   annotation (Dialog(tab="Advanced",group="General machine information"));

equation

  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));
  connect(heatSource.port_b, heatPump.port_a2) annotation (Line(points={{10,-40},
          {18,-40},{18,-12},{12,-12}}, color={0,127,255}));
  connect(heatPump.port_b2, heatSource.port_a) annotation (Line(points={{-8,-12},
          {-14,-12},{-14,-40},{-10,-40}}, color={0,127,255}));
  connect(senMasFloHP.port_b, port_b) annotation (Line(points={{80,-1.11022e-15},
          {90,-1.11022e-15},{90,0},{100,0}}, color={0,127,255}));
  connect(m_flowCon.y, product1.u2) annotation (Line(points={{109.7,70},{109.7,
          18},{-140,18},{-140,34},{-124,34}},
                                          color={0,0,127}));
  connect(heatPump.port_b1, senTHot.port_a)
    annotation (Line(points={{12,0},{24,0}}, color={0,127,255}));
  connect(senTHot.port_b, heatPumpHotWaterFeedback.port_a1) annotation (Line(
        points={{40,0},{42,0},{42,32},{-18,32},{-18,38},{-8,38}}, color={0,127,255}));
  connect(heatPumpHotWaterFeedback.port_b1, senMasFloHP.port_a) annotation (
      Line(points={{12,38},{52,38},{52,0},{64,0}}, color={0,127,255}));
  connect(heatPumpHotWaterFeedback.port_b2, fan.port_a) annotation (Line(points={{-8,26},
          {-80,26},{-80,-42},{-78,-42}},                           color={0,127,
          255}));
  connect(port_a, senTCold.port_a) annotation (Line(points={{-100,0},{-88,0},{
          -88,10},{-58,10}}, color={0,127,255}));
  connect(senTCold.port_b, heatPumpHotWaterFeedback.port_a2) annotation (Line(
        points={{-38,10},{20,10},{20,26},{12,26}}, color={0,127,255}));
  connect(fan.port_b, heatPump.port_a1) annotation (Line(points={{-58,-42},{-52,
          -42},{-52,-38},{-30,-38},{-30,0},{-8,0}}, color={0,127,255}));
  connect(senTHot.T, conPID.u_m) annotation (Line(points={{32,8.8},{32,74},{
          -118,74},{-118,90}}, color={0,0,127}));
  connect(sigBus, heatPump.sigBus) annotation (Line(
      points={{1,101},{1,58},{-22,58},{-22,-9.9},{-7.9,-9.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(mode.y, sigBus.modeSet) annotation (Line(points={{27.2,99},{1.075,99},
          {1.075,101.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus, heatSource.sigBus) annotation (Line(
      points={{1,101},{1,54},{74,54},{74,-29.7},{0.1,-29.7}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatPumpHotWaterFeedback.mFlowCon, division.u1) annotation (Line(
        points={{2,43},{2,60},{72,60},{72,79.6},{64.2,79.6}}, color={0,0,127}));
  connect(m_flowCon.y, division.u2) annotation (Line(points={{109.7,70},{108,70},
          {108,74},{70,74},{70,66.4},{64.2,66.4}}, color={0,0,127}));
  connect(division.y, sigBus.mFlowWaterRel) annotation (Line(points={{38.9,73},
          {23.45,73},{23.45,101.085},{1.075,101.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTCold.T, conPID1.u_m) annotation (Line(points={{-48,23.2},{-48,60},
          {-176,60}},           color={0,0,127}));
  connect(conPID1.u_s, tColdNom1.y)
    annotation (Line(points={{-188,72},{-210.9,72}}, color={0,0,127}));
  connect(conPID.y, sigBus.PLR) annotation (Line(points={{-107,102},{-82,102},{
          -82,104},{1.075,104},{1.075,101.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBus.QRel, switch1.u3) annotation (Line(
      points={{1.075,101.085},{1.075,120},{-228,120},{-228,18},{-186,18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(THotVar.y, switch1.u2) annotation (Line(points={{-271,28},{-229,28},{-229,
          26},{-186,26}},      color={255,0,255}));
  connect(conPID1.y, switch1.u1) annotation (Line(points={{-165,72},{-148,72},{
          -148,48},{-194,48},{-194,34},{-186,34}}, color={0,0,127}));
  connect(switch1.y, product1.u1) annotation (Line(points={{-163,26},{-156,26},
          {-156,46},{-124,46}}, color={0,0,127}));
  connect(product1.y, fan.m_flow_in)
    annotation (Line(points={{-101,40},{-68,40},{-68,-30}}, color={0,0,127}));
  connect(tColdNom2.y, switch2.u3) annotation (Line(points={{-192.9,138},{-180,138},
          {-180,144},{-174,144}}, color={0,0,127}));
  connect(switch2.y, conPID.u_s) annotation (Line(points={{-151,152},{-140,152},
          {-140,102},{-130,102}}, color={0,0,127}));
  connect(tColdNom4.y, product2.u2)
    annotation (Line(points={{-252.9,178},{-174,178}}, color={0,0,127}));
  connect(product2.y, add.u2) annotation (Line(points={{-151,184},{-60,184},{-60,
          172},{-50,172}}, color={0,0,127}));
  connect(tColdNom3.y, add.u1) annotation (Line(points={{-90.9,224},{-72,224},{-72,
          190},{-50,190},{-50,184}}, color={0,0,127}));
  connect(add.y, switch2.u1) annotation (Line(points={{-27,178},{-4,178},{-4,168},
          {-192,168},{-192,160},{-174,160}}, color={0,0,127}));
  connect(sigBus.QRel, product2.u1) annotation (Line(
      points={{1.075,101.085},{-96,101.085},{-96,206},{-200,206},{-200,190},{-174,
          190}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(THotVar.y, switch2.u2) annotation (Line(points={{-271,28},{-94,28},{-94,
          118},{-116,118},{-116,152},{-174,152}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-17,83},{17,-83}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={1,61},
          rotation=90),
        Rectangle(
          extent={{-82,42},{84,-46}},
          lineColor={238,46,47},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-16,83},{16,-83}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={1,-64},
          rotation=90)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=40000),
    Documentation(info="<html>
<p>Modular heat pump with different options</p>
<ul>
<li>with or without pump</li>
<li>with or without an external temperature for TSource</li>
</ul>
<p><br>with different operation types:</p>
<ul>
<li>with a fixed THot, which is THotNom -&gt; temperature difference between THot and TCold is not constant</li>
<li>with a fixed deltaTCon -&gt; THot is not equal THotNom. THotNom is only important for nominal electrical demand</li>
<li>as a high temperature heat pump, using R134a and a piston compressor</li>
<li>as a low temperature heat pump, using R410a and a scroll compressor</li>
</ul>
<p><br>Concept </p>
<p><br>The inner cycle of the heat pump is a Black-Box. The Black-Box uses 4-D performance maps, which describe the COP. The maps are based on a given THot, TSource, deltaTCon and PLR (for further informations: AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTableNDNotManudacturer). The parameters QNom, THotNom, TSourceNom describe the nominal behaviour for a full load operation point e.g. W10W55 or B0W45. The nominal full load electircal power is calculated with the nominal COP and is constant for different TSource. The part load beaviour describes the part load of the compressor as a product of PLR and nominal full load electrical power (variable speed control). The thermal power and the thermal demand are calculated for any operation point as a function of COP and electrical power.</p>
</html>"));
end ModularHeatPumpNew;
