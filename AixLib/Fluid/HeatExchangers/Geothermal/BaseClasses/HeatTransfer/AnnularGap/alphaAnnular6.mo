within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap;
function alphaAnnular6 "WSA: annular gap on inside pipe"
 extends
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alpha_partial;
 import SI = Modelica.SIunits;
 import MATH = Modelica.Math;

  // Variables
protected
 SI.PrandtlNumber Pr = eta*cp/lambda "Prandtl Number in core Fluid";
 // We currently assume: Pr/Pr_w = 1
 SI.KinematicViscosity nue=eta/d;
 SI.NusseltNumber Nu_1 "Nusselt Number 1";
 SI.NusseltNumber Nu_2 "Nusselt Number 2";
 SI.NusseltNumber Nu_R "Nusselt Number pipe";
 //SI.NusseltNumber Nu_Rt "Nusselt Number pipe at Re=10^4";
 // Real f "correction factor for annular gap flow";
 SI.Length d_h=1 "hydraulic diameter";
 Real xi;
 Real gamma;

algorithm
 v := m_dot / d / ((d_o^2 - d_i^2) * Modelica.Constants.pi/4);
 d_h :=d_o - d_i;
 // equations from VDI-Waermeatlas 3.0, 2006. Boundary condition 2 (inner pipe isolated).
 // laminar or turbulent flow? no negative velocity.
 Re := abs(v) * d_h / nue;
 // f := 1.615 * (1+0.07*(d_o/d_i)^(1/3)+0.07*(d_o/d_i)^0.1);

 if Re < 2320 then // laminar flow range ///////////////////////////////////////////////////////////////////
   Nu_1:=3.66 + (4 - 0.102/((d_i/d_o) + 0.02))*(d_i/d_o)^0.04;
   Nu_2:=1.615*(1 + 0.14*(d_i/d_o)^0.1)*(Re*Pr*d_h/L)^(1/3);
   Nu:=(Nu_1^3 + Nu_2^3)^(1/3);

 else // turbulent flow range ///////////////////////////////////////////////////////////////////////////////
   xi := (1.8 * MATH.log10(Re) - 1.5)^(-2);
   //gamma :=(Re - 2300)/(10^4 - 2300);
   Nu_R:=xi*Re*Pr/(1 + 12.7*(xi/8)^0.5*(Pr^(2/3) - 1))*(1 + (d_h/L)^(2/3));
   Nu:=Nu_R * (0.86*(d_i/d_o)^0.84+(1-0.14*(d_i/d_o)^0.6))*(1+(d_i/d_o))^(-1);
 end if;
 //Nu :=Nu_m*(Pr/Pr_w)^0.11;
 alpha := Nu/2 * lambda / d_h;

  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p><b>alphaAnnular</b> computes the coefficient of heat transfer in pipe heat exchangers in the annular gap of outer and inner pipe. </p>
<p>&QUOT;equations used by WSA:&nbsp;annular&nbsp;gap&nbsp;on&nbsp;inside&nbsp;pipe&QUOT;</p>
</html>",
  revisions="<html>
<p><ul>
<li><i>January 10, 2014&nbsp;</i> by Kristian Huchtemann:<br/>Implemented.</li>
</ul></p>
</html>"));
end alphaAnnular6;
