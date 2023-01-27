within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.HierarchicalControl_ModularBoiler;
model InternalControl "This model contains the internal controller"
   ///Hierarchy Control
  parameter Boolean use_advancedControl      "Selection between two position control and advanced control, if true=advanced control is active"
    annotation(choices(
      choice=true "Advance Control",
      choice=false "Two position control",
      radioButtons=true));
  parameter Boolean use_flowTControl "Selection between boiler temperature control and flow temperature control, if true=flow temperature control is active"
    annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Boiler temperature control",
      radioButtons=true), Dialog(enable=
          use_advancedControl or severalHeatCircuits));

  parameter Modelica.Units.SI.Temperature Tref=333.15
    "Reference Temperature for the on off controller"
    annotation(Dialog(
        group="Two position controller"));
  parameter Integer n=1 "Number of layers in the buffer storage"
    annotation(Dialog(
        group="Two position controller"));
  parameter Real bandwidth "Bandwidth around reference signal"
    annotation(Dialog(
        group="Two position controller"));
  parameter Real declination
    annotation(Dialog(group="Flow temperature control"));
  parameter Real day_hour
    annotation(Dialog(group="Flow temperature control"));
  parameter Real night_hour
    annotation(Dialog(group="Flow temperature control"));
  parameter Modelica.Units.SI.ThermodynamicTemperature TOffset
    "Offset to heating curve temperature"
    annotation(Dialog(group="Flow temperature control"));
  parameter Boolean variableSetTemperature_admix
    "Choice between variable oder constant boiler temperature for the admixture control"
    annotation(Dialog(group="Admixtire control"));
  final parameter Boolean severalHeatCircuits=if k > 1 then true else false "If true, there are two or more heat curcuits"
    annotation(Dialog(enable=
          use_advancedControl,                                                                                                       group=
          "Flow temperature control"),                                                                                                                                  choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true));
  parameter Integer k(min=1)=1 "Number of heat curcuits"
    annotation(Dialog(group="Admixture control"));
  parameter Modelica.Units.SI.Temperature TBoiler=348.15
    "Fix boiler temperature for the admixture"
    annotation(Dialog(enable=use_advancedControl and severalHeatcurcuits and not TVar,tab="Control", group="Admixture control"));
  parameter Boolean topLayer=true "If true, two position controller using top level of buffer storage for calculation";

  AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.TwoPositionController
    twoPositionController(
    final topLayer=topLayer,
    final Tref=Tref,
    final n=if topLayer then 1 else n,
    final bandwidth=bandwidth) if not use_advancedControl
    annotation (Placement(transformation(extent={{16,26},{40,52}})));

  //Flow temperature control
  InternalControl_ModularBoiler.flowTemperatureController.flowTemperatureControl_heatingCurve
    flowTemperatureControl_heatingCurve(
      final declination=declination,
      final day_hour=day_hour,
      final TOffset=TOffset,
      final night_hour=night_hour) if use_flowTControl
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));

  Modelica.Blocks.Interfaces.RealInput Tamb if use_flowTControl
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));

  InternalControl_ModularBoiler.flowTemperatureController.returnAdmixture.returnAdmixture returnAdmixture(
    final k=k,
    final variableSetTemperature_admix=variableSetTemperature_admix,
    final TBoiler=TBoiler,
    final use_flowTControl=use_flowTControl) if severalHeatCircuits
    annotation (Placement(transformation(extent={{42,-74},{62,-54}})));
  Modelica.Blocks.Interfaces.RealOutput valPos[k] if severalHeatCircuits
    "Valve position to control the three-way valve"
    annotation (Placement(transformation(extent={{94,-70},{114,-50}})));

  //Flow temperature control
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput PLRin if not use_advancedControl or (
    use_advancedControl and severalHeatCircuits)
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput Tflow
    "Flow temperature of the heat generator"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
  Modelica.Blocks.Interfaces.RealInput TLayers[n] if not use_advancedControl
    "Different temperatures of layers of buffer storage, 1 lowest layer and n top layer; if simple two position controller, then it is equal to Tin"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{94,30},{114,50}})));
  Modelica.Blocks.Interfaces.RealInput TBoilerVar if not use_flowTControl and
    variableSetTemperature_admix                         "Variable boiler temperature for the admixture control"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-102})));
  Modelica.Blocks.Interfaces.RealInput TCon[k] if severalHeatCircuits
                        "Set temperature for the consumers"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={30,-102})));
  Modelica.Blocks.Interfaces.RealInput TMeaCon[k] if severalHeatCircuits
    "Measurement temperature of the consumer"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-102})));

equation

  connect(isOn, twoPositionController.isOn) annotation (Line(points={{-100,20},{
          8,20},{8,43.42},{16,43.42}}, color={255,0,255}));
  connect(PLRin, twoPositionController.PLRin) annotation (Line(points={{-100,60},
          {8,60},{8,50.7},{16,50.7}}, color={0,0,127}));
  connect(TLayers, twoPositionController.TLayers)
    annotation (Line(points={{0,100},{0,36.14},{16,36.14}}, color={0,0,127}));
  connect(isOn, flowTemperatureControl_heatingCurve.isOn)
    annotation (Line(
        points={{-100,20},{-48,20},{-48,-63.8},{-40,-63.8}}, color={255,0,255}));
  connect(isOn, returnAdmixture.isOn)
    annotation (Line(points={{-100,20},{18,20},
          {18,-56.6},{42,-56.6}}, color={255,0,255}));
  connect(returnAdmixture.valPos, valPos)
    annotation (Line(points={{62,-69.8},{88,
          -69.8},{88,-60},{104,-60}}, color={0,0,127}));
  connect(Tflow, flowTemperatureControl_heatingCurve.TFlowMea) annotation (Line(
        points={{-100,-20},{-58,-20},{-58,-78},{-31.2,-78},{-31.2,-70}}, color=
          {0,0,127}));
  connect(Tamb,flowTemperatureControl_heatingCurve.TAmb)
    annotation (Line(
        points={{-100,-60},{-40,-60}},                     color={0,0,127}));
  connect(Tflow, returnAdmixture.TMeaBoiler)
    annotation (Line(points={{-100,-20},{-58,-20},{-58,-78},{-8,-78},{-8,-64},{42,
          -64}},                                             color={0,0,127}));
  connect(TBoilerVar, returnAdmixture.TBoilerVar)
    annotation (Line(points={{0,-102},{0,-82},{20,-82},{20,-60},{40,-60},{40,-59.8},
          {42,-59.8}},                                       color={0,0,127}));
  connect(TCon, returnAdmixture.TCon)
    annotation (Line(points={{30,-102},{30,-69.8},
          {42,-69.8}},            color={0,0,127}));
  connect(TMeaCon, returnAdmixture.TMea)
    annotation (Line(points={{60,-102},{60,
          -82},{52,-82},{52,-74}}, color={0,0,127}));

  if use_advancedControl then
    if use_flowTControl then
      connect(flowTemperatureControl_heatingCurve.PLRset, PLRset)
        annotation (Line(
        points={{-20,-60},{0,-60},{0,0},{60,0},{60,40},{104,40}},   color={0,0,127}));
    else
      connect(returnAdmixture.PLRset, PLRset)
        annotation (Line(points={{62,-59.4},{62,
          -60},{80,-60},{80,40},{104,40}},            color={0,0,127}));
    end if;
  else
    connect(twoPositionController.PLRset, PLRset) annotation (Line(points={{40.48,
          39.78},{40,39.78},{40,40},{104,40}}, color={0,0,127}));
  end if;


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalControl;
