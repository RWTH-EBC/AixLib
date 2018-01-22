within AixLib.Building.Components.DryAir;
model Airload "Air volume"

  replaceable model Physics =
      AixLib.Building.Components.DryAir.BaseClasses.BasisAirloadconstMass constrainedby
    AixLib.Building.Components.DryAir.BaseClasses.PartialBasisAirload  annotation(Placement(transformation(extent={{-56,-64},{-36,-44}})), choicesAllMatching = true);
  extends Physics;

  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2})),                                              Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={                                                                      Rectangle(extent={{
              -80,80},{80,-80}},                                                                                                                                                                                                        lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{
              -30,36},{30,-30}},                                                                                                                                                      lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Air")}), Documentation(revisions = "<html>
 <ul>
 <li><i>Jan 22, 2018&nbsp;</i> by Tim R&ouml;der:<br/>Uses a selectable physics-component (constant mass, constant temperature, ...) and properties from a media model</li>
 <li><i>May 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 </ul>
 </html>", info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>Airload</b> model represents a heat capacity consisting of air. It is described by its volume and media properties. </p>
 <p>By default the <a href=\"AixLib.Building.Components.DryAir.BaseClasses.BasisAirloadconstMass\">BasisAirloadconstMass</a> is activated. </p>
 <h4><font color=\"#008000\">Example Results</font></h4>
 <p><a href=\"AixLib.Building.Components.Examples.DryAir.DryAir_test\">AixLib.Building.Components.Examples.DryAir.DryAir_test</a> </p>
 </html>"));
end Airload;
