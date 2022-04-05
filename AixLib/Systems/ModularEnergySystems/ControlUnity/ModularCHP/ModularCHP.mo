within AixLib.Systems.ModularEnergySystems.ControlUnity.ModularCHP;
model ModularCHP
   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = AixLib.Media.Water,
                           m_flow_nominal=m_flow_nominalCC);

  parameter Modelica.SIunits.Power PelNom=200000 "Nominal electrical power";

  parameter Modelica.SIunits.TemperatureDifference deltaTHeatingCircuit=20 "Nominal temperature difference heat circuit";

  parameter Modelica.SIunits.Temperature THotCoolingWaterMax=273.15 + 95
                                                                       "Max. water temperature THot heat circuit";

  parameter Real PLRMin=0.5;

  parameter Modelica.SIunits.Temperature TStart=273.15 + 20
                                                          "T start"
   annotation (Dialog(tab="Advanced"));

  AixLib.Fluid.BoilerCHP.CHPNotManufacturer cHPNotManufacturer(
    m_flow_nominal=m_flow_nominalCC,
    T_start=TStart,
    PLRMin=PLRMin,
    redeclare package Medium = AixLib.Media.Water,
    PelNom=PelNom) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{100,70},{120,90}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort THotHeatCircuit(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart) annotation (Placement(transformation(extent={{58,-82},{78,-62}})));
  AixLib.Fluid.HeatExchangers.DryCoilEffectivenessNTU hex(
    redeclare package Medium1 = AixLib.Media.Water,
    redeclare package Medium2 = AixLib.Media.Water,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    m1_flow_nominal=m_flow_nominalHC,
    m2_flow_nominal=m_flow_nominalCC,
    dp1_nominal=0,
    dp2_nominal=2500,
    configuration=AixLib.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    use_Q_flow_nominal=true,
    Q_flow_nominal=(1.3423*PelNom/1000 + 17.681)*1000,
    T_a1_nominal=333.15,
    T_a2_nominal=359.41,
    r_nominal=1) annotation (Placement(transformation(extent={{-10,-56},{10,-76}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort TColdHeatCircuit(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalHC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart) annotation (Placement(transformation(extent={{-56,-82},{-36,-62}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort TColdCoolingWater(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalCC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart) annotation (Placement(transformation(extent={{-16,-68},{-32,-52}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort THotCoolingWater(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalCC,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart) annotation (Placement(transformation(extent={{30,-68},{16,-52}})));

  AixLib.Controls.Interfaces.CHPControlBus cHPControlBus
    annotation (Placement(transformation(extent={{-80,82},{-40,122}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{68,4},{88,24}})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{60,36},{80,56}})));

  AixLib.Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = AixLib.Media.Water,
    nPorts=1) annotation (Placement(transformation(extent={{-80,-54},{-60,-34}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = AixLib.Media.Water,
    p_start=100000,
    m_flow_nominal=m_flow_nominalCC) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-36,-14})));
  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,V_flow_HC,V_flow_HC*2}, dp={dp_nominal/0.8,dp_nominal,0})),
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-100,-30})));
  AixLib.Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominalCC,
    zeta=1,
    diameter=1) annotation (Placement(transformation(extent={{-88,-82},{-68,-62}})));
  ControlCHPNotManufacturerModular controlCHPNotManufacturerModular
    annotation (Placement(transformation(extent={{-144,-22},{-124,-2}})));
  Regulation_ModularCHP regulation_ModularCHP(PLRMin=PLRMin,
                                              use_advancedControl=false)
    annotation (Placement(transformation(extent={{-74,44},{-54,64}})));
  hierarchicalControl_modularCHP hierarchicalControl_modularCHP1(
    use_advancedControl=use_advancedControl,
    manualTimeDelay=manualTimeDelay,
    simpleTwoPosition=simpleTwoPosition,
    n=n,
    bandwidth=bandwidth,
    severalHeatcurcuits=severalHeatcurcuits,
    variablePLR=variablePLR,
    k=k,
    TBoiler=TBoiler,
    Tref=Tref,
    declination=declination,
    day_hour=day_hour,
    night_hour=night_hour,
    TOffset=TOffset,
    time_minOff=time_minOff,
    time_minOn=time_minOn,
    variableSetTemperature_admix=variableSetTemperature_admix)
    annotation (Placement(transformation(extent={{-6,42},{14,62}})));
  parameter Boolean use_advancedControl
    "Selection between two position control and flow temperature control, if true=flow temperature control is active" annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Two position control",
      radioButtons=true), Dialog(tab="Control", group="Parameters"));
  parameter Boolean variablePLR=false
    "If true, the user can determine the PLR between PLRmin and 1; else you have a two position conttol with the values 0 and 1 for PLR";
  parameter Integer k=2
                      "Number of heat curcuits" annotation(Dialog(enable=use_advancedControl and severalHeatcurcuits, tab="Control", group="Admixture control"));

  parameter Integer n=if simpleTwoPosition then 1 else n
                        "Number of layers in the buffer storage" annotation(Dialog(enable=not use_advancedControl,tab="Control", group="Two position control"));
  parameter Real bandwidth "Bandwidth around reference signal" annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"));
  parameter Modelica.SIunits.Temperature Tref "Reference Temperature for the on off controller" annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"));
  parameter Boolean severalHeatcurcuits "If true, there are two or more heat curcuits" annotation(choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true), Dialog(enable=use_advancedControl, tab="Control", group="Flow temperature control"));
  parameter Modelica.SIunits.Temperature TBoiler=273.15 + 75
    "Fix boiler temperature for the admixture" annotation(Dialog(enable=use_advancedControl and severalHeatcurcuits and not variableSetTemperature_admix,tab="Control", group="Admixture control"));
  parameter Real declination=1 "Declination of curve" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));
  parameter Real day_hour=6 "Hour of day in which day mode is enabled" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));
  parameter Real night_hour=22 "Hour of night in which night mode is enabled" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));
  parameter Modelica.SIunits.ThermodynamicTemperature TOffset=0
    "Offset to heating curve temperature" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));
     parameter Boolean simpleTwoPosition "Decides if the two position control is used with or without a buffer storage; if true n=1, else n is the number of layers of the buffer storage" annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"), choices(
      choice=true "Simple Two position control",
      choice=false "With buffer storage",
      radioButtons=true));
  Modelica.Blocks.Interfaces.RealInput TLayers[n] if not use_advancedControl
     and not simpleTwoPosition                                               annotation (Placement(
        transformation(
        extent={{-17,-17},{17,17}},
        rotation=-90,
        origin={79,101}),iconTransformation(extent={{4,74},{38,108}})));
  Modelica.Blocks.Interfaces.RealInput TBoilerVar if use_advancedControl and severalHeatcurcuits
     and variableSetTemperature_admix "Variable boiler temperature for the admixture control" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,102})));
  Modelica.Blocks.Interfaces.RealInput TCon[k] if use_advancedControl and
    severalHeatcurcuits "Set temperature for the consumers" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-10,102})));
  parameter Boolean manualTimeDelay
    "If true, the user can set a time during which the heat genearator is switched on independently of the internal control" annotation(Dialog(tab="Control", group="Manual control"), choices(
      choice=true "Manual intern control",
      choice=false "Automatic intern control",
      radioButtons=true));
  parameter Modelica.SIunits.Time time_minOff=900
    "Time after which the device can be turned on again"  annotation(Dialog(tab="Control", group="Manual control"));
  parameter Modelica.SIunits.Time time_minOn=900
    "Time after which the device can be turned off again"  annotation(Dialog(tab="Control", group="Manual control"));
  parameter Boolean variableSetTemperature_admix
    "Choice between variable oder constant boiler temperature for the admixture control" annotation(Dialog(tab="Control", group="Admixture control"));
