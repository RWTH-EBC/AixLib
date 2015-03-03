within AixLib.HVAC.Ductwork;
model PressureLoss "simple pressure loss model based on zeta value"
  extends BaseClasses.SimplePressureLoss;
  outer BaseParameters baseParameters "System properties";
  parameter Real zeta = 1.0 "Pressure loss factor for flow of port_a -> port_b";
equation
  zeta_var = zeta;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(graphics = {Rectangle(extent=  {{-100, 100}, {100, -100}}, lineColor=  {0, 0, 0}, fillColor=  {170, 255, 255}, fillPattern=  FillPattern.HorizontalCylinder), Text(extent=  {{88, 44}, {-88, -40}}, lineColor=  {0, 0, 255}, fillColor=  {255, 255, 0}, fillPattern=  FillPattern.Solid, textString=  "Zeta =%zeta
 d=%D")}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Simple pressure loss model based on a constant zeta value.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Ductwork.Examples.DuctPressureLoss\">AixLib.HVAC.Ductwork.Examples.DuctPressureLoss</a> </p>
 </html>", revisions = "<html>
 <p>30.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -40}, {100, 40}}), graphics));
end PressureLoss;
