within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers;
model EnthalpyExchanger
  "model for a parallel membrane enthalpy exchanger"

  // Medium in air ducts
  package Medium = AixLib.Media.Air
    "medium in the air ducts";

  // General parameter
  parameter Integer n(min=2)
    "number of discrecete volumes in flow direction";
  parameter Integer nParallel(min=1)
    "number of parallel membranes";

  //----------------------Air Ducts------------------------------------

  // Geometry
  parameter Modelica.SIunits.Length lengthDuct
    "length of airDucts in flow direction"
    annotation(Dialog(tab="AirDucts",group="Geometry"));
  parameter Modelica.SIunits.Length heightDuct
    "height of ducts"
    annotation(Dialog(tab="AirDucts",group="Geometry"));
  parameter Modelica.SIunits.Length widthDuct
    "width of ducts"
    annotation(Dialog(tab="AirDucts",group="Geometry"));

  // Heat and mass transfer parameters
  parameter Boolean UWT
    "true if UWT(uniform wall temperature) boundary conditions"
    annotation(Dialog(tab="AirDucts",group="Heat and mass transfer"));
  parameter Boolean local
    "true if heat and mass transfer are locally resolved"
    annotation(Dialog(tab="AirdDucts",group="Heat and mass transfer"));

  // pressure losses
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "nominal mass flow rate";
  parameter Modelica.SIunits.Pressure dp_nominal
    "nominal pressure drop";

  //-----------------------Membrane-------------------------------------

  // Geometry
  parameter Modelica.SIunits.Length lengthMembrane=lengthDuct
    "length of membranes in flow direction"
    annotation(Dialog(enable=false,tab="Membranes",group="Geometry"));
  parameter Modelica.SIunits.Length widthMembrane=widthDuct
    "width of membranes"
    annotation(Dialog(enable=false,tab="Membranes",group="Geometry"));
  parameter Modelica.SIunits.Length deltaMembrane
    "thickness of membranes"
    annotation(Dialog(tab="Membranes",group="Geometry"));
  parameter Modelica.SIunits.SpecificHeatCapacity heatCapacityMembrane
    "mass weighted heat capacity of membrane"
    annotation(Dialog(tab="Membranes",group="Heat and mass transfer"));

  // Membrane properties
  parameter Modelica.SIunits.ThermalConductivity lambdaMembrane
    "thermal conductivity of membrane"
    annotation(Dialog(tab="Membranes",group="Heat and mass transfer"));
  parameter Modelica.SIunits.Density rhoMembrane
    "density of membrane"
    annotation(Dialog(tab="Membranes",group="Others"));

  // calculated parameter
  parameter Modelica.SIunits.Area[n] surfaceAreas=
    fill(lengthMembrane*widthMembrane/n,n)
    "Heat transfer areas"
    annotation(Dialog(enable=false,tab="calculated"));

  //----------------------Housing----------------------------------------
  parameter Modelica.SIunits.SpecificHeatCapacity heatCapacityHousing
    "mass weighted heat capacity of housing"
    annotation(Dialog(tab="Housing",group="Heat and mass transfer"));
  parameter Modelica.SIunits.Mass massHousing
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
    annotation(Evaluate=true, Dialog(tab = "Initialization", enable = use_T_start));
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
    final m_flow_nominal=m_flow_nominal,
    final dp_nominal=dp_nominal,
    final nNodes=n,
    final nParallel=nParallel,
    final lengthDuct=lengthDuct,
    final widthDuct=widthDuct,
    final heightDuct=heightDuct,
    final UWT=UWT,
    final local=local,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start)
    annotation (Placement(transformation(extent={{22,-88},{-34,-32}})));
  BaseClasses.AirDuct airDuct1(
    final m_flow_nominal=m_flow_nominal,
    final dp_nominal=dp_nominal,
    final nNodes=n,
    final nParallel=nParallel,
    final lengthDuct=lengthDuct,
    final widthDuct=widthDuct,
    final heightDuct=heightDuct,
    final UWT=UWT,
    final local=local,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start)
    annotation (Placement(transformation(extent={{-34,88},{22,32}})));
  BaseClasses.Membrane membrane(
    final nNodes=n,
    final nParallel=nParallel,
    final lengthMembrane=lengthMembrane,
    final widthMembrane=widthMembrane,
    final deltaMembrane=deltaMembrane,
    final heatCapacityMembrane=heatCapacityMembrane,
    final lambdaMembrane=lambdaMembrane,
    final rhoMembrane=rhoMembrane,
    final T_start=T_start_m,
    final dT_start=dT_start,
    final p_start=p_start,
    final dp_start=dp_start)
    annotation (Placement(transformation(extent={{-36,-28},{22,28}})));
  Modelica.Blocks.Interfaces.RealInput PMembrane
    "membrane permeability in Barrer"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
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
equation
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
  connect(PMembrane, membrane.PMembrane)
    annotation (Line(points={{-120,0},{-82,0},{-82,3.55271e-15},{-41.8,
          3.55271e-15}},                        color={0,0,127}));
  connect(airDuct1.port_a, port_a1) annotation (Line(points={{-34,60},{-100,60}},
                              color={0,127,255}));
  connect(airDuct1.port_b, port_b1)
    annotation (Line(points={{22,60},{100,60}},          color={0,127,255}));
  connect(airDuct2.port_a, port_a2) annotation (Line(points={{22,-60},{100,-60}},
                      color={0,127,255}));
  connect(airDuct2.port_b, port_b2) annotation (Line(points={{-34,-60},{-100,
          -60}},                 color={0,127,255}));
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
        coordinateSystem(preserveAspectRatio=false)));
end EnthalpyExchanger;