protected
  parameter Modelica.SIunits.Temperature TMinCoolingWater=354.15;
  parameter Modelica.SIunits.TemperatureDifference deltaTCoolingWater=3.47;
  parameter Modelica.SIunits.Temperature THotHeatCircuitMax=92+273.15;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominalCC=0.0641977628513021*PelNom/1000 + 0.5371814977365220;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominalHC=0.0173378319083308*PelNom/1000 + 0.1278781340675630;

   replaceable package MediumHCCC =AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat source"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));

 parameter Modelica.SIunits.Pressure dp_nominal=16*V_flow_HC^2*MediumHCCC.d_const/(2*Modelica.Constants.pi^2);
 parameter Modelica.SIunits.VolumeFlowRate V_flow_CC=m_flow_nominalCC/MediumHCCC.d_const;
 parameter Modelica.SIunits.VolumeFlowRate V_flow_HC=m_flow_nominalHC/MediumHCCC.d_const;

//  zeta=2*dp_nominal*Modelica.Constants.pi^2/(Medium.d_const*V_flow_CC^2*16),

equation

//   if fromKelvin1.Celsius > THotHeatCircuitMax or  fromKelvin2.Celsius > THotCoolingWaterMax then
//     Shutdown=true;
//   else
//      Shutdown=false;
//   end if;

