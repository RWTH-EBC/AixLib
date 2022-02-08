within ControlUnity;
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
      ControlUnity.twoPositionController.BaseClass.partialTwoPositionController
 constrainedby
    ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(Tref=Tref, bandwidth=bandwidth, n=n) annotation(choicesAllMatching=true);

   twoPositionController.BaseClass.twoPositionControllerCal.TwoPositionController_top
    twoPositionController_top(
    Tref=Tref,
    n=n,
    bandwidth=bandwidth) if
                  not use_advancedControl
    annotation (Placement(transformation(extent={{16,32},{36,52}})));

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
    variableSetTemperature_admix=variableSetTemperature_admix,
    TBoiler=TBoiler) if                                                               use_advancedControl and severalHeatcurcuits
    annotation (Placement(transformation(extent={{42,-74},{62,-54}})));
  Modelica.Blocks.Interfaces.RealOutput valPos[k] if use_advancedControl and severalHeatcurcuits
    "Valve position to control the three-way valve"
    annotation (Placement(transformation(extent={{94,-74},{114,-54}})));
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
    annotation (Placement(transformation(extent={{-120,-54},{-80,-14}})));
  Modelica.Blocks.Interfaces.RealInput TLayers[n]
    "Different temperatures of layers of buffer storage, 1 lowest layer and n top layer; if simple two position controller, then it is equal to Tin"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={6,100})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{90,32},{110,52}})));
  Modelica.Blocks.Interfaces.RealInput TBoilerVar if use_advancedControl and severalHeatcurcuits
     and variableSetTemperature_admix "Variable boiler temperature for the admixture control" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={2,-102})));
  Modelica.Blocks.Interfaces.RealInput TCon[k] if use_advancedControl and
    severalHeatcurcuits "Set temperature for the consumers" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={32,-102})));
  Modelica.Blocks.Interfaces.RealInput TMeaCon[k] if use_advancedControl and
    severalHeatcurcuits
    "Measurement temperature of the consumer" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={84,-102})));
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
          {-12,20},{-12,45.4},{16,45.4}}, color={255,0,255}));
  connect(PLRin, twoPositionController_top.PLRin) annotation (Line(points={{-100,
          60},{10,60},{10,51},{16,51}}, color={0,0,127}));
  connect(TLayers, twoPositionController_top.TLayers)
    annotation (Line(points={{6,100},{6,39.8},{16,39.8}}, color={0,0,127}));
  connect(isOn, flowTemperatureControl_heatingCurve.isOn) annotation (Line(
        points={{-100,20},{-46,20},{-46,-63.8},{-30,-63.8}}, color={255,0,255}));
  connect(isOn, returnAdmixture.isOn) annotation (Line(points={{-100,20},{18,20},
          {18,-56.6},{42,-56.6}}, color={255,0,255}));
  connect(returnAdmixture.valPos, valPos) annotation (Line(points={{62,-69.8},{74,
          -69.8},{74,-64},{104,-64}}, color={0,0,127}));
  connect(Tflow, flowTemperatureControl_heatingCurve.TMea) annotation (Line(
        points={{-100,-34},{-58,-34},{-58,-78},{-21.2,-78},{-21.2,-70}}, color=
          {0,0,127}));
  connect(Tamb, flowTemperatureControl_heatingCurve.Tamb) annotation (Line(
        points={{-100,-78},{-68,-78},{-68,-60},{-30,-60}}, color={0,0,127}));
  connect(Tflow, returnAdmixture.TMeaBoiler) annotation (Line(points={{-100,-34},
          {-58,-34},{-58,-80},{-8,-80},{-8,-64},{41.8,-64}}, color={0,0,127}));
  connect(TBoilerVar, returnAdmixture.TBoilerVar)
    annotation (Line(points={{2,-102},{2,-59.8},{42,-59.8}}, color={0,0,127}));
  connect(TCon, returnAdmixture.TCon) annotation (Line(points={{32,-102},{34,-102},
          {34,-69.8},{42,-69.8}}, color={0,0,127}));
  connect(TMeaCon, returnAdmixture.TMea) annotation (Line(points={{84,-102},{84,
          -80},{52,-80},{52,-74}}, color={0,0,127}));
  connect(twoPositionController_top.PLRset, PLRset) annotation (Line(points={{37.2,
          42.6},{64.6,42.6},{64.6,42},{100,42}}, color={0,0,127}));
  connect(flowTemperatureControl_heatingCurve.PLRset, PLRset) annotation (Line(
        points={{-10,-60},{-2,-60},{-2,6},{70,6},{70,42},{100,42}}, color={0,0,127}));
  connect(returnAdmixture.PLRset, PLRset) annotation (Line(points={{62,-59.4},{68,
          -59.4},{68,-58},{70,-58},{70,42},{100,42}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalControl;
