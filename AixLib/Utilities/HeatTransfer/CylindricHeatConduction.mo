within AixLib.Utilities.HeatTransfer;
model CylindricHeatConduction "Heat conduction through cylindric material"

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,-6},{10,14}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{-10,78},{10,98}},
          rotation=0)));
  parameter Modelica.Units.SI.Length d_out(min=0) "outer diameter of pipe";
  parameter Modelica.Units.SI.ThermalConductivity lambda=373
    "Heat conductivity of pipe";
  parameter Modelica.Units.SI.Length d_in(min=0) "inner diameter of pipe";
  parameter Modelica.Units.SI.Length length(min=0) " Length of pipe";
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
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model to describe cylindric heat conduction, for example in pipe
  insulations.
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>October 12, 2016&#160;</i> by Marcus Fuchs:<br/>
    Add description and fix documentation
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
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics));
end CylindricHeatConduction;
