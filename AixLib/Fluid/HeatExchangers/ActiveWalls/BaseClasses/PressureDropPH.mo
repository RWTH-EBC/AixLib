within AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses;
model PressureDropPH
  "Calculates the pressure drop in a radiator according to manufacturer data"
  extends Modelica.Fluid.Interfaces.PartialTwoPortTransport;

  parameter Real m = 2131
    "Pressure drop coefficient, delta_p[Pa] = tubeLength*m*m_flow[kg/s]^n";
  parameter Real n = 1.7
    "Pressure drop exponent, delta_p[Pa] = tubeLength*m*m_flow[kg/s]^n";
  parameter Modelica.Units.SI.Length tubeLength=10 "total length of tube";

equation
   // Isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  //Hydraulic Part: pressure drop works in both directions now

port_b.p = if noEvent(port_a.m_flow>=0) then port_a.p - tubeLength*m*(port_a.m_flow)^n else  port_a.p + tubeLength*m*(port_b.m_flow)^n;

  annotation (
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for calculating the pressure drop.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The pressure drop is calculated according to the following equation
  [1].
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/equations/equation-8xFaklFH.png\"
  alt=\"Delta_P = K*m_flow^2\">
</p>
<p>
  In order to determine <i>K,</i> manufacturer data is used and :
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Fluid/ActiveWalls/PressureDrop.bmp\"
  alt=\"Pressure Drop\">
</p>
<p>
  With the help onf the Matlab Curve Fit Toolbox a curve y = K*x^2 is
  fitted through several selected points.
</p>
<h4>
  <span style=\"color:#008000\">Reference</span>
</h4>
<p>
  Source:
</p>
<ul>
  <li>[1] Ross, Hans: \"Hydraulik der Wasserheizung\", Oldenbourg
  Indunstrieverlag GmbH, 2002.
  </li>
</ul>
</html>",
  revisions="<html><ul>
  <li>
    <i>June 15, 2017&#160;</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>June 10, 2011&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"),
    Diagram(graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
         graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-46,68},{-46,-42},{48,-42}},
          color={0,0,0},
          smooth=Smooth.None,
          arrow={Arrow.Open,Arrow.Open}),
        Line(
          points={{-46,-2},{40,-2}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-46,22},{40,22}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-46,38},{40,38}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-46,48},{40,48}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-46,54},{40,54}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-46,58},{40,58}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-6,60},{-6,-42}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{14,60},{14,-42}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{26,60},{26,-42}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{34,60},{34,-42}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{38,60},{38,-42}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{40,60},{40,-42}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-64,66},{-46,58}},
          lineColor={0,0,0},
          textString="dp"),
        Text(
          extent={{24,-46},{50,-54}},
          lineColor={0,0,0},
          textString="m_flow"),
        Line(
          points={{22,58},{-28,-42}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=1)}));
end PressureDropPH;
