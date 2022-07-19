within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions;
function to_surfaceTiltVDI
  "Conversion of AixLib surface tilt to surface tilt according to VDI 6007"
  extends Modelica.Units.Icons.Conversion;
  input Modelica.Units.SI.Angle til "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for
  roof";
  output Modelica.Units.SI.Angle gamma_F "";
algorithm
  gamma_F:=Modelica.Constants.pi-til;

  annotation (Documentation(info="<html>This function converts the inclination of a surface from the <a href=
\"AixLib\">AixLib</a> definition to the definition of the VDI 6007 part
3.
</html>",
        revisions="<html><ul>
  <li>June 07, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end to_surfaceTiltVDI;
