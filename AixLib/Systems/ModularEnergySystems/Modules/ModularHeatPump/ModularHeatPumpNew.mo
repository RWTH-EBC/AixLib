within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump;
model ModularHeatPumpNew

   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = AixLib.Media.Water,
                           final m_flow_nominal=QNom/MediumCon.cp_const/DeltaTCon);
 parameter Boolean HighTemp=false "High temperature HP"
   annotation(choices(checkBox=true), Dialog(descriptionLabel=true, group="General machine information"));

 parameter Modelica.SIunits.Temperature THotMax= if HighTemp==false then  273.15+55  else 273.15+90 "Max. value of THot to force shutdown"
 annotation (Dialog(tab="Advanced", group="General machine information"));
  parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.HeatFlowRate QNom=150000 "Nominal heat flow"
   annotation (Dialog(group="Nominal condition"));
  parameter Real PLRMin=0.4 "Limit of PLR; less =0"
   annotation (Dialog(group="General machine information"));

  parameter Modelica.SIunits.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="Advanced",group="General machine information"));

    parameter Modelica.SIunits.Temperature T_Start_Condenser=293.15 "Initial temperature condenser"
    annotation (Dialog(tab="Advanced"));

    parameter Boolean TSourceInternal=true
                                          "Use internal TSource?"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));
      parameter Boolean THotExternal=false "Use external THot?"
                                                               annotation (Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

   parameter Modelica.SIunits.Temperature TSource=TSourceNom "Temperature of heat source"
   annotation (Dialog(enable=TSourceInternal,tab="Advanced",group="General machine information"));

parameter  Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/MediumCon.cp_const/DeltaTCon;

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

               parameter Modelica.SIunits.Pressure dpExternal=12000
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
    dpCon_nominal=25000,
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
        origin={46,0})));

  Modelica.Blocks.Sources.RealExpression mFlowEva(y=MediumEvap.cp_const*
        DeltaTEvap) "massflow heat source"
    annotation (Placement(transformation(extent={{126,-48},{84,-24}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{60,-40},{44,-24}})));
  Modelica.Blocks.Sources.RealExpression tSource(y=TSource)
                                                        "TSource"
    annotation (Placement(transformation(extent={{-80,-88},{-56,-74}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                             senTCold(
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=QNom/(4180*DeltaTCon),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-9,-10},{9,10}},
        rotation=0,
        origin={-37,0})));

  AixLib.Fluid.Sources.Boundary_pT bouEvap_b(redeclare package Medium = MediumEvap, nPorts=1)
    annotation (Placement(transformation(extent={{-68,-50},{-48,-30}})));
  AixLib.Fluid.Sources.MassFlowSource_T bouEvap_a(
    redeclare package Medium = MediumEvap,
    use_m_flow_in=true,
    m_flow=1,
    use_T_in=true,
    T=306.15,
    nPorts=1) annotation (Placement(transformation(extent={{60,-82},{40,-62}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{52,76},{64,88}})));

  AixLib.Systems.ModularEnergySystems.Controls.ControlMflowNotManufacturer control(
    THotMax=THotMax,
    THotNom=THotNom,
    TSourceNom=TSourceNom,
    QNom=QNom,
    PLRMin=PLRMin,
    HighTemp=HighTemp,
    DeltaTCon=DeltaTCon) annotation (Placement(transformation(extent={{-60,58},
            {-40,78}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-4,-64})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=TSourceInternal)
    annotation (Placement(transformation(extent={{-80,-78},{-60,-58}})));

  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{30,60},{14,76}})));
  Modelica.Blocks.Sources.RealExpression tHotMax(y=THotMax - DeltaTCon)
    "Maximal THot"
    annotation (Placement(transformation(extent={{74,54},{50,70}})));
  Fluid.Sensors.TemperatureTwoPort
                             senTCold1(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(4180*DeltaTCon),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-9,-10},{9,10}},
        rotation=0,
        origin={-87,32})));
  Fluid.Sensors.TemperatureTwoPort
                             senTHot1(
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=QNom/(4180*DeltaTCon),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={70,34})));
  Fluid.Sensors.MassFlowRate        senMasFloHP(redeclare package Medium =
        Media.Water)        annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={26,0})));
  Modelica.Blocks.Math.Division mFlowRelWater "relative water mass flow"
    annotation (Placement(transformation(extent={{122,28},{102,48}})));
  Modelica.Blocks.Sources.RealExpression mFlowEva1(y=QNom/MediumCon.cp_const/
        DeltaTCon)  "massflow heat source"
    annotation (Placement(transformation(extent={{174,20},{136,42}})));
  Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
  Modelica.Blocks.Sources.RealExpression tHotMax1(y=m_flow_nominal)
    "Maximal THot"
    annotation (Placement(transformation(extent={{-130,64},{-154,80}})));
  Modelica.Blocks.Math.Product deltaTMainMax
    annotation (Placement(transformation(extent={{-150,28},{-130,48}})));
  BaseClasses.HeatPumpHotWaterFeedback heatPumpHotWaterFeedback(
    PLRMin=PLRMin,
    THotNom=THotNom,
    QNom=QNom) annotation (Placement(transformation(extent={{-8,14},{12,34}})));
