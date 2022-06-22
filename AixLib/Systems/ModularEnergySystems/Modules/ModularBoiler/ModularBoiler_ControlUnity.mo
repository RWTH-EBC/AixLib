within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler_ControlUnity
  extends
    AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.BaseClasses.Base_ModBoiler(
  redeclare package Medium=Media.Water);

  parameter Boolean use_advancedControl
    "Selection between two position control and flow temperature control, if true=flow temperature control is active" annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Two position control",
      radioButtons=true));

  parameter Boolean severalHeatcurcuits
    "If true, there are two or more heat curcuits" annotation(Dialog(enable=use_advancedControl, group="Flow temperature control"), choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true));

  parameter Boolean simpleTwoPosition "Decides if the two position control is used with or without a buffer storage; if true n=1, else n is the number of layers of the buffer storage" annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"), choices(
      choice=true "Simple Two position control",
      choice=false "With buffer storage",
      radioButtons=true));

  parameter Boolean manualTimeDelay
    "If true, the user can set a time during which the heat genearator is switched on independently of the internal control" annotation(Dialog(tab="Control", group="Manual control"), choices(
      choice=true "Manual control with time delay",
      choice=false "Automatic intern control",
      radioButtons=true));

  parameter Boolean variablePLR
    "If true, the user can determine the PLR between PLRmin and 1; else you have a two position conttol with the values 0 and 1 for PLR";

  parameter Boolean variableSetTemperature_admix
    "Choice between variable oder constant boiler temperature for the admixture control; if true the boiler temperature can be set from the outside via interface " annotation(Dialog(tab="Control", group="Admixture control"), choices(
      choice=true "Variable set boiler temperature",
      choice=false "Constant set boiler temperature",
      radioButtons=true));

  parameter Boolean TVar
    "Choice between variable oder constant boiler temperature for the admixture control" annotation(Dialog(tab="Control", group="Admixture control"), choices(
      choice=true "Variable boiler temperature",
      choice=false "Constant boiler temperature",
      radioButtons=true));

  parameter Real k_ControlBoilerValve(min=Modelica.Constants.small)=1 "Gain of controller"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));

  parameter Modelica.SIunits.Time Ti_ControlBoilerValve(min=Modelica.Constants.small)=1 "Time constant of Integrator block"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));

  parameter Modelica.SIunits.Time time_minOff=900
    "Time after which the device can be turned on again" annotation(Dialog(tab="Control", group="Manual control"));

  parameter Modelica.SIunits.Time time_minOn=900
    "Time after which the device can be turned off again" annotation(Dialog(tab="Control", group="Manual control"));

  parameter Modelica.SIunits.Temperature TBoiler=273.15 + 75
    "Fix boiler temperature for the admixture" annotation(Dialog(enable=use_advancedControl and severalHeatcurcuits and not TVar,tab="Control", group="Admixture control"));

  parameter Modelica.SIunits.Temperature Tref
    "Reference Temperature for the on off controller"
                                                     annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"));

  parameter Modelica.SIunits.ThermodynamicTemperature TOffset=0
    "Offset to heating curve temperature" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));

  parameter Modelica.SIunits.Temperature TMax=273.15 + 105
    "Maximum temperature, at which the system is shut down" annotation(Dialog(tab="Control", group="Security-related systems"));

  replaceable model TwoPositionController_top =
      Control.TwoPositionController.BaseClasses.partialTwoPositionController
    constrainedby
    Control.TwoPositionController.BaseClasses.partialTwoPositionController annotation(choicesAllMatching=true, Dialog(tab="Control", group="Two position control"));

  parameter Integer n = if simpleTwoPosition then 1 else n "Number of layers in the buffer storage" annotation(Dialog(enable=not use_advancedControl,tab="Control", group="Two position control"));

  parameter Integer k=3 "Number of heat curcuits"  annotation(Dialog(enable=use_advancedControl and severalHeatcurcuits, tab="Control", group="Admixture control"));

  parameter Real bandwidth=2.5 "Bandwidth around reference signal" annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"));

  parameter Real declination=1 "Declination of curve" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));

  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";

  parameter Real day_hour=6 "Hour of day in which day mode is enabled" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));

  parameter Real night_hour=22 "Hour of night in which night mode is enabled" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));

  AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{-70,88},{-50,108}})));

  AixLib.Systems.ModularEnergySystems.Controls.ControlBoilerNotManufacturer
  controlBoilerNotManufacturer(
    DeltaTWaterNom=dTWaterNom,
    QNom=QNom,
    m_flowVar=m_flowVar,
    Advanced=Advanced,
    dTWaterSet=dTWaterSet)
    annotation (Placement(transformation(extent={{-80,44},{-64,60}})));

  Control.Regulation_ModularBoiler regulation_modularBoiler(use_advancedControl=
        use_advancedControl, severalHeatcurcuits=severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-56,52},{-40,68}})));

  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{74,-38},{86,-26}})));

  Modelica.Blocks.Continuous.LimPID PIValve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlBoilerValve,
    Ti=Ti_ControlBoilerValve,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.5) if hasFeedback
               annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-76,24})));
  Modelica.Blocks.Sources.RealExpression TSet_Cold(y=TColdNom) if hasFeedback
    annotation (Placement(transformation(extent={{-100,18},{-90,38}})));

  Control.HierarchicalControl hierarchicalControl(
    PLRMin=PLRMin,
    use_advancedControl=use_advancedControl,
    manualTimeDelay=manualTimeDelay,
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
    TMax=TMax,
    redeclare replaceable model TwoPositionController_top =
        TwoPositionController_top,
    time_minOff=time_minOff,
    time_minOn=time_minOn,
    variableSetTemperature_admix=variableSetTemperature_admix)
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));

  Modelica.Blocks.Interfaces.RealInput TCon[k] if use_advancedControl and
    severalHeatcurcuits "Set temperature for the consumers" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-10,100})));

  Modelica.Blocks.Interfaces.RealInput TBoilerVar if use_advancedControl and severalHeatcurcuits
     and TVar "Variable boiler temperature for the admixture control" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={20,100})));

  Modelica.Blocks.Interfaces.RealInput TLayers[n] if not use_advancedControl
     and not simpleTwoPosition                                               annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={50,100}),iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={50,100})));
  Modelica.Blocks.Interfaces.RealOutput valPos[k] if use_advancedControl and
    severalHeatcurcuits "Valve position for the admixture"
    annotation (Placement(transformation(extent={{94,50},{114,70}})));
  Modelica.Blocks.Interfaces.RealInput TMeaCon[k] if use_advancedControl and
    severalHeatcurcuits "Measurement temperature of the consumers"
    annotation (Placement(transformation(extent={{112,30},{92,50}}),
        iconTransformation(extent={{112,30},{92,50}})));

