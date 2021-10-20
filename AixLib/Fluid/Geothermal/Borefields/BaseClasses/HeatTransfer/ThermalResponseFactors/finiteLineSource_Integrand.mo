within AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors;
 function finiteLineSource_Integrand
   "Integrand function for finite line source evaluation"
   extends Modelica.Icons.Function;
 
   input Real u(unit="1/m") "Integration variable";
   input Modelica.SIunits.Distance dis "Radial distance between borehole axes";
   input Modelica.SIunits.Height len1 "Length of emitting borehole";
   input Modelica.SIunits.Height burDep1 "Buried depth of emitting borehole";
   input Modelica.SIunits.Height len2 "Length of receiving borehole";
   input Modelica.SIunits.Height burDep2 "Buried depth of receiving borehole";
   input Boolean includeRealSource = true "true if contribution of real source is included";
   input Boolean includeMirrorSource = true "true if contribution of mirror source is included";
 
   output Real y(unit="m") "Value of integrand";
 
 protected
   Real f "Intermediate variable";
 algorithm
   if includeRealSource then
     f := sum({
       +AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_Erfint(
        (burDep2 - burDep1 + len2)*u),
       -AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_Erfint(
        (burDep2 - burDep1)*u),
       +AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_Erfint(
        (burDep2 - burDep1 - len1)*u),
       -AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_Erfint(
        (burDep2 - burDep1 + len2 - len1)*u)});
   else
     f := 0;
   end if;
   if includeMirrorSource then
     f := f + sum({
       +AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_Erfint(
       (burDep2 + burDep1 + len2)*u),
       -AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_Erfint(
       (burDep2 + burDep1)*u),
       +AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_Erfint(
       (burDep2 + burDep1 + len1)*u),
       -AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource_Erfint(
       (burDep2 + burDep1 + len2 + len1)*u)});
   end if;
 
   y := 0.5/(len2*u^2)*f*exp(-dis^2*u^2);
 
 annotation (
 Documentation(info="<html>
 <p>
 Integrand of the cylindrical heat source solution for use in
 <a href=\"modelica://AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource\">
 AixLib.Fluid.Geothermal.Borefields.BaseClasses.HeatTransfer.ThermalResponseFactors.finiteLineSource</a>.
 </p>
 </html>", revisions="<html>
 <ul>
 <li>
 August 23, 2018 by Michael Wetter:<br/>
 Reformulated function to use <code>sum</code>.
 </li>
 <li>
 March 22, 2018 by Massimo Cimmino:<br/>
 First implementation.
 </li>
 </ul>
 </html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
 end finiteLineSource_Integrand;
