within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump;
model ModularHeatPumpNew

   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = Media.Water,final m_flow_nominal=QNom/MediumCon.cp_const/DeltaTCon);
       parameter Boolean dTConFix=false "Constant delta T condenser"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true, group="General machine information"));
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
   annotation (Dialog(enable=dTConFix,tab="Advanced",group="General machine information"));

    parameter Modelica.SIunits.Temperature T_Start_Condenser=293.15 "Initial temperature condenser"
    annotation (Dialog(tab="Advanced"));

    parameter Boolean TSourceInternal=true
                                          "Use internal TSource?"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

   parameter Modelica.SIunits.Temperature TSourceFixed=TSourceNom "Temperature of heat source"
   annotation (Dialog(enable=TSourceInternal,tab="Advanced",group="General machine information"));

parameter  Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/MediumCon.cp_const/DeltaTCon;

   replaceable package MediumEvap = Media.Water
                                     constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat source"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));

               parameter Modelica.SIunits.Pressure dpExternal=0 "Additional system pressure difference";
 AixLib.Fluid.HeatPumps.HeatPump heatPump(
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_non_manufacturer=true,
    use_rev=false,
    use_autoCalc=true,
    Q_useNominal=QNom,
    use_refIne=true,
    refIneFre_constant=5,
    nthOrder=3,
    useBusConnectorOnly=false,
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
    TSource=TSourceFixed,
    dTConFix=dTConFix)
    annotation (Placement(transformation(extent={{-10,-18},{10,6}})));

  AixLib.Systems.ModularEnergySystems.Interfaces.VapourCompressionMachineControleBusModular
    sigBus annotation (Placement(transformation(extent={{-20,82},{10,116}}),
        iconTransformation(extent={{-8,90},{10,116}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.BooleanExpression mode(y=true)
    annotation (Placement(transformation(extent={{44,92},{28,106}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort
                             senTHot(
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=QNom/(4180*DeltaTCon),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={58,0})));

  Modelica.Blocks.Sources.RealExpression mFlowEva(y=MediumEvap.cp_const*
        DeltaTEvap) "massflow heat source"
    annotation (Placement(transformation(extent={{110,-48},{72,-26}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{60,-40},{44,-24}})));
  Modelica.Blocks.Sources.RealExpression tSource(y=TSourceFixed)
                                                        "TSource"
    annotation (Placement(transformation(extent={{-62,-98},{-38,-84}})));
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
    annotation (Placement(transformation(extent={{52,58},{64,70}})));

  AixLib.Systems.ModularEnergySystems.Controls.ControlMflowNotManufacturer control(
    THotMax=THotMax,
    THotNom=THotNom,
    TSourceNom=TSourceNom,
    QNom=QNom,
    PLRMin=PLRMin,
    HighTemp=HighTemp,
    DeltaTCon=DeltaTCon,
    dTConFix=dTConFix) annotation (Placement(transformation(extent={{-66,36},{-46,56}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-4,-64})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=TSourceInternal)
    annotation (Placement(transformation(extent={{-80,-84},{-60,-64}})));

  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{30,42},{14,58}})));
  Modelica.Blocks.Sources.RealExpression tHotMax(y=THotMax - DeltaTCon)
    "Maximal THot"
    annotation (Placement(transformation(extent={{62,28},{38,44}})));
  AixLib.Fluid.Movers.SpeedControlled_y
                           fan1(redeclare package Medium = Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,m_flow_nominal/1000,m_flow_nominal/500}, dp={(25000
             + dpExternal)/0.8,(25000 + dpExternal),0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-74,-10},{-54,10}})));
protected
               replaceable package MediumCon = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat sink";

 parameter Modelica.SIunits.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
   annotation (Dialog(tab="Advanced",group="General machine information"));

