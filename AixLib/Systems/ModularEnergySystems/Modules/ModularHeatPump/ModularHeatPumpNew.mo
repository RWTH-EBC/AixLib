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
      parameter Boolean THotExternal=false "Use external THot?"
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

  AixLib.Systems.ModularEnergySystems.Interfaces.VapourCompressionMachineControleBusModular
    sigBus annotation (Placement(transformation(extent={{-20,82},{10,116}}),
        iconTransformation(extent={{-8,90},{10,116}})));
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
        origin={30,0})));

  AixLib.Fluid.Sensors.TemperatureTwoPort
                             senTCold(
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=QNom/(4180*DeltaTCon),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-40,0})));

  AixLib.Systems.ModularEnergySystems.Controls.ControlMflowNotManufacturer control(
    THotMax=THotMax,
    THotNom=THotNom,
    TSourceNom=TSourceNom,
    QNom=QNom,
    PLRMin=PLRMin,
    HighTemp=HighTemp,
    DeltaTCon=DeltaTCon) annotation (Placement(transformation(extent={{-66,58},{
            -46,78}})));

  Fluid.Sensors.MassFlowRate        senMasFloHP(redeclare package Medium =
        Media.Water)        annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={72,0})));
  Modelica.Blocks.Math.Division m_flowRelCon "relative mass flow condenser"
    annotation (Placement(transformation(extent={{30,50},{10,70}})));
  Modelica.Blocks.Sources.RealExpression m_flowCon(y=QNom/MediumCon.cp_const/
        DeltaTCon) "massflow condenser"
    annotation (Placement(transformation(extent={{68,44},{42,64}})));
  BaseClasses.HeatPump_Sources.Liquid heatSource(TSourceNom=TSourceNom)
    "Liquid heat source"
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=QNom/MediumCon.cp_const/DeltaTCon,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-138,26},{-118,46}})));
protected
               replaceable package MediumCon = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat sink";

 parameter Modelica.Units.SI.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
   annotation (Dialog(tab="Advanced",group="General machine information"));

equation

<<<<<<< HEAD
  connect(mFlowEva.y, division1.u2) annotation (Line(points={{81.9,-36},{61.6,
          -36},{61.6,-36.8}},       color={0,0,127}));
  connect(senTCold.port_b, heatPump.port_a1) annotation (Line(points={{-28,0},{
          -8,0}},             color={0,127,255}));
=======
  connect(heatPump.port_b1, senTHot.port_a)
    annotation (Line(points={{10,0},{50,0}},         color={0,127,255}));

  connect(mFlowEva.y, division1.u2) annotation (Line(points={{70.1,-37},{64,-37},
          {64,-36},{61.6,-36},{61.6,-36.8}},
                                    color={0,0,127}));
  connect(senTCold.port_b, heatPump.port_a1) annotation (Line(points={{-28,0},{-10,
          0}},                color={0,127,255}));
