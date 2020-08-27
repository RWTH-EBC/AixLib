within AixLib.Fluid.Movers.Compressors.BaseClasses;
partial model PartialModularCompressors
  "Base model for all modular compressor models"

  // Definition of the medium
  //
  replaceable package Medium = Modelica.Media.R134a.R134a_ph
      constrainedby Modelica.Media.Interfaces.PartialMedium
      "Medium in the component"
      annotation (choicesAllMatching = true);

  // Definition of parameters describing the modular approach in general
  //
  parameter Integer nCom = 1
    "Number of compressors in parallel"
    annotation(Dialog(tab="General",group="Modular approach"));

  // Definition of replaceable compressor models
  //
  replaceable model SimpleCompressor =
    SimpleCompressors.RotaryCompressors.RotaryCompressor
    constrainedby PartialCompressor
    "Model of the simple compressor in parallel"
    annotation (choicesAllMatching=true,
                Dialog(tab="Compressors", group="General"));

  SimpleCompressor modCom[nCom](
    redeclare final package Medium=Medium,
    final VDis=VDis,
    final epsRef=epsRef,
    final diameterInl=diameterInl,
    final diameterOut=diameterOut,
    final rotSpeMax=rotSpeMax,
    final piPreMax=piPreMax,
    final useInpFil=useInpFil,
    final risTim=risTim,
    redeclare final model EngineEfficiency=EngineEfficiency,
    redeclare final model VolumetricEfficiency=VolumetricEfficiency,
    redeclare final model IsentropicEfficiency=IsentropicEfficiency,
    final zetInl=zetInl,
    final zetOut=zetOut,
    final from_dp=from_dp,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearized,
    final heaTraMod=heaTraMod,
    final mWal=mWal,
    final cpWal=cpWal,
    final kAMeaInl=kAMeaInl,
    final kAMeaOut=kAMeaOut,
    final kAMeaAmb=kAMeaAmb,
    final iniTWal0=iniTWal0,
    final TWal0=TWal0,
    each final allowFlowReversal=allowFlowReversal,
    each final dp_start=dp_start,
    each final m_flow_start=m_flow_start,
    each final m_flow_small=m_flow_small,
    each final m_flow_nominal=m_flow_nominal,
    each final show_T=show_T,
    each final show_V_flow=show_V_flow,
    each final show_staEff=show_staEff,
    each final show_qua=show_qua,
    final rotSpe0=rotSpe0,
    final pInl0=pInl0,
    final TInl0=TInl0)
    "Array of compressor models in parallel"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));

  /*To enable propagation of parameters, the simple compressor is introduced
    as a replaceable model and its instance propagates all parameters
    required.
  */

  // Definition of parameters describing general options
  //
  parameter Modelica.SIunits.Volume
    VDis[nCom](min=0) = fill(13e-6, nCom)
    "Displacement volume of the compressor"
    annotation(Dialog(tab="Compressors",group="Geometry"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.Efficiency
    epsRef[nCom](min=0, max=1, nominal=0.05) = fill(0.04, nCom)
    "Ratio of the real and the ideal displacement volume"
    annotation(Dialog(tab="Compressors",group="Geometry"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.Diameter
    diameterInl[nCom](min=0) = fill(12e-3, nCom)
    "Diameter of the pipe at compressor's inlet"
    annotation(Dialog(tab="Compressors",group="Geometry"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.Diameter
    diameterOut[nCom](min=0) = fill(8e-3, nCom)
    "Diameter of the pipe at compressor's outlet"
    annotation(Dialog(tab="Compressors",group="Geometry"),
               HideResult=not show_parCom);

  parameter Modelica.SIunits.Frequency
    rotSpeMax[nCom](min=0) = fill(120, nCom)
    "Maximal rotational speed executable by the compressor"
    annotation(Dialog(tab="Compressors",group="Compressor's characterisitcs"),
               HideResult=true);
  parameter Real
    piPreMax[nCom](min=1, unit="1") = fill(15, nCom)
    "Maximal pressure ratio executable by the compressor"
    annotation(Dialog(tab="Compressors",group="Compressor's characterisitcs"),
               HideResult=true);

  parameter Boolean useInpFil[nCom] = fill(true, nCom)
    "= true, if transient behaviour of rotational speed is computed"
    annotation(Dialog(tab="Compressors",group="Transient behaviour"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.Time risTim[nCom] = fill(0.5, nCom)
    "Time until rotational speed reaches 99.6 % of its set value"
    annotation(Dialog(enable = useInpFil,
               tab="Compressors",group="Transient behaviour"),
               HideResult=not show_parCom);

  // Definition of models describing efficiencies
  //
  replaceable model EngineEfficiency =
    Utilities.EngineEfficiency.SpecifiedEfficiencies.ConstantEfficiency
    constrainedby Utilities.EngineEfficiency.PartialEngineEfficiency
    "Model that describes the calculation of the overall mechanic efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Compressors", group="Efficiencies"),
      HideResult=not show_parCom);
  replaceable model VolumetricEfficiency =
    Utilities.VolumetricEfficiency.SpecifiedEfficiencies.ConstantEfficiency
    constrainedby Utilities.VolumetricEfficiency.PartialVolumetricEfficiency
    "Model that describes the calculation of the overall volumetric efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Compressors", group="Efficiencies"),
      HideResult=not show_parCom);
  replaceable model IsentropicEfficiency =
    AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.ConstantEfficiency
    constrainedby Utilities.IsentropicEfficiency.PartialIsentropicEfficiency
    "Model that describes the calculation of the overall isentropic efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Compressors", group="Efficiencies"),
      HideResult=not show_parCom);

  // Definition of replaceable controller model
  //
  replaceable model ModularController =
    Controls.HeatPump.ModularHeatPumps.ModularCompressorController
    constrainedby Controls.HeatPump.ModularHeatPumps.BaseClasses.PartialModularController
    "Model of the modular controller"
    annotation (choicesAllMatching=true,
                Dialog(tab="Controller", group="General"));

  ModularController modCon(
    final nCom=nCom,
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
    annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));

  /*To enable propagation of parameters, the modular compressor is introduced
    as a replaceable model and its instance propagates all parameters
    required.
  */

  // Definition of parameters describing the expansion valve controller
  //
  parameter Boolean useExt = true
    "= true, if external signal is used instead of internal controllers"
    annotation(Dialog(tab="Controller", group="Base setup"),
               HideResult=not show_parCon);
  parameter Modelica.Blocks.Types.SimpleController controllerType[nCom]=
    fill(Modelica.Blocks.Types.SimpleController.PID, nCom)
    "Type of controller"
    annotation(Dialog(tab="Controller", group="Base setup"),
               HideResult=not show_parCon);
  parameter Boolean reverseAction[nCom] = fill(false, nCom)
    "= true, if medium flow rate is throttled through cooling coil controller"
    annotation(Dialog(tab="Controller", group="Base setup"),
               HideResult=not show_parCon);
  parameter AixLib.Types.Reset reset[nCom]=
    fill(AixLib.Types.Reset.Disabled, nCom)
    "Type of controller output reset"
    annotation(Dialog(tab="Controller", group="Base setup"),
               HideResult=not show_parCon);

  parameter Real k[nCom] = fill(1, nCom)
    "Gain of controller"
    annotation(Dialog(tab="Controller", group="PID setup"),
               HideResult=not show_parCon);
  parameter Modelica.SIunits.Time Ti[nCom] = fill(0.5, nCom)
    "Time constant of integrator block"
    annotation(Dialog(tab="Controller", group="PID setup"),
               HideResult=not show_parCon);
  parameter Real Ni[nCom] = fill(0.9, nCom)
    "Ni*Ti is time constant of anti-windup compensation"
    annotation(Dialog(tab="Controller", group="PID setup"),
               HideResult=not show_parCon);
  parameter Modelica.SIunits.Time Td[nCom] = fill(0.1, nCom)
    "Time constant of derivative block"
    annotation(Dialog(tab="Controller", group="PID setup"),
               HideResult=not show_parCon);
  parameter Real Nd[nCom] = fill(10, nCom)
    "The higher Nd, the more ideal the derivative block"
    annotation(Dialog(tab="Controller", group="PID setup"),
               HideResult=not show_parCon);

  parameter Real wp[nCom] = fill(1, nCom)
    "Set-point weight for Proportional block (0..1)"
    annotation(Dialog(tab="Controller", group="Weighting and limits"),
               HideResult=not show_parCon);
  parameter Real wd[nCom] = fill(0, nCom)
    "Set-point weight for Derivative block (0..1)"
    annotation(Dialog(tab="Controller", group="Weighting and limits"),
               HideResult=not show_parCon);
  parameter Real yMax[nCom] = fill(1, nCom)
    "Upper limit of output"
    annotation(Dialog(tab="Controller", group="Weighting and limits"),
               HideResult=not show_parCon);
  parameter Real yMin[nCom] = fill(0, nCom)
    "Lower limit of output"
    annotation(Dialog(tab="Controller", group="Weighting and limits"),
               HideResult=not show_parCon);

  /*Parameters presented above are used to define each element of the 
    compressor controller. Therefore, the parameters are identically to the 
    parameters of the controller aside from the fact that the 
    parameters are introduced as arraies
  */

  // Definition of parameters describing pressure losses
  //
  parameter Real zetInl[nCom]=
    {((1/0.59-1)^2+(1-(diameterInl[i]/0.066)^2))*(1-(diameterInl[i]/0.066)^2)
    for i in 1:nCom}
    "Pressure loss factor at compressor's inlet for flow of port_a -> port_b"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Pressure losses - General"),
               HideResult=not show_parCom);
  parameter Real zetOut[nCom]=
    {((1/0.59-1)^2+(1-(diameterOut[i]/0.1122)^2))*(1-(diameterOut[i]/0.1122)^2)
    for i in 1:nCom}
    "Pressure loss factor at compressor's outlet for flow of port_a -> port_b"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Pressure losses - General"),
               HideResult=not show_parCom);

  parameter Boolean from_dp[nCom] = fill(false, nCom)
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Pressure losses - Advanced"),
               HideResult=not show_parCom);
  parameter Boolean homotopyInitialization[nCom] = fill(true, nCom)
    "= true, use homotopy method  for initialisation"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Pressure losses - Advanced"),
               HideResult=not show_parCom);
  parameter Boolean linearized[nCom] = fill(false, nCom)
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Pressure losses - Advanced"),
               HideResult=not show_parCom);

  // Definition of parameters describing heat losses
  //
  parameter Utilities.Types.HeatTransferModels
    heaTraMod[nCom] = fill(Utilities.Types.HeatTransferModels.Simplified, nCom)
    "Choose heat transfer model for heat losses at compressor's inlet 
    and outlet"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Heat losses - General"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.Mass mWal[nCom] = fill(2.5, nCom)
    "Mass of the fictitious wall"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Heat losses - Geometry"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.SpecificHeatCapacity cpWal[nCom] = fill(450, nCom)
    "Specific heat capacity of the fictitious wall"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Heat losses - Geometry"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.ThermalConductance kAMeaInl[nCom] = fill(25, nCom)
    "Effective mean thermal conductance between medium and fictitious wall 
    at inlet"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Heat losses - Thermal conductances"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.ThermalConductance kAMeaOut[nCom] = fill(35, nCom)
    "Effective mean thermal conductance between medium and fictitious wall 
    at outlet"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Heat losses - Thermal conductances"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.ThermalConductance kAMeaAmb[nCom] = fill(10, nCom)
    "Effective mean thermal conductance coefficient between fictitious wall 
    and ambient"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Heat losses - Thermal conductances"),
               HideResult=not show_parCom);
  parameter Boolean iniTWal0[nCom] = fill(true, nCom)
    "= true, if wall is initialised at fixed temperature; Otherwise, steady state
    initialisation"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Heat losses - Initialisation"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.Temperature TWal0[nCom] = fill(293.15, nCom)
    "Temperature of wall at initialisation"
    annotation(Dialog(tab = "Pressure and heat losses",
               group="Heat losses - Initialisation"),
               HideResult=not show_parCom);

  // Definition of parameters describing advanced options
  //
  parameter Modelica.SIunits.PressureDifference
    dp_start(displayUnit="Pa") = -20e5
    "Guess value of compressor's dp = port_a.p - port_b.p"
    annotation(Dialog(tab = "Advanced",group="General"),
               HideResult=not show_parCom);
  parameter Medium.MassFlowRate m_flow_start = 0.5*m_flow_nominal
    "Guess value of compressor's m_flow = port_a.m_flowr"
    annotation(Dialog(tab = "Advanced",group="General"),
               HideResult=not show_parCom);
  parameter Medium.MassFlowRate m_flow_small = 1e-6*m_flow_nominal
    "Small mass flow rate for regularization of compressor's zero flow"
    annotation(Dialog(tab = "Advanced",group="General"),
               HideResult=not show_parCom);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation(Dialog(tab="Advanced",group="General"),
               HideResult=not show_parCom);

  // Definition of parameters describing diagnostics
  //
  parameter Boolean show_T = false
    "= true, if compressor's temperatures at port_a and port_b are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_V_flow = false
    "= true, if compressor's volume flow rate at inflowing port is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_staEff = false
    "= true, if thermodynamic states and efficiencies are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"),
               HideResult=true);
  parameter Boolean show_qua = false
    "= true, if vapour qualities are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"),
               HideResult=true);
  parameter Boolean show_parCom = true
    "= true, if compressors' input parameters are shown in results"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_parCon = true
    "= true, if controller's input parameters are shown in results"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  // Definition of parameters used for initialisation
  //
  parameter Modelica.SIunits.Frequency rotSpe0[nCom] = fill(60, nCom)
    "Compressor's rotational spped at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"),
               HideResult=true);
  parameter Modelica.SIunits.AbsolutePressure pInl0[nCom] = fill(3e5, nCom)
    "Pressure at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"),
               HideResult=true);
  parameter Modelica.SIunits.Temperature TInl0[nCom] = fill(283.15, nCom)
    "Temperature at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"),
               HideResult=true);
  parameter Modelica.Blocks.Types.InitPID initType[nCom]=
    fill(Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState,nCom)
    "Init: (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Dialog(tab="Advanced", group="Initialisation Controller"),
               HideResult=not show_parCon);
  parameter Real xi_start[nCom]=fill(0, nCom)
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(tab="Advanced", group="Initialisation Controller"),
               HideResult=not show_parCon);
  parameter Real xd_start[nCom]=fill(0, nCom)
    "Initial or guess value for state of derivative block"
    annotation(Dialog(tab="Advanced", group="Initialisation Controller"),
               HideResult=not show_parCon);
  parameter Real y_start[nCom]=fill(0, nCom)
    "Initial value of output"
    annotation(Dialog(tab="Advanced", group="Initialisation Controller"),
               HideResult=not show_parCon);

  // Definition of parameters deschribing assumptions
  //
  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  // Definition of connectors
  //
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
     m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
     h_outflow(start = Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort[nCom]
    "Heat port for compressors' heat losses"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Controls.Interfaces.ModularHeatPumpControlBus dataBus(
    final nCom=nCom)
    "Connector that contains all relevant control signals"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));


