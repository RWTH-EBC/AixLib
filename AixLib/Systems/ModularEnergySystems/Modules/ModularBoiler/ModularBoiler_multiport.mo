within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler_multiport
  extends BaseClasses.Boiler_base_MultiPort(fan(use_inputFilter=false));

  // Feedback
  parameter Boolean hasFeedback=false   "circuit has Feedback"
    annotation (Dialog(group = "Feedback"), choices(checkBox = true));
  parameter Modelica.Units.SI.PressureDifference dp_Valve=10   "Pressure Difference set in regulating valve for pressure equalization in heating system"
    annotation (Dialog(enable = hasFeedback, group="Feedback"));
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal[2]={10,10}    "Nominal additional pressure drop e.g. for distributor"
    annotation (Dialog(enable = hasFeedback, group="Feedback"));
  // Hierarchical Control
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
  final parameter Boolean severalHeatCircuits=if k > 1 then true else false "Selection between using several circuit and only one heat circuits";
  //Admixture
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominalCon[k] = fill(0.3, k)
    "Nominal mass flow rate for the individual consumers"
     annotation(Dialog(tab="Advanced", group="Nominal conditions consumer"));
  parameter Modelica.Units.SI.PressureDifference dp_nominalCon[k] = fill(10, k)
    "Pressure drop at nominal conditions for the individual consumers"
     annotation(Dialog(tab="Advanced", group="Nominal conditions consumer"));
  // Control
  parameter Boolean simpleTwoPosition=true "Decides if the two position control is used with or without a buffer storage; if true n=1, else n is the number of layers of the buffer storage"
    annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"), choices(
      choice=true "Simple Two position control",
      choice=false "With buffer storage",
      radioButtons=true));
  parameter Boolean TVar=false
    "Choice between variable oder constant boiler temperature for the admixture control"
     annotation(Dialog(tab="Control", group="Admixture control"), choices(
      choice=true "Variable boiler temperature",
      choice=false "Constant boiler temperature",
      radioButtons=true));
  parameter Boolean manualTimeDelay
    "If true, the user can set a time during which the heat genearator is switched on independently of the internal control"
     annotation(Dialog(tab="Control", group="Manual control"), choices(
      choice=true "Manual control with time delay",
      choice=false "Automatic intern control",
      radioButtons=true));
  parameter Integer n_layers = 3;
  parameter Integer n = if simpleTwoPosition then 1 else n_layers "Number of layers in the buffer storage"
    annotation(Dialog(enable=not use_advancedControl,tab="Control", group="Two position control"));
  parameter Real bandwidth=2.5 "Bandwidth around reference signal"
    annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"));
  parameter Real declination=1 "Declination of curve"
    annotation(Dialog(enable=use_advancedControl and not severalHeatCircuits, tab="Control", group="Flow temperature control"));
  parameter Modelica.Units.SI.Temperature Tref=333.15
    "Reference Temperature for the on off controller"
     annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"));
  parameter Real day_hour=6 "Hour of day in which day mode is enabled"
    annotation(Dialog(enable=use_advancedControl and not severalHeatCircuits, tab="Control", group="Flow temperature control"));
  parameter Real night_hour=22 "Hour of night in which night mode is enabled"
    annotation(Dialog(enable=use_advancedControl and not severalHeatCircuits, tab="Control", group="Flow temperature control"));
  parameter Modelica.Units.SI.ThermodynamicTemperature TOffset(displayUnit="K")=0
    "Offset to heating curve temperature"
     annotation(Dialog(enable=use_advancedControl and not severalHeatCircuits, tab="Control", group="Flow temperature control"));
  parameter Modelica.Units.SI.Temperature TBoiler=348.15
    "Fix boiler temperature for the admixture"
     annotation(Dialog(enable=use_advancedControl and severalHeatCircuits and not TVar,tab="Control", group="Admixture control"));
  parameter Modelica.Units.SI.Temperature TMax=348.15
    "Maximum temperature, at which the system is shut down"
     annotation(Dialog(tab="Control", group="Security-related systems"));
  parameter Modelica.Units.SI.Time time_minOff=900
    "Time after which the device can be turned on again"
     annotation(Dialog(tab="Control", group="Manual control"));
  parameter Modelica.Units.SI.Time time_minOn=900
    "Time after which the device can be turned off again"
     annotation(Dialog(tab="Control", group="Manual control"));

  Control.Regulation_wPump_wFeedBack regulation_wPump_wFeedBack(
    final dTWaterNom=dTWaterNom,
    final QNom=QNom,
    final use_advancedControl=use_advancedControl,
    final severalHeatCircuits=severalHeatCircuits,
    final PLRMin=PLRMin,
    final TColdNom=TColdNom)
    annotation (Placement(transformation(extent={{-52,44},{-12,76}})));

  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    redeclare final package Medium = Medium,
    use_inputFilter=false,
    final m_flow_nominal= m_flow_nominal,
    final dpValve_nominal=dp_Valve,
    final dpFixed_nominal=dpFixed_nominal) if hasFeedback
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Control.HierarchicalControl_ModularBoiler.InternalControl_ModularBoiler.flowTemperatureController.returnAdmixture.Admixture
    admixture[k](
    final m_flow_nominalCon=m_flow_nominalCon,
    final dp_nominalCon=dp_nominalCon,
    each final dp_Valve=dp_Valve) if use_advancedControl and severalHeatCircuits
     annotation (Placement(transformation(extent={{54,-90},{96,-48}})));

  Control.HierarchicalControl_ModularBoiler.InternalControl_ModularBoiler.flowTemperatureController.returnAdmixture.BaseClasses.AdmixtureBus
    admixtureBus[k]
    annotation (Placement(transformation(extent={{30,-58},{50,-38}})));
  Control.HierarchicalControl hierarchicalControl(
    final PLRMin=PLRMin,
    final n=n,
    final bandwidth=bandwidth,
    final manualTimeDelay=manualTimeDelay,
    final k=k,
    final use_advancedControl=use_advancedControl,
    final use_flowTControl=use_flowTControl,
    final TBoiler=TBoiler,
    final Tref=Tref,
    final declination=declination,
    final day_hour=day_hour,
    final night_hour=night_hour,
    final TOffset=TOffset,
    final TMax=TMax,
    final time_minOff=time_minOff,
    final time_minOn=time_minOn,
    final variableSetTemperature_admix=TVar,
    final topLayer=simpleTwoPosition)
    annotation (Placement(transformation(extent={{26,38},{58,70}})));
    //redeclare replaceable model TwoPositionController_top =
    //    TwoPositionController_top,
  Modelica.Blocks.Interfaces.RealInput TLayers[n] if not use_advancedControl
     and not simpleTwoPosition
      annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-100,80})));
  Modelica.Blocks.Interfaces.RealInput TCon[k] if use_advancedControl and
    severalHeatCircuits "Set temperature for the consumers"
     annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-100,40}), iconTransformation(extent={{-12,-12},{12,12}},
          origin={-100,40})));

  Modelica.Blocks.Interfaces.RealInput TBoilerVar if use_advancedControl and severalHeatCircuits
     and TVar "Variable boiler temperature for the admixture control"
      annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-100,60}), iconTransformation(extent={{-12,-12},{12,12}},
          origin={-100,60})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    redeclare final package Medium = Medium) annotation (Placement(
        transformation(extent={{-98,-26},{-86,-14}}), iconTransformation(extent={{0,0},
            {0,0}})));
