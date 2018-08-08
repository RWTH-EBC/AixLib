within AixLib.FastHVAC.Media.BaseClasses;
record MediumSimple
parameter Modelica.SIunits.SpecificHeatCapacity c
    "Heat capacity of considered medium";
parameter Modelica.SIunits.Density rho "Density of considered medium";
parameter Modelica.SIunits.ThermalConductivity lambda
    "Thermal conductivity of considered medium";
parameter Modelica.SIunits.DynamicViscosity eta
    "Dynamic viscosity of considered medium";
  annotation (Documentation(info="<html><p>
  This record declares parameters that are used by models within the
  FastHVAC Package.
</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>April 25, 2017</i>, by Michael Mans:<br/>
    Moved to AixLib.
  </li>
</ul>
</html>"));
end MediumSimple;
