within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model CHPGasolineEngine
  import AixLib;
  replaceable package Medium1 =
      DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeH
                                                                constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                annotation(choicesAllMatching=true);
  replaceable package Medium2 =
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                            constrainedby
    DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                         annotation(choicesAllMatching=true);

  replaceable package Medium3 =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus      constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                 annotation(choicesAllMatching=true);

  parameter
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHPEngDataBaseRecord_MaterialData
    CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "Needed engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  parameter Modelica.SIunits.Volume VCyl = CHPEngData.VEng/CHPEngData.z "Cylinder displacement";
  type RotationSpeed=Real(final unit="1/s", min=0);
  parameter RotationSpeed nEng(max=CHPEngData.nEngMax) = 25.583 "Engine speed at full load";
  parameter Modelica.SIunits.Power P_Fue(max=CHPEngData.P_FueNominal) = 49000
    "Maximum fuel expenses";
  parameter Modelica.SIunits.Temperature T_Amb=298.15   "Ambient temperature (matches to fuel and combustion air temperature)";
  type GasConstant=Real(final unit="J/(mol.K)");
  constant GasConstant R = 8.31446 "Gasconstante for calculation purposes";
  constant Modelica.SIunits.MassFlowRate m_MaxExh=CHPEngData.P_FueNominal/H_U*(
      1 + Lambda*L_St)
    "Maximal exhaust gas flow based on the fuel and combustion properties";
  constant Modelica.SIunits.Pressure p_Amb = 101325 "Ambient pressure";
  constant Modelica.SIunits.SpecificEnergy H_U = Medium1.H_U "Specific calorific value of the fuel";
  constant Real Lambda=0.21/(0.21-CHPEngData.xO2Exh) "Combustion air ratio from the residual oxygen content in the exhaust gas";
  constant Real L_St = Medium1.L_st "Stoichiometric air consumption of the fuel";
  constant Real l_Min = L_St*MM_Gas/MM_Air "Minimum of air consumption";
  constant Modelica.SIunits.MolarMass MM_Gas = Medium1.MM "Molar mass of the fuel";
  constant Modelica.SIunits.MolarMass MM_Air = Medium2.MM "Molar mass of the combustion air";
  //constant Modelica.SIunits.MolarMass MM_Components_Gas[:] = Medium1.data[:].MM "Molar masses of the fuel components";
  //constant Modelica.SIunits.MolarMass MM_Components_Air[:] = Medium2.data[:].MM "Molar masses of the cumbustion air components";
  constant Modelica.SIunits.MolarMass MM_ComExh[:] = Medium3.data[:].MM "Molar masses of the combustion products: N2, O2, H2O, CO2";
  constant Real expFacCpComExh[:] = {0.11, 0.15, 0.20, 0.30} "Exponential factor for calculating the specific heat capacity of N2, O2, H2O, CO2";
  constant Modelica.SIunits.SpecificHeatCapacity cpRefComExh[:] = {1000, 900, 1750, 840} "Specific heat capacities of the combustion products at reference state at 0°C";
  constant Modelica.SIunits.Temperature RefT_Com = 1473.15 "Reference combustion temperature for calculation purposes";

  // Exhaust composition
  constant Real n_N2Exh = Medium1.moleFractions_Gas[1] + Lambda*l_Min*Medium2.moleFractions_Air[1] "Exhaust: Number of molecules Nitrogen per mole of fuel";
  constant Real n_O2Exh = (Lambda-1)*l_Min*Medium2.moleFractions_Air[2] "Exhaust: Number of molecules Oxygen per mole of fuel";
  constant Real n_H2OExh = 0.5*sum(Medium1.moleFractions_Gas[i]*Medium1.NatGasTyp.nue_H[i] for i in 1:size(Medium1.NatGasTyp.nue_H, 1)) "Exhaust: Number of molecules H20 per mole of fuel";
  constant Real n_CO2Exh = sum(Medium1.moleFractions_Gas[i]*Medium1.NatGasTyp.nue_C[i] for i in 1:size(Medium1.NatGasTyp.nue_C, 1)) "Exhaust: Number of molecules CO2 per mole of fuel";
  constant Real n_ComExh[:] = {n_N2Exh, n_O2Exh, n_H2OExh, n_CO2Exh};
  constant Modelica.SIunits.MolarMass MM_Exh = sum(n_ComExh[i]*MM_ComExh[i] for i in 1:size(n_ComExh, 1))/sum(n_ComExh[i] for i in 1:size(n_ComExh, 1))
  "Molar mass of the exhaust gas";
  constant Modelica.SIunits.MassFraction X_N2Exh =  MM_ComExh[1]*n_ComExh[1]/(MM_Exh*sum(n_ComExh[j] for j in 1:size(n_ComExh, 1)))  "Mass fraction of N2 in the exhaust gas";
  constant Modelica.SIunits.MassFraction X_O2Exh =  MM_ComExh[2]*n_ComExh[2]/(MM_Exh*sum(n_ComExh[j] for j in 1:size(n_ComExh, 1)))  "Mass fraction of O2 in the exhaust gas";
  constant Modelica.SIunits.MassFraction X_H2OExh =  MM_ComExh[3]*n_ComExh[3]/(MM_Exh*sum(n_ComExh[j] for j in 1:size(n_ComExh, 1)))  "Mass fraction of H2O in the exhaust gas";
  constant Modelica.SIunits.MassFraction X_CO2Exh =  MM_ComExh[4]*n_ComExh[4]/(MM_Exh*sum(n_ComExh[j] for j in 1:size(n_ComExh, 1)))  "Mass fraction of CO2 in the exhaust gas";
  constant Modelica.SIunits.MassFraction Xi_Exh[size(n_ComExh, 1)] = {X_N2Exh, X_O2Exh, X_H2OExh, X_CO2Exh};
  Modelica.SIunits.MassFlowRate m_Exh "Mass flow rate of exhaust gas";
  Modelica.SIunits.MassFlowRate m_CO2Exh "Mass flow rate of CO2 in the exhaust gas";
  Modelica.SIunits.MassFlowRate m_Fue(min=0) "Mass flow rate of fuel";
  Modelica.SIunits.MassFlowRate m_Air(min=0.001) "Mass flow rate of combustion air";
  Modelica.SIunits.SpecificHeatCapacity meanCpComExh[size(n_ComExh, 1)] "Calculated specific heat capacities of the exhaust gas components for the calculated combustion temperature";
  Modelica.SIunits.SpecificHeatCapacity meanCpExh "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature";
  Modelica.SIunits.Power P_eff "Effective engine power";
  Modelica.SIunits.SpecificEnergy h_Exh = 1000*(-286 + 1.011*CHPEngData.T_ExhPowUniOut - 27.29*Lambda + 0.000136*CHPEngData.T_ExhPowUniOut^2 - 0.0255*CHPEngData.T_ExhPowUniOut*Lambda + 6.425*Lambda^2) "Specific enthalpy of the exhaust gas";
  Modelica.SIunits.Power H_Exh "Enthalpy stream of the exhaust gas";
  Modelica.SIunits.Power Q_therm "Total heat from engine combustion";
  Modelica.SIunits.Temperature T_Com(start=RefT_Com) "Temperature of the combustion gases";

    //initial equation

