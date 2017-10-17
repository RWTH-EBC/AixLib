within AixLib.Fluid.Storage;
model TwoPhaseTank
  "Model of a fully-mixed two-phase tank for close-loop systems"

  // Define medium
  //
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialTwoPhaseMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  // Parameters describing the geometry of the tank
  //
  parameter Modelica.SIunits.Volume VTanInl = 2e-3
    "Inler total volume of the tank"
    annotation(Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Area ATanInl = VTanInl/hTanInl
    "Inler cross-sectional area of the tank"
    annotation(Dialog(group="Geometry",
               enable=false));
  parameter Modelica.SIunits.Area ASheInl=
    Modelica.Constants.pi*dTanInl*hTanInl
    "Inler area of the tank's sheat"
    annotation(Dialog(group="Geometry",
               enable=false));
  parameter Modelica.SIunits.Length hTanInl = 0.5
    "Inler height of the tank"
    annotation(Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter dTanInl=
    sqrt(4*ATanInl/Modelica.Constants.pi)
    "Inler diameter of the tank"
    annotation(Dialog(group="Geometry",
               enable=false));

  // Parameters describing the heat loss of the tank if considered
  //
  parameter Boolean useHeatLoss = false
    "= true, if heat losses are computed"
    annotation(Dialog(tab="Heat losses",group="General"));

  parameter Modelica.SIunits.Length sIns = 0.1
    "Thickness of insulation"
    annotation(Dialog(tab="Heat losses",group="Geometry",
               enable=useHeatLoss));
  parameter Modelica.SIunits.Volume VTanOut = ATanOut*hTanOut
    "Outer total volume of the tank"
    annotation(Dialog(tab="Heat losses",group="Geometry",
               enable=false));
  parameter Modelica.SIunits.Area ATanOut=
    Modelica.Constants.pi*dTanOut^2/4
    "Outer cross-sectional area of the tank"
    annotation(Dialog(tab="Heat losses",group="Geometry",
               enable=false));
  parameter Modelica.SIunits.Area ASheOut=
    Modelica.Constants.pi*dTanOut*hTanOut
    "Outer area of the tank's sheat"
    annotation(Dialog(tab="Heat losses",group="Geometry",
               enable=false));
  parameter Modelica.SIunits.Length hTanOut = hTanInl+2*sIns
    "Outer height of the tank"
    annotation(Dialog(tab="Heat losses",group="Geometry",
               enable=false));
  parameter Modelica.SIunits.Diameter dTanOut = dTanInl+2*sIns
    "Outer diameter of the tank"
    annotation(Dialog(tab="Heat losses",group="Geometry",
               enable=false));

  parameter Modelica.SIunits.ThermalConductivity lamIns = 0.04
    "Thermal conductivity of the insulation"
    annotation(Dialog(tab="Heat losses",group="Properties",
               enable=useHeatLoss));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpInl = 100
    "Inler mean heat transfer coefficient"
    annotation(Dialog(tab="Heat losses",group="Properties",
               enable=useHeatLoss));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpOut = 10
    "Outer mean heat transfer coefficient"
    annotation(Dialog(tab="Heat losses",group="Properties",
               enable=useHeatLoss));

  // Definition of parameters describing assumptions
  //
  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  // Definition of parameters describing initialisation and nominal conditions
  //
  parameter Modelica.SIunits.PressureDifference dp_start(displayUnit="Pa") = 0
    "Guess value of dp = port_a.p - port_b.p"
    annotation(Dialog(tab="Advanced",group="Medium Initialisation"));
  parameter Medium.MassFlowRate m_flow_start_a = 0.1
    "Guess value of port_a.m_flow"
    annotation(Dialog(tab="Advanced",group="Medium Initialisation"));
  parameter Medium.MassFlowRate m_flow_start_b = 0.1
    "Guess value of port_b.m_flow"
    annotation(Dialog(tab="Advanced",group="Medium Initialisation"));

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation(Dialog(tab="Advanced",group="Numeric limitations"));
  parameter Medium.MassFlowRate m_flow_small = 1e-6*m_flow_nominal
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab="Advanced",group="Numeric limitations"));

  // Definitions of parameters describing diagnostics
  //
  parameter Boolean show_T = true
    "= true, if temperatures at port_a and port_b are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_V_flow = true
    "= true, if volume flow rate at port_a and port_b are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  // Definition of variables
  //
  Medium.ThermodynamicState staTan
    "Thermodynamic state of the medium in the tank";
  Medium.SaturationProperties satTan
    "Saturation properties of the medium in the tank";

  Real levTan(unit="1")
    "Relative level of the tank";
  Modelica.SIunits.Volume VLiq
    "Volume of the liquid phase";
  Modelica.SIunits.Volume VVap
    "Volume of the vapour phase";
  Modelica.SIunits.Mass mTan
    "Mass of the medium in the tank";
  Modelica.SIunits.Mass mLiq
    "Mass of the liquid phase";
  Modelica.SIunits.Mass mVap
    "Mass of the vapour phase";

  Modelica.SIunits.AbsolutePressure pTot(start=20e5)
    "Total pressure of the tank";
  Modelica.SIunits.Density dTan
    "Density of the medium in the tank";
  Modelica.SIunits.Density dLiq
    "Density of the liquid phase";
  Modelica.SIunits.Density dVap
    "Density of the vapour phase";

  Modelica.SIunits.SpecificEnthalpy hTan
    "Specific enthalpy of the medium in the tank";
  Modelica.SIunits.SpecificEnthalpy hInl
    "Specific enthalpy at tank's inlet";
  Modelica.SIunits.SpecificEnthalpy hOut
    "Specific enthalpy at tank's outlet";
  Modelica.SIunits.SpecificEnthalpy hLiq
    "Specific enthalpy of the liquid phase";
  Modelica.SIunits.SpecificEnthalpy hVap
    "Specific enthalpy of the vapour phase";

  // Definition of connectors
  //
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
     m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
     h_outflow(start = Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatLoss
    "Heat port for heat losses if losses are computed"
    annotation(Placement(transformation(extent={{72,-10},{92,10}}),
               iconTransformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={82,0})));

  // Calculating diagnostic values
  //
  Modelica.SIunits.VolumeFlowRate port_a_V_flow=
      port_a.m_flow/Modelica.Fluid.Utilities.regStep(port_a.m_flow,
                  Medium.density(
                    Medium.setState_phX(
                      p = port_a.p,
                      h = inStream(port_a.h_outflow),
                      X = inStream(port_a.Xi_outflow))),
                  Medium.density(
                       Medium.setState_phX(
                         p = port_b.p,
                         h = inStream(port_b.h_outflow),
                         X = inStream(port_b.Xi_outflow))),
                  m_flow_small) if show_V_flow
    "Volume flow rate at port_a (positive when flow from port_a to port_b)";
  Modelica.SIunits.VolumeFlowRate port_b_V_flow=
      port_b.m_flow/Modelica.Fluid.Utilities.regStep(port_a.m_flow,
                  Medium.density(
                    Medium.setState_phX(
                      p = port_b.p,
                      h = inStream(port_b.h_outflow),
                      X = inStream(port_b.Xi_outflow))),
                  Medium.density(
                       Medium.setState_phX(
                         p = port_a.p,
                         h = inStream(port_a.h_outflow),
                         X = inStream(port_a.Xi_outflow))),
                  m_flow_small) if show_V_flow
    "Volume flow rate at port_b (positive when flow from port_a to port_b)";

  Medium.Temperature port_a_T=
      Modelica.Fluid.Utilities.regStep(port_a.m_flow,
                  Medium.temperature(
                    Medium.setState_phX(
                      p = port_a.p,
                      h = inStream(port_a.h_outflow),
                      X = inStream(port_a.Xi_outflow))),
                  Medium.temperature(
                    Medium.setState_phX(
                      p = port_a.p,
                      h = port_a.h_outflow,
                      X = port_a.Xi_outflow)),
                  m_flow_small) if show_T
    "Temperature close to port_a, if show_T = true";
  Medium.Temperature port_b_T=
      Modelica.Fluid.Utilities.regStep(port_b.m_flow,
                  Medium.temperature(
                    Medium.setState_phX(
                      p = port_b.p,
                      h = inStream(port_b.h_outflow),
                      X = inStream(port_b.Xi_outflow))),
                  Medium.temperature(
                    Medium.setState_phX(
                      p = port_b.p,
                      h = port_b.h_outflow,
                      X = port_b.Xi_outflow)),
                  m_flow_small) if show_T
    "Temperature close to port_b, if show_T = true";

