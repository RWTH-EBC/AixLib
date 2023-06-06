within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.EN1264;
model HeatFlux "Upward and downward heat flux of an underfloor heating circuit according to EN 1264-2"
  extends UnderfloorHeating.BaseClasses.EN1264.TablesAndParameters.qG_TypeA;

  parameter Boolean Ceiling "false if ground plate is under panel heating" annotation (choices(checkBox=true));
  parameter Modelica.Units.SI.ThermalInsulance R_lambdaIns "Thermal resistance of thermal insulation";
  parameter Modelica.Units.SI.ThermalInsulance R_lambdaCeiling "Thermal resistance of ceiling";
  parameter Modelica.Units.SI.ThermalInsulance R_lambdaPlaster "Thermal resistance of plaster";
  final parameter Modelica.Units.SI.ThermalInsulance R_alphaCeiling = if Ceiling then 1/alpha_Ceiling else 0 "Thermal resistance at the ceiling";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer alpha_Ceiling =  5.8824 "Coefficient of heat transfer at Ceiling Surface";
  final parameter Modelica.Units.SI.ThermalConductivity lambda_u = lambda_E "Thermal conductivity of wall layers above panel heating without flooring (coverage)";
  parameter Modelica.Units.SI.Temperature T_U "Temperature of room / ground under panel heating";

  final parameter Modelica.Units.SI.ThermalInsulance R_U = if Ceiling then R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster + R_alphaCeiling  else R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster "Thermal resistance of wall layers under panel heating";
  final parameter Modelica.Units.SI.ThermalInsulance R_O = 1 / alpha_Floor + R_lambdaB + s_u / lambda_u "Thermal resistance of wall layers above panel heating";

  final parameter Modelica.Units.SI.HeatFlux q_max = K_H * dT_H;
  final parameter Modelica.Units.SI.HeatFlux q_U = 1 / R_U * (R_O * q_max + T_Room - T_U);

initial equation

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatFlux;
