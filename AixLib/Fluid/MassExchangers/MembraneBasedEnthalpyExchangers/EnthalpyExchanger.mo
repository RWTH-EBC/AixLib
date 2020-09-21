within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers;
model EnthalpyExchanger
  "model for a parallel membrane enthalpy exchanger"

  // Medium in air ducts
  replaceable package Medium = AixLib.Media.Air
    "medium in the air ducts" annotation(choices(
        choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
        choice(redeclare package Medium = AixLib.Media.AirIncompressible "Moist air incompressible")));

  // General parameter
  parameter Integer n(min=2)
    "number of discrecete volumes in flow direction";
  parameter Integer nParallel(min=1)
    "number of parallel membranes";

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=
    Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  //----------------------Air Ducts------------------------------------

  // Geometry
  parameter Modelica.SIunits.Length lengthDuct
    "length of ducts in flow direction"
    annotation(Dialog(tab="AirDucts",group="Geometry"));
  parameter Modelica.SIunits.Length heightDuct
    "height of ducts"
    annotation(Dialog(tab="AirDucts",group="Geometry"));
  parameter Modelica.SIunits.Length widthDuct
    "width of ducts"
    annotation(Dialog(tab="AirDucts",group="Geometry"));

  // Heat and mass transfer parameters
  parameter Boolean uniWalTem
    "true if uniform wall temperature boundary conditions"
    annotation(Dialog(tab="AirDucts",group="Heat and mass transfer"));
  parameter Boolean local
    "true if heat and mass transfer are locally resolved"
    annotation(Dialog(tab="AirDucts",group="Heat and mass transfer"));
  parameter Integer nWidth(min=1) = 1
    "number of segments in width direction"
    annotation(Dialog(tab="AirDucts",group="Heat and mass transfer"));
  parameter Boolean recDuct
    "true if rectangular duct is used for Nusselt/Sherwood number calculation, else flat gap is used."
     annotation(Dialog(tab="AirDucts",group="Heat and mass transfer"));

  // pressure losses
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dp_nominal
    "nominal pressure drop";

  //-----------------------Membrane-------------------------------------

  // Geometry
  parameter Modelica.SIunits.Length lengthMem=lengthDuct
    "length of membranes in flow direction"
    annotation(Dialog(enable=false,tab="Membranes",group="Geometry"));
  parameter Modelica.SIunits.Length widthMem=widthDuct
    "width of membranes"
    annotation(Dialog(enable=false,tab="Membranes",group="Geometry"));
  parameter Modelica.SIunits.Length thicknessMem
    "thickness of membranes"
    annotation(Dialog(tab="Membranes",group="Geometry"));
  parameter Modelica.SIunits.SpecificHeatCapacity cpMem
    "mass weighted heat capacity of membrane"
    annotation(Dialog(tab="Membranes",group="Heat and mass transfer"));

  // Membrane properties
  parameter Modelica.SIunits.ThermalConductivity lambdaMem
    "thermal conductivity of membrane"
    annotation(Dialog(tab="Membranes",group="Heat and mass transfer"));
  parameter Modelica.SIunits.Density rhoMem
    "density of membrane"
    annotation(Dialog(tab="Membranes",group="Others"));

  // calculated parameter
  parameter Modelica.SIunits.Area[n] surfaceAreas=
    fill(lengthMem*widthMem/n,n)
    "Heat transfer areas"
    annotation(Dialog(enable=false,tab="calculated"));

  //Advanced
  parameter Boolean useConPer=true
    "true, if permeabilty of membrane is assumed to be constant"
    annotation(Dialog(tab="Advanced"));
  parameter Real conPerMem(unit="mol/(m.s.Pa)")=9E5
    "constant permeability of membrane if useConPer=true"
    annotation(Dialog(tab="Advanced",enable=useConPer));

  //----------------------Housing----------------------------------------
  parameter Modelica.SIunits.SpecificHeatCapacity cpHou
    "mass weighted heat capacity of housing"
    annotation(Dialog(tab="Housing",group="Heat and mass transfer"));
  parameter Modelica.SIunits.Mass mHou
    "mass of housing"
    annotation(Dialog(tab="Housing",group="Others"));

  // Initialization
  parameter Modelica.SIunits.MassFlowRate m_flow_start = m_flow_nominal
    "Start value for mass flow rate"
     annotation(Evaluate=true, Dialog(tab = "Initialization"));
  parameter Medium.AbsolutePressure p_a_start=Medium.p_default
      "Start value of pressure at port a"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium.AbsolutePressure p_b_start=p_a_start
      "Start value of pressure at port b"
    annotation(Dialog(tab = "Initialization"));
  final parameter Medium.AbsolutePressure[n] ps_start=if n > 1 then linspace(
        p_a_start, p_b_start, n) else {(p_a_start + p_b_start)/2}
      "Start value of pressure";

  parameter Medium.Temperature T_start=Medium.T_default
    "Start value of temperature"
    annotation(Evaluate=true, Dialog(tab = "Initialization"));
  parameter Modelica.SIunits.Pressure p_start = Medium.p_default
    "reference pressure"
    annotation(Evaluate=true, Dialog(tab = "Initialization"));
  parameter Medium.MassFraction X_start[Medium.nX](
       quantity=Medium.substanceNames)=Medium.X_default
      "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty C_start[Medium.nC](
       quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
      "Start value of trace substances"
    annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
  parameter Modelica.SIunits.Temperature T_start_m
    "membrane temperature start value"
    annotation(Dialog(tab = "Initialization"));
  parameter Modelica.SIunits.TemperatureDifference dT_start
    "start value for temperature between air ducts"
    annotation(Dialog(tab = "Initialization"));
  parameter Modelica.SIunits.PartialPressure p_start_m
    "start value for mean partial pressure at membrane's surface"
    annotation(Dialog(tab = "Initialization"));
  parameter Modelica.SIunits.PartialPressure dp_start
    "Start value for partial pressure gradient over membrane"
    annotation(Dialog(tab = "Initialization"));

  BaseClasses.AirDuct airDuct2(
    redeclare final package Medium=Medium,
    final m_flow_nominal=m_flow_nominal,
    final dp_nominal=dp_nominal,
    final nNodes=n,
    final nParallel=nParallel,
    final nWidth=nWidth,
    final lengthDuct=lengthDuct,
    final widthDuct=widthDuct,
    final heightDuct=heightDuct,
    final uniWalTem=uniWalTem,
    final local=local,
    final recDuct=recDuct,
    final energyDynamics=energyDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start)
    annotation (Placement(transformation(extent={{22,-88},{-34,-32}})));
  BaseClasses.AirDuct airDuct1(
    redeclare final package Medium=Medium,
    final m_flow_nominal=m_flow_nominal,
    final dp_nominal=dp_nominal,
    final nNodes=n,
    final nParallel=nParallel,
    final nWidth=nWidth,
    final lengthDuct=lengthDuct,
    final widthDuct=widthDuct,
    final heightDuct=heightDuct,
    final uniWalTem=uniWalTem,
    final local=local,
    final recDuct=recDuct,
    final energyDynamics=energyDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start)
    annotation (Placement(transformation(extent={{-34,88},{22,32}})));
  BaseClasses.Membrane membrane(
    final nNodes=n,
    final nParallel=nParallel,
    final lengthMem=lengthMem,
    final widthMem=widthMem,
    final thicknessMem=thicknessMem,
    final cpMem=cpMem,
    final lambdaMem=lambdaMem,
    final rhoMem=rhoMem,
    final T_start=T_start_m,
    final dT_start=dT_start,
    final p_start=p_start,
    final dp_start=dp_start)
    annotation (Placement(transformation(extent={{-36,-28},{22,28}})));
  Modelica.Blocks.Interfaces.RealInput perMem(unit="mol/(m.s.Pa)") if
       not useConPer "membrane permeability in Barrer"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    redeclare final package Medium=Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
    redeclare final package Medium=Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(
    redeclare final package Medium=Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(
    redeclare final package Medium=Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacityHousing(C=cpHou*
        mHou) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-74,14})));

