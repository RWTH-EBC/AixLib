within AixLib.FastHVAC.Data.CHP.FuelcellPEM;
record BaseDataDefinition "Basic Mikro_KWK Data"
extends Modelica.Icons.Record;

  import SI = Modelica.SIunits;
  import SIconv = Modelica.SIunits.Conversions.NonSIunits;
  parameter SI.Power P_elRated "rated electrical power (AC) (unit=W)";
  parameter Real eta_0;
  parameter Real eta_1;
  parameter Real eta_2;
  parameter Real r_0;
  parameter Real r_1;
  parameter Real r_2;
  parameter Real alpha_0;
  parameter Real alpha_1;
  parameter Real T_0;
  parameter Real u_0;
  parameter Real u_1;
  parameter Real u_2;
  parameter Real anc_0;
  parameter Real anc_1;
  parameter Real a_0;
  parameter Real a_1;
  parameter Real a_2;
  parameter Real s_0;
  parameter Real s_1;
  parameter Real s_2;
  parameter Real beta_0;
  parameter Real beta_1;
  parameter Real T_1;
  parameter SI.Power FuelConsumptionStart "Fuel consumption during start";
  parameter SI.Power FuelConsumptionStop "Fuel consumption during stop";
  parameter SI.Power PelStartANC "AC power consumption during start";
  parameter SI.Power PelStopANC "AC power consumption during stop";
  parameter SI.Time tauQ "Time constant for thermal behaviour";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseDataDefinition;
