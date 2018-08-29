within AixLib.Controls.HeatPump.BaseClasses;
package Functions "Package with functions for pacakge AixLib.Controls.HeatPump"
  partial function baseFct "Base function of a heating curve"
    extends Modelica.Icons.Function;

    input Modelica.SIunits.ThermodynamicTemperature T_oda;
    input Modelica.SIunits.ThermodynamicTemperature TRoom;
    input Boolean isDay;
    output Modelica.SIunits.ThermodynamicTemperature TSet;

  end baseFct;

  function HeatingCurveFunction
    extends Functions.baseFct;

  algorithm
    TSet := T_oda;
  end HeatingCurveFunction;
end Functions;
