within AixLib.Utilities.HeatTransfer;
model CylindricHeatTransfer "Model for cylindric heat transfer"
  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  parameter Modelica.Units.SI.Density rho=1600 "Density of material";
  parameter Modelica.Units.SI.SpecificHeatCapacity c=1000
    "Specific heat capacity of material";
  parameter Modelica.Units.SI.Length d_out(min=0) "Outer diameter of pipe";
  parameter Modelica.Units.SI.Length d_in(min=0) "Inner diameter of pipe";
  parameter Modelica.Units.SI.Length length(min=0) " Length of pipe";
  parameter Modelica.Units.SI.ThermalConductivity lambda=373
    "Heat conductivity of pipe";
  parameter Modelica.Units.SI.Temperature T0=289.15 "Initial temperature";
  parameter Integer nParallel = 1 "Number of identical parallel pipes";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{-10,78},{10,98}},
          rotation=0)));
  AixLib.Utilities.HeatTransfer.CylindricHeatConduction CylindricHeatConductionOut(
    length=length,
    lambda=lambda,
    d_in=(d_out + d_in)/2,
    d_out=d_out,
    nParallel=nParallel) "Outer heat conduction"
                            annotation (Placement(transformation(extent={{-10,56},
            {10,76}}, rotation=0)));
  AixLib.Utilities.HeatTransfer.CylindricLoad CylindricLoad1(
    final energyDynamics=energyDynamics,
    rho=rho,
    c=c,
    d_in=d_in,
    d_out=d_out,
    length=length,
    T0=T0,
    nParallel=nParallel) "Heat capacity"
                    annotation (Placement(transformation(extent={{-10,38},{10,58}},
                      rotation=0)));
  AixLib.Utilities.HeatTransfer.CylindricHeatConduction CylindricHeatConductionIn(
    length=length,
    lambda=lambda,
    d_out=(d_out + d_in)/2,
    d_in=d_in,
    nParallel=nParallel) "Inner heat conduction"
                            annotation (Placement(transformation(extent={{-10,14},
            {10,34}}, rotation=0)));
equation
  connect(CylindricHeatConductionOut.port_b, port_b) annotation (Line(
      points={{0,74.8},{0,88}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(CylindricHeatConductionIn.port_b, CylindricLoad1.port) annotation (
      Line(
      points={{0,32.8},{0,47.2},{-0.2,47.2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_a, CylindricHeatConductionIn.port_a) annotation (Line(
      points={{0,0},{0,24.4}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(CylindricHeatConductionOut.port_a, CylindricLoad1.port) annotation (Line(points={{0,66.4},{0,47.2},{-0.2,47.2}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,85,85}),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{172,30},{172,-22}}, textString=
                                              "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model to describe the cylindric heat transfer, for example in pipe
  insulations.
</p>
</html>",
      revisions="<html><ul>
  <li>January 24, 2020 by Philipp Mehrfeld:<br/>
    <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/793\">#793</a>
    Switch to Dynamics enumerator to control init and energy conversion
    during simulation.
  </li>
  <li>
    <i>October 12, 2016&#160;</i> by Marcus Fuchs:<br/>
    Add comments and fix documentation
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Sebastian Stinner:<br/>
    Transferred to AixLib
  </li>
  <li>
    <i>November 13, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>by Alexander Hoh:<br/>
    implemented
  </li>
</ul>
</html>"));
end CylindricHeatTransfer;