>>>>>>> issue1147_moduleEnergySystem
  connect(sigBus, heatPump.sigBus) annotation (Line(
      points={{-5,99},{-5,46},{-24,46},{-24,-9.9},{-7.9,-9.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(senTCold.T, control.TCold) annotation (Line(points={{-40,13.2},{-40,59},
          {-44,59}},                   color={0,0,127}));

  connect(mode.y, sigBus.modeSet) annotation (Line(points={{27.2,99},{10,99},{
          10,99},{-5,99}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.PLR, control.PLR) annotation (Line(
      points={{-4.925,99.085},{-4.925,75},{-44,75}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));
  connect(m_flowRelCon.u2, m_flowCon.y)
    annotation (Line(points={{32,54},{40.7,54}}, color={0,0,127}));
  connect(senMasFloHP.m_flow, m_flowRelCon.u1)
    annotation (Line(points={{72,8.8},{72,66},{32,66}}, color={0,0,127}));
  connect(m_flowRelCon.y, sigBus.mFlowWaterRel) annotation (Line(points={{9,60},
          {-4.925,60},{-4.925,99.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTHot.T, control.THot)
    annotation (Line(points={{30,8.8},{30,36},{-16,36},{-16,64},{-44,64}},
                                                         color={0,0,127}));
  connect(heatSource.port_b, heatPump.port_a2) annotation (Line(points={{10,-40},
          {18,-40},{18,-12},{12,-12}}, color={0,127,255}));
  connect(heatPump.port_b2, heatSource.port_a) annotation (Line(points={{-8,-12},
          {-14,-12},{-14,-40},{-10,-40}}, color={0,127,255}));
  connect(sigBus, heatSource.sigBus) annotation (Line(
      points={{-5,99},{-5,46},{-24,46},{-24,-22},{0.1,-22},{0.1,-29.7}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
<<<<<<< HEAD
  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));
  connect(senTHot1.port_b, port_b) annotation (Line(points={{78,34},{86,34},{86,
          0},{100,0}}, color={0,127,255}));
  connect(port_a, senTCold1.port_a)
    annotation (Line(points={{-100,0},{-100,32},{-96,32}}, color={0,127,255}));
  connect(heatPump.port_b1, senMasFloHP.port_a) annotation (Line(points={{12,0},
          {15,0},{15,8.88178e-16},{18,8.88178e-16}}, color={0,127,255}));
  connect(senMasFloHP.port_b, senTHot.port_a) annotation (Line(points={{34,-1.11022e-15},
          {36,-1.11022e-15},{36,0},{38,0}}, color={0,127,255}));
  connect(mFlowRelWater.u2, mFlowEva1.y)
    annotation (Line(points={{124,32},{134.1,31}}, color={0,0,127}));
  connect(senMasFloHP.m_flow, mFlowRelWater.u1) annotation (Line(points={{26,8.8},
          {26,20},{144,20},{144,44},{124,44}}, color={0,0,127}));
  connect(mFlowRelWater.y, sigBus.mFlowWaterRel) annotation (Line(points={{101,38},
          {72,38},{72,40},{-4.925,40},{-4.925,99.085}}, color={0,0,127}), Text(
=======

  connect(mode.y, sigBus.modeSet) annotation (Line(points={{27.2,99},{14,99},{
          14,80},{8,80},{8,78},{-5,78},{-5,99}}, color={255,0,255}), Text(
>>>>>>> issue1147_moduleEnergySystem
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
<<<<<<< HEAD
  connect(senTHot.T, control.THot)
    annotation (Line(points={{46,8.8},{46,64},{-38,64}}, color={0,0,127}));
  connect(senTCold.port_a, fan.port_b)
    annotation (Line(points={{-46,0},{-56,0}}, color={0,127,255}));
  connect(deltaTMainMax.y, fan.m_flow_in)
    annotation (Line(points={{-129,38},{-66,38},{-66,12}}, color={0,0,127}));
  connect(control.mFlowCon, deltaTMainMax.u2) annotation (Line(points={{-61.2,68},
          {-102,68},{-102,62},{-158,62},{-158,32},{-152,32}}, color={0,0,127}));
  connect(tHotMax1.y, deltaTMainMax.u1) annotation (Line(points={{-155.2,72},{-172,
          72},{-172,70},{-184,70},{-184,48},{-152,48},{-152,44}}, color={0,0,127}));
  connect(senTCold1.port_b, heatPumpHotWaterFeedback.port_a2) annotation (Line(
        points={{-78,32},{-12,32},{-12,38},{16,38},{16,18},{12,18}}, color={0,
          127,255}));
  connect(heatPumpHotWaterFeedback.port_b2, fan.port_a) annotation (Line(points
        ={{-8,18},{-82,18},{-82,0},{-76,0}}, color={0,127,255}));
  connect(heatPumpHotWaterFeedback.port_b1, senTHot1.port_a) annotation (Line(
        points={{12,30},{54,30},{54,34},{62,34}}, color={0,127,255}));
  connect(senTHot.port_b, heatPumpHotWaterFeedback.port_a1) annotation (Line(
        points={{54,0},{60,0},{60,30},{-8,30}}, color={0,127,255}));
=======
>>>>>>> issue1147_moduleEnergySystem
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
