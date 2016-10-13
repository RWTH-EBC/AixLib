within AixLib.Utilities.HeatTransfer;
class CylindricLoad "Model for a cylindric heat capacity"

  parameter Modelica.SIunits.Density rho=1600 "Density of material";
  parameter Modelica.SIunits.SpecificHeatCapacity c=1000
    "Specific heat capacity of material";
  parameter Modelica.SIunits.Length d_out=0.04 "outer diameter of pipe";
  parameter Modelica.SIunits.Length d_in=0.02 "inner diameter of pipe";
  parameter Modelica.SIunits.Length length=1 " Length of pipe";
  parameter Modelica.SIunits.Temperature T0=289.15 "initial temperature";
  parameter Integer nParallel = 1 "Number of identical parallel pipes";
  Modelica.SIunits.Mass m "Mass of material";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port(T(start=T0))
    annotation (Placement(transformation(extent={{-12,-18},{8,2}}, rotation=0)));
equation
  m = nParallel*rho*length*Modelica.Constants.pi*(d_out*d_out - d_in*d_in)/4;
  der(port.T) = 1/m/c*port.Q_flow;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Ellipse(
          extent={{-80,68},{80,-92}},
          lineColor={0,0,255},
          fillColor={255,85,85},
          fillPattern=FillPattern.CrossDiag), Ellipse(
          extent={{-42,28},{38,-52}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.3,
      y=0.18,
      width=0.6,
      height=0.6),
    Documentation(revisions="<html>
<ul>
<li><i>October 12, 2016&nbsp;</i> by Marcus Fuchs:<br/>Add comments and fix documentation</li>
<li><i>October 11, 2016&nbsp;</i> by Sebastian Stinner:<br/>Transferred to AixLib</li>
<li><i>November 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>
",  info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p> The <code>CylindricLoad</code> model represents a cylindric heat capacity, which
is described by its area, density, thickness and material specific heat
capacity. </p>
</html>"));
end CylindricLoad;
