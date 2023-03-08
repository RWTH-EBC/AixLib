within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump;
model ModularHeatPump

   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = AixLib.Media.Water,
                           final m_flow_nominal=QNom/MediumCon.cp_const/DeltaTCon);

  parameter Modelica.Units.SI.Temperature THotMax=333.15 "Max. value of THot to force shutdown"
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

parameter Modelica.Units.SI.Pressure dpExternal=0               "Additional system pressure difference";

parameter Modelica.Units.SI.Pressure dpInternal=25000
                                                     "Pressure difference condenser";

 parameter Boolean Modulating=true "Is the heat pump inverter-driven?";




 AixLib.Fluid.HeatPumps.HeatPump heatPump(
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    refIneFre_constant=0.02,
    nthOrder=3,
    useBusConnectorOnly=true,
    use_non_manufacturer=true,
    use_rev=false,
    use_autoCalc=true,
    Q_useNominal=QNom,
    use_refIne=true,
    dpCon_nominal=dpInternal,
    use_conCap=false,
    dpEva_nominal=25000,
    use_evaCap=false,
    tauSenT=1,
    transferHeat=false,
    allowFlowReversalEva=false,
    allowFlowReversalCon=false,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    show_TPort=false,
    THotMax=THotMax,
    THotNom=THotNom,
    TSourceNom=TSourceNom,
    QNom=QNom,
    PLRMin=PLRMin,
    DeltaTCon=DeltaTCon,
    DeltaTEvap=DeltaTEvap,
    TSource=TSourceNom,
    TSourceInternal=TSourceInternal,
    Modulating=Modulating)
    annotation (Placement(transformation(extent={{-8,-16},{12,8}})));

  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

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
    redeclare final package Medium = AixLib.Media.Water,
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
  Modelica.Blocks.Sources.RealExpression m_flowCon(y=m_flow_nominal)
                   "massflow condenser"
    annotation (Placement(transformation(extent={{154,52},{90,80}})));
  BaseClasses.HeatPump_Sources.Liquid heatSource(TSourceNom=TSourceNom)
    "Liquid heat source"
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  BaseClasses.HeatPumpHotWaterFeedback heatPumpHotWaterFeedback(
    EnableFeedback=true,
    PLRMin=PLRMin,
    THotNom=THotNom,
    QNom=QNom,
    DeltaTCon=DeltaTCon)
    annotation (Placement(transformation(extent={{-8,22},{12,42}})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus annotation (
      Placement(transformation(extent={{-14,84},{16,118}}),
        iconTransformation(extent={{-108,-52},{-90,-26}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{62,62},{40,84}})));
  Fluid.Movers.SpeedControlled_y fan(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=false,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per(
        pressure(V_flow={0,m_flow_nominal/1000,m_flow_nominal/1000/0.7}, dp={
            dpInternal/0.9,dpInternal,0})),
    inputType=AixLib.Fluid.Types.InputType.Continuous,
    addPowerToMedium=false,
    use_inputFilter=false,
    riseTime=10,
    init=Modelica.Blocks.Types.Init.SteadyState,
    y_start=1)
    annotation (Placement(transformation(extent={{-84,-52},{-64,-32}})));
  BaseClasses.ModularControl modularControl(
    DeltaTCon=DeltaTCon,
    THotNom=THotNom,
    Modulating=Modulating)
    annotation (Placement(transformation(extent={{-92,72},{-50,98}})));
protected
package MediumCon = AixLib.Media.Water "Medium heat sink";

 parameter Modelica.Units.SI.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
   annotation (Dialog(tab="Advanced",group="General machine information"));

equation

  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));
  connect(heatSource.port_b, heatPump.port_a2) annotation (Line(points={{10,-40},
          {18,-40},{18,-10},{12,-10}}, color={0,127,255}));
  connect(heatPump.port_b2, heatSource.port_a) annotation (Line(points={{-8,-10},
          {-14,-10},{-14,-40},{-10,-40}}, color={0,127,255}));
  connect(senMasFloHP.port_b, port_b) annotation (Line(points={{80,-1.11022e-15},
          {90,-1.11022e-15},{90,0},{100,0}}, color={0,127,255}));
  connect(heatPump.port_b1, senTHot.port_a)
    annotation (Line(points={{12,2},{18,2},{18,0},{24,0}},
                                             color={0,127,255}));
  connect(senTHot.port_b, heatPumpHotWaterFeedback.port_a1) annotation (Line(
        points={{40,0},{42,0},{42,32},{-18,32},{-18,38},{-8,38}}, color={0,127,255}));
  connect(heatPumpHotWaterFeedback.port_b1, senMasFloHP.port_a) annotation (
      Line(points={{12,38},{52,38},{52,0},{64,0}}, color={0,127,255}));
  connect(port_a, senTCold.port_a) annotation (Line(points={{-100,0},{-88,0},{
          -88,10},{-58,10}}, color={0,127,255}));
  connect(senTCold.port_b, heatPumpHotWaterFeedback.port_a2) annotation (Line(
        points={{-38,10},{20,10},{20,26},{12,26}}, color={0,127,255}));
  connect(sigBus, heatPump.sigBus) annotation (Line(
      points={{1,101},{1,52},{-22,52},{-22,-7.9},{-7.9,-7.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus, heatSource.sigBus) annotation (Line(
      points={{1,101},{1,58},{74,58},{74,-29.7},{0.1,-29.7}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(m_flowCon.y, division.u2) annotation (Line(points={{86.8,66},{68,66},
          {68,66.4},{64.2,66.4}},                  color={0,0,127}));
  connect(division.y, sigBus.mFlowWaterRel) annotation (Line(points={{38.9,73},
          {23.45,73},{23.45,101.085},{1.075,101.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpHotWaterFeedback.port_b2, fan.port_a) annotation (Line(points=
         {{-8,26},{-92,26},{-92,-42},{-84,-42}}, color={0,127,255}));
  connect(modularControl.sigBus1, sigBus) annotation (Line(
      points={{-69.9,78.1},{-68,78.1},{-68,68},{1,68},{1,101}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senTCold.T, modularControl.tCold) annotation (Line(points={{-48,23.2},
          {-48,62},{-98,62},{-98,82},{-92,82}},
                                   color={0,0,127}));
  connect(senTHot.T, modularControl.tHot) annotation (Line(points={{32,8.8},{32,
          60},{-100,60},{-100,78.4},{-92,78.4}},
                                       color={0,0,127}));
  connect(sigBus.mFlowSet, fan.y) annotation (Line(
      points={{1.075,101.085},{-28,101.085},{-28,40},{-74,40},{-74,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(fan.port_b, heatPump.port_a1) annotation (Line(points={{-64,-42},{-34,
          -42},{-34,2},{-8,2}}, color={0,127,255}));
  connect(sigBus.m_flowConMea, division.u1) annotation (Line(
      points={{1.075,101.085},{74,101.085},{74,79.6},{64.2,79.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
end ModularHeatPump;
