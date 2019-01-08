within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model CHPGasolineEngineDynamic1212
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
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                 annotation(choicesAllMatching=true);

  parameter
    AixLib.Fluid.BoilerCHP.ModularCHP.OldModels.CHPEngDataBaseRecord_MaterialData
    CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "Needed engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  constant Modelica.SIunits.Volume VCyl = CHPEngData.VEng/CHPEngData.z "Cylinder displacement";
  type RotationSpeed=Real(final unit="1/s", min=0);
  constant RotationSpeed nEngNom(max=CHPEngData.nEngNom) = 25.583 "Nominal engine speed at nominal operating point";
  constant Modelica.SIunits.Power P_mecNom = CHPEngData.P_mecNom "Mecanical power output at nominal operating point";
  parameter Modelica.SIunits.Temperature T_Amb=298.15   "Ambient temperature (matches to fuel and combustion air temperature)";
  type GasConstant=Real(final unit="J/(mol.K)");
  constant GasConstant R = 8.31446 "Gasconstante for calculation purposes";
  constant Real QuoDCyl = CHPEngData.QuoDCyl;
  constant Modelica.SIunits.MassFlowRate m_MaxExh=CHPEngData.P_FueNominal/H_U*(
      1 + Lambda*L_St)
    "Maximal exhaust gas flow based on the fuel and combustion properties";
  constant Modelica.SIunits.Mass m_FueEngRot=CHPEngData.P_FueNominal*60/(H_U*
      CHPEngData.nEngMax*CHPEngData.i)
    "Injected fuel mass per engine rotation(presumed as constant)";
  constant Modelica.SIunits.Pressure p_Amb = 101325 "Ambient pressure";
  constant Modelica.SIunits.Pressure p_mi = p_mfNom+p_meNom "Constant indicated mean effective cylinder pressure";
  constant Modelica.SIunits.Pressure p_meNom = CHPEngData.p_meNom "Nominal mean effective cylinder pressure";
  constant Modelica.SIunits.Pressure ref_p_mfNom = CHPEngData.ref_p_mfNom "Friction mean pressure of reference engine for calculation(dCyl=91mm & nEng=3000rpm & TEng=90°C)";
  constant Modelica.SIunits.Pressure p_mfNom=ref_p_mfNom*QuoDCyl^(-0.3) "Nominal friction mean pressure";
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
 // RotationSpeed nEng(max=CHPEngData.nEngMax) = 25.583 "Current engine speed";
  RotationSpeed nEng(max=CHPEngData.nEngMax, min=0.001) = inertia.w/(2*Modelica.Constants.pi) "Current engine speed";
  Modelica.SIunits.MassFlowRate m_Exh "Mass flow rate of exhaust gas";
  Modelica.SIunits.MassFlowRate m_CO2Exh "Mass flow rate of CO2 in the exhaust gas";
  Modelica.SIunits.MassFlowRate m_Fue(min=0.001) "Mass flow rate of fuel";
  Modelica.SIunits.MassFlowRate m_Air(min=0.001) "Mass flow rate of combustion air";
  Modelica.SIunits.SpecificHeatCapacity meanCpComExh[size(n_ComExh, 1)] "Calculated specific heat capacities of the exhaust gas components for the calculated combustion temperature";
  Modelica.SIunits.SpecificHeatCapacity meanCpExh "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature";
  Modelica.SIunits.SpecificEnergy h_Exh = 1000*(-286 + 1.011*CHPEngData.T_ExhPowUniOut - 27.29*Lambda + 0.000136*CHPEngData.T_ExhPowUniOut^2 - 0.0255*CHPEngData.T_ExhPowUniOut*Lambda + 6.425*Lambda^2) "Specific enthalpy of the exhaust gas";
  Modelica.SIunits.Power P_eff "Effective(mechanical) engine power";
  Modelica.SIunits.Power P_Fue(
    min=0,
    max=CHPEngData.P_FueNominal) = m_Fue*H_U "Fuel expenses at operating point";
  Modelica.SIunits.Power H_Exh "Enthalpy stream of the exhaust gas";
  Modelica.SIunits.Power CalQ_therm "Calculated heat from engine combustion";
  Modelica.SIunits.Power Q_therm(min=0) "Total heat from engine combustion";
  Modelica.SIunits.Torque Mmot "Calculated engine torque";
  Modelica.SIunits.Temperature T_logEngCool=356.15 "Logarithmic mean temperature of coolant inside the engine"
  annotation(Dialog(group="Parameters"));
  Modelica.SIunits.Temperature T_Com(start=T_Amb) "Temperature of the combustion gases";

  // Dynamic engine friction calculation model for the mechanical power and heat output of the combustion engine

  Real A0 = 1.0895-1.079*10^(-2)*(T_logEngCool-273.15)+5.525*10^(-5)*(T_logEngCool-273.15)^2;
  Real A1 = 4.68*10^(-4)-5.904*10^(-6)*(T_logEngCool-273.15)+1.88*10^(-8)*(T_logEngCool-273.15)^2;
  Real A2 = -4.35*10^(-8)+1.12*10^(-9)*(T_logEngCool-273.15)-4.79*10^(-12)*(T_logEngCool-273.15)^2;
  Real B0 = -2.625*10^(-3)+3.75*10^(-7)*(nEng*60)+1.75*10^(-5)*(T_logEngCool-273.15)+2.5*10^(-9)*(T_logEngCool-273.15)*(nEng*60);
  Real B1 = 8.95*10^(-3)+1.5*10^(-7)*(nEng*60)+7*10^(-6)*(T_logEngCool-273.15)-10^(-9)*(T_logEngCool-273.15)*(nEng*60);
  Modelica.SIunits.Pressure p_mf = p_mfNom*((A0+A1*(nEng*60)+A2*(nEng*60)^2)+(B0+B1*(p_meNom/100000))) "Current friction mean pressure at operating point";
  Modelica.SIunits.Pressure p_me = p_mi-p_mf "Current mean effective pressure at operating point";
  Real etaMec = p_me/p_mi "Current percentage of usable mechanical power compared to inner cylinder power from combustion";

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
    annotation (Placement(transformation(extent={{66,62},{86,82}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=m_Exh)
    annotation (Placement(transformation(extent={{30,76},{50,96}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_Com)
    annotation (Placement(transformation(extent={{30,62},{50,82}})));
  Modelica.Blocks.Sources.RealExpression effectiveMechanicalTorque(y=Mmot)
    annotation (Placement(transformation(extent={{-40,6},{-12,34}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Mechanics.Rotational.Sources.Torque engineTorque annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,48})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,78})));

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
  m_Fue = m_FueEngRot*nEng*CHPEngData.i/60;
  m_Air = m_Fue*Lambda*L_St;
  m_Exh = m_Fue + m_Air;
  m_CO2Exh = m_Exh*X_CO2Exh;
  H_Exh = h_Exh*m_Exh;
  if nEng*60>=800 then
  Mmot = CHPEngData.i*p_me*CHPEngData.VEng/(2*Modelica.Constants.pi);
  else
  Mmot = -CHPEngData.i*p_mfNom*CHPEngData.VEng/(2*Modelica.Constants.pi);
  end if;
  CalQ_therm = P_Fue - P_eff - H_Exh;
  Q_therm = if (CalQ_therm>0) then CalQ_therm else 0;
  T_Com = (H_U-(60*p_me*CHPEngData.VEng)/m_FueEngRot)/((1 + Lambda*L_St)*meanCpExh) + T_Amb;
  P_eff = CHPEngData.i*nEng*p_me*CHPEngData.VEng;
 /* if m_Fue>0 then
  T_Com = (P_Fue - P_eff)/(m_Fue*(1 + Lambda*L_St)*meanCpExh) + T_Amb;
  else
  T_Com = T_Amb;
  end if;  */

  connect(port_Air, boundaryAir.ports[1])
    annotation (Line(points={{-100,48},{-66,48}}, color={0,127,255}));
  connect(port_Gasoline, boundaryGasoline.ports[1])
    annotation (Line(points={{-100,78},{-66,78}}, color={0,127,255}));
  connect(exhaustFlow.m_flow_in, realExpression.y)
    annotation (Line(points={{66,80},{58,80},{58,86},{51,86}},
                                               color={0,0,127}));
  connect(exhaustFlow.T_in, realExpression1.y) annotation (Line(points={{64,76},
          {58,76},{58,72},{51,72}}, color={0,0,127}));
  connect(exhaustFlow.ports[1], port_Exhaust)
    annotation (Line(points={{86,72},{98,72}}, color={0,127,255}));
  connect(effectiveMechanicalTorque.y, engineTorque.tau) annotation (Line(
        points={{-10.6,20},{-6.66134e-016,20},{-6.66134e-016,36}}, color={0,0,127}));
  connect(inertia.flange_b, flange_a) annotation (Line(points={{4.44089e-016,88},
          {0,88},{0,100}}, color={0,0,0}));
  connect(inertia.flange_a, engineTorque.flange)
    annotation (Line(points={{0,68},{0,58}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-120,-134},{122,134}}, fileName=
              "modelica://AixLib/../../Nützliches/Modelica Icons_Screenshots/Icon_ICE.png"),
        Text(
          extent={{-100,90},{100,74}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CHPGasolineEngineDynamic1212;
