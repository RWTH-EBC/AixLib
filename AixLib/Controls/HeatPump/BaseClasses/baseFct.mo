within AixLib.Controls.HeatPump.BaseClasses;
partial function baseFct "Base function of a heating curve"
  extends Modelica.Icons.Function;

  input Modelica.SIunits.ThermodynamicTemperature T_oda;
  input Modelica.SIunits.ThermodynamicTemperature TRoom;
  input Boolean isDay;
  output Modelica.SIunits.ThermodynamicTemperature TSet;


end baseFct;