equation

  connect(mode.y, sigBus.mode) annotation (Line(points={{27.2,99},{2,99},{2,99},
          {-5,99}},         color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatPump.port_b1, senTHot.port_a)
    annotation (Line(points={{10,0},{50,0}},         color={0,127,255}));

  connect(mFlowEva.y, division1.u2) annotation (Line(points={{70.1,-37},{64,-37},
          {64,-36},{61.6,-36},{61.6,-36.8}},
                                    color={0,0,127}));
  connect(senTCold.port_b, heatPump.port_a1) annotation (Line(points={{-28,0},{-10,
          0}},                color={0,127,255}));
  connect(sigBus, heatPump.sigBus) annotation (Line(
      points={{-5,99},{-5,28},{-24,28},{-24,-9.9},{-9.9,-9.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.QEvapNom, division1.u1) annotation (Line(
      points={{-4.925,99.085},{-4.925,74},{72,74},{72,-27.2},{61.6,-27.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bouEvap_b.ports[1], heatPump.port_b2) annotation (Line(points={{-48,-40},
          {-10,-40},{-10,-12}}, color={0,127,255}));
  connect(bouEvap_a.ports[1], heatPump.port_a2) annotation (Line(points={{40,-72},
          {26,-72},{26,-12},{10,-12}},    color={0,127,255}));
   connect(division1.y,bouEvap_a. m_flow_in) annotation (Line(points={{43.2,-32},
          {40,-32},{40,-50},{86,-50},{86,-64},{62,-64}},       color={0,0,127}));
  connect(senTHot.port_b, port_b) annotation (Line(points={{66,0},{100,0}},
                    color={0,127,255}));
  connect(sigBus.Pel, integrator.u) annotation (Line(
      points={{-5,99},{-5,64},{50.8,64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(sigBus.PLR, control.PLR) annotation (Line(
      points={{-4.925,99.085},{-4.925,53},{-44,53}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senTHot.T, control.THot) annotation (Line(points={{58,8.8},{58,28},{4,
          28},{4,42},{-44,42}}, color={0,0,127}));
  connect(switch1.y, bouEvap_a.T_in) annotation (Line(points={{4.8,-64},{10,-64},
          {10,-76},{14,-76},{14,-82},{68,-82},{68,-68},{62,-68}}, color={0,0,127}));
  connect(tSource.y, switch1.u1) annotation (Line(points={{-36.8,-91},{-13.6,
          -91},{-13.6,-70.4}},
                          color={0,0,127}));
  connect(booleanExpression.y, switch1.u2) annotation (Line(points={{-59,-74},{
          -44,-74},{-44,-64},{-13.6,-64}},
                                       color={255,0,255}));
  connect(tHotMax.y, greater.u2) annotation (Line(points={{36.8,36},{32,36},{32,
          43.6},{31.6,43.6}},     color={0,0,127}));
  connect(greater.y, sigBus.Shutdown) annotation (Line(points={{13.2,50},{10,50},
          {10,99.085},{-4.925,99.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(greater.y, control.Shutdown) annotation (Line(points={{13.2,50},{10,
          50},{10,46},{-44,46}}, color={255,0,255}));
  connect(senTCold.T, greater.u1) annotation (Line(points={{-37,11},{-37,18},{
          66,18},{66,50},{31.6,50}},   color={0,0,127}));
  connect(port_a, fan1.port_a)
    annotation (Line(points={{-100,0},{-74,0}}, color={0,127,255}));
  connect(senTCold.port_a, fan1.port_b)
    annotation (Line(points={{-46,0},{-54,0}}, color={0,127,255}));
  connect(control.mFlowCon, fan1.y) annotation (Line(points={{-67.2,46},{-76,46},
          {-76,20},{-64,20},{-64,12}}, color={0,0,127}));
  connect(senTCold.T, control.TCold) annotation (Line(points={{-37,11},{-37,36},
          {-42,36},{-42,37},{-44,37}}, color={0,0,127}));
  connect(sigBus.TSource, switch1.u3) annotation (Line(
      points={{-5,99},{-5,74},{-110,74},{-110,-57.6},{-13.6,-57.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

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
