within AixLib.Systems.ModularEnergySystems.ControlUnity.Modules;
model ModularBoiler_AdmixNoArray
  extends AixLib.Fluid.Interfaces.PartialModularPort_b(
  redeclare package Medium = AixLib.Media.Water,
  final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    nPorts=nPorts,
  dp_nominal=dp_nominal_calc);

  // extends AixLib.Fluid.Interfaces.PartialModularPort_b(
  // redeclare package Medium = AixLib.Media.Water,
  // final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
  // final nPorts=k,
  // dp_start=0,
  // m_flow_start=0,
  // dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2,
  //   port_a(p(start=Medium.p_default)),
  //   ports_b(p(start=Medium.p_default)));

  parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.Temperature TColdNom=273.15 + 35
                                                            "Return temperature TCold"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Thermal dimension power"
   annotation (Dialog(group="Nominal condition"));
  parameter Boolean m_flowVar=false "Use variable water massflow"
  annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));

  parameter Boolean Pump=true "Model includes a pump"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true));

  parameter Boolean Advanced=false "dTWater is constant for different PLR"
  annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));

  parameter Modelica.SIunits.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
   annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));

  parameter Modelica.SIunits.Temperature THotMax=378.15      "Maximal temperature to force shutdown" annotation(Dialog(tab="Control", group="Security-related systems"));
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";

  parameter Modelica.SIunits.Temperature TStart=273.15 + 20
                                                          "T start"
   annotation (Dialog(tab="Advanced"));

//    parameter Modelica.SIunits.PressureDifference dp_start=0
//      "Guess value of dp = port_a.p - port_b.p"
//      annotation (Dialog(tab="Advanced", group="Initialization"));
//    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
//      "Guess value of m_flow = port_a.m_flow"
//      annotation (Dialog(tab="Advanced", group="Initialization"));
   parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
     "Start value of pressure"
     annotation (Dialog(tab="Advanced", group="Initialization"));

  AixLib.Fluid.BoilerCHP.BoilerNotManufacturer heatGeneratorNoControl(
    T_start=TStart,
    dTWaterSet=dTWaterSet,
    QNom=QNom,
    PLRMin=PLRMin,
    redeclare package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    dTWaterNom=dTWaterNom,
    TColdNom=TColdNom,
    m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTHot(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,0})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTCold(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-72,0})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{80,-42},{92,-30}})));

  AixLib.Systems.ModularEnergySystems.Controls.ControlBoilerNotManufacturer controlBoilerNotManufacturer(
    DeltaTWaterNom=dTWaterNom,
    QNom=QNom,
    m_flowVar=m_flowVar,
    Advanced=Advanced,
    dTWaterSet=dTWaterSet)
    annotation (Placement(transformation(extent={{-100,36},{-80,56}})));
  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,V_flow_nominal,2*V_flow_nominal}, dp={dp_nominal/0.8,
            dp_nominal,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
  AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{-74,88},{-54,108}})));

     //
    ///Control unity

  Regulation_modularBoiler regulation_modularBoiler(use_advancedControl=use_advancedControl)
    annotation (Placement(transformation(extent={{-62,46},{-42,66}})));
  parameter Integer n= if simpleTwoPosition then 1 else n "Number of layers in the buffer storage" annotation(Dialog(tab="Control", group="Two position control"));
  parameter Boolean simpleTwoPosition = false annotation(Dialog(tab="Control", group="Two position control"));
  parameter Boolean use_advancedControl = true
    "Selection between two position control and flow temperature control, if true=flow temperature control is active"
                                                                                                                     annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Two position control",
      radioButtons=true), Dialog(tab="Control", group="Parameters"));

   ///Control unity
   //
  parameter Modelica.SIunits.Temperature Tref
    "Reference Temperature for the on off controller"
                                                     annotation(Dialog(tab="Control", group="Two position control"));
  parameter Real bandwidth=2.5 "Bandwidth around reference signal" annotation(Dialog(tab="Control", group="Two position control"));
  Modelica.Blocks.Interfaces.RealInput TLayers[n] if not use_advancedControl
     and not simpleTwoPosition                                               annotation (Placement(
        transformation(
        extent={{-17,-17},{17,17}},
        rotation=-90,
        origin={53,99}), iconTransformation(extent={{4,74},{38,108}})));
  //parameter Integer k=2 "Number of heat curcuits"  annotation(Dialog(tab="Control", group="Admixture control"));
  parameter Modelica.SIunits.Temperature TBoiler=273.15 + 75
    "Fix boiler temperature for the admixture" annotation(Dialog(tab="Control", group="Admixture control"));
  parameter Boolean severalHeatcurcuits = true
    "If true, there are two or more heat curcuits"
                                                  annotation(choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true), Dialog(tab="Control", group="Flow temperature control"));
  Modelica.Blocks.Interfaces.RealInput TCon[nPorts] if use_advancedControl and
    severalHeatcurcuits "Set temperature for the consumers" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-8,100})));
  parameter Real declination=1 annotation(Dialog(tab="Control", group="Flow temperature control"));
  parameter Real day_hour=6 annotation(Dialog(tab="Control", group="Flow temperature control"));
  parameter Real night_hour=22 annotation(Dialog(tab="Control", group="Flow temperature control"));
  flowTemperatureController.renturnAdmixture.Admixture admixture(
    redeclare package Medium = Medium,
    each k=nPorts,
    m_flow_nominalCon=m_flow_nominalCon,
    dp_nominalCon=dp_nominalCon,
    QNomCon=QNomCon,
    each energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    each Kv=10) if use_advancedControl and severalHeatcurcuits annotation (
      Placement(transformation(
        extent={{-16,-14},{16,14}},
        rotation=0,
        origin={18,-66})));

  parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition parameterPipe=
      AixLib.DataBase.Pipes.Copper.Copper_6x1()
    "Pipe type and diameter (can be overwritten in each pipe)";
  parameter AixLib.DataBase.Pipes.InsulationBaseDataDefinition parameterIso=
      AixLib.DataBase.Pipes.Insulation.Iso50pc()
    "Insulation Type (can be overwritten in each pipe)";
  flowTemperatureController.renturnAdmixture.AdmixtureBus admixtureBus
    annotation (Placement(transformation(extent={{74,-92},{94,-72}})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominalCon
    "Nominal mass flow rate for the individual consumers" annotation(Dialog(tab="Advanced", group="Nominal conditions consumer"));

  parameter Modelica.SIunits.PressureDifference dp_nominalCon
    "Pressure drop at nominal conditions for the individual consumers" annotation(Dialog(tab="Advanced", group="Nominal conditions consumer"));
  parameter Modelica.SIunits.HeatFlowRate QNomCon "Nominal heat power that the consumers need" annotation(Dialog(tab="Advanced", group="Nominal conditions consumer"));
  parameter Boolean TVar = true
    "Choice between variable oder constant boiler temperature for the admixture control";
  Modelica.Blocks.Interfaces.RealInput TBoilerVar if use_advancedControl and severalHeatcurcuits
     and TVar "Variable boiler temperature for the admixture control" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={24,102})));
