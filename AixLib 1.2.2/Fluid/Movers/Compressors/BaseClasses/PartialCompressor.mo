within AixLib.Fluid.Movers.Compressors.BaseClasses;
partial model PartialCompressor
  "Partial model for compressor that contains basic definitions used in 
  various compressor models"

  // Definition of the medium
  //
  replaceable package Medium =
    Modelica.Media.R134a.R134a_ph
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium in the component"
    annotation (choicesAllMatching = true);

  // Definition of parameters describing general options
  //
  parameter Modelica.Units.SI.Volume VDis(min=0) = 13e-6
    "Displacement volume of the compressor"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Modelica.Units.SI.Efficiency epsRef(
    min=0,
    max=1,
    nominal=0.05) = 0.04 "Ratio of the real and the ideal displacement volume"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Modelica.Units.SI.Diameter diameterInl(min=0) = 12e-3
    "Diameter of the pipe at compressor's inlet"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Modelica.Units.SI.Diameter diameterOut(min=0) = 8e-3
    "Diameter of the pipe at compressor's outlet"
    annotation (Dialog(tab="General", group="Geometry"));

  parameter Modelica.Units.SI.Frequency rotSpeMax(min=0) = 120
    "Maximal rotational speed executable by the compressor" annotation (Dialog(
        tab="General", group="Compressor's characterisitcs"), HideResult=true);
  parameter Real
    piPreMax(min=1, unit="1") = 15
    "Maximal pressure ratio executable by the compressor"
    annotation(Dialog(tab="General",group="Compressor's characterisitcs"),
               HideResult=true);

  parameter Boolean useInpFil = true
    "= true, if transient behaviour of rotational speed is computed"
    annotation(Dialog(group="Transient behaviour"));
  parameter Modelica.Units.SI.Time risTim=0.5
    "Time until rotational speed reaches 99.6 % of its set value"
    annotation (Dialog(enable=useInpFil, group="Transient behaviour"));

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
      tab = "Efficiencies and similitude theory", group="Engine efficiency"));
  replaceable model VolumetricEfficiency =
    Utilities.VolumetricEfficiency.SpecifiedEfficiencies.ConstantEfficiency
    constrainedby Utilities.VolumetricEfficiency.PartialVolumetricEfficiency
    "Model that describes the calculation of the overall volumetric efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Efficiencies and similitude theory", group="Volumetric efficiency"));
  replaceable model IsentropicEfficiency =
    AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.ConstantEfficiency
    constrainedby Utilities.IsentropicEfficiency.PartialIsentropicEfficiency
    "Model that describes the calculation of the overall isentropic efficiency"
    annotation (Placement(
      transformation(
      extent={{-36,-40},{-16,-20}})),
      choicesAllMatching=true,
      Dialog(
      tab = "Efficiencies and similitude theory", group="Isentropic efficiency"));

  // Definition of parameters describing pressure losses
  //
  parameter Real zetInl=
    ((1/0.59-1)^2+(1-(diameterInl/0.066)^2))*(1-(diameterInl/0.066)^2)
    "Pressure loss factor at compressor's inlet for flow of port_a -> port_b"
    annotation(Dialog(tab = "Pressure losses",group="General",
               enable = if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureLosses
                        or simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
                        then true else false));
  parameter Real zetOut=
    ((1/0.59-1)^2+(1-(diameterOut/0.1122)^2))*(1-(diameterOut/0.1122)^2)
    "Pressure loss factor at compressor's outlet for flow of port_a -> port_b"
    annotation(Dialog(tab = "Pressure losses",group="General",
               enable = if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureLosses
                        or simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
                        then true else false));

  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation(Dialog(tab = "Pressure losses",group="Advanced",
               enable = if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureLosses
                        or simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
                        then true else false));
  parameter Boolean homotopyInitialization=true
    "= true, use homotopy method  for initialisation"
    annotation(Dialog(tab = "Pressure losses",group="Advanced",
               enable = if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureLosses
                        or simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
                        then true else false));
  parameter Boolean linearized=false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Dialog(tab = "Pressure losses",group="Advanced",
               enable = if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureLosses
                        or simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
                        then true else false));

  // Definition of parameters describing heat losses
  //
  parameter Utilities.Types.HeatTransferModels
    heaTraMod=Utilities.Types.HeatTransferModels.Simplified
    "Choose heat transfer model for heat losses at compressor's inlet 
    and outlet"
    annotation(Dialog(tab = "Heat losses",group="General",
               enable = if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
                        then true else false));
  parameter Modelica.Units.SI.Mass mWal=2.5 "Mass of the fictitious wall"
    annotation (Dialog(
      tab="Heat losses",
      group="Geometry",
      enable=if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
           then true else false));
  parameter Modelica.Units.SI.SpecificHeatCapacity cpWal=450
    "Specific heat capacity of the fictitious wall" annotation (Dialog(
      tab="Heat losses",
      group="Geometry",
      enable=if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
           then true else false));
  parameter Modelica.Units.SI.ThermalConductance kAMeaInl=25 "Effective mean thermal conductance between medium and fictitious wall 
    at inlet" annotation (Dialog(
      tab="Heat losses",
      group="Thermal conductances",
      enable=if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
           then true else false));
  parameter Modelica.Units.SI.ThermalConductance kAMeaOut=35 "Effective mean thermal conductance between medium and fictitious wall 
    at outlet" annotation (Dialog(
      tab="Heat losses",
      group="Thermal conductances",
      enable=if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
           then true else false));
  parameter Modelica.Units.SI.ThermalConductance kAMeaAmb=5 "Effective mean thermal conductance coefficient between fictitious wall 
    and ambient" annotation (Dialog(
      tab="Heat losses",
      group="Thermal conductances",
      enable=if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
           then true else false));
  parameter Boolean iniTWal0=true
    "= true, if wall is initialised at fixed temperature; Otherwise, steady state
    initialisation"
    annotation(Dialog(tab = "Heat losses",group="Initialisation",
               enable = if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
                        then true else false));
  parameter Modelica.Units.SI.Temperature TWal0=293.15
    "Temperature of wall at initialisation" annotation (Dialog(
      tab="Heat losses",
      group="Initialisation",
      enable=if (simCom == Utilities.Types.SimpleCompressor.RotaryCompressorPressureHeatLosses)
           then true else false));

  // Definition of parameters deschribing assumptions
  //
  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);
  parameter Utilities.Types.SimpleCompressor simCom=
    Utilities.Types.SimpleCompressor.Default
    "Parameter used to activate or deactivate menue choices"
    annotation(Dialog(tab="Assumptions",enable=false), Evaluate=true,
               HideResult=true);

  // Definition of parameters describing advanced options
  //
  parameter Modelica.Units.SI.PressureDifference dp_start(displayUnit="Pa") = -20e5
    "Guess value of compressor's dp = port_a.p - port_b.p"
    annotation (Dialog(tab="Advanced", group="General"));
  parameter Medium.MassFlowRate m_flow_start = 0.5*m_flow_nominal
    "Guess value of compressor's m_flow = port_a.m_flowr"
    annotation(Dialog(tab = "Advanced",group="General"));
  parameter Medium.MassFlowRate m_flow_small = 1e-6*m_flow_nominal
    "Small mass flow rate for regularization of compressor's zero flow"
    annotation(Dialog(tab = "Advanced",group="General"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.1
    "Nominal mass flow rate"
    annotation (Dialog(tab="Advanced", group="General"), HideResult=true);

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

  // Definition of parameters used for initialisation
  //
  parameter Modelica.Units.SI.Frequency rotSpe0=60
    "Compressor's rotational spped at initialisation" annotation (Dialog(tab=
          "Advanced", group="Initialisation"), HideResult=true);
  parameter Modelica.Units.SI.AbsolutePressure pInl0=3e5
    "Pressure at compressor's inlet at initialisation" annotation (Dialog(tab=
          "Advanced", group="Initialisation"), HideResult=true);
  parameter Modelica.Units.SI.Temperature TInl0=283.15
    "Temperature at compressor's inlet at initialisation" annotation (Dialog(
        tab="Advanced", group="Initialisation"), HideResult=true);

  // Definition of submodels
  //
  replaceable model CompressionProcess =
    SimpleCompressors.CompressionProcesses.RotaryCompression
    constrainedby PartialCompression
    "Model of the compression process"
    annotation (choicesAllMatching=true);

  CompressionProcess comPro(
    redeclare final package Medium = Medium,
    final VDis=VDis,
    final epsRef=epsRef,
    final rotSpeMax=rotSpeMax,
    final piPreMax=piPreMax,
    final useInpFil=useInpFil,
    final risTim=risTim,
    redeclare final model EngineEfficiency = EngineEfficiency,
    redeclare final model VolumetricEfficiency = VolumetricEfficiency,
    redeclare final model IsentropicEfficiency = IsentropicEfficiency,
    final allowFlowReversal=allowFlowReversal,
    final dp_start=dp_start,
    final m_flow_start=m_flow_start,
    final m_flow_small=m_flow_small,
    final show_T=show_T,
    final show_V_flow=show_V_flow,
    final m_flow_nominal=m_flow_nominal,
    final show_staEff=show_staEff,
    final show_qua=show_qua,
    final rotSpe0=rotSpe0,
    final pInl0=pInl0,
    final TInl0=TInl0)
    "Model describing compression process"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  /*To enable propagation of parameters, the compression process is introduced
    as a replaceable model and its instance propagates all parameters
    required.
  */

  // Definition of connectors
  //
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium=Medium,
     m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
     h_outflow(start=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium=Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = Medium.h_default))
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort
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


equation
  // Connection of control signals
  //
  connect(manVarCom,comPro. manVarCom)
    annotation (Line(points={{-60,100},{-60,40},{-6,40},{-6,10}},
                color={0,0,127}));
  connect(comPro.curManVarCom, curManVarCom)
    annotation (Line(points={{6,10},{6,40},{60,40},{60,100}},
                color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
        Text(
          extent={{-100,-130},{100,-150}},
          lineColor={28,108,200},
          textString="%name")}),    Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a base model for simple compressor models that are used, for
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
  <li>Redecleration of the model <code>parCom</code>.
  </li>
  <li>Connection of <code>parCom.heatPort</code> with
  <code>heatPort</code>.
  </li>
  <li>Connection of <code>port_a</code> and <code>port_b</code> with
  <code>parCom.port_a</code> and <code>parCom.port_b</code>.
  </li>
</ul>
<p>
  The latter provides the possibility to add further components (e.g.
  pressure losses or heat transfers) located at the compressor's inlet
  and outlet.
</p>
<h4>
  Modeling approaches
</h4>
<p>
  This base model mainly consists of one sub-models and, therefore,
  please checkout this model for further information of underlying
  modeling approaches:
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression\">
    AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression</a>.
  </li>
</ul>
</html>"));
end PartialCompressor;
