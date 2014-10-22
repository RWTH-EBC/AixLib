within AixLib.HVAC.HeatExchanger.BaseClasses;
model SimpleHeatTransfer "Just passing heat flow through"

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Blocks.Interfaces.RealInput Q "Heat flow from port a to port b"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));

equation
  port_a.Q_flow = Q;
  port_b.Q_flow = -Q;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Line(
          points={{0,-60},{0,60}},
          color={0,0,255},
          smooth=Smooth.None), Line(
          points={{-20,40},{0,60},{20,40}},
          color={0,0,255},
          smooth=Smooth.None)}), Documentation(revisions="<html>
<p>12.01.2014, Peter Matthes</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model transfers a given power from one thermal port to a second.</p>
</html>"));
end SimpleHeatTransfer;