//  X_Gas = Medium1.X_i;
//  X_Air = Medium2.X_i;
//  stateGas = Medium1.setState_pTX(p_Amb, T_Amb, X_Gas);
//  stateAir = Medium2.setState_pTX(p_Amb, T_Amb, X_Air);

  Modelica.Fluid.Interfaces.FluidPort_a port_Gasoline(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-110,68},{-90,88}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_Air(redeclare package Medium =
        Medium2)
    annotation (Placement(transformation(extent={{-110,38},{-90,58}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exhaust(redeclare package Medium =
        Medium3)
    annotation (Placement(transformation(extent={{108,62},{88,82}})));
  Modelica.Fluid.Sources.FixedBoundary boundaryGasoline(
    nPorts=1,
    redeclare package Medium = Medium1,
    p=p_Amb,
    T=T_Amb) annotation (Placement(transformation(extent={{-46,68},{-66,88}})));
  Modelica.Fluid.Sources.FixedBoundary boundaryAir(
    nPorts=1,
    redeclare package Medium = Medium2,
    p=p_Amb,
    T=T_Amb) annotation (Placement(transformation(extent={{-46,38},{-66,58}})));
  Modelica.Fluid.Sources.MassFlowSource_T exhaustFlow(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium3,
    X=Xi_Exh,
    use_X_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{50,62},{70,82}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=m_Exh)
    annotation (Placement(transformation(extent={{14,76},{34,96}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_Com)
    annotation (Placement(transformation(extent={{14,62},{34,82}})));
  Modelica.Blocks.Sources.RealExpression calculatedCombustionHeat(y=Q_therm)
    annotation (Placement(transformation(extent={{-14,-36},{14,-8}})));
  Modelica.Blocks.Sources.RealExpression calculatedCombustionTemperature(y=
        T_Com)
    annotation (Placement(transformation(extent={{-14,-14},{14,14}})));
  Modelica.Blocks.Sources.RealExpression effectiveMechanicalPower(y=P_eff)
    annotation (Placement(transformation(extent={{-14,8},{14,36}})));
  Modelica.Blocks.Interfaces.RealOutput mechanicalPower annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={0,112}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={0,112})));
equation

//  n_ComExh[:] = {n_N2Exh, n_CO2Exhaust, n_H2OExhaust, n_O2Exhaust};
//  n_N2Exh = Medium1.moleFractions_Gas[1] + Lambda*l_Min*Medium2.moleFractions_Air[1];
//  n_CO2Exhaust = sum(Medium1.moleFractions_Gas[i]*Medium1.nue_C[i] for i in 1:size(Medium1.nue_C, 1));
//  n_H2OExhaust = 0.5*sum(Medium1.moleFractions_Gas[i]*Medium1.nue_H[i] for i in 1:size(Medium1.nue_H, 1));
//  n_O2Exhaust = (Lambda-1)*l_Min*Medium2.moleFractions_Air[2];
//  MM_Exh = sum(n_ComExh[i]*MM_ComExh[i] for i in 1:size(n_ComExh, 1))/sum(n_ComExh[i] for i in 1:size(n_ComExh, 1));
 // for i in 1:size(n_ComExh, 1) loop
  //Xi_Exh[i] = MM_ComExh[i]*n_ComExh[i]/(MM_Exh*sum(n_ComExh[j] for j in 1:size(n_ComExh, 1)));
 // end for;
  for i in 1:size(n_ComExh, 1) loop
  meanCpComExh[i] = cpRefComExh[i]/(expFacCpComExh[i] + 1)/(T_Com/273.15 - 1)*(-1 + (T_Com/273.15)^(expFacCpComExh[i] + 1));
  end for;
  meanCpExh = sum(meanCpComExh[i]*Xi_Exh[i] for i in 1:size(n_ComExh, 1));
  m_Fue = P_Fue/H_U;
  m_Air = m_Fue*Lambda*L_St;
  m_Exh = m_Fue + m_Air;
  m_CO2Exh = m_Exh*X_CO2Exh;
  H_Exh = h_Exh*m_Exh;
  P_eff = CHPEngData.i*nEng*CHPEngData.p_me*CHPEngData.VEng;
  Q_therm = m_Fue*H_U - P_eff - H_Exh;
  if m_Fue>0 then
  T_Com = (m_Fue*H_U - P_eff)/(m_Fue*(1 + Lambda*L_St)*meanCpExh) + T_Amb;
  else
  T_Com = T_Amb;
  end if;

  connect(port_Air, boundaryAir.ports[1])
    annotation (Line(points={{-100,48},{-66,48}}, color={0,127,255}));
  connect(port_Gasoline, boundaryGasoline.ports[1])
    annotation (Line(points={{-100,78},{-66,78}}, color={0,127,255}));
  connect(exhaustFlow.m_flow_in, realExpression.y)
    annotation (Line(points={{50,80},{42,80},{42,86},{35,86}},
                                               color={0,0,127}));
  connect(exhaustFlow.T_in, realExpression1.y) annotation (Line(points={{48,76},
          {42,76},{42,72},{35,72}}, color={0,0,127}));
  connect(exhaustFlow.ports[1], port_Exhaust)
    annotation (Line(points={{70,72},{98,72}}, color={0,127,255}));
  connect(effectiveMechanicalPower.y,mechanicalPower)  annotation (Line(
        points={{15.4,22},{26,22},{26,46},{0,46},{0,112}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-120,-134},{122,134}}, fileName="modelica://ModularCHP/../Nützliches/Modelica Icons_Screenshots/Icon_ICE.png"),
        Text(
          extent={{-100,98},{100,82}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CHPGasolineEngine;
