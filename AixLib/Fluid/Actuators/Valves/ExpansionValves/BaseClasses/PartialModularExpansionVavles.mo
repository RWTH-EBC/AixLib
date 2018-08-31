within AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses;
partial model PartialModularExpansionVavles
  "Base model for all modular expansion valve models"

  // Definition of parameters describing the modular approach in general
  //
  parameter Integer nVal = 1
    "Number of valves - each valve will be connected to an individual port_b"
    annotation(Dialog(tab="General",group="Modular approach"));

  // Definition of replaceable expansion valve models
  //
  replaceable model SimpleExpansionValve =
    SimpleExpansionValves.IsenthalpicExpansionValve
    constrainedby PartialExpansionValve
    "Model of simple expansion valve"
    annotation (choicesAllMatching=true,
                Dialog(tab="Expansion valves", group="General"));

  SimpleExpansionValve modExpVal[nVal](
    redeclare each final package Medium = Medium,
    final AVal=AVal,
    final dInlPip=dInlPip,
    final useInpFil=useInpFil,
    final risTim=risTim,
    final calcProc=calcProc,
    final mFlowNom=mFlowNom,
    final dpNom=dpNom,
    redeclare final model FlowCoefficient = FlowCoefficient,
    each final allowFlowReversal=allowFlowReversal,
    each final dp_start=dp_start,
    final m_flow_nominal=mFlowNom)
    "Array of expansion valves"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));

  // Definition of parameters describing the expansion valves
  //
  parameter Modelica.SIunits.Area AVal[nVal] = fill(2e-6, nVal)
    "Cross-sectional areas of the valves when they are fully opened"
    annotation(Dialog(tab="Expansion valves",group="Geometry"),
               HideResult=not show_parVal);
  parameter Modelica.SIunits.Diameter dInlPip[nVal] = fill(7.5e-3, nVal)
    "Diameters of the pipes at valves' inlets"
    annotation(Dialog(tab="Expansion valves",group="Geometry"),
               HideResult=not show_parVal);

  parameter Boolean useInpFil[nVal] = fill(false, nVal)
    "= true, if transient behaviours of valves opening or closing are computed"
    annotation(Dialog(tab="Expansion valves",group="Transient behaviour"),
               HideResult=not show_parVal);
  parameter Modelica.SIunits.Time risTim[nVal] = fill(0.5, nVal)
    "Time until valves opening reach 99.6 % of the set values"
    annotation(Dialog(tab="Expansion valves",group="Transient behaviour"),
               HideResult=not show_parVal);

  parameter Utilities.Types.CalcProc calcProc[nVal]=fill(Utilities.Types.CalcProc.flowCoefficient,
      nVal) "Chose predefined calculation method for flow coefficients"
    annotation (Dialog(tab="Expansion valves", group="Flow Coefficient"),
      HideResult=not show_parVal);
  parameter Modelica.SIunits.MassFlowRate mFlowNom[nVal]=
    {m_flow_nominal/sum(AVal)*AVal[i] for i in 1:nVal}
    "Mass flow at nominal conditions"
    annotation(Dialog(tab="Expansion valves",group="Flow Coefficient"),
               HideResult=not show_parVal);
  parameter Modelica.SIunits.PressureDifference dpNom[nVal]=
    fill(dp_nominal, nVal)
    "Pressure drop at nominal conditions"
    annotation(Dialog(tab="Expansion valves",group="Flow Coefficient"),
               HideResult=not show_parVal);

  replaceable model FlowCoefficient =
    Utilities.FlowCoefficient.SpecifiedFlowCoefficients.ConstantFlowCoefficient
    constrainedby BaseClasses.PartialFlowCoefficient
    "Model that describes the calculation of the flow coefficient"
    annotation(choicesAllMatching=true,
               Dialog(tab="Expansion valves",group="Flow Coefficient"),
               HideResult=not show_parVal);

  /*Parameters presented above are used to define each element of the 
    expansion valve vector. Therefore, the parameters are identically to the 
    parameters of a simple expension valve aside from the fact that the 
    parameters are introduced as arraies
  */

  // Definition of replaceable controller model
  //
  replaceable model ModularController =
    Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController
    constrainedby
    Controls.HeatPump.ModularHeatPumps.BaseClasses.PartialModularController
    "Model of the modular controller"
    annotation (choicesAllMatching=true,
                Dialog(tab="Controller", group="General"));

  ModularController expValCon(
    final nCom=nVal,
    final useExt=useExt,
    final controllerType=controllerType,
    final reverseAction=reverseAction,
    final reset=reset,
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
    final y_start=y_start)
    "Model of internal controller"
    annotation (
    Placement(transformation(extent={{-10,-78},{10,-58}})));

  // Definition of parameters describing the expansion valve controller
  //
  parameter Boolean useExt = false
    "= true, if external signal is used instead of internal controllers"
    annotation(Dialog(tab="Controller", group="Base setup"),
               HideResult=not show_parCon);
  parameter Modelica.Blocks.Types.SimpleController controllerType[nVal]=
    fill(Modelica.Blocks.Types.SimpleController.PID,nVal)
    "Type of controller"
    annotation(Dialog(tab="Controller", group="Base setup"),
               HideResult=not show_parCon);
  parameter Boolean reverseAction[nVal] = fill(false,nVal)
    "= true, if medium flow rate is throttled through cooling coil controller"
    annotation(Dialog(tab="Controller", group="Base setup"),
               HideResult=not show_parCon);
  parameter AixLib.Types.Reset reset[nVal]=
    fill(AixLib.Types.Reset.Disabled,nVal)
    "Type of controller output reset"
    annotation(Dialog(tab="Controller", group="Base setup"),
               HideResult=not show_parCon);

  parameter Real k[nVal] = fill(1,nVal)
    "Gain of controller"
    annotation(Dialog(tab="Controller", group="PID setup"),
               HideResult=not show_parCon);
  parameter Modelica.SIunits.Time Ti[nVal] = fill(0.5,nVal)
    "Time constant of integrator block"
    annotation(Dialog(tab="Controller", group="PID setup"),
               HideResult=not show_parCon);
  parameter Real Ni[nVal] = fill(0.9,nVal)
    "Ni*Ti is time constant of anti-windup compensation"
    annotation(Dialog(tab="Controller", group="PID setup"),
               HideResult=not show_parCon);
  parameter Modelica.SIunits.Time Td[nVal] = fill(0.1,nVal)
    "Time constant of derivative block"
    annotation(Dialog(tab="Controller", group="PID setup"),
               HideResult=not show_parCon);
  parameter Real Nd[nVal] = fill(10,nVal)
    "The higher Nd, the more ideal the derivative block"
    annotation(Dialog(tab="Controller", group="PID setup"),
               HideResult=not show_parCon);

  parameter Real wp[nVal] = fill(1,nVal)
    "Set-point weight for Proportional block (0..1)"
    annotation(Dialog(tab="Controller", group="Weighting and limits"),
               HideResult=not show_parCon);
  parameter Real wd[nVal] = fill(0,nVal)
    "Set-point weight for Derivative block (0..1)"
    annotation(Dialog(tab="Controller", group="Weighting and limits"),
               HideResult=not show_parCon);
  parameter Real yMax[nVal] = fill(1,nVal)
    "Upper limit of output"
    annotation(Dialog(tab="Controller", group="Weighting and limits"),
               HideResult=not show_parCon);
  parameter Real yMin[nVal] = fill(0,nVal)
    "Lower limit of output"
    annotation(Dialog(tab="Controller", group="Weighting and limits"),
               HideResult=not show_parCon);

  parameter Modelica.Blocks.Types.InitPID initType[nVal]=
    fill(Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,nVal)
    "Init: (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Dialog(tab="Advanced", group="Initialisation Controller"),
               HideResult=not show_parCon);
  parameter Real xi_start[nVal]=fill(0, nVal)
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(tab="Advanced", group="Initialisation Controller"),
               HideResult=not show_parCon);
  parameter Real xd_start[nVal]=fill(0, nVal)
    "Initial or guess value for state of derivative block"
    annotation(Dialog(tab="Advanced", group="Initialisation Controller"),
               HideResult=not show_parCon);
  parameter Real y_start[nVal]=fill(0, nVal)
    "Initial value of output"
    annotation(Dialog(tab="Advanced", group="Initialisation Controller"),
               HideResult=not show_parCon);

  /*Parameters presented above are used to define each element of the 
    expansion valve controller. Therefore, the parameters are identically to the 
    parameters of the controller aside from the fact that the 
    parameters are introduced as arraies
  */

  // Extends base port model and set base parameters
  //
  extends Fluid.Interfaces.PartialModularPort_b(
    redeclare replaceable package Medium =
      Modelica.Media.R134a.R134a_ph,
    final nPorts=nVal);

  // Definition of parameters describing diagnostics
  //
  parameter Boolean show_parVal = false
    "= true, if expansions valves' input parameters are shown in results"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_parCon = false
    "= true, if controller's input parameters are shown in results"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  // Definition of connectors
  //
  Controls.Interfaces.ModularHeatPumpControlBus dataBus(
    final nVal=nVal) "Data bus connector"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));


