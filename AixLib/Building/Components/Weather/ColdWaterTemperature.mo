within AixLib.Building.Components.Weather;
model ColdWaterTemperature
  import Modelica.SIunits.Conversions.*;

  /*Datas are average from 2010 to 2017 in Germany*/
  /*Correlation based on "Development of an energy savings benchmark for all residential end-uses"*/

  parameter   Real deltaT_max_avg = 17.0 "max difference between max and minimum monthly ambient temperature";
  parameter   Real T_avg = 9.5 "average ambient temperature by year";
  Real ratio "in Celsius";
  Real lag "in Celsius";
  Real day;

  Modelica.Blocks.Interfaces.RealOutput coldWaterTemperature "Coldwater Temperature"
    annotation (Placement(transformation(extent={{90,-16},{124,18}})));



equation
  day = time/86400;
  ratio = 0.4 +0.018 * (T_avg-6.667);
  lag = 35 - 1.8 * (T_avg-6.667);
  coldWaterTemperature=  from_degC(max(T_avg+ 10/3 + ratio * deltaT_max_avg/2 * sin(Modelica.Constants.pi/180*(360/365*(day-15-lag)-90)),0));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ColdWaterTemperature;
