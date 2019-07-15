within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss;
partial function delta_p_partial
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Function;
  input SI.Diameter d_i=0.01 "inner diameter of annular gap";
  input SI.Diameter d_o=0.02 "outer diameter of annular gap";
  input SI.MassFlowRate m_dot=1 "Mass Flow Rate of Medium";
  input SI.Length height=0;
  input SI.Density d=999.2 "Density";
  input SI.Length L=1 "length of pipe";
  input SI.KinematicViscosity ny=1e-6;

  output SI.Pressure dpFG;

protected
  SI.Velocity w "Velocity of Fluid";
  SI.ReynoldsNumber Re "Reynolds Number";
  Real xi;
  Real phi= ((1 + a^2)*Modelica.Math.log(a) + (1 - a^2))/((1 - a^2)*
    Modelica.Math.log(a));
//  SI.Pressure dpF;
  Real a=d_i/d_o "relation of diameters";
  SI.Diameter d_h=d_o - d_i "hydraulic diameter of annular gap";
  SI.Acceleration gravity=9.81;

  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Base function for calculation of pressure loss in an annular gap.</p>
</html>",
    revisions="<html>
<p><ul>
<li><i>January 10, 2014&nbsp;</i> by Kristian Huchtemann:<br/>Implemented.</li>
</ul></p>
</html>"));
end delta_p_partial;
