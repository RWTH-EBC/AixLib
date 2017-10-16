within AixLib.Controls.HeatPump.ModularHeatPumps;
package BaseClasses "Package that contains base models used for controllers of modular heat pumps"
  extends Modelica.Icons.BasesPackage;

  partial model PartialModularController
    "Base model used for all modular controllers"

    // Definition of parameters describing modular approach
    //
    parameter Integer nVal = 1
      "Number of valves"
      annotation(Dialog(tab="General",group="Modular approach"));
    parameter Boolean useExt = true
      "= true, if external signal is used instead of internal controllers"
      annotation(Dialog(tab="General",group="Modular approach"));

    // Definition of parameters describing the controller
    //
    parameter Modelica.Blocks.Types.SimpleController
      controllerType[nVal] = fill(Modelica.Blocks.Types.SimpleController.PID,nVal)
      "Type of controller"
      annotation(Dialog(tab="Controller",group="General"));
    parameter Boolean reverseAction[nVal] = fill(false,nVal)
      "= true, if medium flow rate is throttled through cooling coil controller"
      annotation(Dialog(tab="Controller",group="General"));
    parameter Types.Reset reset[nVal] = fill(AixLib.Types.Reset.Disabled,nVal)
      "Type of controller output reset"
      annotation(Dialog(tab="Controller",group="General"));

    parameter Real k[nVal] = fill(1,nVal)
      "Gain of controller"
      annotation(Dialog(tab="Controller",group="Proportional term"));

    parameter Modelica.SIunits.Time Ti[nVal] = fill(0.5,nVal)
      "Time constant of integrator block"
      annotation(Dialog(tab="Controller",group="Integral term"));
    parameter Real Ni[nVal] = fill(0.9,nVal)
      "Ni*Ti is time constant of anti-windup compensation"
      annotation(Dialog(tab="Controller",group="Integral term"));

    parameter Modelica.SIunits.Time Td[nVal] = fill(0.1,nVal)
      "Time constant of derivative block"
      annotation(Dialog(tab="Controller",group="Derivative term"));
    parameter Real Nd[nVal] = fill(10,nVal)
      "The higher Nd, the more ideal the derivative block"
      annotation(Dialog(tab="Controller",group="Derivative term"));

    parameter Real wp[nVal] = fill(1,nVal)
      "Set-point weight for Proportional block (0..1)"
      annotation(Dialog(tab="Controller",group="Wheightning"));
    parameter Real wd[nVal] = fill(0,nVal)
      "Set-point weight for Derivative block (0..1)"
      annotation(Dialog(tab="Controller",group="Wheightning"));

    parameter Real yMax[nVal] = fill(1,nVal)
      "Upper limit of output"
      annotation(Dialog(tab="Controller",group="Controller limits"));
    parameter Real yMin[nVal] = fill(0.02,nVal)
      "Lower limit of output"
      annotation(Dialog(tab="Controller",group="Controller limits"));

    parameter Modelica.Blocks.Types.InitPID initType[nVal]=
      fill(Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,nVal)
      "Init: (1: no init, 2: steady state, 3: initial state, 4: initial output)"
      annotation(Dialog(tab="Initialisation",group="General"));
    parameter Real xi_start[nVal] = fill(0,nVal)
      "Initial or guess value value for integrator output (= integrator state)"
      annotation(Dialog(tab="Initialisation",group="Start values"));
    parameter Real xd_start[nVal] = fill(0,nVal)
      "Initial or guess value for state of derivative block"
      annotation(Dialog(tab="Initialisation",group="Start values"));
    parameter Real y_start[nVal] = fill(0,nVal)
      "Initial value of output"
      annotation(Dialog(tab="Initialisation",group="Start values"));

    // Definition of models
    //
    Continuous.LimPID internalController[nVal](
      controllerType=controllerType,
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
      final reset=reset,
      u_m=dataBus.actConVar,
      u_s=dataBus.intSetSig) if (useExt == true)
      "Internal controller if internal controller is required"
      annotation (Placement(transformation(extent={{-70,40},{-50,60}})));

    // Definition of connectors and inputs and outputs
    //
    Interfaces.ModularHeatPumpControlBus dataBus(
      final nComp=nVal)
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

    Modelica.Blocks.Interfaces.BooleanOutput useExtBlo
      "Boolean block used to set data bus' useExt-signal"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-60,0})));


  equation
    // Connect parameters describing if internal or external signal is used
    //
    connect(useExtBlo, dataBus.extConVal)
      annotation (Line(points={{-60,0},{-60,-80},{0.05,-80},{0.05,-99.95}},
                  color={255,0,255}));

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
            extent={{-74,92},{74,-30}},
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
