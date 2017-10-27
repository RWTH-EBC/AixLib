within AixLib.Fluid.Movers.Compressors.SimpleCompressors;
model RotaryCompressorSimplePressure
  "Model that describes a simple rotary compressor with pressure losses"

  // Definition of the medium
  //
  replaceable package Medium =
    Modelica.Media.R134a.R134a_ph
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium in the component"
    annotation (choicesAllMatching = true);

  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  parameter Modelica.SIunits.PressureDifference dp_start(displayUnit="Pa") = 0
    "Guess value of dp = port_a.p - port_b.p"
    annotation(Dialog(tab = "Advanced"));
  parameter Medium.MassFlowRate m_flow_start = 0
    "Guess value of m_flow = port_a.m_flow"
    annotation(Dialog(tab = "Advanced"));
  // Note: value of m_flow_small shall be refined by derived model,
  // based on local m_flow_nominal
  parameter Medium.MassFlowRate m_flow_small
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));

  parameter Boolean show_T = true
    "= true, if temperatures at port_a and port_b are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_V_flow = true
    "= true, if volume flow rate at inflowing port is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));


  // Definition of parameters describing the geometry
  //
  parameter Modelica.SIunits.Volume
    VDis(min=0) = 13e-6
    "Displacement volume of the compressor"
    annotation(Dialog(tab="General",group="Geometry"));
  parameter Modelica.SIunits.Efficiency
    epsRef(min=0, max=1, nominal=0.05) = 0.04
    "Ratio of the real and the ideal displacement volume"
    annotation(Dialog(tab="General",group="Geometry"));

  parameter Modelica.SIunits.Frequency
    rotSpeMax(min=0) = 120
    "Maximal rotational speed executable by the compressor"
    annotation(Dialog(tab="General",group="Compressor's characterisitcs"),
               HideResult=true);
  parameter Real
    piPreMax(min=1, unit="1") = 15
    "Maximal pressure ratio executable by the compressor"
    annotation(Dialog(tab="General",group="Compressor's characterisitcs"),
               HideResult=true);

  parameter Boolean useInpFil = true
    "= true, if transient behaviour of rotational speed is computed"
    annotation(Dialog(group="Transient behaviour"));
  parameter Modelica.SIunits.Time risTim = 0.5
    "Time until rotational speed reaches 99.6 % of its set value"
    annotation(Dialog(enable = useInpFil,
               group="Transient behaviour"));

  // Definition of models describing efficiencies
  //
  replaceable model EngineEfficiency =
    Utilities.EngineEfficiency.ConstantEfficiency
    constrainedby Utilities.EngineEfficiency.PartialEngineEfficiency
    "Model that describes the calculation of the overall mechanic efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Efficiencies and similitude theory", group="Engine efficiency"));
  replaceable model VolumetricEfficiency =
    Utilities.VolumetricEfficiency.ConstantEfficiency
    constrainedby Utilities.VolumetricEfficiency.PartialVolumetricEfficiency
    "Model that describes the calculation of the overall volumetric efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Efficiencies and similitude theory", group="Volumetric efficiency"));
  replaceable model IsentropicEfficiency =
    Utilities.IsentropicEfficiency.ConstantEfficiency
    constrainedby Utilities.IsentropicEfficiency.PartialIsentropicEfficiency
    "Model that describes the calculation of the overall isentropic efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Efficiencies and similitude theory", group="Isentropic efficiency"));

  // Extensions and parameter propagation
  //
