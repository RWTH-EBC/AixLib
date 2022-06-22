within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.HierarchicalControl_ModularBoiler;
model InternalControl "This model contains the internal controller"
   ///Hierarchy Control
  parameter Real PLRMin=0.15;
  parameter Boolean use_advancedControl      "Selection between two position control and flow temperature control, if true=flow temperature control is active"
                                                                                                                                                              annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Two position control",
      radioButtons=true));

       //Two position controller
 replaceable model TwoPositionController_top =
      TwoPositionController.BaseClasses.partialTwoPositionController
 constrainedby TwoPositionController.BaseClasses.partialTwoPositionController(
                                                                   Tref=Tref, bandwidth=bandwidth, n=n) annotation(choicesAllMatching=true);

   TwoPositionController.TwoPositionController_TopLayer
    twoPositionController_top(
    Tref=Tref,
    n=n,
    bandwidth=bandwidth) if
                  not use_advancedControl
    annotation (Placement(transformation(extent={{16,26},{40,52}})));

        //Flow temperature control
  InternalControl_ModularBoiler.flowTemperatureController.flowTemperatureControl_heatingCurve
    flowTemperatureControl_heatingCurve(declination=declination,
    day_hour=day_hour,
    night_hour=night_hour,
    TOffset=TOffset) if                    use_advancedControl and not severalHeatcurcuits
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));

    Modelica.Blocks.Interfaces.RealInput Tamb if use_advancedControl and not
    severalHeatcurcuits
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));

  InternalControl_ModularBoiler.flowTemperatureController.returnAdmixture.returnAdmixture returnAdmixture(k=k,
    variableSetTemperature_admix=variableSetTemperature_admix,
    TBoiler=TBoiler) if                                                               use_advancedControl and severalHeatcurcuits
    annotation (Placement(transformation(extent={{42,-74},{62,-54}})));
  Modelica.Blocks.Interfaces.RealOutput valPos[k] if use_advancedControl and severalHeatcurcuits
    "Valve position to control the three-way valve"
    annotation (Placement(transformation(extent={{94,-70},{114,-50}})));
  parameter Boolean severalHeatcurcuits "If true, there are two or more heat curcuits" annotation(Dialog(enable=use_advancedControl, group="Flow temperature control"), choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true));

  //Flow temperature control
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput PLRin if not use_advancedControl or (
    use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput Tflow
    "Flow temperature of the heat generator"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
  Modelica.Blocks.Interfaces.RealInput TLayers[n]
    "Different temperatures of layers of buffer storage, 1 lowest layer and n top layer; if simple two position controller, then it is equal to Tin"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{94,30},{114,50}})));
  Modelica.Blocks.Interfaces.RealInput TBoilerVar if use_advancedControl and severalHeatcurcuits
     and variableSetTemperature_admix "Variable boiler temperature for the admixture control" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-102})));
  Modelica.Blocks.Interfaces.RealInput TCon[k] if use_advancedControl and
    severalHeatcurcuits "Set temperature for the consumers" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={30,-102})));
  Modelica.Blocks.Interfaces.RealInput TMeaCon[k] if use_advancedControl and
    severalHeatcurcuits
    "Measurement temperature of the consumer" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-102})));
  parameter Modelica.SIunits.Temperature Tref=273.15 + 60
    "Reference Temperature for the on off controller" annotation(Dialog(
        group="Two position controller"));
  parameter Boolean variablePLR=false
    "If true, the user can determine the PLR between PLRmin and 1; else you have a two position conttol with the values 0 and 1 for PLR";
  parameter Integer n=n "Number of layers in the buffer storage" annotation(Dialog(
        group="Two position controller"));
  parameter Real bandwidth=bandwidth "Bandwidth around reference signal" annotation(Dialog(
        group="Two position controller"));

  parameter Real declination=declination  annotation(Dialog(group="Flow temperature control"));
  parameter Real day_hour=day_hour  annotation(Dialog(group="Flow temperature control"));
  parameter Real night_hour=night_hour  annotation(Dialog(group="Flow temperature control"));
  parameter Modelica.SIunits.ThermodynamicTemperature TOffset=TOffset
    "Offset to heating curve temperature"  annotation(Dialog(group="Flow temperature control"));
  parameter Boolean variableSetTemperature_admix
    "Choice between variable oder constant boiler temperature for the admixture control" annotation(Dialog(group="Admixtire control"));
equation
  connect(isOn, twoPositionController_top.isOn) annotation (Line(points={{-100,20},
          {8,20},{8,43.42},{16,43.42}},   color={255,0,255}));
  connect(PLRin, twoPositionController_top.PLRin) annotation (Line(points={{-100,60},
          {8,60},{8,50.7},{16,50.7}},   color={0,0,127}));
  connect(TLayers, twoPositionController_top.TLayers)
    annotation (Line(points={{0,100},{0,36.14},{16,36.14}},
                                                          color={0,0,127}));
  connect(isOn, flowTemperatureControl_heatingCurve.isOn) annotation (Line(
        points={{-100,20},{-48,20},{-48,-63.8},{-40,-63.8}}, color={255,0,255}));
  connect(isOn, returnAdmixture.isOn) annotation (Line(points={{-100,20},{18,20},
          {18,-56.6},{42,-56.6}}, color={255,0,255}));
  connect(returnAdmixture.valPos, valPos) annotation (Line(points={{62,-69.8},{
          88,-69.8},{88,-60},{104,-60}},
                                      color={0,0,127}));
  connect(Tflow, flowTemperatureControl_heatingCurve.TMea) annotation (Line(
        points={{-100,-20},{-58,-20},{-58,-78},{-31.2,-78},{-31.2,-70}}, color=
          {0,0,127}));
  connect(Tamb, flowTemperatureControl_heatingCurve.Tamb) annotation (Line(
        points={{-100,-60},{-40,-60}},                     color={0,0,127}));
  connect(Tflow, returnAdmixture.TMeaBoiler) annotation (Line(points={{-100,-20},
          {-58,-20},{-58,-78},{-8,-78},{-8,-64},{41.8,-64}}, color={0,0,127}));
  connect(TBoilerVar, returnAdmixture.TBoilerVar)
    annotation (Line(points={{0,-102},{0,-82},{20,-82},{20,-60},{40,-60},{40,
          -59.8},{42,-59.8}},                                color={0,0,127}));
  connect(TCon, returnAdmixture.TCon) annotation (Line(points={{30,-102},{30,
          -69.8},{42,-69.8}},     color={0,0,127}));
  connect(TMeaCon, returnAdmixture.TMea) annotation (Line(points={{60,-102},{60,
          -82},{52,-82},{52,-74}}, color={0,0,127}));
  connect(twoPositionController_top.PLRset, PLRset) annotation (Line(points={{40.48,
          39.78},{40,39.78},{40,40},{104,40}},   color={0,0,127}));
  connect(flowTemperatureControl_heatingCurve.PLRset, PLRset) annotation (Line(
        points={{-20,-60},{0,-60},{0,0},{60,0},{60,40},{104,40}},   color={0,0,127}));
  connect(returnAdmixture.PLRset, PLRset) annotation (Line(points={{62,-59.4},{
          62,-60},{80,-60},{80,40},{104,40}},         color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalControl;
