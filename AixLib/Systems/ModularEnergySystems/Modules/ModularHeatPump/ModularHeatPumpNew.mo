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
  Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium = Media.Water,
    redeclare Fluid.Movers.Data.Generic per,
    inputType=AixLib.Fluid.Types.InputType.Continuous,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
  BaseClasses.HeatPump_Sources.Liquid heatSource(TSourceNom=TSourceNom)
    "Liquid heat source"
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
protected
               replaceable package MediumCon = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat sink";

 parameter Modelica.Units.SI.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
   annotation (Dialog(tab="Advanced",group="General machine information"));

equation

  connect(senTCold.port_b, heatPump.port_a1) annotation (Line(points={{-28,0},{-8,
          0}},                color={0,127,255}));
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
  connect(fan1.port_b, senTCold.port_a)
    annotation (Line(points={{-62,0},{-52,0}}, color={0,127,255}));
  connect(port_a, fan1.port_a)
    annotation (Line(points={{-100,0},{-82,0}}, color={0,127,255}));
  connect(control.mFlowCon, fan1.y)
    annotation (Line(points={{-67.2,68},{-72,68},{-72,12}}, color={0,0,127}));
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
  connect(control.schutdown, sigBus.Shutdown) annotation (Line(points={{-67,60},
          {-94,60},{-94,99.085},{-4.925,99.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPump.port_b1, senTHot.port_a)
    annotation (Line(points={{12,0},{22,0}}, color={0,127,255}));
  connect(senTHot.port_b, senMasFloHP.port_a) annotation (Line(points={{38,0},{
          51,0},{51,8.88178e-16},{64,8.88178e-16}}, color={0,127,255}));
  connect(senMasFloHP.port_b, port_b) annotation (Line(points={{80,-1.11022e-15},
          {90,-1.11022e-15},{90,0},{100,0}}, color={0,127,255}));
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
