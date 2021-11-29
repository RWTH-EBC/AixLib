within ControlUnity;
model hierarchicalControl_modularBoilerNEW

  ///Hierarchy Control
  parameter Real PLRmin=0.15;
  parameter Boolean use_advancedControl=true "Selection between two position control and flow temperature control, if true=flow temperature control is active" annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Two position control",
      radioButtons=true));

  Modelica.Blocks.Interfaces.RealInput Tin "Boiler temperature"
    annotation (Placement(transformation(extent={{-120,12},{-80,52}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{90,50},{110,70}})));

  Modelica.Blocks.Interfaces.RealInput PLRin if not use_advancedControl or (
    use_advancedControl and severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-120,54},{-80,94}})));

      emergencySwitch_modularBoiler emergencySwitch_modularBoiler1
    annotation (Placement(transformation(extent={{-64,16},{-44,36}})));
 //Two position controller
 replaceable twoPositionController.BaseClass.twoPositionControllerCal.twoPositionController_top
    twoPositionController_layers(
    n=n,
    variablePLR=variablePLR,
    layerCal=layerCal,
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
    flowTemperatureControl_heatingCurve if use_advancedControl and not severalHeatcurcuits
    annotation (Placement(transformation(extent={{-28,-70},{-8,-50}})));

    Modelica.Blocks.Interfaces.RealInput Tamb if use_advancedControl and not
    severalHeatcurcuits
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,-98},{-80,-58}})));

  Modelica.Blocks.Interfaces.RealInput TMeaBoiler if
                                               use_advancedControl
    "Measurement flow temperature of the boiler" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-42,-108})));
        flowTemperatureController.renturnAdmixture.returnAdmixture returnAdmixture(k=k,
      bandwidth=bandwidth) if                                                         use_advancedControl and severalHeatcurcuits
    annotation (Placement(transformation(extent={{46,-74},{66,-54}})));
   Modelica.Blocks.Interfaces.RealInput TsetAdm if    use_advancedControl and severalHeatcurcuits
    "Set temperature for n heat curcuits in admixture control" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={22,-110})));
  Modelica.Blocks.Interfaces.RealOutput valPos if    use_advancedControl and severalHeatcurcuits
    "Valve position to control the three-way valve"
    annotation (Placement(transformation(extent={{90,-76},{110,-56}})));
  parameter Boolean severalHeatcurcuits=false "If true, there are two or more heat curcuits" annotation(Dialog(enable=use_advancedControl, group="Flow temperature control"), choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true));
  parameter Modelica.SIunits.Temperature Tb=273.15+60 "Fix boiler temperature for return admixture with several heat curcuits" annotation(Dialog(enable=severalHeatCurcuits, group="Flow temperature control"));

  //Flow temperature control

  parameter Modelica.SIunits.Temperature THotMax=273.15 + 90
    "Maximum temperature, from which the system is switched off" annotation(Dialog(group="Security-related systems"));




  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,-14},{-80,26}})));

  parameter Boolean variablePLR=false
    "If true, the user can determine the PLR between PLRmin and 1; else you have a two position conttol with the values 0 and 1 for PLR";

  parameter Integer k "Number of heat curcuits";
  Modelica.Blocks.Interfaces.RealInput TMeaCon
    "Measurement temperature of the consumer" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={56,-110})));
equation


/// unconditioned quantities

  connect(Tamb, flowTemperatureControl_heatingCurve.Tamb) annotation (Line(
        points={{-100,-78},{-74,-78},{-74,-60},{-28,-60}}, color={0,0,127}));
  connect(flowTemperatureControl_heatingCurve.TMea, TMeaBoiler) annotation (
      Line(points={{-11.4,-70},{-11.4,-87},{-42,-87},{-42,-108}}, color={0,0,
          127}));
  connect(TsetAdm, returnAdmixture.Tset) annotation (Line(points={{22,-110},{22,
          -67.2},{46,-67.2}}, color={0,0,127}));
  connect(Tin, emergencySwitch_modularBoiler1.T_ein) annotation (Line(points={{-100,
          32},{-72,32},{-72,31.2},{-64,31.2}}, color={0,0,127}));
  connect(isOn, emergencySwitch_modularBoiler1.isOn) annotation (Line(points={{-100,
          6},{-74,6},{-74,23.8},{-64,23.8}}, color={255,0,255}));
  connect(PLRin, twoPositionController_layers.PLRin) annotation (Line(points={{-100,
          74},{-38,74},{-38,63},{24,63}}, color={0,0,127}));
  connect(emergencySwitch_modularBoiler1.y, twoPositionController_layers.isOn)
    annotation (Line(points={{-43.8,29},{10,29},{10,57.4},{24,57.4}}, color={255,
          0,255}));
  connect(emergencySwitch_modularBoiler1.y, flowTemperatureControl_heatingCurve.isOn)
    annotation (Line(points={{-43.8,29},{-36,29},{-36,-68},{-28,-68}}, color={255,
          0,255}));
  connect(emergencySwitch_modularBoiler1.y, returnAdmixture.isOn) annotation (
      Line(points={{-43.8,29},{10,29},{10,-58.2},{46,-58.2}},
                                                          color={255,0,255}));
  connect(PLRin, returnAdmixture.PLRin) annotation (Line(points={{-100,74},{-48,
          74},{-48,40},{32,40},{32,-55.2},{46,-55.2}},
                                                   color={0,0,127}));
  connect(returnAdmixture.PLRset, PLRset) annotation (Line(points={{66,-59.4},{
          78,-59.4},{78,60},{100,60}},
                                  color={0,0,127}));
  connect(returnAdmixture.valPos, valPos) annotation (Line(points={{66,-67.2},{
          80,-67.2},{80,-66},{100,-66}},
                                      color={0,0,127}));
  connect(flowTemperatureControl_heatingCurve.PLRset, PLRset) annotation (Line(
        points={{-8,-60},{-2,-60},{-2,-4},{86,-4},{86,60},{100,60}}, color={0,0,
          127}));
  connect(twoPositionController_layers.PLRset, PLRset) annotation (Line(points=
          {{45.2,54.6},{62,54.6},{62,60},{100,60}}, color={0,0,127}));
  connect(TLayers, twoPositionController_layers.TLayers)
    annotation (Line(points={{6,100},{6,51.8},{24,51.8}}, color={0,0,127}));
  connect(TMeaBoiler, returnAdmixture.TMeaBoiler) annotation (Line(points={{-42,
          -108},{-42,-78},{16,-78},{16,-61},{46,-61}}, color={0,0,127}));
  connect(TMeaCon, returnAdmixture.TMea)
    annotation (Line(points={{56,-110},{56,-74}}, color={0,0,127}));
end hierarchicalControl_modularBoilerNEW;
