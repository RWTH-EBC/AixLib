within AixLib.Utilities.HeatTransfer;
model CylindricHeatTransfer "Model for cylindric heat transfer"

  parameter Modelica.SIunits.Density rho=1600 "Density of material";
  parameter Modelica.SIunits.SpecificHeatCapacity c=1000
    "Specific heat capacity of material";
  parameter Modelica.SIunits.Length d_out=0.04 "Outer diameter of pipe";
  parameter Modelica.SIunits.Length d_in=0.02 "Inner diameter of pipe";
  parameter Modelica.SIunits.Length length=1 " Length of pipe";
  parameter Modelica.SIunits.ThermalConductivity lambda=373
    "Heat conductivity of pipe";
  parameter Modelica.SIunits.Temperature T0=289.15 "Initial temperature";
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
    nParallel=nParallel)
    "Outer heat conduction" annotation (Placement(transformation(extent={{-10,56},
            {10,76}}, rotation=0)));
  AixLib.Utilities.HeatTransfer.CylindricLoad CylindricLoad1(
    rho=rho,
    c=c,
    d_in=d_in,
    d_out=d_out,
    length=length,
    T0=T0,
    nParallel=nParallel)
    "Heat capacity" annotation (Placement(transformation(extent={{-10,36},
            {10,56}}, rotation=0)));
  AixLib.Utilities.HeatTransfer.CylindricHeatConduction CylindricHeatConductionIn(
    length=length,
    lambda=lambda,
    d_out=(d_out + d_in)/2,
    d_in=d_in,
    nParallel=nParallel)
    "Inner heat conduction" annotation (Placement(transformation(extent={{-10,14},
            {10,34}}, rotation=0)));
equation
  connect(CylindricHeatConductionOut.port_b, port_b) annotation (Line(
      points={{0,74.8},{0,88}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(CylindricLoad1.port, CylindricHeatConductionOut.port_a) annotation (
      Line(
      points={{-0.2,45.2},{-0.2,55.6},{0,55.6},{0,66.4}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(CylindricHeatConductionIn.port_b, CylindricLoad1.port) annotation (
      Line(
      points={{0,32.8},{0,45.2},{-0.2,45.2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_a, CylindricHeatConductionIn.port_a) annotation (Line(
      points={{0,0},{0,24.4}},
      color={191,0,0},
      smooth=Smooth.None));
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
            100,100}}),  graphics),
    Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p> Model to describe the cylindric heat transfer, for example in pipe
insulations. </p>

</html>",
      revisions="<html>
<ul>
<li><i>October 12, 2016&nbsp;</i> by Marcus Fuchs:<br/>Add comments and fix documentation</li>
<li><i>October 11, 2016&nbsp;</i> by Sebastian Stinner:<br/>Transferred to AixLib</li>
<li><i>November 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
  <li>
         by Alexander Hoh:<br/>
         implemented</li>
</ul>
</html>"));
end CylindricHeatTransfer;