equation
  connect(regulation_wPump_wFeedBack.TCold, senTCold.T)
    annotation (Line(points={{-52,54.6667},{-60,54.6667},{-60,11}},
                                                 color={0,0,127}));
  connect(heatGeneratorNoControl.TVolume, regulation_wPump_wFeedBack.THot_Boiler)
    annotation (Line(points={{0,-11},{0,-18},{-50,-18},{-50,22},{-58,22},{-58,
          48},{-52,48},{-52,49.3333}},
        color={0,0,127}));
  connect(senTHot.T, regulation_wPump_wFeedBack.THot)
    annotation (Line(points={{60,11},
          {60,24},{-56,24},{-56,44},{-52,44}},        color={0,0,127}));
  connect(regulation_wPump_wFeedBack.y, fan.y)
    annotation (Line(points={{-34.8571,44},{-36,44},{-36,12}},
                                                color={0,0,127}));
  connect(regulation_wPump_wFeedBack.dTWater, heatGeneratorNoControl.dTWater)
    annotation (Line(points={{-23.4286,44},{-23.4286,38},{-16,38},{-16,9},{-12,
          9}},                                                          color={0,
          0,127}));
  connect(boilerControlBus.DeltaTWater, regulation_wPump_wFeedBack.dTwater_in)
    annotation (Line(
      points={{0.05,100.05},{-80,100.05},{-80,70.6667},{-52,70.6667}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PLR, regulation_wPump_wFeedBack.PLR_in)
    annotation (
      Line(
      points={{0.05,100.05},{-80,100.05},{-80,76},{-52,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  if hasFeedback then
    connect(port_a1, val.port_1)
     annotation (Line(points={{-92,-20},{-92,0},{-90,0}},
                                                 color={0,127,255}));
    connect(val.port_2, senTCold.port_a)
     annotation (Line(points={{-70,0},{-70,0}}, color={0,127,255}));
    connect(senTHot.port_b, val.port_3)
     annotation (Line(points={{70,0},{70,-20},{-80,-20},{-80,-10}},
                      color={0,127,255}, pattern=LinePattern.Dash));
  else
    connect(port_a1, senTCold.port_a);
  end if;

  if use_advancedControl and severalHeatCircuits then
    for i in 1:k loop
      connect(port_a, admixture[i].port_a2)
        annotation (Line(points={{-100,0},{-100,-86},{96,-86},{96,-81.6}},                                                           color={0,127,255}, pattern=LinePattern.Dash));
      connect(admixture[i].port_b2, port_a1)
        annotation (Line(points={{54,-81.6},{-92,-81.6},{-92,-20}},                                   color={0,127,255}, pattern=LinePattern.Dash));
      connect(senTHot.port_b, admixture[i].port_a1)
        annotation (Line(points={{70,0},{70,-34},{54,-34},{54,-56.4}},
                                                         color={0,127,255}, pattern=LinePattern.Dash));
      connect(admixture[i].port_b1, ports_b[i])
        annotation (Line(points={{96,-56.4},{100,-56.4},{100,0}},
                  color={0,127,255}, pattern=LinePattern.Dash));
    end for;
  else
    connect(port_a, port_a1)
      annotation (Line(points={{-100,0},{-100,-20},{-92,-20},{-92,-20}},
                      color={0,127,255}, pattern=LinePattern.Dash));
    connect(senTHot.port_b, ports_b[1])
      annotation (Line(points={{70,0},{100,0}}, color={0,127,255}, pattern=LinePattern.Dash));
  end if;

  connect(regulation_wPump_wFeedBack.y_valve, val.y)
    annotation (Line(points={{-40.5714,44},{-40,44},{-40,26},{-80,26},{-80,12}},
                                                    color={0,0,127}));
  connect(admixtureBus.Tsen_b1, hierarchicalControl.TMeaCon)
    annotation (Line(
      points={{40,-48},{40,-46},{42,-46},{42,18},{51.6,18},{51.6,38}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(admixtureBus, admixture.admixtureBus)
    annotation (Line(
      points={{40,-48},{40,-49.05},{75,-49.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(hierarchicalControl.PLRset, regulation_wPump_wFeedBack.PLR_mea)
    annotation (Line(points={{58,63.6},{62,63.6},{62,78},{-82,78},{-82,64},{-52,
          64},{-52,65.3333}},           color={0,0,127}));
  connect(hierarchicalControl.PLRset, heatGeneratorNoControl.PLR)
    annotation (
      Line(points={{58,63.6},{62,63.6},{62,26},{-20,26},{-20,6},{-12,6},{-12,5.4}},
                      color={0,0,127}));
  connect(regulation_wPump_wFeedBack.y, boilerControlBus.mFlow_relB)
    annotation (Line(points={{-34.8571,44},{-36,44},{-36,38},{-84,38},{-84,94},
          {0,94},{0,100}},
                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(regulation_wPump_wFeedBack.PLR, hierarchicalControl.PLRin)
    annotation (Line(points={{-29.1429,44},{-30,44},{-30,40},{10,40},{10,63.6},
          {26,63.6}},
        color={0,0,127}));
  connect(boilerControlBus.PLREx, hierarchicalControl.PLRinEx)
    annotation (Line(
      points={{0,100},{8,100},{8,68.4},{26,68.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.Tamb, hierarchicalControl.Tamb)
    annotation (Line(
      points={{0,100},{8,100},{8,44.4},{26,44.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.isOn, hierarchicalControl.isOn)
    annotation (Line(
      points={{0.05,100.05},{-4,100.05},{-4,100},{8,100},{8,58.8},{26,58.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.internControl, hierarchicalControl.internControl)
    annotation (Line(
      points={{0,100},{48.4,100},{48.4,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTHot.T, hierarchicalControl.Tb)
    annotation (Line(points={{60,11},{60,24},{20,24},{20,49.2},{26,49.2}},
                                                    color={0,0,127}));
  if not use_advancedControl then
    if simpleTwoPosition then
      connect(senTHot.T, hierarchicalControl.TLayers[1])
        annotation (Line(points={{60,11},{60,24},{66,24},{66,76},{42,76},{42,70}},
                                                                     color={0,0,127}));
    else
      connect(TLayers, hierarchicalControl.TLayers)
        annotation (
        Line(points={{-100,80},{42,80},{42,70}},           color={0,0,127}));
    end if;
  end if;

  connect(TCon, hierarchicalControl.TCon)
    annotation (Line(points={{-100,40},{-88,
          40},{-88,28},{46.8,28},{46.8,38}},
                                    color={0,0,127}));
  connect(TBoilerVar, hierarchicalControl.TBoilerVar)
    annotation (Line(points={{-100,60},
          {-86,60},{-86,30},{42,30},{42,38}},               color={0,0,127}));
  connect(hierarchicalControl.valPos, admixtureBus.valveSet)
    annotation (Line(
        points={{58,44.4},{58,44},{64,44},{64,20},{40,20},{40,-16},{40.05,-16},{
          40.05,-47.95}},                                                 color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularBoiler_multiport;
