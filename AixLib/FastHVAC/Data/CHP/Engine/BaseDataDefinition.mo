within AixLib.FastHVAC.Data.CHP.Engine;
record BaseDataDefinition "Basic Mikro_KWK Data"
extends Modelica.Icons.Record;

  import SI = Modelica.SIunits;
  import SIconv = Modelica.SIunits.Conversions.NonSIunits;
  Modelica.SIunits.MassFlowRate dotm_max "maximum mass flow rate";
  Modelica.SIunits.MassFlowRate dotm_min "minimum mass flow rate";
  parameter SI.Power P_elRated "rated electrical power (unit=W)";
  parameter Modelica.SIunits.Time tauQ_th_start
  "time constant for thermal start behavior (unit=sec) ";
  parameter Modelica.SIunits.Time tauQ_th_stop
  "time constant for stop behaviour (unit=sec)";
  parameter Modelica.SIunits.Time tauP_el
  "time constant electrical power start behavior (unit=sec)";
  parameter SI.Power dotQ_thRated "rated thermal power (unit=W)";
  parameter SI.Power dotE_fuelRated "rated fuel power (unit=W)";
  parameter Modelica.SIunits.Power P_elStandby
    "electrical consumption in standby mode";
  parameter Modelica.SIunits.Power P_elStop
    "electrical consumption during shutdown mode";
  parameter Modelica.SIunits.Power P_elStart
    "electrical consumption during startup";
  parameter Real a_0;
  parameter Real a_1;
  parameter Real a_2;
  parameter Real a_3;
  parameter Real a_4;
  parameter Real a_5;
  parameter Real a_6;
  parameter Real b_0;
  parameter Real b_1;
  parameter Real b_2;
  parameter Real b_3;
  parameter Real b_4;
  parameter Real b_5;
  parameter Real b_6;

end BaseDataDefinition;