equation
  // Connect port_a with inlet ports of expansion valves
  //
  for i in 1:nVal loop
    connect(port_a, modExpVal[i].port_a);
  end for;

  // Connect data bus and further control signals
  //
  connect(expValCon.manVar, modExpVal.manVarVal)
    annotation (Line(points={{-6,-56.8},{-6,-14},
                {-5,-14},{-5,-10.6}}, color={0,0,127}));
  connect(modExpVal.curManVarVal, expValCon.curManVar)
    annotation (Line(points={{5.1,-10.5},{5.1,-13.25},
                {6,-13.25},{6,-56.8}}, color={0,0,127}));
  connect(dataBus, expValCon.dataBus)
    annotation (Line(points={{0,-100},{0,-78}},
                color={255,204,51},
                thickness=0.5));

  annotation (Icon(graphics={
        Polygon(
          points={{0,-50},{-20,-34},{-20,-64},{0,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,-50},{20,-34},{20,-64},{0,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-90,0},{-50,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{20,50},{50,50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Ellipse(
          extent={{-10,-18},{10,-38}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-10,-18},{10,-38}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Line(
          points={{0,-38},{0,-50}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{30,72},{30,-66}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{30,72},{10,72}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{10,22},{30,22}},
          color={244,125,35},
          thickness=0.5),
        Polygon(
          points={{0,0},{-20,16},{-20,-14},{0,0}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,0},{20,16},{20,-14},{0,0}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{-10,32},{10,12}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-10,32},{10,12}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Line(
          points={{0,12},{0,0}},
          color={0,0,0},
          thickness=0.5),
        Polygon(
          points={{0,50},{-20,66},{-20,36},{0,50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,50},{20,66},{20,36},{0,50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{-10,82},{10,62}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-10,82},{10,62}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Line(
          points={{0,62},{0,50}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-52,50},{-20,50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-52,0},{-20,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-52,-50},{-20,-50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-52,50},{-52,-50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Ellipse(
          extent={{-54,2},{-50,-2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{10,-28},{30,-28}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{20,0},{90,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{20,-50},{50,-50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{50,26},{90,26}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{50,-26},{90,-26}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{50,50},{50,26}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{50,-26},{50,-50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Rectangle(
          extent={{-20,-70},{20,-90}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-18,-70},{18,-90}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="Control"),
        Ellipse(
          extent={{-2,-88},{2,-92}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{-2,-68},{2,-72}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Line(
          points={{0,-68},{0,-66}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{0,-92},{0,-96}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{30,-66},{0,-66}},
          color={244,125,35},
          thickness=0.5)}), Documentation(revisions="<html>
<ul>
  <li>
  October 17, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This is a base model for modular expansion valves that are used, for example, 
in close-loop systems like heat pumps or chillers.
</p>
<h4>Definitions needed for completion</h4>
<p>
Three definitions need to be added by an extending class using this component:
</p>
<ul>
<li>Redecleration of the model <code>SimpleExpansionValve</code>.</li>
<li>Redecleration of the model <code>ModularController</code>.</li>
<li>Connection of <code>expansionValves[i]</code> with <code>ports_b[i]</code>.</li>
</ul>
<p>
The latter provides the possibility to add further components (e.g. sensors or
pipes) located at the expansion valves' outlets.
</p>
<h4>Modeling approaches</h4>
<p>
This base model mainly consists of two sub-models and, therefore, please 
checkout these models for further information of underlying modeling
approaches:
</p>
<ul>
<li>
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve</a>.
</li>
<li>
<a href=\"modelica://AixLib.Controls.HeatPump.ModularHeatPumps.BaseClasses.PartialModularController\">
AixLib.Controls.HeatPump.ModularHeatPumps.BaseClasses.PartialModularController</a>.
</li>
</ul>
</html>"));
end PartialModularExpansionVavles;
