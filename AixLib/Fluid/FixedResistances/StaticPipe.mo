within AixLib.Fluid.FixedResistances;
model StaticPipe
  extends AixLib.Fluid.Interfaces.PartialTwoPortTransport;
  import Modelica.Math;
  parameter Modelica.SIunits.Length D = 0.05 "Diameter";
  parameter Modelica.SIunits.Length l = 1 "Length";
  parameter Modelica.SIunits.Length e = 2.5e-5 "Roughness";
  Modelica.SIunits.ReynoldsNumber Re(nominal = 1e5) "Reynolds number";
  Real lambda2 "Modified friction factor";
protected
  Modelica.SIunits.DynamicViscosity mu "Dynamic viscosity";
  Modelica.SIunits.Density rho "Density of the fluid";
equation
  mu = Medium.dynamicViscosity(Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)));
  rho = Medium.density(Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow)));
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
  lambda2 = abs(dp) * 2 * D ^ 3 * rho / (l * mu * mu);
  Re = -2 * sqrt(lambda2) * Math.log10(2.51 / sqrt(lambda2 + 1e-10) + 0.27 * (e / D));
  m_flow = sign(dp) * Modelica.Constants.pi / 4 * D * mu * Re;
  annotation(Icon(graphics={  Rectangle(extent=  {{-100, 40}, {100, -40}}, lineColor=  {0, 0, 0}, fillColor=  {95, 95, 95},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-100, 30}, {100, -30}}, lineColor=  {0, 0, 0}, fillColor=  {0, 128, 255},
            fillPattern=                                                                                                    FillPattern.HorizontalCylinder)}), Documentation(revisions="<html>
 Will be removed
 </html>"));
end StaticPipe;
