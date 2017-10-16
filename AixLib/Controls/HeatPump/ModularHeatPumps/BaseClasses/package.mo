within AixLib.Controls.HeatPump.ModularHeatPumps;
package BaseClasses "Package that contains base models used for controllers of modular heat pumps"
  extends Modelica.Icons.BasesPackage;

  partial model PartialModularController
    "Base model used for all modular controllers"

    // Definition of parameters describing modular approach
    //
    parameter Integer nVal = 1
      "Number of valves";

    // Definition of parameters describing the controller
    //
    parameter Real k=1 "Gain of controller";
    parameter Modelica.SIunits.Time Ti=0.5 "Time constant of Integrator block";
    parameter Real yMax=1 "Upper limit of output";
    parameter Real yMin=0 "Lower limit of output";
    parameter Real wp=1 "Set-point weight for Proportional block (0..1)";
    parameter Modelica.SIunits.Time Td=0.1 "Time constant of Derivative block";
    parameter Real wd=0 "Set-point weight for Derivative block (0..1)";
    parameter Real Ni=0.9 "Ni*Ti is time constant of anti-windup compensation";
    parameter Real Nd=10 "The higher Nd, the more ideal the derivative block";
    parameter Boolean reverseAction=false
      "Set to true for throttling the water flow rate through a cooling coil controller";
    parameter Modelica.Blocks.Types.InitPID initType=Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
      "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)";
    parameter Real xi_start=0
      "Initial or guess value value for integrator output (= integrator state)";
    parameter Real xd_start=0
      "Initial or guess value for state of derivative block";
    parameter Real y_start=0 "Initial value of output";


    // Definition of connectors and inputs and outputs
    //
    Interfaces.ModularHeatPumpControlBus dataBus(final
        nComp=nVal)
      "Data bus with signals to allow control of expansion valves"
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Blocks.Interfaces.RealInput opeAct[nVal]
      "Array of signals with actual expansion valves' opening degrees"
      annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={60,112}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={60,112})));
    Modelica.Blocks.Interfaces.RealOutput opeSet[nVal]
      "Array of set signals for expansion valves' opening degrees"
      annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-60,112}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-60,112})));
    Continuous.LimPID internalController(
      k=k,
      Ti=Ti,
      Ni=Ni,
      Td=Td,
      Nd=Nd,
      wp=wp,
      wd=wd,
      yMax=yMax,
      yMin=yMin,
      initType=initType,
      xi_start=xi_start,
      xd_start=xd_start,
      y_start=y_start,
      reverseAction=reverseAction,
      final reset=AixLib.Types.Reset.Input,
      controllerType=Modelica.Blocks.Types.SimpleController.PI)
      "Internal controller if internal controller is required"
      annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
    Modelica.Blocks.Interfaces.BooleanOutput useExt
      "Boolean expressing of external set signal is used"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-60,0})));

  equation
    // Connect input signals - check if manual input is used
    //
    connect(useExt, dataBus.extCon)
      annotation (Line(points={{-60,0},{-60,-80},{0.05,-80},{0.05,-99.95}},
                  color={255,0,255}));
    if useExt == true then
      connect(opeSet, dataBus.extSetSig);
    else
    end if;

    // Connect output signals
    //
    connect(opeAct, dataBus.actSetSig)
      annotation (Line(points={{60,112},{60,-80},{0.05,-80},{0.05,-99.95}},
                  color={0,0,127}));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-80,60},{80,-60}},
            lineColor={0,0,0},
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5),
          Text(
            extent={{-76,90},{76,-30}},
            lineColor={175,175,175},
            lineThickness=0.5,
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid,
            textStyle={TextStyle.Bold},
            textString="Control"),
          Line(
            points={{0,-70},{0,-96}},
            color={244,125,35},
            thickness=0.5),
          Ellipse(
            extent={{-10,-50},{10,-70}},
            lineColor={0,0,0},
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid,
            startAngle=0,
            endAngle=360),
          Line(
            points={{-60,92},{-60,70}},
            color={244,125,35},
            thickness=0.5),
          Ellipse(
            extent={{-70,70},{-50,50}},
            lineColor={0,0,0},
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid,
            startAngle=0,
            endAngle=360),
          Line(
            points={{60,92},{60,70}},
            color={244,125,35},
            thickness=0.5),
          Ellipse(
            extent={{50,70},{70,50}},
            lineColor={0,0,0},
            fillColor={244,125,35},
            fillPattern=FillPattern.Solid,
            startAngle=0,
            endAngle=360)}),
          Diagram(
            coordinateSystem(preserveAspectRatio=false)));
  end PartialModularController;
end BaseClasses;
