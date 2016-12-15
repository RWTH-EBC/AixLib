within AixLib.Utilities.HeatTransfer;
model CylindricHeatConduction

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,-6},{10,14}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{-10,78},{10,98}},
          rotation=0)));
  parameter Modelica.SIunits.Length d_out=0.04 "outer diameter of pipe";
  parameter Modelica.SIunits.ThermalConductivity lambda=373
    "Heat conductivity of pipe";
  parameter Modelica.SIunits.Length d_in=0.02 "inner diameter of pipe";
  parameter Modelica.SIunits.Length length=1 " Length of pipe";
  parameter Integer nParallel = 1 "Number of identical parallel pipes";

equation
  port_a.Q_flow + port_b.Q_flow = 0;
  port_a.Q_flow = (2*lambda*length*Modelica.Constants.pi/(log(d_out/d_in)))*(port_a.T - port_b.T)*nParallel;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          fillColor={170,255,170},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Model to describe cylindric heat conduction, for example in pipe insulations.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
      revisions="<html>
<ul>
<li><i>November 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
  <li>
         by Alexander Hoh:<br>
         implemented</li>
<ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics));
end CylindricHeatConduction;
