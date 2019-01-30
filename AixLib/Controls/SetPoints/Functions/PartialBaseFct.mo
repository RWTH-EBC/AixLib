within AixLib.Controls.SetPoints.Functions;
partial function PartialBaseFct "Base function of a heating curve"
  extends Modelica.Icons.Function;

  input Modelica.SIunits.ThermodynamicTemperature T_oda;
  input Modelica.SIunits.ThermodynamicTemperature TRoom;
  input Boolean isDay;
  output Modelica.SIunits.ThermodynamicTemperature TSet;

end PartialBaseFct;
