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
    "Different temperatures of layers of buffer storage; 1 lowest layer and n top layer"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={2,100})));
  emergencySwitch_modularBoiler emergencySwitch_modularBoiler1 if not use_advancedControl
    annotation (Placement(transformation(extent={{-18,46},{2,66}})));
  Modelica.Blocks.Interfaces.RealInput PLRin if not use_advancedControl
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));

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



  //Flow temperature control
  replaceable flowTemperatureController.flowTemperatureControl_heatingCurve
    flowTemperatureControl_heatingCurve if use_advancedControl
    constrainedby
    ControlUnity.flowTemperatureController.partialFlowtemperatureControl
    annotation (Placement(transformation(extent={{-18,-76},{2,-56}})), choicesAllMatching=true, Dialog(enable= use_advancedControl));

    Modelica.Blocks.Interfaces.RealInput Tamb if use_advancedControl
    "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,-98},{-80,-58}})));

 emergencySwitch_modularBoiler emergencySwitch_modularBoiler2 if use_advancedControl
    annotation (Placement(transformation(extent={{24,-34},{44,-14}})));
  Modelica.Blocks.Interfaces.RealInput TMeaRet if use_advancedControl
    "Measurement temperature of the return" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-10,-108})));

  parameter Modelica.SIunits.Temperature THotMax=273.15 + 90
    "Maximum temperature, from which the system is switched off" annotation(Dialog(group="Security-related systems"));


equation
  //Advanced or simple control
  if use_advancedControl then
connect(TMeaRet, flowTemperatureControl_heatingCurve.TMea) annotation (Line(
        points={{-10,-108},{-10,-76},{-2.4,-76}}, color={0,0,127}));
  connect(Tamb, flowTemperatureControl_heatingCurve.Tamb) annotation (Line(
        points={{-100,-78},{-70,-78},{-70,-66},{-18,-66}},       color={0,0,127}));
  connect(emergencySwitch_modularBoiler2.PLR_set,
    flowTemperatureControl_heatingCurve.PLRin) annotation (Line(points={{44,-21},
          {58,-21},{58,-48},{-26,-48},{-26,-59},{-18,-59}}, color={0,0,127}));
  connect(flowTemperatureControl_heatingCurve.y,
    emergencySwitch_modularBoiler2.PLR_ein) annotation (Line(points={{2,-66},{10,
          -66},{10,-25.2},{24,-25.2}},      color={0,0,127}));
  connect(Tin, emergencySwitch_modularBoiler2.T_ein) annotation (Line(points={{-102,
          72},{-74,72},{-74,18},{18,18},{18,-18.8},{24,-18.8}}, color={0,0,127}));
else

 connect(PLRin, emergencySwitch_modularBoiler1.PLR_ein) annotation (Line(
        points={{-100,0},{-32,0},{-32,54.8},{-18,54.8}}, color={0,0,127}));
  connect(Tin, emergencySwitch_modularBoiler1.T_ein) annotation (Line(points={{-102,
          72},{-30,72},{-30,61.2},{-18,61.2}}, color={0,0,127}));
  connect(emergencySwitch_modularBoiler1.PLR_set, twoPositionController_layers.PLRin)
    annotation (Line(points={{2,59},{10,59},{10,63},{24,63}}, color={0,0,127}));
  connect(TLayers, twoPositionController_layers.TLayers) annotation (Line(
        points={{2,100},{2,72},{18,72},{18,57.6},{24,57.6}}, color={0,0,127}));
  connect(twoPositionController_layers.PLRset, PLRset) annotation (Line(points={
          {45,59.2},{67.5,59.2},{67.5,60},{100,60}}, color={0,0,127}));

  end if;



  connect(flowTemperatureControl_heatingCurve.PLRset, PLRset) annotation (Line(
        points={{2.2,-59},{78,-59},{78,60},{100,60}}, color={0,0,127}));
end hierarchicalControl_modularBoiler;
