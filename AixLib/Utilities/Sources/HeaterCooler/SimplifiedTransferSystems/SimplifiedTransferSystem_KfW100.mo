within AixLib.Utilities.Sources.HeaterCooler.SimplifiedTransferSystems;
record SimplifiedTransferSystem_KfW100
  extends Modelica.Icons.Record;
  parameter Real k_Rad(unit="1")=1 "Gain for radiator";
  parameter Real k_UfhGroFlo(unit="1")=0.9256 "Gain for underfloorheating of ground floor";
  parameter Real k_UfhFlo(unit="1")=0.9122 "Gain for underfloorheating of inner floor";
  parameter Real k_Cca(unit="1")=0.9353 "Gain for concrete core activation";
  parameter Modelica.Units.SI.Time T_Rad(start=1)=0.5 * 3600 "Time Constant for radiator";
  parameter Modelica.Units.SI.Time T_UfhGroFlo(start=1)=1.7512 * 3600 "Time Constant for underfloorheating of ground floor";
  parameter Modelica.Units.SI.Time T_UfhFlo(start=1)=1.9069 * 3600 "Time Constant for underfloorheating of inner floor";
  parameter Modelica.Units.SI.Time T_Cca(start=1)=5.8455 * 3600  "Time Constant for concrete core activation";
  parameter Real fraHeaRadRad=0.5608 "Fraction of heating to radiation for radiators";
  parameter Real fraCooRadRad=0.5 "Fraction of cooling to radiation for radiators";
  parameter Real fraHeaRadUfh=0.6379 "Fraction of heating to radiation for underfloorheating";
  parameter Real fraCooRadUfh=0.5 "Fraction of cooling to radiation for underfloorheating";
  parameter Real fraHeaRadCca=0.696 "Fraction of heating to radiation for concreate core activation";
  parameter Real fraCooRadCca=0.5 "Fraction of cooling to radiation for concreate core activation";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimplifiedTransferSystem_KfW100;
