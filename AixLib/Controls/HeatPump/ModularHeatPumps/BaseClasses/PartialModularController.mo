within AixLib.Controls.HeatPump.ModularHeatPumps.BaseClasses;
partial model PartialModularController
  "Base model used for all modular controllers"

  // Definition of parameters describing modular approach
  //
  parameter Integer nCom = 1
    "Number of components"
    annotation(Dialog(tab="General",group="Modular approach"),
               HideResult=true);
  parameter Boolean useExt = true
    "= true, if external signal is used instead of internal controllers"
    annotation(Dialog(tab="General",group="Modular approach"),
               HideResult=true);

  // Definition of parameters describing the controller
  //
  parameter Modelica.Blocks.Types.SimpleController controllerType[nCom]=
    fill(Modelica.Blocks.Types.SimpleController.PID,nCom)
    "Type of controller"
    annotation(Dialog(tab="Controller",group="General"),
               HideResult=true);
  parameter Boolean reverseAction[nCom] = fill(false,nCom)
    "= true, if medium flow rate is throttled through cooling coil controller"
    annotation(Dialog(tab="Controller",group="General"),
               HideResult=true);
  parameter AixLib.Types.Reset reset[nCom]=
    fill(AixLib.Types.Reset.Disabled,nCom)
    "Type of controller output reset"
    annotation(Dialog(tab="Controller",group="General"),
               HideResult=true);

  parameter Real k[nCom] = fill(1,nCom)
    "Gain of controller"
    annotation(Dialog(tab="Controller",group="Proportional term"),
               HideResult=true);

  parameter Modelica.Units.SI.Time Ti[nCom]=fill(0.5, nCom)
    "Time constant of integrator block" annotation (Dialog(tab="Controller",
        group="Integral term"), HideResult=true);
  parameter Real Ni[nCom] = fill(0.9,nCom)
    "Ni*Ti is time constant of anti-windup compensation"
    annotation(Dialog(tab="Controller",group="Integral term"),
               HideResult=true);

  parameter Modelica.Units.SI.Time Td[nCom]=fill(0.1, nCom)
    "Time constant of derivative block" annotation (Dialog(tab="Controller",
        group="Derivative term"), HideResult=true);
  parameter Real Nd[nCom] = fill(10,nCom)
    "The higher Nd, the more ideal the derivative block"
    annotation(Dialog(tab="Controller",group="Derivative term"),
               HideResult=true);

  parameter Real wp[nCom] = fill(1,nCom)
    "Set-point weight for Proportional block (0..1)"
    annotation(Dialog(tab="Controller",group="Wheightning"),
               HideResult=true);
  parameter Real wd[nCom] = fill(0,nCom)
    "Set-point weight for Derivative block (0..1)"
    annotation(Dialog(tab="Controller",group="Wheightning"),
               HideResult=true);

  parameter Real yMax[nCom] = fill(1,nCom)
    "Upper limit of output"
    annotation(Dialog(tab="Controller",group="Controller limits"),
               HideResult=true);
  parameter Real yMin[nCom] = fill(0,nCom)
    "Lower limit of output"
    annotation(Dialog(tab="Controller",group="Controller limits"),
               HideResult=true);

  parameter Modelica.Blocks.Types.Init initType[nCom]=fill(Modelica.Blocks.Types.Init.InitialState,
      nCom)
    "Init: (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(tab="Initialisation", group="General"), HideResult=true);
  parameter Real xi_start[nCom] = fill(0,nCom)
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(tab="Initialisation",group="Start values"),
               HideResult=true);
  parameter Real xd_start[nCom] = fill(0,nCom)
    "Initial or guess value for state of derivative block"
    annotation(Dialog(tab="Initialisation",group="Start values"),
               HideResult=true);
  parameter Real y_start[nCom] = fill(0,nCom)
    "Initial value of output"
    annotation(Dialog(tab="Initialisation",group="Start values"),
               HideResult=true);

  // Definition of models
  //
  Continuous.LimPID intCon[nCom](
    final controllerType=controllerType,
    final k=k,
    final Ti=Ti,
    final Ni=Ni,
    final Td=Td,
    final Nd=Nd,
    final wp=wp,
    final wd=wd,
    final yMax=yMax,
    final yMin=yMin,
    final initType=initType,
    final xi_start=xi_start,
    final xd_start=xd_start,
    final y_start=y_start,
    final reverseActing=reverseAction,
    final reset=reset) if not useExt
    "Internal controller if internal controller is required"
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));

  // Definition of connectors and inputs and outputs
  //
  Modelica.Blocks.Interfaces.BooleanOutput useExtBlo
    "Boolean block used to set data bus' useExt-signal"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,0})));
  Modelica.Blocks.Interfaces.RealOutput manVarThr[nCom]
    "Input connector to pass controller's manipualted signals through if activated"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-60,70})));

  Modelica.Blocks.Interfaces.RealInput curManVar[nCom]
    "Array of signals with current manipulated variables of controlled components"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,112}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,112})));
  Modelica.Blocks.Interfaces.RealOutput manVar[nCom]
    "Array of manipulated variables for controlled components" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,112}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,112})));

  Interfaces.ModularHeatPumpControlBus dataBus "Data bus with control signals"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

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
          endAngle=360),
        Text(
          extent={{-100,170},{100,130}},
          lineColor={28,108,200},
          textString="%name")}),
        Diagram(
          coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>October 17, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a base model used by all modular controller models. It
  defines basic inputs, outputs, parameters and sub-models. The main
  inputs and outputs are the modular heat pump control bus <a href=
  \"modelica://AixLib.Controls.Interfaces.ModularHeatPumpControlBus\">AixLib.Controls.Interfaces.ModularHeatPumpControlBus</a>,
  the manipulated signals passed to the controlled components and the
  current manipulated signals. The main sub-model is a PID controller
  presented in <a href=
  \"modelica://AixLib.Controls.Continuous.LimPID\">AixLib.Controls.Continuous.LimPID</a>
  that is initialised if no external controller is used. Furthermore,
  all parameters with respect to the PID controller are propagated
  because the modular controller shall be used in an architectural
  modeling approach.
</p>
<h4>
  Equations needed for completion
</h4>
<p>
  For completion of a modular controller extending from this base
  class, it is necessary to provide an internal control strategy. This
  strategy may differ from component to component. Therefore, the User
  must define two things:
</p>
<ul>
  <li>Connect <code>useExtBlo</code> with the appropriate data bus
  connector if required.
  </li>
  <li>Connect <code>setVal</code> with internal or external manipulated
  signal depending on <code>useExtBlo</code>.
  </li>
</ul>
</html>"));
end PartialModularController;
