within AixLib.Obsolete.YearIndependent.FastHVAC.Media.BaseClasses;
record MediumSimple
  parameter Modelica.Units.SI.SpecificHeatCapacity c
    "Heat capacity of considered medium";
  parameter Modelica.Units.SI.Density rho "Density of considered medium";
  parameter Modelica.Units.SI.ThermalConductivity lambda
    "Thermal conductivity of considered medium";
  parameter Modelica.Units.SI.DynamicViscosity eta
    "Dynamic viscosity of considered medium";
  annotation (Documentation(info="<html><p>
  This record declares parameters that are used by models within the
  FastHVAC Package.
</p>
<ul>
  <li>
    <i>April 25, 2017</i>, by Michael Mans:<br/>
    Moved to AixLib.
  </li>
</ul>
</html>"));
end MediumSimple;
