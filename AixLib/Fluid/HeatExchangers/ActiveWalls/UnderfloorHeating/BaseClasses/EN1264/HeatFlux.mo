within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.EN1264;
model HeatFlux "Upward and downward heat flux of an underfloor heating circuit according to EN 1264-2"
  extends UnderfloorHeating.BaseClasses.EN1264.TablesAndParameters.qG_TypeA(
    dT_H=Q_flow_nominal/A/K_H);
  parameter Modelica.Units.SI.Diameter dInn
    "Inner diameter of pipe";
  parameter Modelica.Units.SI.Temperature T_U=293.15
    "Nominal Room Temperature lying under panel heating"
    annotation (Dialog(group="Room Specifications"));
  parameter Modelica.Units.SI.Power Q_flow_nominal
    "Nominal heat load for room with panel heating"
    annotation (Dialog(group="Room Specifications"));
  parameter Modelica.Units.SI.Temperature TSup_nominal
    "Nominal supply temperature";
  parameter Modelica.Units.SI.Temperature TRet_nominal
    "Nominal return temperature";
  final parameter Modelica.Units.SI.TemperatureDifference dT_HU=
      UnderfloorHeating.BaseClasses.logDT({TSup_nominal,TRet_nominal,T_U});
  parameter Modelica.Units.SI.Length length
    "Possible pipe length for given panel heating area";
  parameter Modelica.Units.SI.Area A "Surface area";
  final parameter Modelica.Units.SI.ThermalInsulance R_U=if isCeiling then
      R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster + R_alphaCeiling else
      R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster
    "Thermal resistance of wall layers under panel heating";
  final parameter Modelica.Units.SI.ThermalInsulance R_O = 1 / alpha_Floor +
  R_lambdaB + s_u / lambda_E
  "Thermal resistance of wall layers above panel heating";

  final parameter Modelica.Units.SI.ThermalResistance R_add=1/(K_H*(1 + R_O/R_U*
      dT_H/dT_HU)*A + A*(T_Room - T_U)/(R_U*dT_HU)) - 1/(A/R_O + A/R_U*
      dT_H/dT_HU) - R_pipe - 1/(2200*Modelica.Constants.pi*dInn*length)
    "additional thermal resistance";
  final parameter Modelica.Units.SI.ThermalResistance R_pipe=if withSheathing
       then (log(d_a + (D-d_a)/d_a))/(2*sheMat.lambda*Modelica.Constants.pi*
      length) + (log(d_a/dInn))/(2*pipMat.lambda*Modelica.Constants.pi*length)
  else (log(d_a/dInn))/(2*pipMat.lambda*Modelica.Constants.pi*length)
    "thermal resistance through pipe layers";

initial equation
  assert(q_Gmax >= K_H*dT_H and q_G >= K_H*dT_H, "Panel Heating Parameters evaluate to a limiting heat flux that exceeds the maximum limiting heat flux in"
     + getInstanceName());


  if isCeiling then
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
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatFlux;