///
if simpleTwoPosition then
else
end if;

  connect(hex.port_b1,THotHeatCircuit. port_a)
    annotation (Line(points={{10,-72},{58,-72}},         color={0,127,255}));
  connect(TColdHeatCircuit.port_b,hex. port_a1)
    annotation (Line(points={{-36,-72},{-10,-72}}, color={0,127,255}));

  connect(THotHeatCircuit.port_b, port_b) annotation (Line(points={{78,-72},{86,
          -72},{86,0},{100,0}}, color={0,127,255}));
  connect(cHPNotManufacturer.PowerDemand, integrator.u) annotation (Line(points={{11,-4},{60,-4},
          {60,14},{66,14}},                     color={0,0,127}));
  connect(cHPNotManufacturer.Pel, integrator1.u) annotation (Line(points={{11,8},{58,8},{58,46}},
                                            color={0,0,127}));
  connect(THotCoolingWater.port_b, hex.port_a2)
    annotation (Line(points={{16,-60},{10,-60}}, color={0,127,255}));
  connect(hex.port_b2, TColdCoolingWater.port_a)
    annotation (Line(points={{-10,-60},{-16,-60}},color={0,127,255}));
  connect(integrator.y, cHPControlBus.EnergyConsumption) annotation (Line(
        points={{89,14},{92,14},{92,100},{-60,100},{-60,102}},   color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(integrator1.y, cHPControlBus.ElectricEnergy) annotation (Line(points={{81,46},{92,46},{
          92,120},{-22,120},{-22,102},{-60,102}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(cHPNotManufacturer.THotEngine, cHPControlBus.TVolume) annotation (
      Line(points={{0,-11},{0,-28},{122,-28},{122,120},{-36,120},{-36,102},{-60,102}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fan.port_b, cHPNotManufacturer.port_a)
    annotation (Line(points={{-36,-4},{-36,0},{-10,0}}, color={0,127,255}));
  connect(fan.port_a, TColdCoolingWater.port_b) annotation (Line(points={{-36,-24},
          {-36,-60},{-32,-60}}, color={0,127,255}));
  connect(cHPNotManufacturer.port_b, THotCoolingWater.port_a)
    annotation (Line(points={{10,0},{30,0},{30,-60}}, color={0,127,255}));
  connect(bou.ports[1], fan.port_a) annotation (Line(points={{-60,-44},{-36,-44},
          {-36,-24}}, color={0,127,255}));
  connect(port_a, fan1.port_a)
    annotation (Line(points={{-100,0},{-100,-20}}, color={0,127,255}));
  connect(hydraulicResistance.port_b, TColdHeatCircuit.port_a)
    annotation (Line(points={{-68,-72},{-56,-72}}, color={0,127,255}));
  connect(hydraulicResistance.port_a, fan1.port_b) annotation (Line(points={{-88,-72},
          {-100,-72},{-100,-40}},      color={0,127,255}));
  connect(controlCHPNotManufacturerModular.mFlowRelHC, fan1.y) annotation (Line(points={{-123,-19},
          {-120,-19},{-120,-30},{-112,-30}}, color={0,0,127}));
  connect(controlCHPNotManufacturerModular.mFlowCC, fan.m_flow_in)
    annotation (Line(points={{-123,-12.8},{-48,-12.8},{-48,-14}}, color={0,0,127}));
  connect(cHPNotManufacturer.THotEngine, controlCHPNotManufacturerModular.TVolume) annotation (
      Line(points={{0,-11},{0,-28},{-72,-28},{-72,12},{-156,12},{-156,-9},{-146,-9}}, color={0,0,
          127}));
  connect(THotHeatCircuit.T, cHPControlBus.THot) annotation (Line(points={{68,-61},{68,-40},{130,
          -40},{130,120},{-60,120},{-60,102}},                      color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TColdHeatCircuit.T, cHPControlBus.TCold) annotation (Line(points={{-46,-61},{-46,-58},{
          -188,-58},{-188,120},{-60,120},{-60,102}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPControlBus.isOn, hierarchicalControl_modularCHP1.isOn) annotation (Line(
      points={{-59.9,102.1},{-22,102.1},{-22,54},{-6.2,54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TBoilerVar, hierarchicalControl_modularCHP1.TBoilerVar) annotation (Line(points={{40,102},
          {38,102},{38,34},{4,34},{4,40.4}},     color={0,0,127}));
  connect(TCon, hierarchicalControl_modularCHP1.TCon) annotation (Line(points={{-10,102},
          {-10,32},{7.4,32},{7.4,40.4}},
                                color={0,0,127}));

  connect(cHPControlBus.PLR, hierarchicalControl_modularCHP1.PLRin) annotation (Line(
      points={{-59.9,102.1},{-59.9,70},{-14,70},{-14,57.8},{-6,57.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(hierarchicalControl_modularCHP1.PLRset, regulation_ModularCHP.PLRin) annotation (Line(
        points={{14.2,58},{22,58},{22,26},{-82,26},{-82,58},{-74,58}},   color={0,0,127}));
  connect(regulation_ModularCHP.PLRset, cHPNotManufacturer.PLR) annotation (Line(points={{-54,57.6},
          {-48,57.6},{-48,58},{-38,58},{-38,6.6},{-12,6.6}}, color={0,0,127}));
  connect(regulation_ModularCHP.PLRoff, controlCHPNotManufacturerModular.PLROff) annotation (
      Line(points={{-54,51.4},{-52,51.4},{-52,18},{-180,18},{-180,-20},{-146,
          -20}},                                                                    color={255,0,
          255}));

  connect(cHPControlBus.Tamb, hierarchicalControl_modularCHP1.Tamb) annotation (
     Line(
      points={{-59.9,102.1},{-30,102.1},{-30,43},{-6,43}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPControlBus.PLREx, hierarchicalControl_modularCHP1.PLRinEx)
    annotation (Line(
      points={{-59.9,102.1},{-59.9,70},{-14,70},{-14,61},{-6,61}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cHPControlBus.internControl, hierarchicalControl_modularCHP1.internControl)
    annotation (Line(
      points={{-59.9,102.1},{-22,102.1},{-22,78},{8.2,78},{8.2,62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(THotHeatCircuit.T, hierarchicalControl_modularCHP1.TFlow) annotation (
     Line(points={{68,-61},{46,-61},{46,28},{-12,28},{-12,47},{-6,47}}, color={
          0,0,127}));
  connect(THotCoolingWater.T, hierarchicalControl_modularCHP1.Tb) annotation (
      Line(points={{23,-51.2},{23,22},{-24,22},{-24,50.4},{-6,50.4}}, color={0,
          0,127}));
  connect(hierarchicalControl_modularCHP1.shutdown, regulation_ModularCHP.shutdown)
     annotation (Line(points={{14,49.4},{24,49.4},{24,52},{32,52},{32,14},{-78,
          14},{-78,51.4},{-74,51.4}}, color={255,0,255}));

   if simpleTwoPosition then
  connect(THotHeatCircuit.T, hierarchicalControl_modularCHP1.TLayers[1])
    annotation (Line(points={{68,-61},{68,-14},{50,-14},{50,70},{4.4,70},{4.4,
            62}},
        color={0,0,127})); else
  connect(TLayers, hierarchicalControl_modularCHP1.TLayers) annotation (Line(
        points={{79,101},{79,76},{4.4,76},{4.4,62}}, color={0,0,127}));
   end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1000,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Model of a CHP-module with an inner cooling circuit and a control unit. Heat circuit and cooling circuit are connected with a heat exchanger. Further informations are given in the submodel discribtion.</p>
<h4>Temperature Control</h4>
<p>This module has an integrated control model that contains three different variants of control for heat generators:</p>
<ul>
<li>Two position control: Flow temperature of the boiler is controlled by an On-Off-Controller with hysteresis.</li>
<li>Ambient guided flow temperature control: Variable flow temperature of boiler which is determined by a heating curve as a function of the ambient temperature.</li>
<li>Admixture control: Fix flow temperature of boiler which is set by the user. The flow temperature to the consumer is also set by the user and is controlled to the set temperature by a valve.</li>
</ul>
<p>The control model is build up hierarchically. The emergency swith precedes all types of regulation. Furthermore, the user has possibility to use an extern control which outpus has to be the PLR (partial load ratio). It is also possible to set a minimum running time for the heat generator, during which it runs continuously and can only be switched off by the emergency stop switch. Further Information on the individual parameters at <a href=\"ControlUnity.hierarchicalControl_modular\">HierarchicalControl</a>. 
</html>"));
end ModularCHP;
