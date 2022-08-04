within AixLib.Obsolete.YearIndependent.FastHVAC.Data.CHP;
record BaseDataDefinition "Basic Mikro_KWK Data"
extends Modelica.Icons.Record;

  import      Modelica.Units.SI;
  import SIconv = Modelica.Units.NonSI;
  Modelica.Units.SI.MassFlowRate dotm_max "maximum mass flow rate";
  Modelica.Units.SI.MassFlowRate dotm_min "minimum mass flow rate";
  parameter SI.Power P_elRated "rated electrical power (unit=W)";
  parameter Modelica.Units.SI.Time tauQ_th
    "time constant thermal power start behavior (unit=sec) ";
  parameter Modelica.Units.SI.Time tauP_el
    "time constant electrical power start behavior (unit=sec)";

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
