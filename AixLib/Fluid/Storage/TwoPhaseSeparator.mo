within AixLib.Fluid.Storage;
model TwoPhaseSeparator
  "Model of a fully-mixed two-phase tank that works as ideally phase seperator"

  // Definition of medium
  //
  replaceable package Medium =
   Modelica.Media.Water.WaterIF97_ph
      constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
      "Medium in the component"
      annotation (choicesAllMatching = true);

  // Parameters describing tank's geometry
  //
  parameter Modelica.SIunits.Volume VTanInn = 2e-3
    "Inner total volume of the tank"
    annotation(Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Area ATanInn = VTanInn/hTanInn
    "Inner cross-sectional area of the tank"
    annotation(Dialog(group="Geometry",
               enable=false));
  parameter Modelica.SIunits.Length hTanInn = 0.5
    "Inner height of the tank"
    annotation(Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter dTanInn=
    sqrt(4*ATanInn/Modelica.Constants.pi)
    "Inner diameter of the tank"
    annotation(Dialog(group="Geometry",
               enable=false));

  // Parameters describing tank's heat losses if computed
  //
  parameter Boolean useHeatLoss = false
    "= true, if heat losses are computed"
    annotation(Dialog(tab="Heat losses",group="General"));

  parameter Modelica.SIunits.Length sIns = 0.1
    "Thickness of insulation"
    annotation(Dialog(tab="Heat losses",group="Geometry",
               enable=useHeatLoss));

  parameter Modelica.SIunits.ThermalConductivity lamIns = 0.04
    "Thermal conductivity of the insulation"
    annotation(Dialog(tab="Heat losses",group="Properties",
               enable=useHeatLoss));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpInn = 100
    "Inner mean heat transfer coefficient"
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

  parameter Boolean steSta = false
    "= true, if tank is initialised steady state"
    annotation(Dialog(tab="Advanced",group="Tank Initialisation"));
  parameter Modelica.SIunits.Volume VLiq0 = 0.2*VTanInn
    "Volume of the liquid phase at initialisation"
    annotation(Dialog(tab="Advanced",group="Tank Initialisation"));
  parameter Modelica.SIunits.AbsolutePressure pTan0 = 10e5
    "Mean pressure of the medium in the tank at initialisation"
    annotation(Dialog(tab="Advanced",group="Tank Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy hTan0 = 300e3
    "Mean specific enthalpy of the medium in the tank at initialisation"
    annotation(Dialog(tab="Advanced",group="Tank Initialisation"));

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation(Dialog(tab="Advanced",group="Numeric limitations"));
  parameter Medium.MassFlowRate m_flow_small = 1e-6*m_flow_nominal
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab="Advanced",group="Numeric limitations"));

  // Definitions of parameters describing diagnostics
  //
  parameter Boolean show_T = false
    "= true, if temperatures at port_a and port_b are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_V_flow = false
    "= true, if volume flow rate at port_a and port_b are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_tankProperties = true
    "= true, if tank properties are included as summary record"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_tankPropertiesDetailed = false
    "= true, if more detailed tank properties are included as summary record"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_heatLosses = false
    "= true, if heat losses are included as summary record"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  // Definition of variables
  //
  Medium.ThermodynamicState staTan
    "Thermodynamic state of the medium in the tank";
  Medium.SaturationProperties satTan
    "Saturation properties of the medium in the tank";

  record TankProperties
    "Record that contains properties of the tank"
    Modelica.SIunits.AbsolutePressure pTan
      "Mean pressure of the medium in the tank";
    Modelica.SIunits.Temperature TTan
      "Mean temperature of the medium in the tank";
    Modelica.SIunits.Density dTan
      "Mean density of the medium in the tank";
    Modelica.SIunits.SpecificEnthalpy hTan
      "Mean specific enthalpy of the medium in the tank";

    Modelica.SIunits.Density dLiq
      "Density of the liquid phase";
    Modelica.SIunits.Density dVap
      "Density of the vapour phase";
    Modelica.SIunits.SpecificEnthalpy hLiq
      "Specific enthalpy of the liquid phase";
    Modelica.SIunits.SpecificEnthalpy hVap
      "Specific enthalpy of the vapour phase";

    Modelica.SIunits.SpecificEnthalpy hInn
      "Specific enthalpy at tank's Innet";
    Modelica.SIunits.SpecificEnthalpy hOut
      "Specific enthalpy at tank's outlet";

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

    Real levTan(unit="1")
      "Relative level of the tank";
    Real quaTan(unit="1")
      "Quality of the tank's medium";
  end TankProperties;

  record TankPropertiesDetailed
    "Record that contains detailed properties of the tank"
    Modelica.SIunits.Mass mXi[Medium.nXi]
      "Masses of independent components in the fluid";
    Modelica.SIunits.Mass mC[Medium.nC]
      "Masses of trace substances in the fluid";

    Modelica.SIunits.MassFlowRate dMTan
      "Change in tank's mass wrt. time";
    Modelica.SIunits.Power dUTan
      "Change in tank's internal energy wrt. time";
    Medium.DerDensityByEnthalpy ddhp
    "Density derivative w.r.t. specific enthalpy";
    Medium.DerDensityByPressure ddph
    "Density derivative w.r.t. pressure";

    Real quaInn(unit="1")
      "Quality of the tank's medium at inlet";
    Real quaOut(unit="1")
      "Quality of the tank's medium at outlet";
  end TankPropertiesDetailed;

  record HeatLosses
    "Record that contains properties of calculated heat losses"
    Modelica.SIunits.ThermalConductance G
      "Thermal conductance of the tank's sheat";
    Modelica.SIunits.ThermalConductance GShe
      "Thermal conductance of the tank's sheat";
    Modelica.SIunits.ThermalConductance GTopBot
      "Thermal conductance of the tank's top and bottom";
    Modelica.SIunits.TemperatureDifference dTHeaLos
      "Temperature difference between tank and ambient";
    Modelica.SIunits.Power Q_flow_loss
      "Heat losses from tank to ambient";
  end HeatLosses;

  // Definition of records that summarise variables computed in the model
  //
  TankProperties tankProperties(
    pTan=pTan,
    TTan=TTan,
    dTan=dTan,
    hTan=hTan,
    dLiq=dLiq,
    dVap=dVap,
    hLiq=hLiq,
    hVap=hVap,
    hInn=hInn,
    hOut=hOut,
    VLiq=VLiq,
    VVap=VVap,
    mTan=mTan,
    mLiq=mLiq,
    mVap=mVap,
    levTan=levTan,
    quaTan=quaTan) if show_tankProperties
    "Record that summarises basic tank properties";
  TankPropertiesDetailed tankPropertiesDetailed(
      mXi=mXi,
      mC=mC,
      dMTan=dMTan,
      dUTan=dUTan,
      ddhp=ddhp,
      ddph=ddph,
      quaInn=quaInn,
      quaOut=quaOut) if show_tankPropertiesDetailed
    "Record that summarises detailed tank properties";
  HeatLosses heatLosses(
    G=G,
    GShe=GShe,
    GTopBot=GTopBot,
    dTHeaLos=TTan-heatPort.T,
    Q_flow_loss=heaFloSen.Q_flow) if (show_heatLosses and useHeatLoss)
    "Record that contains properties of calculated heat losses";

  // Definition of connectors and models
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
      port_b.m_flow/Modelica.Fluid.Utilities.regStep(port_b.m_flow,
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

protected
  parameter Modelica.SIunits.ThermalConductance G = GShe + 2*GTopBot
    "Thermal conductance of the tank's sheat"
    annotation(Dialog(tab="Heat losses",group="Properties",
               enable=false));
  parameter Modelica.SIunits.ThermalConductance GShe = 2*Modelica.Constants.pi*
    hTanInn / (1/(alpInn*(dTanInn/2)) + 1/lamIns*log(1+sIns/(dTanInn/2)) +
    1/(alpOut*(dTanInn/2+sIns)))
    "Thermal conductance of the tank's sheat"
    annotation(Dialog(tab="Heat losses",group="Properties",
               enable=false));
  parameter Modelica.SIunits.ThermalConductance GTopBot=
    ATanInn / (1/alpInn + sIns/lamIns + 1/alpOut)
    "Thermal conductance of the tank's top and bottom"
    annotation(Dialog(tab="Heat losses",group="Properties",
               enable=false));

  Modelica.SIunits.AbsolutePressure pTan(start=pTan0)
    "Mean pressure of the medium in the tank";
  Modelica.SIunits.Temperature TTan
    "Mean temperature of the medium in the tank";
  Modelica.SIunits.Density dTan
    "Mean density of the medium in the tank";
  Modelica.SIunits.SpecificEnthalpy hTan(start=hTan0)
    "Mean specific enthalpy of the medium in the tank";

  Modelica.SIunits.Density dLiq
    "Density of the liquid phase";
  Modelica.SIunits.Density dVap
    "Density of the vapour phase";
  Modelica.SIunits.SpecificEnthalpy hLiq
    "Specific enthalpy of the liquid phase";
  Modelica.SIunits.SpecificEnthalpy hVap
    "Specific enthalpy of the vapour phase";

  Modelica.SIunits.SpecificEnthalpy hInn
    "Specific enthalpy at tank's Innet";
  Modelica.SIunits.SpecificEnthalpy hOut
    "Specific enthalpy at tank's outlet";

  Modelica.SIunits.Volume VLiq(start=VLiq0)
    "Volume of the liquid phase";
  Modelica.SIunits.Volume VVap
    "Volume of the vapour phase";
  Modelica.SIunits.Mass mTan
    "Mass of the medium in the tank";
  Modelica.SIunits.Mass mLiq
    "Mass of the liquid phase";
  Modelica.SIunits.Mass mVap
    "Mass of the vapour phase";
  Modelica.SIunits.Mass mXi[Medium.nXi]
    "Masses of independent components in the fluid";
  Modelica.SIunits.Mass mC[Medium.nC]
    "Masses of trace substances in the fluid";

  Modelica.SIunits.MassFlowRate dMTan
    "Change in tank's mass wrt. time";
  Modelica.SIunits.Power dUTan
    "Change in tank's internal energy wrt. time";
  Medium.DerDensityByEnthalpy ddhp
  "Density derivative w.r.t. specific enthalpy";
  Medium.DerDensityByPressure ddph
  "Density derivative w.r.t. pressure";

  Real levTan(unit="1")
    "Relative level of the tank";
  Real quaTan(unit="1")
    "Quality of the tank's medium";
  Real quaInn(unit="1")
    "Quality of the tank's medium at inlet";
  Real quaOut(unit="1")
    "Quality of the tank's medium at outlet";

  Real eps = Modelica.Constants.eps
    "Bigest number such that 1.0 + eps = 1.0";
  Real pTriCri
    "Trigger to check if tank's medium exceeds critical pressure";

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    heaTran(G=G) if useHeatLoss
    "Model to calculate heat losses"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFloSen
    "Sensor measuring heat losses in order to use measured value for calculations"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
    "Convert input temperature to heat port temperature"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.RealExpression porTem(y=TTan)
    "Source block to set temperature to calculate heat losses"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

initial equation
  if steSta then
   der(hTan) = 0;
  else
    hTan = hTan0;
  end if;

equation
  // Introduction of assertion to check model's boundaries
  //
  assert(VLiq/VTanInn <= 1, "Caution: Relative tank level is greater than
    maximum tank capacity! Increase the tank size!",
    level = AssertionLevel.warning)
    "Checking if the tank is undersized";

  // Calculation of thermodynamic states
  //
  satTan = Medium.setSat_p(pTan)
    "Saturation properties based on pressure of the tank's medium";
  staTan = Medium.setState_ph(pTan,hTan)
    "Mean thermodynamic state of the tank's medium";

  dTan = Medium.density(staTan) "Mean density of the tank's medium";
  TTan = Medium.temperature(staTan) "Mean temperature of the tank's medium";

  dLiq = Medium.bubbleDensity(satTan) "Liquid density";
  dVap = Medium.dewDensity(satTan) "Vapour density";
  hLiq = Medium.bubbleEnthalpy(satTan) "Liquid enthalpy";
  hVap = Medium.dewEnthalpy(satTan) "Vapour enthalpy";

  ddhp = Medium.density_derh_p(staTan) "Density derivative wrt. hTan";
  ddph = Medium.density_derp_h(staTan) "Density derivative wrt. pTan";

  pTriCri = pTan/Medium.fluidConstants[1].criticalPressure
    "Trigger to check if tank's medium exceeds ciritical pressure (>=1)";
  quaTan = noEvent(if (pTriCri<1 and hTan<hLiq) then 0
    else if (pTriCri<1 and hTan>hLiq and hTan<hVap) then
    (hTan - hLiq)/max(hVap - hLiq, 1e-6) else 1.0)
    "Mean vapour quality of the tank's medium";
  quaInn = noEvent(if (pTriCri<1 and hInn<hLiq) then 0
    else if (pTriCri<1 and hInn>hLiq and hInn<hVap) then
    (hInn - hLiq)/max(hVap - hLiq, 1e-6) else 1.0)
    "Mean vapour quality of the tank's medium at inlet conditions";
  quaOut = noEvent(if (pTriCri<1 and hOut<hLiq) then 0
    else if (pTriCri<1 and hOut>hLiq and hOut<hVap) then
    (hOut - hLiq)/max(hVap - hLiq, 1e-6) else 1.0)
    "Mean vapour quality of the tank's medium at outlet conditions";

  // Calculation of basic properties assuming thermodynamic equilibrium
  //
  VTanInn = VLiq + VVap "Geometric condition";

  mTan = dTan*VTanInn "Basic relationship";
  mTan = mLiq + mVap  "Converstion of mass";
  VLiq = smooth(1, noEvent(if (quaTan > 0.0 and quaTan < 1.0) then
    mTan*(1-quaTan)/dLiq else if (quaTan >= 1.0) then 0 else VTanInn))
    "Volume of liquid phase depending on tank's actual quality";
  mVap = smooth(1, noEvent(if (quaTan > 0.0 and quaTan < 1.0) then
    mTan*quaTan else if (quaTan >= 1.0) then mTan else 0.0))
    "Mass of vapour phase depending on tank's actual quality";
  /*The calculation procedure of the phases' masses is conducted as presented
    above to ensure two things. Firstly, to ensure that the phases' masses cannot 
    be negative and, secondly, to ensure that the phases' masses are resticrted
    by the maximum tank capacity.
  */

  levTan = min(VLiq/VTanInn,1) "Relative level of the tank";

  // Calculation of boundaries and add equations for flow reversal
  //
  pTan = port_a.p "Assuming thermodynamic equilibrium";
  0 = port_a.p - port_b.p "Assuming thermodynamic equilibrium";

  hInn = actualStream(port_a.h_outflow);
  port_a.h_outflow = smooth(1,noEvent(if (levTan >= 1-eps) or (levTan <= eps)
    or (pTriCri>=1) then hTan else hVap))
    "Check relative tank level and set specific enthalpy at tank's inlet";
  /*If flow direction identical to design direction, the inlet specific
    enthalpy is identical to the specific enthalpy at the inlet port. Otherwise,
    vapour state or mean enthalpy is forced.
  */
  hOut = actualStream(port_b.h_outflow);
  port_b.h_outflow = smooth(1,noEvent(if (levTan >= 1-eps) or (levTan <= eps)
    or (pTriCri>=1) then hTan else hLiq))
    "Check relative tank level and set specific enthalpy at tank's outlet";
  /*If flow direction identical to design direction, the outlet specific
    enthalpy is identical to the liquid state or mean specific enthalpy. 
    Otherwise, the specific enthalpy is identical to the specific enthalpy at 
    tank's outlet.
  */

  // Calculation of conversation equations
  //
  dMTan = port_a.m_flow + port_b.m_flow
    "Mass balance: Ports' side";
  dMTan = VTanInn*(ddph*der(pTan) + ddhp*der(hTan))
    "Mass balance: Tank's side";

  dUTan = port_a.m_flow*actualStream(port_a.h_outflow) + port_b.m_flow*
    actualStream(port_b.h_outflow) - heaFloSen.Q_flow
    "Energy balance: Port's side";
  dUTan =VTanInn*(hTan*(ddph*der(pTan) + ddhp*der(hTan)) + dTan*der(hTan) -
    der(pTan))
    "Energy balance: Tank's side";

  // Calculation of conservation equations of transported substances
  //
  der(mXi) = port_a.m_flow*actualStream(port_a.Xi_outflow) +
    port_b.m_flow*actualStream(port_b.Xi_outflow);
  der(mC) = port_a.m_flow*actualStream(port_a.C_outflow) +
    port_b.m_flow*actualStream(port_b.C_outflow);

  // Connections describing heat losses if computed
  //
  connect(porTem.y, preTem.T)
    annotation (Line(points={{-69,0},{-69,0},{-42,0}}, color={0,0,127}));
  connect(preTem.port, heaFloSen.port_a)
    annotation (Line(points={{-20,0},{-20,0},{-10,0}}, color={191,0,0}));
  connect(heaFloSen.port_b, heaTran.port_a)
    annotation (Line(points={{10,0},{20,0}}, color={191,0,0}));
  connect(heaTran.port_b, heatPort)
    annotation (Line(points={{40,0},{82,0}}, color={191,0,0}));

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
          rotation=90),
        Text(
          extent={{-104,-16},{104,16}},
          lineColor={28,108,200},
          textString="%name",
          origin={-96,0},
          rotation=270)}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
  October 18, 2017, by Mirko Engelpracht, Christian Vering:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",
        info="<html>
<p>This is a model of a ideally working two-phase separator. 
The separator separates a vapor mixture into its liquid and 
vapour parts until the tank is either empty or full.
</p>
<h4>Assumptions</h4>
<p>
Several assumptions are made and presented below:
</p>
<ul>
<li>Dynamic mass and energy balances.</li>
<li>Thermodynamic equilibrium at all times.</li>
<li>Upright position of the separator with circular 
cross-sectional area.</li>
<li>Inlet at the top.</li>
<li>Outlet at the bottom.</li>
<li>Heat losses can be computed optionally. However, time 
independent heat transfer coefficients are assumed that 
must be given a priori.</li>
</ul>
<p>
Moreover, the thermodynamic model is generally based on the 
tank model presented by Quoilin et al. (2014) in their
ThermoCycle library.
</p>
<h4>Calculation of specific enthalpies</h4>
<p>
The specific enthalpies at the tank's inlet and outlet depend
on the relative tank level. The calculation procedures
are presented below:
</p>
<p align=\"left\">
<img src=\"modelica://AixLib/Resources/Images/Fluid/Storage/separatorSpecificEnthalpyInlet.png\"
alt=\"Calculation procedure of specific enthalpy at inlet\"/>
</p>
<p align=\"left\">
<img src=\"modelica://AixLib/Resources/Images/Fluid/Storage/separatorSpecificEnthalpyOutlet.png\"
alt=\"Calculation procedure of specific enthalpy at outlet\"/>
</p>
<h4>Implementation</h4>
<p>
If the two-phase separator is connected with respect
to design direction, it will behave like a liquid receiver.
If the two-phase separator is connected aggainst design
direction or flow reversal occurs, it will behave like a
mist eliminator.
</p>
<h4>References</h4>
<p>
Quoilin, Sylvain; Desideri, Adriano; Wronski, Jorrit;
Bell, Ian and Lemort, Vincent (2014):
<a href=\"http://www.ep.liu.se/ecp/096/072/ecp14096072.pdf\">
ThermoCycle: A Modelica library for the simulation of
thermodynamic systems</a>. In: <i>Proceedings of the 10th 
International Modelica Conference</i>; March 10-15; 2014; 
Lund; Sweden. Link&ouml;ping University Electronic Press, 
S. 683&ndash;692.
</p>
</html>"));
end TwoPhaseSeparator;
