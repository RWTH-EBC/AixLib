within AixLib.Controls.Interfaces;
expandable connector ModularHeatPumpControlBus
  "Connector used for modular heat pump controller"

  // Definition of parameters describing modular approach in general
  //
  parameter Integer nComp = 1
    "Number of components that shall be controlled"
    annotation(Dialog(tab="General",group="Modular approach"));

  // Definition of parameters describing controlling system in general
  //
  parameter Boolean extConCom = false
    "= true, if external signal is used for compressors"
    annotation(Dialog(tab="General",group="Controller"));
  parameter Boolean extConVal = false
    "= true, if external signal is used for expansion valves"
    annotation(Dialog(tab="General",group="Controller"));
  parameter Choices.heatPumpMode mode=Choices.heatPumpMode.heatPump
    "Choose between heat pump or chiller mode"
    annotation (Dialog(tab="General", group="Controller"));

  // Definition of variables describing expansion valves
  //
  parameter Choices.ControlVariableValve controlVariableValve=
    Choices.ControlVariableValve.TSupHea
    "Choose between different control variables for expansion valve"
    annotation (Dialog(tab="Expansion Valves", group="Control variable"));
  Real actConVarValve[nComp]
    "Array of measured values of expansion valves' controlled variables"
    annotation(Dialog(tab="Expansion Valves",group="Control variable"));

  Real intSetSigValve[nComp]
    "Array of expansion valves' set signals given internally"
    annotation(Dialog(tab="Expansion Valves",group="Set signals"));
  Real extSetSigValve[nComp]
    "Array of expansion valves' set signals given externally"
    annotation(Dialog(tab="Expansion Valves",group="Set signals"));
  Real actSetSigValve[nComp]
    "Array of expansion valves' actual set signals"
    annotation(Dialog(tab="Expansion Valves",group="Set signals"));

  Modelica.SIunits.AbsolutePressure senPreValve[nComp]
    "Array of measured pressures at expansion valves' outlets"
    annotation(Dialog(tab="Expansion Valves",group="Measurements"));
  Modelica.SIunits.Temperature senTemValve[nComp]
    "Array of measured temperatures at expansion valves' outlets"
    annotation(Dialog(tab="Expansion Valves",group="Measurements"));
  Modelica.SIunits.MassFlowRate senMasFloValve[nComp]
    "Array of measured mass flows at expansion valves' outlets"
    annotation(Dialog(tab="Expansion Valves",group="Measurements"));
  Real senPhaValve[nComp](unit="1")
    "Array of measured phases at expansion valves' outlets"
    annotation(Dialog(tab="Expansion Valves",group="Measurements"));

  // Definition of variables describing compressors
  //

  // Definition of variables describing measurements
  //

  annotation (Icon(coordinateSystem(preserveAspectRatio=false),
        graphics={
          Rectangle(
            lineColor={255,204,51},
            lineThickness=0.5,
            extent={{-20.0,-2.0},{20.0,2.0}}),
          Polygon(
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            points={{-80.0,50.0},{80.0,50.0},{100.0,30.0},{80.0,-40.0},
                    {60.0,-50.0},{-60.0,-50.0},{-80.0,-40.0},{-100.0,30.0}},
            smooth=Smooth.Bezier),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-65.0,15.0},{-55.0,25.0}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-5.0,15.0},{5.0,25.0}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{55.0,15.0},{65.0,25.0}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-35.0,-25.0},{-25.0,-15.0}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{25.0,-25.0},{35.0,-15.0}})}),
        Diagram(
          coordinateSystem(preserveAspectRatio=false)));
end ModularHeatPumpControlBus;
