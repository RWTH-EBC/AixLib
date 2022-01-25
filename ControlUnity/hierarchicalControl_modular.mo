within ControlUnity;
model hierarchicalControl_modular

  ///Hierarchy Control
  parameter Real PLRmin=0.15;
  parameter Boolean use_advancedControl=false      "Selection between two position control and flow temperature control, if true=flow temperature control is active"
                                                                                                                                                                    annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Two position control",
      radioButtons=true));


  Modelica.Blocks.Interfaces.RealInput Tb "Boiler temperature"
    annotation (Placement(transformation(extent={{-120,-52},{-80,-12}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{92,50},{112,70}})));

  Modelica.Blocks.Interfaces.RealInput PLRin if not use_advancedControl or (
    use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-120,38},{-80,78}})));

      emergencySwitch_modularBoiler emergencySwitch_modularBoiler1(TMax=TMax)
    annotation (Placement(transformation(extent={{-60,16},{-40,36}})));
 //Two position controller
 replaceable twoPositionController.BaseClass.twoPositionControllerCal.twoPositionController_top
    twoPositionController_layers(
    n=n,
    variablePLR=variablePLR,
    bandwidth=bandwidth,
    Tref=Tref) if              not use_advancedControl
                                 constrainedby
    ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(Tref=Tref, bandwidth=bandwidth, n=n)
    annotation (Placement(transformation(extent={{24,24},{44,44}})), choicesAllMatching=true, Dialog(enable=not use_advancedControl));
  Modelica.Blocks.Interfaces.RealInput TLayers[n]
    "Different temperatures of layers of buffer storage, 1 lowest layer and n top layer; if simple two position controller, then it is equal to Tin"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={6,100})));

  parameter Integer n=3 "Number of layers in the buffer storage" annotation(Dialog(
        group="Two position controller"));

  parameter Real bandwidth "Bandwidth around reference signal" annotation(Dialog(
        group="Two position controller"));
   //////
   //////
   //////

  //Flow temperature control
  flowTemperatureController.flowTemperatureControl_heatingCurve
    flowTemperatureControl_heatingCurve(declination=declination,
    day_hour=day_hour,
    night_hour=night_hour,
    TOffset=TOffset) if                    use_advancedControl and not severalHeatcurcuits
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));

    Modelica.Blocks.Interfaces.RealInput Tamb if use_advancedControl and not
    severalHeatcurcuits
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,-98},{-80,-58}})));

        flowTemperatureController.renturnAdmixture.returnAdmixture returnAdmixture(k=k,
    TVar=TVar,
    TBoiler=TBoiler) if                                                               use_advancedControl and severalHeatcurcuits
    annotation (Placement(transformation(extent={{42,-74},{62,-54}})));
  Modelica.Blocks.Interfaces.RealOutput valPos[k] if use_advancedControl and severalHeatcurcuits
    "Valve position to control the three-way valve"
    annotation (Placement(transformation(extent={{90,-76},{110,-56}})));
  parameter Boolean severalHeatcurcuits=false "If true, there are two or more heat curcuits" annotation(Dialog(enable=use_advancedControl, group="Flow temperature control"), choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true));

  //Flow temperature control

  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-122,0},{-82,40}})));

  parameter Boolean variablePLR=false
    "If true, the user can determine the PLR between PLRmin and 1; else you have a two position conttol with the values 0 and 1 for PLR";

  parameter Integer k "Number of heat curcuits";
  Modelica.Blocks.Interfaces.RealInput TMeaCon[k] if use_advancedControl and
    severalHeatcurcuits
    "Measurement temperature of the consumer" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={90,-116})));
  parameter Modelica.SIunits.Temperature TBoiler=273.15 + 75
    "Fix boiler temperature for the admixture"
                                              annotation(Dialog(
        group="Flow temperature control"));
  parameter Modelica.SIunits.Temperature Tref
    "Reference Temperature for the on off controller"
                                                     annotation(Dialog(
        group="Two position controller"));
  parameter Modelica.SIunits.Temperature Tset[k];
  Modelica.Blocks.Interfaces.RealInput TCon[k] if use_advancedControl and
    severalHeatcurcuits "Set temperature for the consumers" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={34,-116})));
  parameter Real declination=1 "Declination of curve" annotation(Dialog(group="Flow temperature control"));
  parameter Real day_hour=6 "Hour of day in which day mode is enabled" annotation(Dialog(group="Flow temperature control"));
  parameter Real night_hour=22 "Hour of night in which night mode is enabled" annotation (Dialog(group="Flow temperature control"));
  parameter Modelica.SIunits.ThermodynamicTemperature TOffset(displayUnit="K") = 0
    "Offset to heating curve temperature" annotation(Dialog(group="Flow temperature control"));
  parameter Modelica.SIunits.Temperature TMax=273.15 + 105
    "Maximum temperature, at which the system is shut down" annotation(Dialog(group="Security-related systems"));
  parameter Boolean TVar
    "Choice between variable oder constant boiler temperature for the admixture control";
  Modelica.Blocks.Interfaces.RealInput TBoilerVar if use_advancedControl and severalHeatcurcuits
     and TVar "Variable boiler temperature for the admixture control" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-116})));