protected
   parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const annotation(Dialog(tab="Advanced", group="Nominal conditions consumer"));
  parameter Modelica.SIunits.PressureDifference dp_nominal_calc=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
   replaceable package MediumBoiler =AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat source"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));

equation
  if Pump==false then
  else
  end if;

  ///Connections of Two position controller
 if simpleTwoPosition then
  connect(senTHot.T, hierarchicalControl_modularBoilerNEW1.TLayers[1])
    annotation (Line(points={{60,11},{60,66},{10.4,66},{10.4,60}}, color={0,0,127}));
    else
  connect(TLayers, hierarchicalControl_modularBoilerNEW1.TLayers) annotation (
      Line(points={{53,99},{53,80},{10.4,80},{10.4,60}}, color={0,0,127}));
   end if;
   ///
  connect(senTHot.port_a, heatGeneratorNoControl.port_b)
    annotation (Line(points={{50,0},{-2,0}}, color={0,127,255}));
  connect(heatGeneratorNoControl.PowerDemand, integrator1.u) annotation (Line(
        points={{-1,-7},{30,-7},{30,-36},{78.8,-36}},
                                                   color={0,0,127}));

  connect(fan1.port_b, heatGeneratorNoControl.port_a)
    annotation (Line(points={{-32,0},{-22,0}},color={0,127,255}));
  connect(senTCold.port_b, fan1.port_a)
    annotation (Line(points={{-62,0},{-52,0}}, color={0,127,255}));
  connect(controlBoilerNotManufacturer.DeltaTWater_b, heatGeneratorNoControl.dTWater)
    annotation (Line(points={{-79,40.8},{-70,40.8},{-70,16},{-34,16},{-34,9},{-24,9}},
                   color={0,0,127}));

  connect(senTCold.T, controlBoilerNotManufacturer.TCold) annotation (Line(
        points={{-72,11},{-72,26},{-114,26},{-114,49},{-102,49}}, color={0,0,127}));
  connect(heatGeneratorNoControl.TVolume, controlBoilerNotManufacturer.THot)
    annotation (Line(points={{-12,-11},{-12,-26},{-110,-26},{-110,46},{-102,46}},
        color={0,0,127}));
  connect(boilerControlBus.DeltaTWater, controlBoilerNotManufacturer.DeltaTWater_a)
    annotation (Line(
      points={{-63.95,98.05},{-63.95,92},{-106,92},{-106,43},{-102,43}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator1.y, boilerControlBus.EnergyDemand) annotation (Line(points={{92.6,
          -36},{110,-36},{110,106},{-63.95,106},{-63.95,98.05}},      color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.PLR, regulation_modularBoiler.PLRin) annotation (
      Line(
      points={{-63.95,98.05},{-63.95,92},{-74,92},{-74,59},{-62,59}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(controlBoilerNotManufacturer.mFlowRel, regulation_modularBoiler.mFlow_rel)
    annotation (Line(points={{-79,54},{-74,54},{-74,54.2},{-62,54.2}}, color={0,
          0,127}));
  connect(regulation_modularBoiler.mFlow_relB, fan1.y) annotation (Line(points={{-41.8,
          55},{-34,55},{-34,20},{-42,20},{-42,12}},        color={0,0,127}));
  connect(boilerControlBus.isOn, hierarchicalControl_modularBoilerNEW1.isOn)
    annotation (Line(
      points={{-63.95,98.05},{-34,98.05},{-34,92},{-26,92},{-26,52},{-0.2,52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(regulation_modularBoiler.PLRset,
    hierarchicalControl_modularBoilerNEW1.PLRin) annotation (Line(points={{-42,59.6},
          {-20,59.6},{-20,55.8},{0,55.8}},       color={0,0,127}));
  connect(senTHot.T, hierarchicalControl_modularBoilerNEW1.Tb) annotation (Line(
        points={{60,11},{56,11},{56,72},{-4,72},{-4,46.8},{0,46.8}},    color={0,
          0,127}));
  connect(hierarchicalControl_modularBoilerNEW1.PLRset, heatGeneratorNoControl.PLR)
    annotation (Line(points={{20.2,56},{30,56},{30,16},{-30,16},{-30,5.4},{-24,5.4}},
                 color={0,0,127}));
  connect(hierarchicalControl_modularBoilerNEW1.PLRset,
    regulation_modularBoiler.PLRMea) annotation (Line(points={{20.2,56},{30,56},
          {30,32},{-68,32},{-68,49.4},{-62,49.4}},color={0,0,127}));

  connect(boilerControlBus.Tamb, hierarchicalControl_modularBoilerNEW1.Tamb)
    annotation (Line(
      points={{-64,98},{-38,98},{-38,82},{-30,82},{-30,42.2},{0,42.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TCon, hierarchicalControl_modularBoilerNEW1.TCon) annotation (Line(
        points={{-8,100},{-8,34},{13.4,34},{13.4,38.4}}, color={0,0,127}));

    ///Admixture

  connect(admixture.port_b1, ports_b[1]) annotation (Line(points={{34,-57.6},{54,
          -57.6},{54,-58},{76,-58},{76,0},{100,0}}, color={0,127,255}));
  connect(admixture.port_b2, port_a) annotation (Line(
      points={{2,-74.4},{-100,-74.4},{-100,0}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(TBoilerVar, hierarchicalControl_modularBoilerNEW1.TBoilerVar)
    annotation (Line(points={{24,102},{24,28},{10,28},{10,38.4}}, color={0,0,127}));
  connect(senTCold.port_a, admixture.port_a2) annotation (Line(
      points={{-82,0},{-82,-98},{52,-98},{52,-74.4},{34,-74.4}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(senTHot.port_b, admixture.port_a1) annotation (Line(
      points={{70,0},{70,-38},{-12,-38},{-12,-57.6},{2,-57.6}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(hierarchicalControl_modularBoilerNEW1.valPos[1], admixtureBus.valveSet)
    annotation (Line(points={{20,43.4},{48,43.4},{48,38},{62,38},{62,-72},{84.05,
          -72},{84.05,-81.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(admixtureBus, admixture.admixtureBus) annotation (Line(
      points={{84,-82},{72,-82},{72,-80},{38,-80},{38,-38},{18,-38},{18,-52.7}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(hierarchicalControl_modularBoilerNEW1.TMeaCon[1], admixtureBus.Tsen_b1)
    annotation (Line(points={{19,38.4},{19,-32},{58,-32},{58,-68},{84.05,-68},{84.05,
          -81.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.internControl, hierarchicalControl_modularBoilerNEW1.internControl)
    annotation (Line(
      points={{-63.95,98.05},{-60,98.05},{-60,78},{14.2,78},{14.2,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PLREx, hierarchicalControl_modularBoilerNEW1.PLRinEx)
    annotation (Line(
      points={{-63.95,98.05},{-32,98.05},{-32,59},{0,59}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),
        Polygon(
          points={{-18.5,-23.5},{-26.5,-7.5},{-4.5,36.5},{3.5,10.5},{25.5,14.5},
              {15.5,-27.5},{-2.5,-23.5},{-8.5,-23.5},{-18.5,-23.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-16.5,-21.5},{-6.5,-1.5},{19.5,-21.5},{-6.5,-21.5},{-16.5,-21.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26.5,-21.5},{27.5,-29.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>A boiler model consisting of physical components. The user has the choice to run the model for three different setpoint options:</p>
<ol>
<li>Setpoint depends on part load ratio (water mass flow=dimension water mass flow; advanced=false &amp; m_flowVar=false)</li>
<li>Setpoint depends on part load ratio and a constant water temperature difference which is idependent from part load ratio (water mass flow is variable; advanced=false &amp; m_flowVar=true)</li>
<li>Setpoint depends on part load ratio an a variable water temperature difference (water mass flow is variable; advanced=true)</li>
</ol>
</html>"),
    experiment(StopTime=10));
end ModularBoiler_AdmixNoArray;