protected
               replaceable package MediumCon = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat sink";

 parameter Modelica.SIunits.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
   annotation (Dialog(tab="Advanced",group="General machine information"));

equation

  connect(mFlowEva.y, division1.u2) annotation (Line(points={{81.9,-36},{61.6,
          -36},{61.6,-36.8}},       color={0,0,127}));
  connect(senTCold.port_b, heatPump.port_a1) annotation (Line(points={{-28,0},{
          -8,0}},             color={0,127,255}));
  connect(sigBus, heatPump.sigBus) annotation (Line(
      points={{-5,99},{-5,46},{-24,46},{-24,-9.9},{-7.9,-9.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bouEvap_b.ports[1], heatPump.port_b2) annotation (Line(points={{-48,-40},
          {-8,-40},{-8,-12}},   color={0,127,255}));
  connect(bouEvap_a.ports[1], heatPump.port_a2) annotation (Line(points={{40,-72},
          {26,-72},{26,-12},{12,-12}},    color={0,127,255}));
   connect(division1.y,bouEvap_a. m_flow_in) annotation (Line(points={{43.2,-32},
          {40,-32},{40,-50},{86,-50},{86,-64},{62,-64}},       color={0,0,127}));

  connect(switch1.y, bouEvap_a.T_in) annotation (Line(points={{4.8,-64},{10,-64},
          {10,-82},{68,-82},{68,-68},{62,-68}},                   color={0,0,127}));
  connect(tSource.y, switch1.u1) annotation (Line(points={{-54.8,-81},{-22,-81},
          {-22,-70},{-13.6,-70},{-13.6,-70.4}},
                          color={0,0,127}));
  connect(booleanExpression.y, switch1.u2) annotation (Line(points={{-59,-68},{
          -44,-68},{-44,-64},{-13.6,-64}},
                                       color={255,0,255}));
  connect(tHotMax.y, greater.u2) annotation (Line(points={{48.8,62},{48.8,61.6},
          {31.6,61.6}},           color={0,0,127}));
  connect(greater.y, sigBus.Shutdown) annotation (Line(points={{13.2,68},{10,68},
          {10,99.085},{-4.925,99.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(greater.y, control.Shutdown) annotation (Line(points={{13.2,68},{-38,
          68}},                  color={255,0,255}));
  connect(senTCold.T, greater.u1) annotation (Line(points={{-37,11},{-36,11},{
          -36,48},{36,48},{36,68},{31.6,68}},
                                       color={0,0,127}));
  connect(senTCold.T, control.TCold) annotation (Line(points={{-37,11},{-37,52},
          {-38,52},{-38,59}},          color={0,0,127}));

  connect(mode.y, sigBus.modeSet) annotation (Line(points={{27.2,99},{10,99},{
          10,99},{-5,99}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.PLR, control.PLR) annotation (Line(
      points={{-4.925,99.085},{-4.925,75},{-38,75}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBus.QEvapNom, division1.u1) annotation (Line(
      points={{-4.925,99.085},{-4.925,92},{80,92},{80,-27.2},{61.6,-27.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBus.Pel, integrator.u) annotation (Line(
      points={{-5,99},{-5,82},{50.8,82}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TSource, switch1.u3) annotation (Line(
      points={{-5,99},{-5,84},{-114,84},{-114,-57.6},{-13.6,-57.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-162,0},{-122,-22}},
          lineColor={28,108,200},
          textString="Muss y_flow Pump?")}),
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
