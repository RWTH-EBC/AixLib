within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.EN1264.TablesAndParameters;
model K_H_TypeA
 "Merge of all functions to calculate K_H for underfloor heating type A (EN 1264)"
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor "Wall type for floor" annotation (Dialog(group="Room Specifications", enable=not ROM), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling "Wall type for ceiling" annotation (Dialog(group="Room Specifications", enable=not ROM), choicesAllMatching=true);
  parameter AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Piping.PipeBaseDataDefinition PipeRecord  "Pipe layers"    annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);

  final parameter Boolean withSheathing = if PipeRecord.n == 2 then true else false "false if pipe has no Sheathing" annotation (choices(checkBox=true));
  final parameter Boolean Ceiling = if wallTypeCeiling.n == 3 then true else false  "false if ground plate is under panel heating"  annotation (Dialog(group="Room Specifications"), choices(checkBox=true));
  final parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Ceiling = 5.8824 "Coefficient of heat transfer at floor surface";
  final parameter Modelica.SIunits.ThermalInsulance R_alphaCeiling = if Ceiling then 1/alpha_Ceiling else 0 "Thermal resistance at the ceiling";
  final parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Floor = 10.8 "Coefficient of heat transfer at floor surface";
  final parameter Modelica.SIunits.Thickness s_u = wallTypeFloor.d[1] "thickness of floor screed";
  final parameter Modelica.SIunits.ThermalConductivity lambda_E = wallTypeFloor.lambda[1] "Thermal conductivity of floor screed";
  final parameter Modelica.SIunits.ThermalInsulance R_lambdaB0 = if wallTypeFloor.n == 2 then wallTypeFloor.d[2]/wallTypeFloor.lambda[2] else 0 "Thermal resistance of flooring";
  final parameter Modelica.SIunits.ThermalInsulance R_lambdaIns = wallTypeCeiling.d[1]/wallTypeCeiling.lambda[1] "Thermal resistance of thermal insulation";
  final parameter Modelica.SIunits.ThermalInsulance R_lambdaCeiling = if Ceiling then wallTypeCeiling.d[2]/wallTypeCeiling.lambda[2]
    else wallTypeCeiling.d[2]/wallTypeCeiling.lambda[2] + wallTypeCeiling.d[3]/wallTypeCeiling.lambda[3] + wallTypeCeiling.d[4]/wallTypeCeiling.lambda[4] "Thermal resistance of ceiling";
  final parameter Modelica.SIunits.ThermalInsulance R_lambdaPlaster = if Ceiling then wallTypeCeiling.d[3]/wallTypeCeiling.lambda[3] else 0 "Thermal resistance of plaster";
 final parameter Modelica.SIunits.ThermalConductivity lambda_R = PipeRecord.lambda[1] "Coefficient of heat transfer of pipe material";
 final parameter Modelica.SIunits.Diameter d_a = PipeRecord.d[1] "outer diameter of pipe";
 final parameter Modelica.SIunits.ThermalConductivity lambda_M = if withSheathing then PipeRecord.lambda[2] else 0  "Thermal Conductivity for Sheathing" annotation (Dialog(enable = withSheathing));
 final parameter Modelica.SIunits.Diameter D = if withSheathing then PipeRecord.d[2] else 0  "Outer diameter of pipe including Sheathing" annotation (Dialog(enable = withSheathing));
 final parameter Modelica.SIunits.Thickness s_R = PipeRecord.t[1] "thickness of pipe wall";

 parameter Modelica.SIunits.Distance T "Spacing between tubes";
 constant Modelica.SIunits.ThermalConductivity lambda_R0 = 0.35;
 constant Modelica.SIunits.Thickness s_R0 = 0.002;

 final parameter Modelica.SIunits.Diameter d_M = if withSheathing then D else 0;

 final parameter Modelica.SIunits.ThermalInsulance R_lambdaB = if R_lambdaB0 < 0.1 then 0.1 else R_lambdaB0 "Thermal resistance of flooring used for dimensioning";
 final parameter Modelica.SIunits.CoefficientOfHeatTransfer B =  if withSheathing == false then
 if lambda_R == 0.35 and s_R == 0.002 then
   6.7
 else
   if T <= 0.375 then
   (1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / (2 * lambda_R) * log(d_a / (d_a - 2 * s_R)) - 1 / (2 * lambda_R0) * log(d_a / (d_a - 2 * s_R0))))^(-1)
   else
    (1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * 0.375 * ( 1 / (2 * lambda_R) * log(d_a / (d_a - 2 * s_R)) - 1 / (2 * lambda_R0) * log(d_a / (d_a - 2 * s_R0))))^(-1)
   else
     if T <= 0.375 then
   (1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / (2 * lambda_M) * log(d_M / d_a) + 1 / (2 * lambda_R) * log(d_a / (d_a - 2 * s_R)) - 1 / (2 * lambda_R0) * log(d_M / (d_M - 2 * s_R0))))^(-1)
     else
       (1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / (2 * lambda_M) * log(d_M / d_a) + 1 / (2 * lambda_R) * log(d_a / (d_a - 2 * s_R)) - 1 / (2 * lambda_R0) * log(d_M / (d_M - 2 * s_R0))))^(-1)
 "system dependent coefficient" annotation (Dialog(enable = false));
 constant Modelica.SIunits.CoefficientOfHeatTransfer B_0 = 6.7 "system dependent coefficient for lambda_R0 = 0.35 W/(m.K) abd s_R0 = 0.002 m";

 constant Modelica.SIunits.ThermalConductivity lambda_u0 = 1;
 constant Modelica.SIunits.Diameter s_u0 = 0.045;
 final parameter Real a_B = (1 / alpha_Floor + s_u0 / lambda_u0) / (1 / alpha_Floor + s_u0 / lambda_E + R_lambdaB);
 final parameter Real a_T = determine_aT.y;
 final parameter Real a_u = determine_au.y;
 final parameter Real a_D = determine_aD.y;

 final parameter Real m_T = if T <= 0.375 then 1 - T / 0.075 else 1 - 0.375 / 0.075;
 final parameter Real m_u = 100 * (0.045 - s_u);
 final parameter Real m_D = 250 * (D - 0.02);

 final parameter Real product_ai = a_B * a_T^(m_T) * a_u^(m_u) * a_D^(m_D) "product of powers for parameters of floor heating";

 final parameter Modelica.SIunits.CoefficientOfHeatTransfer K_H = if s_u > s_uStar and s_u > 0.065 then
 1 / ( (1 / K_HStar) + ((s_u - s_uStar) / lambda_E))
 else
 if T > 0.375 then
 B * product_ai * 0.375 / T
 else
 B * product_ai;

