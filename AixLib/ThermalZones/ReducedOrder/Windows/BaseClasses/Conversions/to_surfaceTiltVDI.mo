within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions;
function to_surfaceTiltVDI
  "Conversion of AixLib surface tilt to surface tilt according to VDI 6007"
  extends Modelica.SIunits.Icons.Conversion;
  import Modelica.Constants.pi;
  input Modelica.SIunits.Angle til;
  output Modelica.SIunits.Angle gamma_F;
algorithm
  gamma_F:=pi-til;

  annotation (Documentation(info="<html>
This function converts the inclination of a surface from the
 <a href=\"AixLib\">AixLib</a> definition to the definition of the VDI 6007
 part 3.
</html>",
        revisions="<html>
<ul>
<li>June 07, 2016,&nbsp; by Stanley Risch:<br>Implemented. </li>
<ul>
</html>"));
end to_surfaceTiltVDI;
