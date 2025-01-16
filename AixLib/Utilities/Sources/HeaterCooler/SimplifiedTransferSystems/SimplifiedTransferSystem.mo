within AixLib.Utilities.Sources.HeaterCooler.SimplifiedTransferSystems;
record SimplifiedTransferSystem
  extends Modelica.Icons.Record;
   // TODO Jonatan: fill out values here
  parameter Real k_Rad(unit="1")=1 "Gain for radiator";
  parameter Real k_UfhGroFlo(unit="1")=0.9 "Gain for underfloorheating of ground floor";
  parameter Real k_UfhFlo(unit="1")=0.9 "Gain for underfloorheating of inner floor";
  parameter Real k_Cca(unit="1")=0.94 "Gain for concrete core activation";
  parameter Modelica.Units.SI.Time T_Rad(start=1)=1 "Time Constant for radiator";
  parameter Modelica.Units.SI.Time T_UfhGroFlo(start=1)=3600 "Time Constant for underfloorheating of ground floor";
  parameter Modelica.Units.SI.Time T_UfhFlo(start=1)=3600 "Time Constant for underfloorheating of inner floor";
  parameter Modelica.Units.SI.Time T_Cca(start=1)=14400  "Time Constant for concrete core activation";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimplifiedTransferSystem;
