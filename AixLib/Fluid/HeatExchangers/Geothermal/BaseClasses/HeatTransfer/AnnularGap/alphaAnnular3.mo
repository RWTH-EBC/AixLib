within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap;
function alphaAnnular3
  "single phase medium in annular gap Boundary condition 3 (both pipes have same temperature, heat flow from both pipes)"
 extends
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alpha_partial;
 import SI = Modelica.SIunits;
 import MATH = Modelica.Math;

  // Variables
protected
 SI.PrandtlNumber Pr = eta*cp/lambda "Prandtl Number in core Fluid";
 // We currently assume: Pr/Pr_w = 1
 SI.KinematicViscosity nue=eta/d;
 SI.NusseltNumber Nu_m "Nusselt Number for turbulent flow";
 SI.NusseltNumber Nu_R "Nusselt Number pipe";
 SI.NusseltNumber Nu_Rt "Nusselt Number pipe at Re=10^4";
 Real f "correction factor for annular gap flow";
 SI.Length d_h=1 "hydraulic diameter";
 Real xi;
 Real gamma;

algorithm
 v := m_dot / d / ((d_o^2 - d_i^2) * Modelica.Constants.pi/4);
 d_h :=d_o - d_i;
 // equations from VDI-Waermeatlas 3.0, 2006. Boundary condition 2 (inner pipe isolated).
 // laminar or turbulent flow? no negative velocity.
 Re := abs(v) * d_h / nue;
 f := 1.615 * (1+0.14*(d_o/d_i)^(1/3));

 if Re < 2320 then // laminar flow range
   Nu_m := (
         ( 3.66 + (4-(0.102/((d_i/d_o)+0.02)))*(d_i/d_o)^0.04) ^3
         + ( f*(Re*Pr*d_h/L)^(1/3))^3)
          ^(1/3);

 else // turbulent flow range
   xi := (1.82 * MATH.log10(Re) - 1.64)^(-2);

   gamma :=(Re - 2300)/(10^4 - 2300);
   if Re < 10e4 and Re >= 2300 then // transition flow range
     Nu_Rt :=xi/8*10^4*Pr/(1 + 12.7*sqrt(xi/8)*(Pr^(2/3) - 1))*(1 + (d_h/L)^(2
       /3));
     Nu_m:=(1 - gamma)*
         ( ( 3.66 + (4-(0.102/((d_i/d_o)+0.02)))*(d_i/d_o)^0.04) ^3
         + ( f*(2300*Pr*d_h/L)^(1/3))^3)^(1/3)
         + gamma*
         Nu_Rt * ((0.86*(d_i/d_o)^0.84+(1-0.14*(d_i/d_o)^0.6))/(1+(d_i/d_o)));
   else // Re > 10^4
     Nu_R :=xi/8*Re*Pr/(1 + 12.7*sqrt(xi/8)*(Pr^(2/3) - 1))*(1 + (d_h/L)^(2/3));
     Nu_m := Nu_R * (
      (0.86*(d_i/d_o)^0.84+(1-0.14*(d_i/d_o)^0.6))
      /(1+(d_i/d_o)));
   end if;

 end if;
 Nu :=Nu_m*(Pr/Pr_w)^0.11;
 alpha := Nu * lambda / d_h;

  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p><b>alphaAnnular</b> computes the coefficient of heat transfer in pipe heat exchangers in the annular gap of outer and inner pipe. </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Source:</p>
<ul>
<li>&QUOT;single&nbsp;phase&nbsp;medium&nbsp;in&nbsp;annular&nbsp;gap&nbsp;Boundary&nbsp;condition&nbsp;3&nbsp;(both&nbsp;pipes&nbsp;have&nbsp;same&nbsp;temperature,&nbsp;heat&nbsp;flow&nbsp;from&nbsp;both&nbsp;pipes)&QUOT; according to VDI-Waermeatlas&nbsp;3.0,&nbsp;2006.</li>
</ul>
</html>",
  revisions="<html>
<p><ul>
<li><i>January 10, 2014&nbsp;</i> by Kristian Huchtemann:<br/>Implemented.</li>
</ul></p>
</html>"));
end alphaAnnular3;