protected
 final parameter Modelica.SIunits.Thickness s_uStar = if T > 0.2 then (0.5 * T) else 0.1;
 final parameter Modelica.SIunits.CoefficientOfHeatTransfer K_HStar = B * a_B * a_T^(m_T) * a_u^(100*(0.045-s_uStar)) * a_D^(m_D);

 import Modelica.Math.log;

  Tables.CombiTable2DParameter determine_au(
    table=[0.0,0,0.05,0.1,0.15; 0.05,1.069,1.056,1.043,1.037; 0.075,1.066,1.053,1.041,1.035; 0.1,1.063,1.05,1.039,1.0335;
        0.15,1.057,1.046,1.035,1.0305; 0.2,1.051,1.041,1.0315,1.0275; 0.225,1.048,1.038,1.0295,1.026; 0.3,1.0395,1.031,
        1.024,1.021; 0.375,1.03,1.0221,1.0181,1.015],
    u2=R_lambdaB,
    u1=if T <= 0.375 then T else 0.375)
                  "Table A.2 according to EN 1264-2 p. 29"
    annotation (Placement(transformation(extent={{-96,20},{-70,46}})));
  Tables.CombiTable2DParameter determine_aD(
    table=[0.0,0,0.05,0.1,0.15; 0.05,1.013,1.013,1.012,1.011; 0.075,1.021,1.019,1.016,1.014; 0.1,1.029,1.025,1.022,1.018;
        0.15,1.04,1.034,1.029,1.024; 0.2,1.046,1.04,1.035,1.03; 0.225,1.049,1.043,1.038,1.033; 0.3,1.053,1.049,1.044,1.039;
        0.375,1.056,1.051,1.046,1.042],
    u2=R_lambdaB,
    u1=if T <= 0.375 then T else 0.375)
                  "Table A.3 according to EN 1264-2 p. 30"
    annotation (Placement(transformation(extent={{-96,-20},{-70,6}})));
  Tables.CombiTable1DParameter determine_aT(table=[0,1.23; 0.05,1.188; 0.10,1.156; 0.15,1.134], u=R_lambdaB)
    "Table A.1 according to EN 1264-2 p. 29" annotation (Placement(transformation(extent={{-96,60},{-72,84}})));

initial equation
   assert(D >= 0.008 and D <= 0.03, "For dimensioning the outer diameter including Sheathing needs to be between 8 mm and 30 mm", AssertionLevel.warning);
   assert(s_u > 0.01, "For dimensioning the floor screed needs to be thicker than 10 mm", AssertionLevel.warning);

   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
       coordinateSystem(preserveAspectRatio=false)));
end K_H_TypeA;
