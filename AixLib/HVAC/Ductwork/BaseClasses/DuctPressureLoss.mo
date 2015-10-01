within AixLib.HVAC.Ductwork.BaseClasses;


model DuctPressureLoss "Pressure Loss of a Duct"
  extends Interfaces.TwoPortMoistAirTransportFluidprops;
  import Modelica.Math;
  parameter Modelica.SIunits.Length D = 0.05 "Diameter";
  parameter Modelica.SIunits.Length l = 1 "Length";
  parameter Modelica.SIunits.Length e = 2.5e-5 "Roughness";
  Modelica.SIunits.VolumeFlowRate Volflow "Volume Flow";
  Real lambda;
  Modelica.SIunits.ReynoldsNumber Re "Reynolds number";
equation
  portMoistAir_a.m_flow = BaseClasses.m_flow_of_dp(dp, rho_MoistAir, dynamicViscosity, l, D, e / D) / (1 + X_Steam);
  Re = 4 * rho_MoistAir * Volflow / dynamicViscosity / D / Modelica.Constants.pi;
  Volflow = portMoistAir_a.m_flow * (1 + X_Steam) / rho_MoistAir;
  lambda = if Volflow > 0 then 1 / 8 * dp * D ^ 5 * Modelica.Constants.pi ^ 2 / l / rho_MoistAir / Volflow ^ 2 else 0;
  annotation( Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Pressure loss model for duct.</p>
 <p>It covers laminar and turbulent regime.</p>
 <p>The critical Reynolds Number is 2300.</p>
 <p>See function for Equations.</p>
 </html>", revisions = "<html>
 <p>30.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -40}, {100, 40}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points=  {{20, -70}, {60, -85}, {20, -100}, {20, -70}}, lineColor=  {0, 128, 255}, fillColor=  {0, 128, 255}, fillPattern=  FillPattern.Solid, visible=  showDesignFlowDirection), Polygon(points=  {{20, -75}, {50, -85}, {20, -95}, {20, -75}}, lineColor=  {255, 255, 255}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, visible=  allowFlowReversal), Line(points=  {{55, -85}, {-60, -85}}, color=  {0, 128, 255}, visible=  showDesignFlowDirection), Rectangle(extent=  {{-100, 100}, {100, -100}}, lineColor=  {0, 0, 0}, fillColor=  {240, 240, 240}, fillPattern=  FillPattern.Solid), Line(points=  {{-76, 72}, {-76, -38}, {76, -38}}, color=  {0, 0, 0}, arrow=  {Arrow.Open, Arrow.Open}), Text(extent=  {{-98, 88}, {-62, 78}}, lineColor=  {0, 0, 0}, textString=  "lambda"), Text(extent=  {{62, -44}, {92, -58}}, lineColor=  {0, 0, 0}, textString=  "Re"), Line(points=  {{-68, 62}, {-66, 46}, {-58, 12}, {-48, -8}}, color=  {0, 0, 0}, thickness=  0.5), Line(points=  {{-44, 26}, {-26, 4}, {6, -14}, {64, -28}}, color=  {0, 0, 0}, thickness=  0.5), Line(points=  {{-42, 38}, {-24, 16}, {8, -2}, {66, -16}}, color=  {0, 0, 0}, thickness=  0.5), Line(points=  {{-42, 52}, {-24, 30}, {8, 12}, {66, 2}}, color=  {0, 0, 0}, thickness=  0.5), Line(points=  {{-40, 62}, {-22, 40}, {10, 22}, {66, 16}}, color=  {0, 0, 0}, thickness=  0.5)}));
end DuctPressureLoss;
