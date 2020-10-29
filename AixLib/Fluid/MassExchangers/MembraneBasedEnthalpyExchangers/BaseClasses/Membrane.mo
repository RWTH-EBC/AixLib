within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses;
model Membrane "model of membrane"

  parameter Integer nNodes = 2
    "number of discrete volumes";
  parameter Integer nParallel = 1
    "number of parallel membranes";

  // Parameters
  parameter Modelica.SIunits.Length lengthMem
    "length of membrane in flow direction"
    annotation(Dialog(tab="Geometry"));
  parameter Modelica.SIunits.Length widthMem
    "width of membrane"
    annotation(Dialog(tab="Geometry"));
  parameter Modelica.SIunits.Length thicknessMem
    "thickness of membrane"
    annotation(Dialog(tab="Geometry"));
  parameter Boolean couFloArr=true
    "true: counter-flow arrangement; false: quasi-counter-flow arrangement"
     annotation(Dialog(tab="Geometry"));
  parameter Modelica.SIunits.SpecificHeatCapacity cpMem
    "mass weighted heat capacity of membrane"
    annotation(Dialog(tab="Membrane properties",group="Heat Transfer"));
  parameter Modelica.SIunits.ThermalConductivity lambdaMem
    "thermal conductivity of membrane"
    annotation(Dialog(tab="Membrane properties",group="Heat Transfer"));
  parameter Modelica.SIunits.Density rhoMem
    "density of membrane"
    annotation(Dialog(tab="Membrane properties",group="Others"));

  //Advanced
  parameter Boolean useConPer=true
    "true, if permeabilty of membrane is assumed to be constant"
    annotation(Dialog(tab="Advanced"));
  parameter Real conPerMem(unit="mol/(m.s.Pa)")=9E5
    "constant permeability of membrane if useConPer=true"
    annotation(Dialog(tab="Advanced",enable=useConPer));

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
  Modelica.Blocks.Interfaces.RealInput perMem(unit="mol/(m.s.Pa)") if
       not useConPer "membrane permeability in Barrer"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput[nNodes] coeCroCouSens if not couFloArr
    "coefficient for heat transfer reduction due to cross-flow portion";
  Modelica.Blocks.Interfaces.RealInput[nNodes] coeCroCouLats if not couFloArr
    "coefficient for mass transfer reduction due to cross-flow portion";

  // Heat and Mass Transfer models
  model HeatTransfer=BaseClasses.HeatTransfer.MembraneHeatTransfer
    "heat transfer model in membrane";
  model MassTransfer=BaseClasses.MassTransfer.MembraneMassTransfer
    "mass transfer model in membrane";

  HeatTransfer heatTransfer(
    thicknessMem=thicknessMem,
    lambdaMem=lambdaMem,
    lengthMem=lengthMem,
    widthMem=widthMem,
    rhoMem=rhoMem,
    cpMem=cpMem,
    nParallel=nParallel,
    T_start=T_start,
    dT_start=dT_start,
    n=nNodes,
    coeCroCous=coeCroCouSenInts,
    energyDynamics=energyDynamics);

  MassTransfer massTransfer(
    thicknessMem=thicknessMem,
    lengthMem=lengthMem,
    widthMem=widthMem,
    rhoMem=rhoMem,
    perMem=perMemInt,
    nParallel=nParallel,
    p_start=p_start,
    dp_start=dp_start,
    n=nNodes,
    coeCroCous=coeCroCouLatInts);

  // Ports
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_a[nNodes]
    annotation (Placement(transformation(extent={{-50,40},{-30,60}}),
        iconTransformation(extent={{-50,40},{-30,60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPorts_b[nNodes]
    annotation (Placement(transformation(extent={{-50,-60},{-30,-40}}),
        iconTransformation(extent={{-50,-60},{-30,-40}})));
  Utilities.MassTransfer.MassPort massPorts_a[nNodes] annotation (Placement(
        transformation(extent={{28,68},{52,92}}), iconTransformation(extent={{16,24},
            {66,76}})));
  Utilities.MassTransfer.MassPort massPorts_b[nNodes] annotation (Placement(
        transformation(extent={{28,-92},{52,-68}}), iconTransformation(extent={{14,-76},
            {64,-24}})));

protected
  Modelica.Blocks.Interfaces.RealInput perMemInt(unit="mol/(m.s.Pa)");

  Modelica.Blocks.Interfaces.RealInput[nNodes] coeCroCouSenInts
    "coefficient for heat transfer reduction due to cross-flow portion";
  Modelica.Blocks.Interfaces.RealInput[nNodes] coeCroCouLatInts
    "coefficient for heat transfer reduction due to cross-flow portion";

equation
  if useConPer then
    perMemInt = conPerMem;
  end if;
  if couFloArr then
    coeCroCouSenInts = fill(1,nNodes);
    coeCroCouLatInts = fill(1,nNodes);
  end if;
  connect(coeCroCouSens,coeCroCouSenInts);
  connect(coeCroCouLats,coeCroCouLatInts);

  connect(perMemInt, perMem);

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
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model provides a thin membrane layer. Here the coupled heat and mass transfer through the membrane is calculated using the heat transfer model LocalMembraneHeatTransfer and the mass transfer model LocalMembraneMassTransfer.</p>
<p>The geometry and specification of the membrane are set in this model. By using the parameter <code>nParallel</code> the parallel arrangement of several membranes is possible.</p>
</html>", revisions="<html>
<ul>
<li>November 20, 2018, by Martin Kremer:<br/>Changing mass transfer calculation: Now using permeability and thickness of membrane instead of permeance.</li>
<li>August 21, 2018, by Martin Kremer:<br/>First implementation. </li>
</ul>
</html>"));
end Membrane;