//   extends AixLib.Fluid.Interfaces.PartialTwoPortTransport(
//     redeclare replaceable package Medium =
//         Modelica.Media.R134a.R134a_ph,
//     dp_start=-20e5,
//     m_flow_start=0.5*m_flow_nominal,
//     m_flow_small=1e-6*m_flow_nominal,
//     show_T=false,
//     show_V_flow=false);

  // Definition of parameters describing nominal conditions
  //
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation(Dialog(tab="Advanced"),
               HideResult=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_lea = 1e-8
    "Leackage mass flow rate used for compressor shut-down"
    annotation(Dialog(tab="Advanced"),
               HideResult=true);

  // Definition of parameters describing diagnostics
  //
  parameter Boolean show_staEff = false
    "= true, if thermodynamic states and efficiencies are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"),
               HideResult=true);
  parameter Boolean show_qua = false
    "= true, if vapour qualities are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"),
               HideResult=true);

  // Definition of parameters used for initialisation
  //
  parameter Modelica.SIunits.Frequency rotSpe0 = 60
    "Compressor's rotational spped at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"),
               HideResult=true);
  parameter Modelica.SIunits.AbsolutePressure pInl0 = 3e5
    "Pressure at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"),
               HideResult=true);
  parameter Modelica.SIunits.Temperature TInl0 = 283.15
    "Temperature at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation"),
               HideResult=true);
  parameter Modelica.SIunits.Density dInl0=
    Medium.density(Medium.setState_pTX(p=pInl0,T=TInl0))
    "Density at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation",
               enable=false),
               HideResult=true);
  parameter Modelica.SIunits.SpecificEnthalpy hInl0=
    Medium.specificEnthalpy(Medium.setState_pTX(p=pInl0,T=TInl0))
    "Specific enthalpy at compressor's inlet at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation",
               enable=false),
               HideResult=true);











  RotaryCompressorSimple rotCom(
    redeclare replaceable package Medium = Medium,
    VDis=VDis,
    epsRef=epsRef,
    rotSpeMax=rotSpeMax,
    piPreMax=piPreMax,
    useInpFil=useInpFil,
    risTim=risTim,
    redeclare model EngineEfficiency = EngineEfficiency,
    redeclare model VolumetricEfficiency = VolumetricEfficiency,
    redeclare model IsentropicEfficiency = IsentropicEfficiency,
    allowFlowReversal=allowFlowReversal,
    dp_start=dp_start,
    m_flow_start=m_flow_start,
    m_flow_small=m_flow_small,
    show_T=show_T,
    show_V_flow=show_V_flow,
    m_flow_nominal=m_flow_nominal,
    m_flow_lea=m_flow_lea,
    show_staEff=show_staEff,
    show_qua=show_qua,
    rotSpe0=rotSpe0,
    pInl0=pInl0,
    TInl0=TInl0)                                   "Model of a simple rotary compressor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  FixedResistances.HydraulicResistance hydraulicResistance(
    m_flow_nominal=m_flow_nominal,
    redeclare final replaceable package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    final show_T=false,
    from_dp=from_dp,
    homotopyInitialization=homotopyInitialization,
    linearized=linearized,
    zeta=zetInl,
    diameter=diameterInl,
    dp_start=dp_start,
    m_flow_start=m_flow_start)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  FixedResistances.HydraulicResistance hydraulicResistance1(
    redeclare final replaceable package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    final show_T=false,
    final from_dp=from_dp,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearized,
    zeta=zetOut,
    diameter=diameterOut,
    final dp_start=dp_start,
    final m_flow_start=m_flow_start)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat port connector to calculate heat losses to ambient"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealInput
    manVarCom(start=rotSpe0, quantity = "Velocity", unit = ("1/s"))
    "Prescribed compressor's rotational speed"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,100})),
        HideResult=true);
  Modelica.Blocks.Interfaces.RealOutput
    curManVarCom(quantity="Velocity", unit=("1/s"))
    "Current compressor's rotational speed"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,100})), HideResult=true);
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
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  final parameter Real zetInl=10
    "Pressure loss factor for flow of port_a -> port_b";
  final parameter Modelica.SIunits.Diameter diameterInl=1
    "Diameter of component";
  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)";
  parameter Boolean homotopyInitialization=true "= true, use homotopy method";
  parameter Boolean linearized=false
    "= true, use linear relation between m_flow and dp for any flow rate";
  final parameter Real zetOut=10
    "Pressure loss factor for flow of port_a -> port_b";
  final parameter Modelica.SIunits.Diameter diameterOut=0.1
    "Diameter of component";
equation

  connect(port_a, hydraulicResistance.port_a)
    annotation (Line(points={{-100,0},{-50,0}}, color={0,127,255}));
  connect(hydraulicResistance.port_b, rotCom.port_a)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,127,255}));
  connect(rotCom.port_b, hydraulicResistance1.port_a)
    annotation (Line(points={{10,0},{30,0}}, color={0,127,255}));
  connect(hydraulicResistance1.port_b, port_b)
    annotation (Line(points={{50,0},{100,0}}, color={0,127,255}));
  connect(manVarCom, rotCom.manVarCom) annotation (Line(points={{-60,100},{-60,30},
          {-6,30},{-6,10}}, color={0,0,127}));
  connect(rotCom.curManVarCom, curManVarCom) annotation (Line(points={{6,10},{6,
          30},{60,30},{60,100}}, color={0,0,127}));
  connect(rotCom.heatPort, heatPort)
    annotation (Line(points={{0,-10},{0,-100}}, color={191,0,0}));
  annotation (Icon(graphics={
        Ellipse(
          extent={{-60,40},{20,-40}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,28},{20,-32}},
          lineColor={0,0,0},
          fillColor={182,182,182},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent={{-26,6},{-14,-6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-22,46},{-18,26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{80,80},{-80,-80}},
                  lineColor={0,0,0},
                  startAngle=0,
                  endAngle=360,
                  fillPattern=FillPattern.Sphere,
                  fillColor={214,214,214}),
                Line(
                  points={{74,-30},{-60,-52}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{74,30},{-58,54}},
                  color={0,0,0},
                  thickness=0.5),
        Ellipse(
          extent={{-60,40},{20,-40}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,28},{20,-32}},
          lineColor={0,0,0},
          fillColor={182,182,182},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent={{-26,6},{-14,-6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-22,46},{-18,26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end RotaryCompressorSimplePressure;