equation

/// unconditioned quantities

  connect(Tamb, flowTemperatureControl_heatingCurve.Tamb) annotation (Line(
        points={{-100,-78},{-74,-78},{-74,-60},{-30,-60}}, color={0,0,127}));
  connect(isOn, emergencySwitch_modularBoiler1.isOn) annotation (Line(points={{-102,20},{-76,20},
          {-76,34},{-68,34},{-68,33.4},{-60,33.4}},
                                             color={255,0,255}));
  connect(PLRin, twoPositionController_layers.PLRin) annotation (Line(points={{-100,58},{-38,58},
          {-38,43},{24,43}},              color={0,0,127}));
  connect(emergencySwitch_modularBoiler1.y, twoPositionController_layers.isOn)
    annotation (Line(points={{-39.6,26},{10,26},{10,37.4},{24,37.4}}, color={255,
          0,255}));
  connect(emergencySwitch_modularBoiler1.y, flowTemperatureControl_heatingCurve.isOn)
    annotation (Line(points={{-39.6,26},{-36,26},{-36,-63.8},{-30,-63.8}},
                                                                       color={255,
          0,255}));
  connect(emergencySwitch_modularBoiler1.y, returnAdmixture.isOn) annotation (
      Line(points={{-39.6,26},{10,26},{10,-56.6},{42,-56.6}},
                                                          color={255,0,255}));
  connect(TLayers, twoPositionController_layers.TLayers)
    annotation (Line(points={{6,100},{6,31.8},{24,31.8}}, color={0,0,127}));
  connect(returnAdmixture.valPos, valPos) annotation (Line(points={{62,-69.8},{82,-69.8},{82,-66},
          {100,-66}},                    color={0,0,127}));
  connect(Tb, emergencySwitch_modularBoiler1.TBoiler) annotation (Line(points={{-100,-32},{-74,-32},
          {-74,20},{-68,20},{-68,19.8},{-60,19.8}},    color={0,0,127}));
  connect(Tb, returnAdmixture.TMeaBoiler) annotation (Line(points={{-100,-32},{-114,-32},{-114,-92},
          {30,-92},{30,-64},{41.8,-64}},                    color={0,0,127}));
  connect(Tb, flowTemperatureControl_heatingCurve.TMea) annotation (Line(points={{-100,-32},{-114,
          -32},{-114,-92},{-20,-92},{-20,-82},{-21.2,-82},{-21.2,-70}},
                                                                     color={0,0,
          127}));
  connect(TMeaCon, returnAdmixture.TMea) annotation (Line(points={{90,-116},{90,-86},{52,-86},{52,
          -74}},                   color={0,0,127}));
  connect(TCon, returnAdmixture.TCon) annotation (Line(points={{34,-116},{34,-69.8},{42,-69.8}},
                              color={0,0,127}));
  connect(TBoilerVar, returnAdmixture.TBoilerVar)
    annotation (Line(points={{0,-116},{0,-59.8},{42,-59.8}}, color={0,0,127}));
  connect(twoPositionController_layers.PLRset, PLRset) annotation (Line(points={{45.2,34.6},{52,34.6},
          {52,60},{102,60}}, color={0,0,127}));
  connect(flowTemperatureControl_heatingCurve.PLRset, PLRset) annotation (Line(points={{-10,-60},
          {-4,-60},{-4,-30},{64,-30},{64,60},{102,60}}, color={0,0,127}));
  connect(returnAdmixture.PLRset, PLRset) annotation (Line(points={{62,-59.4},{70,-59.4},{70,-56},
          {78,-56},{78,60},{102,60}}, color={0,0,127}));
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
end hierarchicalControl_modular;
