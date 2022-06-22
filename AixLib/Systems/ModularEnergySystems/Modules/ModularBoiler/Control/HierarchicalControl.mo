within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control;
model HierarchicalControl

  ///Hierarchy Control
  parameter Real PLRMin=0.15;
  parameter Boolean use_advancedControl      "Selection between two position control and flow temperature control, if true=flow temperature control is active"
                                                                                                                                                              annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Two position control",
      radioButtons=true));
   parameter Boolean manualTimeDelay "If true, the user can set a time during which the heat genearator is switched on independently of the internal control";

  Modelica.Blocks.Interfaces.RealInput Tb "Boiler temperature"
    annotation (Placement(transformation(extent={{-120,-50},{-80,-10}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{90,50},{110,70}})));

  Modelica.Blocks.Interfaces.RealInput PLRin if not use_advancedControl or (
    use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));

  AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.HierarchicalControl_ModularBoiler.EmergencySwitch
    emergencySwitch_modularBoiler1(TMax=TMax)
    annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
 //Two position controller
 replaceable model TwoPositionController_top =
      TwoPositionController.BaseClasses.partialTwoPositionController
 constrainedby TwoPositionController.BaseClasses.partialTwoPositionController(
                                                                   Tref=Tref, bandwidth=bandwidth, n=n) annotation(choicesAllMatching=true);

  Modelica.Blocks.Interfaces.RealInput TLayers[n]
    "Different temperatures of layers of buffer storage, 1 lowest layer and n top layer; if simple two position controller, then it is equal to Tin"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));

  parameter Integer n=3 "Number of layers in the buffer storage" annotation(Dialog(
        group="Two position controller"));

  parameter Real bandwidth "Bandwidth around reference signal" annotation(Dialog(
        group="Two position controller"));
   //////
   //////
   //////

  //Flow temperature control

    Modelica.Blocks.Interfaces.RealInput Tamb if use_advancedControl and not
    severalHeatcurcuits
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));

  Modelica.Blocks.Interfaces.RealOutput valPos[k] if use_advancedControl and severalHeatcurcuits
    "Valve position to control the three-way valve"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  parameter Boolean severalHeatcurcuits "If true, there are two or more heat curcuits" annotation(Dialog(enable=use_advancedControl, group="Flow temperature control"), choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true));

  //Flow temperature control

  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));

  parameter Boolean variablePLR
    "If true, the user can determine the PLR between PLRmin and 1; else you have a two position conttol with the values 0 and 1 for PLR";

  parameter Integer k "Number of heat curcuits" annotation(Dialog(group="Admixture control"));
  Modelica.Blocks.Interfaces.RealInput TMeaCon[k] if use_advancedControl and
    severalHeatcurcuits
    "Measurement temperature of the consumer" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-100})));
  parameter Modelica.SIunits.Temperature TBoiler=273.15 + 75
    "Fix boiler temperature for the admixture"
                                              annotation(Dialog(
        group="Admixture control"));
  parameter Modelica.SIunits.Temperature Tref
    "Reference Temperature for the on off controller"
                                                     annotation(Dialog(
        group="Two position controller"));

  Modelica.Blocks.Interfaces.RealInput TCon[k] if use_advancedControl and
    severalHeatcurcuits "Set temperature for the consumers" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={30,-100})));
  parameter Real declination=1 "Declination of curve" annotation(Dialog(group="Flow temperature control"));
  parameter Real day_hour=6 "Hour of day in which day mode is enabled" annotation(Dialog(group="Flow temperature control"));
  parameter Real night_hour=22 "Hour of night in which night mode is enabled" annotation (Dialog(group="Flow temperature control"));
  parameter Modelica.SIunits.ThermodynamicTemperature TOffset(displayUnit="K") = 0
    "Offset to heating curve temperature" annotation(Dialog(group="Flow temperature control"));
  parameter Modelica.SIunits.Temperature TMax=273.15 + 105
    "Maximum temperature, at which the system is shut down" annotation(Dialog(group="Security-related systems"));

  Modelica.Blocks.Interfaces.RealInput TBoilerVar if use_advancedControl and severalHeatcurcuits
     and variableSetTemperature_admix "Variable boiler temperature for the admixture control" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Interfaces.RealInput PLRinEx
    "Set PLR from the extern control"
    annotation (Placement(transformation(extent={{-120,70},{-80,110}})));
  Modelica.Blocks.Interfaces.BooleanInput internControl
    "Choice between intern and extern control" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,100})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{66,-2},{86,18}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-7,-8},{7,8}},
        rotation=90,
        origin={60,-19})));

  HierarchicalControl_ModularBoiler.InternalControl internalControl(
    PLRMin=PLRMin,
    use_advancedControl=use_advancedControl,
    severalHeatcurcuits=severalHeatcurcuits,
    Tref=Tref,
    n=n,
    bandwidth=bandwidth,
    declination=declination,
    day_hour=day_hour,
    night_hour=night_hour,
    TOffset=TOffset,
    variableSetTemperature_admix=variableSetTemperature_admix)
    annotation (Placement(transformation(extent={{-22,14},{-2,34}})));
  parameter Modelica.SIunits.Time time_minOff=900
    "Time after which the device can be turned on again" annotation(Dialog(group="Manual control"));
  parameter Modelica.SIunits.Time time_minOn=900
    "Time after which the device can be turned off again" annotation(Dialog(group="Manual control"));
  parameter Boolean variableSetTemperature_admix
    "Choice between variable oder constant boiler temperature for the admixture control" annotation(Dialog(group="Admixture control"));
  HierarchicalControl_ModularBoiler.ManualControl manualControl(
    manualTimeDelay=manualTimeDelay,
    time_minOff=time_minOff,
    time_minOn=time_minOn)
    annotation (Placement(transformation(extent={{24,20},{44,40}})));
