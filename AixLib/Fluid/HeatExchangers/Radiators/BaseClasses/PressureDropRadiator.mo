within AixLib.Fluid.HeatExchangers.Radiators.BaseClasses;
model PressureDropRadiator
  "Calculates the pressure drop in a radiator according to manufacturer data"
  extends AixLib.Fluid.Interfaces.PartialTwoPortTransport;

  parameter Real PD(unit="1/(kg.m)")
    "Pressure drop coefficient, delta_p[Pa] = PD*m_flow[kg/s]^2";

equation
   // Isenthalpic state transformation (no storage and no loss of energy)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  //Hydraulic Part: pressure drop

   port_b.p = if noEvent(port_a.m_flow>=0) then port_a.p - PD*port_a.m_flow*
   port_a.m_flow else  port_a.p + PD*port_a.m_flow*port_a.m_flow;

  annotation (
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Calculates the pressure drop in a radiator according to manufacturer
  data
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
  \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/equation-8xFaklFH.png\"
  alt=\"Delta_P = K*m_flow^2\">
</p>
<p>
  In order to determine <i>K,</i> manufacturer data is used and :
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/PressureDrop.bmp\"
  alt=\"Pressure Drop\">
</p>
<p>
  With the help of the Matlab Curve Fit Toolbox a curve y = K*x^2 is
  fitted through several selected points.
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  [1] Ross, Hans: \"Hydraulik der Wasserheizung\", Oldenbourg
  Industrieverlag GmbH, 2002.
</p>
</html>",
  revisions="<html><ul>
  <li>
    <i>October, 2016&#160;</i> by Peter Remmen:<br/>
    Transfer to AixLib.
  </li>
  <li>
    <i>October 7, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>June 10, 2011&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"),
    Diagram(graphics),
    Icon(graphics={Bitmap(extent={{-80,76},{94,-58}}, fileName=
              "modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/PressureDrop.bmp")}));
end PressureDropRadiator;
