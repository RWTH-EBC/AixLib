within AixLib.Controls.SetPoints.Functions;
partial function PartialBaseFct "Base function of a heating curve"
  extends Modelica.Icons.Function;

  input Modelica.SIunits.ThermodynamicTemperature T_oda;
  input Modelica.SIunits.ThermodynamicTemperature TRoom;
  input Boolean isDay;
  output Modelica.SIunits.ThermodynamicTemperature TSet;

  annotation (Documentation(revisions="<html>
 <li><i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)</li>
</html>"));
end PartialBaseFct;
