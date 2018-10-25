within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap;
partial function alpha_partial
  extends Modelica.Icons.Function;
  import SI = Modelica.SIunits;
  import MATH = Modelica.Math;

  //main input
  input SI.Length d_i=0.01 "inner diameter of annular gap";
  input SI.Length d_o=0.01 "outer diameter of annular gap";

  //main output
  output SI.CoefficientOfHeatTransfer alpha;

  // additional input
  input SI.DynamicViscosity eta=1139.0*10e-6 "Dynamic Viscosity";
  input SI.Density d=999.2 "Density";
  input SI.ThermalConductivity lambda=0.5911 "thermal Conductivity";
  input SI.HeatCapacity cp=4186 "heat Capacity at constant pressure J/kgK";
  input SI.MassFlowRate m_dot=1 "Mass Flow Rate of Medium";
  input SI.Length L=1 "length of pipe";
  input SI.PrandtlNumber Pr_w=1139.0*10e-6*4186/0.5911 "Prandtl Number at Wall";

  // additional output variables
  output SI.Velocity v "Velocity of Fluid";
  output SI.ReynoldsNumber Re;
  output SI.NusseltNumber Nu "Temperature corrected Nusselt Number";

  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Base function for convection in annular gap.</p>
</html>",
  revisions="<html>
<p><ul>
<li><i>January 10, 2014&nbsp;</i> by Kristian Huchtemann:<br/>Implemented.</li>
</ul></p>
</html>"));
end alpha_partial;