equation
  connect(controlBoilerNotManufacturer.DeltaTWater_b, heatGeneratorNoControl.dTWater)
    annotation (Line(points={{-63.2,47.84},{-62,47.84},{-62,48},{-60,48},{-60,42},
          {-16,42},{-16,8},{-10,8},{-10,9}},
        color={0,0,127}));
  connect(controlBoilerNotManufacturer.mFlowRel, regulation_modularBoiler.mFlow_rel)
    annotation (Line(points={{-63.2,58.4},{-56,58.4}},                   color={
          0,0,127}));
  connect(senTCold.T, controlBoilerNotManufacturer.TCold) annotation (Line(
        points={{-60,11},{-60,36},{-88,36},{-88,54.4},{-81.6,54.4}}, color={0,0,
          127}));
  connect(controlBoilerNotManufacturer.THot, heatGeneratorNoControl.TVolume)
    annotation (Line(points={{-81.6,52},{-86,52},{-86,38},{-22,38},{-22,-18},{2,
          -18},{2,-11}}, color={0,0,127}));
  connect(heatGeneratorNoControl.PowerDemand, integrator1.u) annotation (Line(
        points={{13,-7},{44,-7},{44,-32},{72.8,-32}}, color={0,0,127}));
  connect(regulation_modularBoiler.mFlow_relB, fan.y) annotation (Line(points={{-39.84,
          60},{-36,60},{-36,12}},                         color={0,0,127}));
  connect(PIValve.y, val.y)
    annotation (Line(points={{-82.6,24},{-84,24},{-84,12}}, color={0,0,127}));
  connect(PIValve.u_m, senTCold.T) annotation (Line(points={{-76,16.8},{-76,14},
          {-60,14},{-60,11}}, color={0,0,127}));
  connect(TSet_Cold.y, PIValve.u_s) annotation (Line(points={{-89.5,28},{-84,28},
          {-84,34},{-66,34},{-66,24},{-68.8,24}}, color={0,0,127}));
  connect(regulation_modularBoiler.PLRset, hierarchicalControl.PLRin)
    annotation (Line(points={{-39.84,63.2},{-40,63.2},{-40,64},{-36,64},{-36,68},
          {-10,68}}, color={0,0,127}));
  connect(regulation_modularBoiler.PLRMea, hierarchicalControl.PLRset)
    annotation (Line(points={{-56,55.2},{-58,55.2},{-58,44},{18,44},{18,68},{10,
          68}},                 color={0,0,127}));
  connect(hierarchicalControl.PLRset, heatGeneratorNoControl.PLR) annotation (
      Line(points={{10,68},{18,68},{18,44},{-14,44},{-14,5.4},{-10,5.4}}, color=
         {0,0,127}));
  connect(TCon, hierarchicalControl.TCon) annotation (Line(points={{-10,100},{-10,
          80},{-20,80},{-20,46},{3,46},{3,52}}, color={0,0,127}));
  connect(TBoilerVar, hierarchicalControl.TBoilerVar) annotation (Line(points={{20,100},
          {20,78},{-18,78},{-18,52},{0,52}},                color={0,0,127}));
  if simpleTwoPosition then
    connect(senTHot.T, hierarchicalControl.TLayers[1])
    annotation (Line(points={{60,11},{60,76},{0,76},{0,72}},       color={0,0,127}));
  else
    connect(TLayers, hierarchicalControl.TLayers) annotation (
      Line(points={{50,100},{50,76},{0,76},{0,72}},      color={0,0,127}));
  end if;

  connect(senTHot.T, hierarchicalControl.Tb) annotation (Line(points={{60,11},{60,
          40},{-10,40},{-10,50},{-16,50},{-16,59},{-10,59}},
                                  color={0,0,127}));
  connect(hierarchicalControl.valPos, valPos) annotation (Line(points={{10,56},{
          80,56},{80,60},{104,60}},color={0,0,127}));
  connect(TMeaCon, hierarchicalControl.TMeaCon) annotation (Line(points={{102,40},
          {80,40},{80,46},{6,46},{6,52}}, color={0,0,127}));
  connect(boilerControlBus.DeltaTWater, controlBoilerNotManufacturer.DeltaTWater_a)
    annotation (Line(
      points={{-59.95,98.05},{-90,98.05},{-90,50},{-82,50},{-82,49.6},{-81.6,49.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));

  connect(boilerControlBus.PLR, regulation_modularBoiler.PLRin) annotation (
      Line(
      points={{-59.95,98.05},{-59.95,61.6},{-56,61.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(regulation_modularBoiler.mFlow_relB, boilerControlBus.mFlow_relB) annotation (Line(
        points={{-39.84,60},{-34,60},{-34,80},{-60,80},{-60,98}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.internControl, hierarchicalControl.internControl)
    annotation (Line(
      points={{-60,98},{-28,98},{-28,92},{4,92},{4,72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.isOn, hierarchicalControl.isOn) annotation (Line(
      points={{-59.95,98.05},{-28,98.05},{-28,92},{-22,92},{-22,65},{-10,65}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.Tamb, hierarchicalControl.Tamb) annotation (Line(
      points={{-60,98},{-28,98},{-28,92},{-22,92},{-22,56},{-10,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PLREx, hierarchicalControl.PLRinEx) annotation (Line(
      points={{-60,98},{-28,98},{-28,92},{-22,92},{-22,71},{-10,71}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator1.y, boilerControlBus.EnergyDemand) annotation (Line(points=
         {{86.6,-32},{120,-32},{120,120},{-60,120},{-60,98.05},{-59.95,98.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularBoiler_ControlUnity;
