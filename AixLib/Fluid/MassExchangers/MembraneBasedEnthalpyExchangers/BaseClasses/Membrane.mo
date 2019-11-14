within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses;
model Membrane "model of membrane"

  parameter Integer nNodes = 2
    "number of discrete volumes";
  parameter Integer nParallel = 1
    "number of parallel air ducts";

  // Parameters
  parameter Modelica.SIunits.Length lengthMembrane
    "length of membrane in flow direction"
    annotation(Dialog(tab="Geometry"));
  parameter Modelica.SIunits.Length widthMembrane
    "width of membrane"
    annotation(Dialog(tab="Geometry"));
  parameter Modelica.SIunits.Length deltaMembrane
    "thickness of membrane"
    annotation(Dialog(tab="Geometry"));
  parameter Modelica.SIunits.SpecificHeatCapacity heatCapacityMembrane
    "mass weighted heat capacity of membrane"
    annotation(Dialog(tab="Membrane properties",group="Heat Transfer"));
  parameter Modelica.SIunits.ThermalConductivity lambdaMembrane
    "thermal conductivity of membrane"
    annotation(Dialog(tab="Membrane properties",group="Heat Transfer"));
  parameter Modelica.SIunits.Density rhoMembrane
    "density of membrane"
    annotation(Dialog(tab="Membrane properties",group="Others"));

  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=
    Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  // Initialization
  parameter Modelica.SIunits.Temperature T_start
    "start value of membrane's temperature"
    annotation(Dialog(tab="Initialization", group="Heat Transfer"));
  parameter Modelica.SIunits.TemperatureDifference dT_start
    "start value for temperature difference between heatPorts_a and heatPorst_b"
    annotation(Dialog(tab="Initialization", group="Heat Transfer"));
  parameter Modelica.SIunits.PartialPressure p_start
    "start value for mean partial pressure of water vapour at membrane's surface"
    annotation(Dialog(tab="Initialization", group="Mass Transfer"));
  parameter Modelica.SIunits.PartialPressure dp_start
    "start value for partial pressure difference between membrane's surfaces"
    annotation(Dialog(tab="Initialization", group="Mass Transfer"));

  // Inputs
  Modelica.Blocks.Interfaces.RealInput PMembrane(unit="mol/(m.s.Pa)")
    "membrane permeability in Barrer"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  // Heat and Mass Transfer models
  replaceable model HeatTransfer=BaseClasses.HeatTransfer.MembraneHeatTransfer
    "heat transfer model in membrane";
  replaceable model MassTransfer=BaseClasses.MassTransfer.MembraneMassTransfer
    "mass transfer model in membrane";

  HeatTransfer heatTransfer(
    deltaMembrane=deltaMembrane,
    lambdaMembrane=lambdaMembrane,
    lengthMembrane=lengthMembrane,
    widthMembrane=widthMembrane,
    rhoMembrane=rhoMembrane,
    heatCapacityMembrane=heatCapacityMembrane,
    nParallel=nParallel,
    T_start=T_start,
    dT_start=dT_start,
    n=nNodes);

  MassTransfer massTransfer(
    deltaMembrane=deltaMembrane,
    lengthMembrane=lengthMembrane,
    widthMembrane=widthMembrane,
    rhoMembrane=rhoMembrane,
    PMembrane=PMembrane,
    nParallel=nParallel,
    p_start=p_start,
    dp_start=dp_start,
    n=nNodes);

  // Ports
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_a[nNodes]
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_b[nNodes]
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Utilities.MassTransfer.MassPort massPorts_a[nNodes] annotation (Placement(
        transformation(extent={{28,68},{52,92}}), iconTransformation(extent={{14,
            50},{68,104}})));
  Utilities.MassTransfer.MassPort massPorts_b[nNodes] annotation (Placement(
        transformation(extent={{28,-92},{52,-68}}), iconTransformation(extent={{14,-108},
            {68,-54}})));

equation
  connect(heatPorts_a,heatTransfer.heatPorts_a);
  connect(heatPorts_b,heatTransfer.heatPorts_b);

  connect(massPorts_a,massTransfer.massPorts_a);
  connect(massPorts_b,massTransfer.massPorts_b);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Backward)}),                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Membrane;
