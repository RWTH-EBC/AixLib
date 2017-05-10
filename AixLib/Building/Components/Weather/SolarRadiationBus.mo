within AixLib.Building.Components.Weather;
expandable connector SolarRadiationBus
  extends Modelica.Icons.SignalBus;
  Modelica.SIunits.Irradiance BeamRadHor "beam irradiance on the horizontal surface";
  Modelica.SIunits.Irradiance DiffRadHor "diffuse irradiance on the horizontal surface";
  Modelica.SIunits.Irradiance BeamRad "beam incident irradiance on a plane normal to the direction of incidence";
  Modelica.SIunits.Irradiance GlobalRadHor "global irradiance on the horizontal surface";
  Modelica.SIunits.Angle DayAngleSun;
  Modelica.SIunits.Angle HourAngleSun;
  Modelica.SIunits.Angle DeclinationSun;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}));
end SolarRadiationBus;
