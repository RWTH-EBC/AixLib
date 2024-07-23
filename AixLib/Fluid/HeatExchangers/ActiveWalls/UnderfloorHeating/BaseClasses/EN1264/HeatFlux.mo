within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.EN1264;
model HeatFlux "Upward and downward heat flux of an underfloor heating circuit according to EN 1264-2"
  extends UnderfloorHeating.BaseClasses.EN1264.TablesAndParameters.qG_TypeA(
  final R_U = if Ceiling then R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster + R_alphaCeiling  else R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster,
  R_O = 1 / alpha_Floor + R_lambdaB + s_u / lambda_u);

  parameter Boolean Ceiling "false if ground plate is under panel heating" annotation (choices(checkBox=true));
  final parameter Modelica.Units.SI.ThermalInsulance R_alphaCeiling = if Ceiling then 1/alpha_Ceiling else 0 "Thermal resistance at the ceiling";
  final parameter Modelica.Units.SI.ThermalConductivity lambda_u = lambda_E "Thermal conductivity of wall layers above panel heating without flooring (coverage)";
  parameter Modelica.Units.SI.Temperature T_U "Temperature of room / ground under panel heating";


  final parameter Modelica.Units.SI.HeatFlux q_max = K_H * dT_H;
  final parameter Modelica.Units.SI.HeatFlux q_U = 1 / R_U * (R_O * q_max + T_Room - T_U);
  final parameter Modelica.Units.SI.TemperatureDifference dT_HU=
      UnderfloorHeating.BaseClasses.logDT({TSup_nominal,TRet_nominal,
      TZoneBel_nominal});
    final parameter Modelica.Units.SI.ThermalResistance R_add=1/(K_H*(1 + R_O/R_U*
      dT_H/dT_HU)*A + A*(TZone_nominal - T_U)/(R_U*dT_HU)) - 1/(A/R_O + A/R_U*
      dT_H/dT_HU) - R_pipe - 1/(2200*Modelica.Constants.pi*dInn*length)
    "additional thermal resistance";
  final parameter Modelica.Units.SI.ThermalResistance R_pipe=if withSheathing
       then (log(d_a + thicknessSheathing/d_a))/(2*sheathingMaterial.lambda*
      Modelica.Constants.pi*length) + (log(d_a/dInn))/(2*pipeMaterial.lambda*Modelica.Constants.pi*length)
       else (log(d_a/dInn))/(2*pipeMaterial.lambda*Modelica.Constants.pi*length)
    "thermal resistance through pipe layers";


initial equation

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatFlux;
