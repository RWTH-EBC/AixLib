within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model ALT_GasolineEngineCombustion
  replaceable package Medium_Gasoline = ALT_NaturalGasMixtureTypeAachen
                                                                constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                annotation(choicesAllMatching=true);
  replaceable package Medium_Air =
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir   constrainedby
    DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                         annotation(choicesAllMatching=true);

  parameter Modelica.SIunits.Volume V_Eng = 0.002237 "Engine displacement";
  parameter Modelica.SIunits.Volume V_Cyl = V_Eng/z "Cylinder displacement";
  parameter Modelica.SIunits.Length h_Stroke=0.086    "Stroke";
  parameter Modelica.SIunits.Length d_Cyl=0.091    "Cylinder diameter";
  type RotationSpeed=Real(final unit="1/s", min=0);
  parameter RotationSpeed n = 25.583 "Engine speed at full load";
  parameter Real Lambda = 1.3125 "Combustion air ratio";
  parameter Real z = 4 "Number of cylinders";
  parameter Real eps = 10.5 "Compression ratio";
  parameter Modelica.SIunits.Mass m_EngineBlock = 122 "Total dry weight of the engine block";
  parameter Modelica.SIunits.Pressure p_me=540000   "Mean effective cylinder pressure";
  parameter Modelica.SIunits.Efficiency etaMech = 0.324 "Mechanical efficiency of the engine";
  parameter Modelica.SIunits.Power P_Fuel = 49000 "Maximum fuel expenses";
  parameter Modelica.SIunits.Power Q_MaxHeat = 30400 "Maximum of usable heat";
  parameter Modelica.SIunits.Temperature T_Amb=298.15   "Ambient temperature (matches to fuel and combustion air temperature)";
  parameter Modelica.SIunits.Temperature T_ExhaustPowUnitOut=383.15   "Exhaust gas temperature after exhaust heat exchanger";
  parameter Real i = 0.5 "Number of combustion for one operating cycle (1->two-stroke, 0.5->four-stroke)";
  type GasConstant=Real(final unit="J/(mol.K)");
  constant GasConstant R = 8.31446 "Gasconstante for calculation purposes";
  constant Modelica.SIunits.Pressure p_Amb = 101325 "Ambient pressure";
  constant Modelica.SIunits.SpecificEnergy H_U = Medium_Gasoline.H_U "Specific calorific value of the fuel";
  constant Real L_st = Medium_Gasoline.L_st "Stoichiometric air consumption of the fuel";
  constant Real l_min = L_st*MM_Gas/MM_Air "Minimum of air consumption";
  constant Modelica.SIunits.MolarMass MM_Gas = Medium_Gasoline.MM "Molar mass of the fuel";
  constant Modelica.SIunits.MolarMass MM_Air = Medium_Air.MM "Molar mass of the combustion air";
  constant Modelica.SIunits.MolarMass MM_Components_Gas[:] = Medium_Gasoline.data[:].MM "Molar masses of the fuel components";
  constant Modelica.SIunits.MolarMass MM_Components_Air[:] = Medium_Air.data[:].MM "Molar masses of the cumbustion air components";
  constant Modelica.SIunits.MolarMass MM_Components_Exhaust[:] = {0.02802, 0.04401, 0.018, 0.032} "Molar masses of the combustion products: N2, CO2, H2O, O2";
  constant Real expFac_cp_ComponentsExhaust[:] = {0.11, 0.30, 0.20, 0.15} "Exponential factor for calculating the specific heat capacity";
  constant Modelica.SIunits.SpecificHeatCapacity cp_RefComponentsExhaust[:] = {1000, 840, 1750, 900} "Specific heat capacities of the combustion products at reference state at 0°C";
  constant Modelica.SIunits.Temperature RefT_Combustion = 1473.15 "Reference combustion temperature for calculation purposes";

  // Exhaust composition
  Real n_N2Exhaust = Medium_Gasoline.moleFractions_Gas[1] + Lambda*l_min*Medium_Air.moleFractions_Air[1] "Exhaust: Nitrogen per mole of fuel";
  Real n_CO2Exhaust = sum(Medium_Gasoline.moleFractions_Gas[i]*Medium_Gasoline.nue_C[i] for i in 1:size(Medium_Gasoline.nue_C, 1)) "Exhaust: CO2 per mole of fuel";
  Real n_H2OExhaust = 0.5*sum(Medium_Gasoline.moleFractions_Gas[i]*Medium_Gasoline.nue_H[i] for i in 1:size(Medium_Gasoline.nue_H, 1)) "Exhaust: H20 per mole of fuel";
  Real n_O2Exhaust = (Lambda-1)*l_min*Medium_Air.moleFractions_Air[2] "Exhaust: Oxygen per mole of fuel";
  Real n_ComponentsExhaust[:] = {n_N2Exhaust, n_CO2Exhaust, n_H2OExhaust, n_O2Exhaust};
  Modelica.SIunits.MolarMass MM_Exhaust = sum(n_ComponentsExhaust[i]*MM_Components_Exhaust[i] for i in 1:size(n_ComponentsExhaust, 1))/sum(n_ComponentsExhaust[i] for i in 1:size(n_ComponentsExhaust, 1))
  "Molar mass of the exhaust gas";
  Modelica.SIunits.MassFraction X_Exhaust[size(n_ComponentsExhaust, 1)] "Mass fractions of the exhaust gas components";

  Modelica.SIunits.MassFlowRate m_Exh "Mass flow rate of exhaust gas";
  Modelica.SIunits.MassFlowRate m_Fuel "Mass flow rate of fuel";
  Modelica.SIunits.MassFlowRate m_Air "Mass flow rate of combustion air";
  Modelica.SIunits.SpecificHeatCapacity meanCp_ComponentsExhaust[size(n_ComponentsExhaust, 1)] "Calculated specific heat capacities of the exhaust gas components for the calculated combustion temperature";
  Modelica.SIunits.SpecificHeatCapacity meanCp_Exhaust "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature";
  Modelica.SIunits.Power P_e "Effective engine power";
  Modelica.SIunits.SpecificEnergy h_Exhaust = 1000*(-286 + 1.011*T_ExhaustPowUnitOut - 27.29*Lambda + 0.000136*T_ExhaustPowUnitOut^2 - 0.0255*T_ExhaustPowUnitOut*Lambda + 6.425*Lambda^2) "Specific enthalpy of the exhaust gas";
  Modelica.SIunits.Power H_Exhaust "Enthalpy stream of the exhaust gas";
  Modelica.SIunits.Power Q_therm "Total heat from engine combustion";
  Modelica.SIunits.Temperature T_Combustion(start=RefT_Combustion) "Temperature of the combustion gases";

  Modelica.Blocks.Sources.RealExpression CalculatedCombustionHeat(y=Q_therm)
    annotation (Placement(transformation(extent={{-10,-10},{18,18}})));
  Modelica.Blocks.Sources.RealExpression CalculatedCombustionTemperature(y=
        T_Combustion)
    annotation (Placement(transformation(extent={{-10,12},{18,40}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=2, k={1,-1})
    annotation (Placement(transformation(extent={{54,-46},{38,-30}})));
  Modelica.Blocks.Interfaces.RealInput EngineHeatToAmbientAndCoolingCircle
    "Calculated heat to cooling circle and ambient of chp-PowerUnit"
    annotation (Placement(transformation(extent={{12,-106},{-22,-72}}),
        iconTransformation(
        extent={{17,-17},{-17,17}},
        rotation=90,
        origin={-3,-95})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ExhaustHeatFlow
    annotation (Placement(transformation(extent={{10,-48},{-10,-28}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_EngineExhaustGasOut
    annotation (Placement(transformation(extent={{-128,-62},{-80,-14}}),
        iconTransformation(extent={{-114,-62},{-78,-26}})));
    //initial equation

//  X_Gas = Medium_Gasoline.X_i;
//  X_Air = Medium_Air.X_i;
//  stateGas = Medium_Gasoline.setState_pTX(p_Amb, T_Amb, X_Gas);
//  stateAir = Medium_Air.setState_pTX(p_Amb, T_Amb, X_Air);

equation

//  n_ComponentsExhaust[:] = {n_N2Exhaust, n_CO2Exhaust, n_H2OExhaust, n_O2Exhaust};
//  n_N2Exhaust = Medium_Gasoline.moleFractions_Gas[1] + Lambda*l_min*Medium_Air.moleFractions_Air[1];
//  n_CO2Exhaust = sum(Medium_Gasoline.moleFractions_Gas[i]*Medium_Gasoline.nue_C[i] for i in 1:size(Medium_Gasoline.nue_C, 1));
//  n_H2OExhaust = 0.5*sum(Medium_Gasoline.moleFractions_Gas[i]*Medium_Gasoline.nue_H[i] for i in 1:size(Medium_Gasoline.nue_H, 1));
//  n_O2Exhaust = (Lambda-1)*l_min*Medium_Air.moleFractions_Air[2];
//  MM_Exhaust = sum(n_ComponentsExhaust[i]*MM_Components_Exhaust[i] for i in 1:size(n_ComponentsExhaust, 1))/sum(n_ComponentsExhaust[i] for i in 1:size(n_ComponentsExhaust, 1));
  for i in 1:size(n_ComponentsExhaust, 1) loop
  X_Exhaust[i] = MM_Components_Exhaust[i]*n_ComponentsExhaust[i]/(MM_Exhaust*sum(n_ComponentsExhaust[j] for j in 1:size(n_ComponentsExhaust, 1)));
  end for;
  for i in 1:size(n_ComponentsExhaust, 1) loop
  meanCp_ComponentsExhaust[i] = cp_RefComponentsExhaust[i]/(expFac_cp_ComponentsExhaust[i] + 1)/(T_Combustion/273.15 - 1)*(-1 + (T_Combustion/273.15)^(expFac_cp_ComponentsExhaust[i] + 1));
  end for;
  meanCp_Exhaust = sum(meanCp_ComponentsExhaust[i]*X_Exhaust[i] for i in 1:size(n_ComponentsExhaust, 1));
  m_Fuel = P_Fuel/H_U;
  m_Air = m_Fuel*Lambda*L_st;
  m_Exh = m_Fuel + m_Air;
  H_Exhaust = h_Exhaust*m_Exh;
  P_e = i*n*p_me*V_Eng;
  Q_therm = m_Fuel*H_U - P_e - H_Exhaust;
  T_Combustion = (m_Fuel*H_U - P_e)/(m_Fuel*(1 + Lambda*L_st)*meanCp_Exhaust) + T_Amb;
 // stateGas.p = p_Amb;
 // stateGas.T = T_Amb;
 // stateGas.X[:] = Medium_Gasoline.reference_X;
 // stateAir.p = p_Amb;
 // stateAir.T = T_Amb;
 // stateAir.X[:] = Medium_Air.reference_X;

  connect(multiSum.u[1], EngineHeatToAmbientAndCoolingCircle) annotation (Line(
        points={{54,-35.2},{55,-35.2},{55,-89},{-5,-89}},  color={0,0,127}));
  connect(multiSum.y, ExhaustHeatFlow.Q_flow)
    annotation (Line(points={{36.64,-38},{10,-38}}, color={0,0,127}));
  connect(ExhaustHeatFlow.port, port_EngineExhaustGasOut)
    annotation (Line(points={{-10,-38},{-104,-38}}, color={191,0,0}));
  connect(CalculatedCombustionHeat.y, multiSum.u[2]) annotation (Line(points={{19.4,4},
          {64,4},{64,-38},{54,-38},{54,-40.8}},                      color={0,0,
          127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-88,90},{88,-92}}, fileName="")}),     Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ALT_GasolineEngineCombustion;
