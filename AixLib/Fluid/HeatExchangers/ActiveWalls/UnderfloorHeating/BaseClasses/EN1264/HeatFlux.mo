within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.EN1264;
model HeatFlux "Upward and downward heat flux of an underfloor heating circuit according to EN 1264-2"
  extends
    UnderfloorHeating.BaseClasses.EN1264.TablesAndParameters.qG_TypeA;
  import Modelica.Constants.pi;

  parameter Modelica.SIunits.Temperature T_U "Temperature of room / ground under panel heating";

  final parameter Modelica.SIunits.ThermalInsulance R_U = if Ceiling then R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster + R_alphaCeiling  else R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster "Thermal resistance of wall layers under panel heating";
  final parameter Modelica.SIunits.ThermalInsulance R_O = 1 / alpha_Floor + R_lambdaB + s_u / lambda_E "Thermal resistance of wall layers above panel heating";

  final parameter Modelica.SIunits.HeatFlux q_max = K_H * dT_H;
  final parameter Modelica.SIunits.HeatFlux q_U = 1 / R_U * (R_O * q_max + T_Room - T_U);
  final parameter Modelica.SIunits.ThermalResistance R_pipe = if withSheathing then (log(D/d_a))/(2*lambda_M*pi) + (log(d_a/(d_a-2*s_R)))/(2*lambda_R*pi) else (log(d_a/(d_a-2*s_R)))/(2*lambda_R*pi) "thermal resistance through pipe layers";

initial equation
if Ceiling then
    assert(wallTypeFloor.n == 2 and wallTypeCeiling.n == 3, "EN 1264 calculates parameters only for panel heating type A (2 floor layers, 3 ceiling layers). Error accuring in"
       + getInstanceName());
  else
    assert(wallTypeFloor.n == 2 and wallTypeCeiling.n == 4, "EN 1264 calculates parameters only for panel heating type A (2 floor layers, 4 ground plate layers). Error accuring in"
       + getInstanceName());
  end if;

  if T_U >= 18 + 273.15 then
    assert(R_lambdaIns >= 0.75, "Thermal resistivity of insulation layer needs to be greater than 0.75 m²K / W (see EN 1264-4 table 1)");
  else
    assert(R_lambdaIns >= 1.25, "Thermal resistivity of insulation layer needs to be greater than 1.25 m²K / W (see EN 1264-4 table 1)");
  end if;

end HeatFlux;
