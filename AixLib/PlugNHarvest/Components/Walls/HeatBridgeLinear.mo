within AixLib.PlugNHarvest.Components.Walls;
model HeatBridgeLinear "Heat transfer due to a heat bridge (linear model)"
  extends PlugNHarvest.Components.Walls.BaseClasses.PartialHeatBridgeWalls;

   parameter Real psiVer(unit="W/(m.K)") = 0.1;
   parameter Real psiHor(unit="W/(m.K)") = 0.1;
   parameter Modelica.SIunits.Length wallHeight = 0.1;
   parameter Modelica.SIunits.Length wallLength = 0.1;
   Modelica.SIunits.TemperatureDifference dT;
equation
  dT=port_a.T-port_b.T;
  qFlow=psiVer*wallHeight*dT+psiHor*wallLength*dT;
  port_a.Q_flow=qFlow;
  port_b.Q_flow=-qFlow;

  annotation (Diagram(graphics), Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Model for linear heat bridge. </p>
<h4><font color=\"#008000\">Concept</font></h4>
<p>Models linear heat bridge in both horizontal and vertical direction.</p>
</html>",
   revisions="<html>
<ul>
<li><i>January 29, 2018&nbsp;</i> by Sebastian Stinner:<br/>Implemented</li>

</ul>
</html>"));
end HeatBridgeLinear;
