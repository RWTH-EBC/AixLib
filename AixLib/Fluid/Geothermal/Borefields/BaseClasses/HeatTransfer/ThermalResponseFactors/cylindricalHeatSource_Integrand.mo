within AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors;
 function cylindricalHeatSource_Integrand
   "Integrand function for cylindrical heat source evaluation"
   extends Modelica.Icons.Function;
 
   input Real u "Normalized integration variable";
   input Real Fo "Fourier number";
   input Real p "Ratio of distance over radius";
 
   output Real y "Value of integrand";
 
 algorithm
   y := 1.0/(u^2*Modelica.Constants.pi^2)*(exp(-u^2*Fo) - 1.0)
     /(AixLib.Utilities.Math.Functions.besselJ1(u)^2+AixLib.Utilities.Math.Functions.besselY1(u)^2)
     *(AixLib.Utilities.Math.Functions.besselJ0(p*u)*AixLib.Utilities.Math.Functions.besselY1(u)
       -AixLib.Utilities.Math.Functions.besselJ1(u)*AixLib.Utilities.Math.Functions.besselY0(p*u));
 
 annotation (
 Inline=true,
 Documentation(info="<html>
 <p>
 Integrand of the cylindrical heat source solution for use in
 <a href=\"modelica://AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.cylindricalHeatSource\">
 AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.cylindricalHeatSource</a>.
 </p>
 </html>", revisions="<html>
 <ul>
 <li>
 March 22, 2018 by Massimo Cimmino:<br/>
 First implementation.
 </li>
 </ul>
 </html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
 end cylindricalHeatSource_Integrand;