protected
  Modelica.Blocks.Interfaces.RealInput perMemInt(unit="mol/(m.s.Pa)");

equation
  if useConPer then
    perMemInt = conPerMem;
  end if;
  connect(perMemInt, perMem);
  connect(airDuct1.heatPorts[n:-1:1], membrane.heatPorts_a[1:n]) annotation (
      Line(points={{-17.2,32},{-18,32},{-18,14},{-18.6,14}}, color={191,0,0}));
  connect(airDuct1.massPorts[n:-1:1], membrane.massPorts_a[1:n]) annotation (
      Line(points={{5.48,32.28},{4,32.28},{4,14},{4.89,14}},
        color={0,140,72}));
  connect(membrane.heatPorts_b, airDuct2.heatPorts) annotation (Line(points={{-18.6,
          -14},{-6,-14},{-6,-32},{5.2,-32}},         color={191,0,0}));
  connect(membrane.massPorts_b, airDuct2.massPorts) annotation (Line(points={{4.31,
          -14},{-4,-14},{-4,-32.28},{-17.48,-32.28}},               color={0,140,
          72}));
  connect(perMem, membrane.perMem)
    annotation (Line(points={{-120,0},{-82,0},{-82,3.55271e-15},{-41.8,3.55271e-15}},
                                                color={0,0,127}));
  connect(airDuct1.port_a, port_a1) annotation (Line(points={{-34,60},{-100,60}},
                              color={0,127,255}));
  connect(airDuct1.port_b, port_b1)
    annotation (Line(points={{22,60},{100,60}},          color={0,127,255}));
  connect(airDuct2.port_a, port_a2) annotation (Line(points={{22,-60},{100,-60}},
                      color={0,127,255}));
  connect(airDuct2.port_b, port_b2) annotation (Line(points={{-34,-60},{-100,-60}},
                                 color={0,127,255}));
  connect(heatCapacityHousing.port, airDuct1.heatPorts[1]) annotation (Line(
        points={{-64,14},{-58,14},{-58,16},{-38,16},{-38,32},{-17.2,32}}, color=
         {191,0,0}));
  connect(heatCapacityHousing.port, airDuct2.heatPorts[1]) annotation (Line(
        points={{-64,14},{-58,14},{-58,-32},{5.2,-32}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,20}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-20},{100,-100}},
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.None,
          pattern=LinePattern.Dash),
        Line(points={{-60,60},{60,60}}, color={28,108,200}),
        Line(points={{60,60},{50,56}}, color={28,108,200}),
        Line(points={{60,60},{50,62}}, color={28,108,200}),
        Line(points={{60,-60},{-60,-60}}, color={28,108,200}),
        Line(points={{-60,-60},{-50,-64}}, color={28,108,200}),
        Line(points={{-60,-60},{-50,-58}}, color={28,108,200})}),Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model combines two <a href=\"AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.AirDuct\">AirDuctModels</a> with a <a href=\"AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.Membrane\">MembraneModel</a> to form a model of a membrane-based counter-flow enthalpy exchanger.</p>