protected
  parameter Utilities.Types.SimpleCompressor simCom = modCom[1].simCom
    "Parameter used to activate or deactivate menue choices";


equation
  // Connect port_a with inlet ports of expansion valves and connect heat ports
  //
  for i in 1:nCom loop
    connect(port_a,modCom[i].port_a);
  end for;
  connect(heatPort,modCom.heatPort);

  // Connect data bus and further control signals
  //
  connect(modCon.dataBus, dataBus)
    annotation (Line(points={{0,-78},{0,-78},{0,-100}},color={255,204,51},
                thickness=0.5));
  connect(modCon.manVar, modCom.manVarCom)
    annotation (Line(points={{-6,-56.8},{-6,-33.4},{-6,-10}},
                color={0,0,127}));
  connect(modCom.curManVarCom, modCon.curManVar)
    annotation (Line(points={{6,-10},{6,-10},{6,-56.8}}, color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-50,-44},{50,-44}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-50,44},{50,44}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
                Ellipse(
                  extent={{20,64},{-20,24}},
                  lineColor={0,0,0},
                  startAngle=0,
                  endAngle=360,
                  fillPattern=FillPattern.Sphere,
                  fillColor={214,214,214}),
                Line(
                  points={{18,36},{-14,30}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{18,52},{-14,58}},
                  color={0,0,0},
                  thickness=0.5),
        Line(
          points={{-50,44},{-50,-44}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
                Ellipse(
                  extent={{20,20},{-20,-20}},
                  lineColor={0,0,0},
                  startAngle=0,
                  endAngle=360,
                  fillPattern=FillPattern.Sphere,
                  fillColor={214,214,214}),
                Line(
                  points={{18,-8},{-14,-14}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{18,8},{-14,14}},
                  color={0,0,0},
                  thickness=0.5),
                Ellipse(
                  extent={{20,-24},{-20,-64}},
                  lineColor={0,0,0},
                  startAngle=0,
                  endAngle=360,
                  fillPattern=FillPattern.Sphere,
                  fillColor={214,214,214}),
                Line(
                  points={{18,-52},{-14,-58}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{18,-36},{-14,-30}},
                  color={0,0,0},
                  thickness=0.5),
        Line(
          points={{50,44},{50,-44}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{20,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-100,0},{-20,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Ellipse(
          extent={{-52,2},{-48,-2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{48,2},{52,-2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
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
          points={{0,-68},{0,-64}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{0,-92},{0,-96}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{0,-66},{30,-66}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{30,-66},{30,24}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{30,24},{0,24}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{30,-20},{0,-20}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{-30,-24},{-30,66}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{0,64},{0,90}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-30,66},{0,66}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-30,20},{0,20}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-30,-24},{0,-24}},
          color={255,0,0},
          thickness=0.5),
        Text(
          extent={{-100,140},{100,110}},
          lineColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a base model for modular compressors that are used, for
  example, in close-loop systems like heat pumps or chillers.
</p>
<h4>
  Definitions needed for completion
</h4>
<p>
  Three definitions need to be added by an extending class using this
  component:
</p>
<ul>
  <li>Redecleration of the model <code>modCom</code>.
  </li>
  <li>Redecleration of the model <code>modCon</code>.
  </li>
  <li>Connection of <code>modCom[i].port_b</code> with
  <code>port_b</code>.
  </li>
</ul>
<p>
  The latter provides the possibility to add further components (e.g.
  sensors or pipes) located at the compressors' outlets.
</p>
<h4>
  Modeling approaches
</h4>
<p>
  This base model mainly consists of two sub-models and, therefore,
  please checkout these models for further information of underlying
  modeling approaches:
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompressor\">
    AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompressor</a>.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Controls.HeatPump.ModularHeatPumps.BaseClasses.PartialModularController\">
    AixLib.Controls.HeatPump.ModularHeatPumps.BaseClasses.PartialModularController</a>.
  </li>
</ul>
</html>"));
end PartialModularCompressors;
