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
  parameter Boolean extCon = false
    "= true, if external signal is used"
    annotation(Dialog(tab="General",group="Controller"));
  parameter Choices.heatPumpMode mode=Choices.heatPumpMode.heatPump
    "Choose between heat pump or chiller mode"
    annotation (Dialog(tab="General", group="Controller"));

  // Definition of inputs for expansion valves (signals flowing into the model)
  //
  Boolean active[nComp]
    "= true, if component is active"
    annotation(Dialog(tab="Input - Valve",group="General"));

  parameter Choices.ControlVariableValve controlVariableValve=
    Choices.ControlVariableValve.TSupHea
    "Choose between different control variables for expansion valve"
    annotation (Dialog(tab="Input - Valve", group="Control variable"));
  Real actConVar[nComp]
    "Array of measured values of controlled variables"
    annotation(Dialog(tab="Input - Valve",group="Control variable"));

  Real extSetSig[nComp]
    "Array of set signals given externally"
    annotation(Dialog(tab="Input - Valve",group="Set signals"));

  // Definition of outputs for expansion valves (signals flowing out of the model)
  //
  Real actSetSig[nComp]
    "Array of actual set signals"
    annotation(Dialog(tab="Output - Valve",group="Set signals"));

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