<h4>Usage</h4>
<p>Here will follow some hints for parametrization of the model.</p>
<ul>
<li>Heat and mass transfer are resolved locally by defining the paramter <span style=\"font-family: Courier New;\">n</span>. <br>The higher the number of segments are, the better the accuracy, but also the higher the simulation time.<br>Please note, that using a highly distributed air duct the Nusselt/ Sherwood number needs to be calculated locally (see parameters for heat and mass transfer).</li>
<li>By using the parameter <span style=\"font-family: Courier New;\">nParallel</span> a parallel arrangement of several membrane and air ducts can be realized.</li>
<li>The air ducts in membrane-based enthalpy exchangers are normally divided in width by webs that provide mechanical stability.<br>This subdivision influences the heat and mass transfer. This is represented by the parameter <span style=\"font-family: Courier New;\">nWidth</span>. If this effect should be neglected set <span style=\"font-family: Courier New;\">nWidth</span> to one.</li>
<li>The membrane model summarizes the complete membrane structure consisting of the thin membrane layer and the supportive layer as producers normally declare the overall thickness.<br>Therefore, reasonable values for the parameter <span style=\"font-family: Courier New;\">thicknessMembrane</span> lie in between 10 to 300 &mu;m. </li>
<li>The permeability describes the water transport through the membrane. It is given in the unit <i>Barrer</i>. Values in the order of <i>1E5</i> till <i>1E8</i> are reasonable.</li>
</ul>
<h4>References</h4>
<ul>
<li>Kremer, M.; Mathis, P.; Mueller, D. (2019): Moisture Recovery - A Dynamic Modelling Approach. E3S Web Conf., Volume 111, p.01099. DOI: <a href=\"https://doi.org/10.1051/e3sconf/201911101099\">10.1051/e3sconf</a>.</li>
</ul>
<h4>Assumptions</h4>
<p>Please note, that the heat and mass transfer models implemented in this model only provide accurate transfer models for laminar flow, which is common for enthalpy exchangers.</p>
</html>", revisions="<html>
<ul>
<li>April 23, 2019, by Martin Kremer:<br/>Adding heat capacitor for the housing of the enthalpy exchangers.</li>
<li>January 16, 2019, by Martin Kremer:<br/>Redeclaring sub model parameters as final. Enabling air duct models for changes on top level.</li>
<li>November 23, 2018, by Martin Kremer:<br/>Adding model for adsorption enthalpy. Adding humidity sensor needed for adsoprtion model.</li>
<li>November 20, 2018, by Martin Kremer:<br/>Changing mass transfer calculation: Now using permeability and thickness of membrane instead of permeance.</li>
<li>November 5,2018 by Martin Kremer:<br/>Correcting error in calculation of heat and mass flow with cross flow coefficient.</li>
<li>August 21, 2018, by Martin Kremer:<br/>First implementation. </li>
</ul>
</html>"));
end EnthalpyExchanger;
