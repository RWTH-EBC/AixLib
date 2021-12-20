within ControlUnity;
model hierarchicalControl_modularBoiler
  parameter Real PLRmin=0.15;
  parameter Boolean use_advancedControl=true "Selection between two position control and flow temperature control, if true=flow temperature control is active" annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Two position control",
      radioButtons=true));

  Modelica.Blocks.Interfaces.RealInput Tin "Boiler temperature"
    annotation (Placement(transformation(extent={{-122,52},{-82,92}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{90,50},{110,70}})));

  Modelica.Blocks.Interfaces.RealInput PLRin
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
 //Two position controller
 replaceable twoPositionController.BaseClass.twoPositionControllerCal.twoPositionController_layers
    twoPositionController_layers(n=n,
    layerCal=layerCal,
    TLayer_dif=TLayer_dif,
    Tlayerref=Tlayerref,
    bandwidth=bandwidth) if              not use_advancedControl
                                 constrainedby
    ControlUnity.twoPositionController.BaseClass.partialTwoPositionController
    annotation (Placement(transformation(extent={{24,44},{44,64}})), choicesAllMatching=true, Dialog(enable=not use_advancedControl));
  Modelica.Blocks.Interfaces.RealInput TLayers[n] if not use_advancedControl
    "Different temperatures of layers of buffer storage, 1 lowest layer and n top layer; if simple two position controller, then it is equal to Tin"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={6,100})));
  emergencySwitch_modularBoiler emergencySwitch_modularBoiler1 if not use_advancedControl
    annotation (Placement(transformation(extent={{-18,46},{2,66}})));


  parameter Integer n=3 "Number of layers in the buffer storage" annotation(Dialog(
        group="Two position controller"));
  parameter Boolean layerCal=true
    "If true, the two-position controller uses the mean temperature of the buffer storage" annotation(Dialog(
        group="Two position controller"));
  parameter Modelica.SIunits.TemperatureDifference TLayer_dif=8
    "Reference difference temperature for the on off controller for the buffer storage with layer calculation" annotation(Dialog(
        group="Two position controller"));
  parameter Modelica.SIunits.Temperature Tlayerref=273.15 + 65 annotation(Dialog(
        group="Two position controller"));
  parameter Real bandwidth "Bandwidth around reference signal" annotation(Dialog(
        group="Two position controller"));
   //////
   //////
   //////


  //Flow temperature control
  flowTemperatureController.flowTemperatureControl_heatingCurve
    flowTemperatureControl_heatingCurve if use_advancedControl
    annotation (Placement(transformation(extent={{-20,-76},{0,-56}})));


    Modelica.Blocks.Interfaces.RealInput Tamb if use_advancedControl
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,-98},{-80,-58}})));

 emergencySwitch_modularBoiler emergencySwitch_modularBoiler2 if use_advancedControl
    annotation (Placement(transformation(extent={{18,-36},{38,-16}})));
  Modelica.Blocks.Interfaces.RealInput TMeaRet if use_advancedControl
    "Measurement temperature of the return" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-10,-108})));

  parameter Boolean severalHeatcurcuits=false "If true, there are two or more heat curcuits" annotation(Dialog(enable=use_advancedControl, group="Flow temperature control"), choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true));
  parameter Modelica.SIunits.Temperature Tb=273.15+60 "Fix boiler temperature for return admixture with several heat curcuits" annotation(Dialog(enable=severalHeatCurcuits, group="Flow temperature control"));
  Modelica.Blocks.Logical.Switch switch2 if use_advancedControl
    annotation (Placement(transformation(extent={{-60,-56},{-44,-40}})));

  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=
        severalHeatcurcuits) if use_advancedControl
    annotation (Placement(transformation(extent={{-102,-54},{-86,-36}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Tb) if use_advancedControl
    annotation (Placement(transformation(extent={{-98,-34},{-80,-18}})));

  //Flow temperature control


  parameter Modelica.SIunits.Temperature THotMax=273.15 + 90
    "Maximum temperature, from which the system is switched off" annotation(Dialog(group="Security-related systems"));




equation
  //Advanced or simple control
  if use_advancedControl then  //advanced control
connect(TMeaRet, flowTemperatureControl_heatingCurve.TMea) annotation (Line(
        points={{-10,-108},{-10,-76},{-3.4,-76}}, color={0,0,127}));
    connect(Tin, emergencySwitch_modularBoiler2.TBoiler) annotation (Line(
          points={{-102,72},{-76,72},{-76,14},{-16,14},{-16,-20.8},{18,-20.8}},
          color={0,0,127}));
   connect(booleanExpression1.y, switch2.u2) annotation (Line(points={{-85.2,-45},
          {-68.6,-45},{-68.6,-48},{-61.6,-48}}, color={255,0,255}));
  connect(realExpression.y, switch2.u1) annotation (Line(points={{-79.1,-26},{-70,
          -26},{-70,-41.6},{-61.6,-41.6}}, color={0,0,127}));
  connect(Tamb, switch2.u3) annotation (Line(points={{-100,-78},{-68,-78},{-68,-54.4},
          {-61.6,-54.4}}, color={0,0,127}));
    connect(switch2.y, flowTemperatureControl_heatingCurve.Tamb) annotation (
        Line(points={{-43.2,-48},{-34,-48},{-34,-66},{-20,-66}}, color={0,0,127}));

  else //simple control
 connect(PLRin, emergencySwitch_modularBoiler1.PLR_ein) annotation (Line(
        points={{-100,0},{-32,0},{-32,54.8},{-18,54.8}}, color={0,0,127}));
    connect(Tin, emergencySwitch_modularBoiler1.TBoiler) annotation (Line(
          points={{-102,72},{-30,72},{-30,61.2},{-18,61.2}}, color={0,0,127}));
  connect(emergencySwitch_modularBoiler1.PLR_set, twoPositionController_layers.PLRin)
    annotation (Line(points={{2,59},{10,59},{10,63},{24,63}}, color={0,0,127}));
  connect(TLayers, twoPositionController_layers.TLayers) annotation (Line(
        points={{6,100},{6,72},{18,72},{18,51.8},{24,51.8}}, color={0,0,127}));
  connect(twoPositionController_layers.PLRset, PLRset) annotation (Line(points={{45.2,
            54.6},{67.5,54.6},{67.5,60},{100,60}},   color={0,0,127}));

  end if;



/// unconditioned quantities

  connect(flowTemperatureControl_heatingCurve.PLRset,
    emergencySwitch_modularBoiler2.PLR_ein) annotation (Line(points={{0,-66},{8,
          -66},{8,-27.2},{18,-27.2}},   color={0,0,127}));
  connect(emergencySwitch_modularBoiler2.PLR_set, PLRset) annotation (Line(
        points={{38,-23},{58,-23},{58,-22},{82,-22},{82,60},{100,60}}, color={0,
          0,127}));
end hierarchicalControl_modularBoiler;