equation
  // Calculation of basic properties assuming thermodynamic equilibrium
  //
  VTanInl = VLiq + VVap "Geometric condition";

  mTan = dTan*VTanInl "Basic relationship";
  mTan = mLiq + mVap "Converstion of mass";
  mLiq = VLiq*dLiq "Mass of liquid phase";
  mVap = VVap*dVap "Mass of vapour phase";

  levTan = VLiq/VTanInl "Relative level of the tank";

  // Calculation of boundaries and add equations for flow reversal
  //
  pTot = port_a.p "Assuming thermodynamic equilibrium";
  pTot = port_b.p "Assuming thermodynamic equilibrium";

  port_a.h_outflow = hInl "Usage of auxilarry variable";
  hInl = semiLinear(port_a.m_flow,inStream(port_a.h_outflow),hLiq)
    "Check flow direction and set specific enthalpy at tank's inlet";
  /*If flow direction identical to design direction, the inlet specific
    enthalpy is identical to the specific enthalpy at the inlet port. Otherwise,
    liquid state is forced.
  */
  port_b.h_outflow = hOut "Usage of auxilarry variable";
  hOut = semiLinear(port_a.m_flow,hLiq,inStream(port_b.h_outflow))
    "Check flow direction and set specific enthalpy aat tank's outlet";
  /*If flow direction identical to design direction, the outlet specific
    enthalpy is identical to the liquid phase specific enthalpy. Otherwise,
    the specific enthalpy is identical to the specific enthalpy at 
    tank's outlet.
  */

  // Calculation of thermodynamic states
  //
  satTan = Medium.setSat_p(pTot)
    "Saturation properties based on total pressure";
  staTan = Medium.setState_ph(pTot,hTan)
    "Mean thermodynamic state of the medium";

  dTan = Medium.density(staTan) "Density of the fluid";
  dLiq = Medium.bubbleDensity(satTan) "Liquid density";
  dVap = Medium.dewDensity(satTan) "Vapour density";
  hLiq = Medium.bubbleEnthalpy(satTan) "Liquid enthalpy";
  hVap = Medium.dewEnthalpy(satTan) "Vapour enthalpy";

  // Calculation of conversation equations
  //
  port_a.m_flow + port_b.m_flow = VTanInl*(Medium.density_derh_p(staTan)*
    der(hTan)+Medium.density_derp_h(staTan)*der(pTot))
    "Mass balance";

  VTanInl*(dTan*der(hTan) - der(pTot)) =
    port_a.m_flow*(hInl-hTan) + port_b.m_flow*(hOut-hTan)
    "Energy balance";

  // Calculation of transported substances
  //
  port_a.Xi_outflow = if allowFlowReversal then
    inStream(port_b.Xi_outflow) else Medium.X_default[1:Medium.nXi];
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);

  port_a.C_outflow = if allowFlowReversal then
    inStream(port_b.C_outflow) else zeros(Medium.nC);
  port_b.C_outflow = inStream(port_a.C_outflow);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward,
          origin={0,0},
          rotation=90),
        Rectangle(
          extent={{-90,72},{90,-72}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          origin={0,0},
          rotation=90),
        Polygon(
          points={{-75,-37},{-75,21},{-75,33},{-59,33},{-47,21},{-25,37},{-13,21},
              {3,37},{23,21},{39,37},{53,21},{69,37},{69,29},{69,-19},{-75,-37}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier,
          origin={3,-15},
          rotation=360),
        Rectangle(
          extent={{45,72},{-45,-72}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          origin={0,-45},
          rotation=90)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TwoPhaseTank;