equation

/// unconditioned quantities

  connect(PLRinEx, switch1.u3) annotation (Line(points={{-100,90},{-26,90},{-26,
          52},{58,52}},                 color={0,0,127}));
  connect(internControl, switch1.u2)
    annotation (Line(points={{40,100},{40,60},{58,60}}, color={255,0,255}));
  connect(switch2.y, PLRset) annotation (Line(points={{87,8},{88,8},{88,60},{
          100,60}},                 color={0,0,127}));
  connect(switch2.u3, realExpression.y)
    annotation (Line(points={{64,0},{60,0},{60,-11.3}},      color={0,0,127}));
  connect(switch1.y, switch2.u1) annotation (Line(points={{81,60},{82,60},{82,
          40},{60,40},{60,16},{64,16}}, color={0,0,127}));
  connect(emergencySwitch_modularBoiler1.y, switch2.u2) annotation (Line(points={{-43.6,
          40},{-38,40},{-38,8},{64,8}},          color={255,0,255}));
  connect(isOn, emergencySwitch_modularBoiler1.isOn) annotation (Line(points={{-100,30},
          {-76,30},{-76,47.4},{-64,47.4}},                       color={255,0,255}));
  connect(Tb, emergencySwitch_modularBoiler1.TBoiler) annotation (Line(points={{-100,
          -30},{-72,-30},{-72,33.8},{-64,33.8}},                          color=
         {0,0,127}));
  connect(TLayers, internalControl.TLayers) annotation (Line(points={{0,100},{0,
          60},{-12,60},{-12,34}},   color={0,0,127}));
  connect(Tb, internalControl.Tflow) annotation (Line(points={{-100,-30},{-60,
          -30},{-60,22},{-22,22}},                    color={0,0,127}));
  connect(TMeaCon, internalControl.TMeaCon) annotation (Line(points={{60,-100},
          {60,-70},{-6,-70},{-6,13.8}},    color={0,0,127}));
  connect(TCon, internalControl.TCon) annotation (Line(points={{30,-100},{30,
          -74},{-9,-74},{-9,13.8}},color={0,0,127}));
  connect(TBoilerVar, internalControl.TBoilerVar) annotation (Line(points={{0,-100},
          {0,-78},{-12,-78},{-12,13.8}},                     color={0,0,127}));
  connect(internalControl.valPos, valPos) annotation (Line(points={{-1.6,18},{
          50,18},{50,-60},{100,-60}},   color={0,0,127}));
  connect(emergencySwitch_modularBoiler1.y, manualControl.isOn) annotation (
      Line(points={{-43.6,40},{12,40},{12,30},{24,30}}, color={255,0,255}));
  connect(internalControl.PLRset, manualControl.PLR) annotation (Line(points={{-1.6,28},
          {16,28},{16,37.6},{23.8,37.6}},                       color={0,0,127}));
  connect(PLRin, internalControl.PLRin) annotation (Line(points={{-100,60},{-32,
          60},{-32,30},{-22,30}}, color={0,0,127}));
  connect(Tamb, internalControl.Tamb) annotation (Line(points={{-100,-60},{-32,
          -60},{-32,18},{-22,18}},color={0,0,127}));
  connect(manualControl.PLRset, switch1.u1) annotation (Line(points={{44,36.8},
          {50,36.8},{50,68},{58,68}},                color={0,0,127}));
  connect(emergencySwitch_modularBoiler1.y, internalControl.isOn) annotation (
      Line(points={{-43.6,40},{-38,40},{-38,26},{-22,26}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>Model that contains the three different variants of control for heat generators:</p>
<ul>
<li>Two position control: Flow temperature of the boiler is controlled by an On-Off-Controller with hysteresis.</li>
<li>Ambient guided flow temperature control: Variable flow temperature of boiler which is determined by a heating curve as a function of the ambient temperature.</li>
<li>Admixture control: Fix flow temperature of boiler which is set by the user. The flow temperature to the consumer is also set by the user and is controlled to the set temperature by a valve.</li>
</ul>
<p>The control model is build up hierarchically. The emergency swith precedes all types of regulation. </p>
<h4>Important parameters</h4>
<ul>
<li>use_advancedControl: The user can select between two position control or flow temperature control.</li>
<li>severalHeatcurcuits: The user can select between ambient guided flow temperature control or admixture control.</li>
<li>n: Indicates the number of layers of the buffer storage.</li>
<li>k: Indicates the number of heat curcuits for the different consumers.</li>
<li>TBoiler: The user sets the fix flow temperature of the boiler before the simulation.</li>
<li>Tref: Set temperature for the two position controller.</li>
<li>bandwidth: Width of the hysteresis.</li>
</ul>
</html>"));
end HierarchicalControl;
