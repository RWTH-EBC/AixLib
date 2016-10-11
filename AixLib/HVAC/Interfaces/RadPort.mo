within AixLib.HVAC.Interfaces;
connector RadPort "Port for radiative heat transfer 1-dim"
  extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Line(points = {{-100, 100}, {100, -100}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-98, -96}, {100, 100}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{0, -100}, {0, 100}}, color = {0, 0, 0}, thickness = 0.5)}), Diagram(graphics={  Text(extent = {{-80, 114}, {82, 72}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, textString = "%name"), Line(points = {{-60, 58}, {60, -60}}, color = {0, 0, 0}, thickness = 1), Line(points = {{-80, 0}, {80, 0}}, color = {0, 0, 0}, thickness = 1), Line(points = {{-60, -60}, {58, 60}}, color = {0, 0, 0}, thickness = 1), Line(points = {{0, -80}, {0, 80}}, color = {0, 0, 0}, thickness = 1)}), Documentation(revisions = "<html>
 <p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
 </html>", info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Connector for radiative heat transfer.</p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>Same functionality as HeatPort.</p>
 <p>Is used for components with radiative heat transfer (NOT air).</p>
 </html>"));
end RadPort;
