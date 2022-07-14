within AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents;
model GasolineEngineChp_EngineModel
  "Internal combustion engine model for CHP-applications."
  import AixLib;

  replaceable package Medium1 =
      DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
    "Fuel medium model used in the CHP plant" annotation(choicesAllMatching=true,
      Documentation(revisions="<html>
</html>"));
  replaceable package Medium2 =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                            constrainedby
    DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
    "Air medium model used in the CHP plant" annotation(choicesAllMatching=true);
  replaceable package Medium3 =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
    "Exhaust gas medium model used in the CHP plant" annotation(choicesAllMatching=true);
  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_SenerTecDachsG5_5()
    "Needed engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  constant Modelica.Units.SI.Volume VCyl=CHPEngData.VEng/CHPEngData.z
    "Cylinder displacement";
  type RotationSpeed=Real(final unit="1/s", min=0);
  constant RotationSpeed nEngNominal = 25.583 "Nominal engine speed at operating point";
  constant Modelica.Units.SI.Power P_mecNominal=CHPEngData.P_mecNominal
    "Mecanical power output at nominal operating point";
  parameter Modelica.Units.SI.Temperature T_Amb=298.15
    "Ambient temperature (matches to fuel and combustion air temperature)";
  type GasConstant=Real(final unit="J/(mol.K)");
  constant GasConstant R = 8.31446 "Gasconstant for calculation purposes";
  constant Real QuoDCyl = CHPEngData.QuoDCyl;
  constant Boolean FuelType = Medium1.isGas "True = Gasoline fuel, False = Liquid fuel";
  constant Modelica.Units.SI.MassFlowRate m_MaxExh=CHPEngData.P_FueNominal/H_U*
      (1 + Lambda*L_St)
    "Maximal exhaust gas flow based on the fuel and combustion properties";
  constant Modelica.Units.SI.Mass m_FueEngRot=CHPEngData.P_FueNominal*60/(H_U*
      CHPEngData.nEngMax*CHPEngData.i)
    "Injected fuel mass per engine rotation(presumed as constant)";
  constant Modelica.Units.SI.Pressure p_Amb=101325 "Ambient pressure";
  constant Modelica.Units.SI.Pressure p_mi=p_mfNominal + p_meNominal
    "Constant indicated mean effective cylinder pressure";
  constant Modelica.Units.SI.Pressure p_meNominal=CHPEngData.p_meNominal
    "Nominal mean effective cylinder pressure";
  constant Modelica.Units.SI.Pressure ref_p_mfNominal=CHPEngData.ref_p_mfNominal
    "Friction mean pressure of reference engine for calculation(dCyl=91mm & nEng=3000rpm & TEng=90°C)";
  constant Modelica.Units.SI.Pressure p_mfNominal=ref_p_mfNominal*QuoDCyl^(-0.3)
    "Nominal friction mean pressure";
  constant Modelica.Units.SI.Temperature T_ExhOut=CHPEngData.T_ExhPowUniOut
    "Assumed exhaust gas outlet temperature of the CHP unit for heat calculations";
  constant Modelica.Units.SI.SpecificEnergy H_U=Medium1.H_U
    "Specific calorific value of the fuel";
  constant Real Lambda=CHPEngData.Lambda "Combustion air ratio";
  constant Real L_St = Medium1.L_st "Stoichiometric air consumption per mass fuel";
  constant Real l_Min = L_St*MM_Fuel/MM_Air "Minimum molar air consumption per mole fuel";
  constant Modelica.Units.SI.MolarMass MM_Fuel=Medium1.MM
    "Molar mass of the fuel";
  constant Modelica.Units.SI.MolarMass MM_Air=Medium2.MM
    "Molar mass of the combustion air";
  constant Modelica.Units.SI.MolarMass MM_ComExh[:]=Medium3.data[:].MM
    "Molar masses of the combustion products: N2, O2, H2O, CO2";
  constant Real expFacCpComExh[:] = {0.11, 0.15, 0.20, 0.30} "Exponential factor for calculating the specific heat capacity of N2, O2, H2O, CO2";
  constant Modelica.Units.SI.SpecificHeatCapacity cpRefComExh[:]={1000,900,1750,
      840}
    "Specific heat capacities of the combustion products at reference state at 0°C";
  constant Modelica.Units.SI.Temperature RefT_Com=1473.15
    "Reference combustion temperature for calculation purposes";

  // Exhaust composition for gasoline fuels

  constant Real n_N2Exh = if FuelType then Medium1.moleFractions_Gas[1] + Lambda*l_Min*Medium2.moleFractions_Air[1]
  else Lambda*l_Min*Medium2.moleFractions_Air[1] "Exhaust: Number of molecules Nitrogen per mole of fuel";
  constant Real n_O2Exh = (Lambda-1)*l_Min*Medium2.moleFractions_Air[2] "Exhaust: Number of molecules Oxygen per mole of fuel";
  constant Real n_H2OExh = if FuelType then 0.5*sum(Medium1.moleFractions_Gas[i]*Medium1.Fuel.nue_H[i] for i in 1:size(Medium1.Fuel.nue_H, 1))
  else 0.5*(Medium1.Fuel.Xi_liq[2]*Medium1.MM/Medium1.Fuel.MMi_liq[2]) "Exhaust: Number of molecules H20 per mole of fuel";
  constant Real n_CO2Exh = if FuelType then sum(Medium1.moleFractions_Gas[i]*Medium1.Fuel.nue_C[i] for i in 1:size(Medium1.Fuel.nue_C, 1))
  else Medium1.Fuel.Xi_liq[1]*Medium1.MM/Medium1.Fuel.MMi_liq[1] "Exhaust: Number of molecules CO2 per mole of fuel";
  constant Real n_ComExh[:] = {n_N2Exh, n_O2Exh, n_H2OExh, n_CO2Exh};
  constant Real n_Exh = sum(n_ComExh[j] for j in 1:size(n_ComExh, 1)) "Number of exhaust gas molecules per mole of fuel";
  constant Modelica.Units.SI.MolarMass MM_Exh=sum(n_ComExh[i]*MM_ComExh[i] for
      i in 1:size(n_ComExh, 1))/sum(n_ComExh[i] for i in 1:size(n_ComExh, 1))
    "Molar mass of the exhaust gas";
  constant Modelica.Units.SI.MassFraction X_N2Exh=MM_ComExh[1]*n_ComExh[1]/(
      MM_Exh*n_Exh) "Mass fraction of N2 in the exhaust gas";
  constant Modelica.Units.SI.MassFraction X_O2Exh=MM_ComExh[2]*n_ComExh[2]/(
      MM_Exh*n_Exh) "Mass fraction of O2 in the exhaust gas";
  constant Modelica.Units.SI.MassFraction X_H2OExh=MM_ComExh[3]*n_ComExh[3]/(
      MM_Exh*n_Exh) "Mass fraction of H2O in the exhaust gas";
  constant Modelica.Units.SI.MassFraction X_CO2Exh=MM_ComExh[4]*n_ComExh[4]/(
      MM_Exh*n_Exh) "Mass fraction of CO2 in the exhaust gas";
  constant Modelica.Units.SI.MassFraction Xi_Exh[size(n_ComExh, 1)]={X_N2Exh,
      X_O2Exh,X_H2OExh,X_CO2Exh};

  Boolean SwitchOnOff=true
     "Operation switch of the CHP unit (true=On, false=Off)"
    annotation (Dialog(group="Modulation"));
  RotationSpeed nEng(min=0) "Current engine speed";
  Modelica.Units.SI.MassFlowRate m_flow_Exh "Mass flow rate of exhaust gas";
  Modelica.Units.SI.MassFlowRate m_flow_CO2Exh
    "Mass flow rate of CO2 in the exhaust gas";
  Modelica.Units.SI.MassFlowRate m_flow_Fue(min=0) "Mass flow rate of fuel";
  Modelica.Units.SI.MassFlowRate m_flow_Air(min=0)
    "Mass flow rate of combustion air";
  Modelica.Units.SI.SpecificHeatCapacity meanCpComExh[size(n_ComExh, 1)]
    "Calculated specific heat capacities of the exhaust gas components for the calculated combustion temperature";
  Modelica.Units.SI.SpecificHeatCapacity meanCpExh
    "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature";
  Modelica.Units.SI.SpecificEnergy h_Exh=1000*(-286 + 1.011*T_ExhCHPOut - 27.29
      *Lambda + 0.000136*T_ExhCHPOut^2 - 0.0255*T_ExhCHPOut*Lambda + 6.425*
      Lambda^2) "Specific enthalpy of the exhaust gas";
  Modelica.Units.SI.Power P_eff "Effective(mechanical) engine power";
  Modelica.Units.SI.Power P_Fue(min=0) = m_flow_Fue*H_U
    "Fuel expenses at operating point";
  Modelica.Units.SI.Power H_Exh "Enthalpy stream of the exhaust gas";
  Modelica.Units.SI.Power CalQ_therm "Calculated heat from engine combustion";
  Modelica.Units.SI.Power Q_therm(min=0) "Total heat from engine combustion";
  Modelica.Units.SI.Torque Mmot "Calculated engine torque";
  Modelica.Units.SI.Temperature T_logEngCool=356.15
    "Logarithmic mean temperature of coolant inside the engine"
    annotation (Dialog(group="Parameters"));
  Modelica.Units.SI.Temperature T_Com(start=T_Amb)
    "Temperature of the combustion gases";
  Modelica.Units.SI.Temperature T_ExhCHPOut=383.15
    "Exhaust gas outlet temperature of CHP unit"
    annotation (Dialog(group="Parameters"));
  Real modFac=1 "Modulation factor for energy outuput control of the Chp unit"
    annotation (Dialog(group="Modulation"));

  // Dynamic engine friction calculation model for the mechanical power and heat output of the combustion engine

  Real A0 = 1.0895-1.079*10^(-2)*(T_logEngCool-273.15)+5.525*10^(-5)*(T_logEngCool-273.15)^2;
  Real A1 = 4.68*10^(-4)-5.904*10^(-6)*(T_logEngCool-273.15)+1.88*10^(-8)*(T_logEngCool-273.15)^2;
  Real A2 = -4.35*10^(-8)+1.12*10^(-9)*(T_logEngCool-273.15)-4.79*10^(-12)*(T_logEngCool-273.15)^2;
  Real B0 = -2.625*10^(-3)+3.75*10^(-7)*(nEng*60)+1.75*10^(-5)*(T_logEngCool-273.15)+2.5*10^(-9)*(T_logEngCool-273.15)*(nEng*60);
  Real B1 = 8.95*10^(-3)+1.5*10^(-7)*(nEng*60)+7*10^(-6)*(T_logEngCool-273.15)-10^(-9)*(T_logEngCool-273.15)*(nEng*60);
  Modelica.Units.SI.Pressure p_mf=p_mfNominal*((A0 + A1*(nEng*60) + A2*(nEng*60)
      ^2) + (B0 + B1*(p_meNominal/100000)))
    "Current friction mean pressure at operating point";
  Modelica.Units.SI.Pressure p_me=(modFac*p_mi) - p_mf
    "Current mean effective pressure at operating point";
  Real etaMec = p_me/p_mi "Current percentage of usable mechanical power compared to inner cylinder power from combustion";

  Modelica.Fluid.Interfaces.FluidPort_b port_exh(redeclare package Medium =
        Medium3)
    annotation (Placement(transformation(extent={{108,-10},{88,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T exhaustFlow(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium3,
    X=Xi_Exh,
    use_X_in=false,
    nPorts=1) "Flow source of the exhaust gas from the engine combustion"
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Blocks.Sources.RealExpression massFlowExhaust(y=m_flow_Exh)
    annotation (Placement(transformation(extent={{28,-4},{50,20}})));
  Modelica.Blocks.Sources.RealExpression effectiveMechanicalTorque(y=Mmot)
    annotation (Placement(transformation(extent={{18,-12},{-6,12}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    "Mechanical port of the engines output drive"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque engineTorque
    "Calculated engine torque"                              annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,0})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.5*CHPEngData.z/4)
    "Inertia model of the engine"                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-68,0})));

  Modelica.Blocks.Interfaces.RealInput exhaustGasTemperature
    "Exhaust gas temperature calculated in the thermal engine model"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,-104}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,-70})));
  AixLib.Controls.Interfaces.CHPControlBus cHPEngineBus
    "Signal bus of the mechanical combustion engine model"
    annotation (Placement(transformation(extent={{-20,76},{20,116}})));
  Modelica.Blocks.Sources.RealExpression engineSpeed(y=nEng)
    annotation (Placement(transformation(extent={{-42,66},{-22,86}})));
  Modelica.Blocks.Sources.RealExpression fuelPower(y=P_Fue)
    annotation (Placement(transformation(extent={{-42,52},{-22,72}})));
  Modelica.Blocks.Sources.RealExpression thermalPower(y=Q_therm)
    annotation (Placement(transformation(extent={{-42,38},{-22,58}})));
  Modelica.Blocks.Sources.RealExpression outputTorque(y=Mmot)
    annotation (Placement(transformation(extent={{42,24},{22,44}})));
  Modelica.Blocks.Sources.RealExpression airFlow(y=m_flow_Fue)
    annotation (Placement(transformation(extent={{42,52},{22,72}})));
  Modelica.Blocks.Sources.RealExpression carbondioxideFlow(y=m_flow_CO2Exh)
    annotation (Placement(transformation(extent={{42,66},{22,86}})));
  Modelica.Blocks.Sources.RealExpression SpecificHeatCapExhGas(y=meanCpExh)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-32,34})));
  Modelica.Blocks.Sources.RealExpression fuelFlow(y=m_flow_Air)
    annotation (Placement(transformation(extent={{42,38},{22,58}})));
equation

for i in 1:size(n_ComExh, 1) loop
  meanCpComExh[i] = cpRefComExh[i]/(expFacCpComExh[i] + 1)/(T_Com/273.15 - 1)*(-1 + (T_Com/273.15)^(expFacCpComExh[i] + 1));
  end for;
  meanCpExh = sum(meanCpComExh[i]*Xi_Exh[i] for i in 1:size(n_ComExh, 1));
  m_flow_Fue = modFac*m_FueEngRot*nEng*CHPEngData.i/60;
  m_flow_Air = m_flow_Fue*Lambda*L_St;
 // m_Exh = m_Fue + m_Air;
  m_flow_CO2Exh = m_flow_Fue*(1 + Lambda*L_St)*X_CO2Exh;
  H_Exh =h_Exh*m_flow_Fue*(1 + Lambda*L_St);
  if inertia.w>=80 and SwitchOnOff then
  Mmot = CHPEngData.i*p_me*CHPEngData.VEng/(2*Modelica.Constants.pi);
  nEng = inertia.w/(2*Modelica.Constants.pi);
    m_flow_Exh = m_flow_Fue + m_flow_Air;
  elseif inertia.w>=80 and not
                              (SwitchOnOff) then
  Mmot = -CHPEngData.i*p_mf*CHPEngData.VEng/(2*Modelica.Constants.pi);
  nEng = inertia.w/(2*Modelica.Constants.pi);
    m_flow_Exh = m_flow_Fue + m_flow_Air + 0.0001;
  elseif inertia.w<80 and noEvent(inertia.w>0.1) then
  Mmot = -CHPEngData.i*p_mf*CHPEngData.VEng/(2*Modelica.Constants.pi);
  nEng = inertia.w/(2*Modelica.Constants.pi);
    m_flow_Exh = m_flow_Fue + m_flow_Air + 0.0001;
  else
  Mmot = 0;
  nEng = 0;
    m_flow_Exh = 0.001;
  end if;
  CalQ_therm = P_Fue - P_eff - H_Exh;
  Q_therm = if (nEng>1) and (CalQ_therm>=10) then CalQ_therm else 0;
  T_Com = (H_U-(60*p_me*CHPEngData.VEng)/m_FueEngRot)/((1 + Lambda*L_St)*meanCpExh) + T_Amb;
  P_eff = CHPEngData.i*nEng*p_me*CHPEngData.VEng;

 /* if m_Fue>0 then
  T_Com = (P_Fue - P_eff)/(m_Fue*(1 + Lambda*L_St)*meanCpExh) + T_Amb;
  else
  T_Com = T_Amb;
  end if;  */

  connect(exhaustFlow.m_flow_in, massFlowExhaust.y)
    annotation (Line(points={{66,8},{51.1,8}},   color={0,0,127}));
  connect(exhaustFlow.ports[1], port_exh)
    annotation (Line(points={{86,0},{98,0}}, color={0,127,255}));
  connect(inertia.flange_b, flange_a) annotation (Line(points={{-78,
          1.33227e-015},{-100,1.33227e-015},{-100,0}},
                           color={0,0,0}));
  connect(inertia.flange_a, engineTorque.flange)
    annotation (Line(points={{-58,-1.33227e-015},{-58,1.33227e-015},{-40,
          1.33227e-015}},                    color={0,0,0}));
  connect(exhaustFlow.T_in, exhaustGasTemperature) annotation (Line(points={{64,
          4},{56,4},{56,-40},{0,-40},{0,-104}}, color={0,0,127}));
  connect(engineTorque.tau, effectiveMechanicalTorque.y) annotation (Line(
        points={{-18,-1.55431e-015},{-12,-1.55431e-015},{-12,0},{-7.2,0}},
        color={0,0,127}));
  connect(engineSpeed.y, cHPEngineBus.meaRotEng)
    annotation (Line(points={{-21,76},{0.1,76},{0.1,96.1}}, color={0,0,127}));
  connect(fuelPower.y, cHPEngineBus.meaFuePowEng)
    annotation (Line(points={{-21,62},{0.1,62},{0.1,96.1}}, color={0,0,127}));
  connect(thermalPower.y, cHPEngineBus.meaThePowEng)
    annotation (Line(points={{-21,48},{0.1,48},{0.1,96.1}}, color={0,0,127}));
  connect(SpecificHeatCapExhGas.y, cHPEngineBus.calMeaCpExh)
    annotation (Line(points={{-21,34},{0.1,34},{0.1,96.1}}, color={0,0,127}));
  connect(carbondioxideFlow.y, cHPEngineBus.meaMasFloCO2Eng)
    annotation (Line(points={{21,76},{0.1,76},{0.1,96.1}}, color={0,0,127}));
  connect(airFlow.y, cHPEngineBus.meaMasFloAirEng)
    annotation (Line(points={{21,62},{0.1,62},{0.1,96.1}}, color={0,0,127}));
  connect(outputTorque.y, cHPEngineBus.meaTorEng)
    annotation (Line(points={{21,34},{0.1,34},{0.1,96.1}}, color={0,0,127}));
  connect(fuelFlow.y, cHPEngineBus.meaMasFloFueEng)
    annotation (Line(points={{21,48},{0.1,48},{0.1,96.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-120,-134},{122,134}}, fileName=
              "modelica://AixLib/Resources/Images/Fluid/BoilerCHP/Icon_ICE.png"),
        Text(
          extent={{-100,80},{100,64}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  The model of the internal combustion engine is the centrepiece of the
  BHKW model developed. It is divided into a thermal and a
  mechanical-chemical part.
</p>
<p>
  The energy balance of the combustion engine is used to determine the
  maximum heat released. The mechanical power is calculated using a
  mean value model, which is characterized by short calculation times
  and simple parameterization. An empirical approach is used to
  describe the specific enthalpy of the exhaust gas. The required mass
  flows of the combustion products are determined by assuming complete
  combustion with a known fuel composition. Various liquid and gaseous
  fuels have been implemented on the basis of the existing material
  models and are available to the user.
</p>
<p>
  Due to the complexity of a combustion engine, assumptions have to be
  made. These are listed below to understand the function and
  applicability of the model.
</p>
<p>
  <br/>
  <b><span style=\"color: #005500;\">Assumptions</span></b>
</p>
<p>
  <br/>
  Assumptions made and resulting limitations of the internal combustion
  engine model:
</p>
<p>
  - The nominal power point of the power unit is known and the
  modulationof the operation point is achieved by a reduction of the
  introduced fuel.
</p>
<p>
  - The indicated mean pressure is assumed to be constant as a
  necessary measure for the calculation of engine power. This
  corresponds to a constant thermodynamic combustion process within the
  cylinders.
</p>
<p>
  - The engine must be started with an electric machine. It is
  controlled by the release of the fuel quantity from a minimum speed
  (800rpm). The speed then increases to equilibrium with the
  counteracting generator torque.
</p>
<p>
  - Complete and superstoichiometric combustion is assumed to solve the
  gross reaction equation
</p>
<p>
  - Entry of air and fuel at ambient conditions and constant amount of
  fuel and air per combustion cycle
</p>
<p>
  -&gt; Only conditionally with turbocharging of the engines, since
  then the cylinder filling can vary depending on the boost pressure
  (slight consideration due to stored rated performance data)
</p>
<p>
  <br/>
  Air ratio or residual oxygen in the exhaust gas is known to estimate
  the combustion process. So this is a necessary assumption for the
  calculation of material flows (mass flows, composition of the exhaust
  gas).
</p>
<p>
  The mean specific heat capacity of the exhaust gas for a temperature
  range from 0 ° C to the maximum adiabatic combustion temperature is
  used to calculate the exhaust gas temperature.
</p>
<p>
  The mean specific heat capacity is determinated with a potency
  approach according to Müller (1968).
</p>
<p>
  Frictional losses that can be calculated based on a known friction
  mean pressure at a speed of 3000rpm (if not known, default average
  values ​​from VK1 by S.Pischinger) are converted into usable heat.
</p>
<p>
  The calculation of the exhaust gas enthalpy according to an empirical
  approach is based on investigations by R.Pischinger which uses a
  reference point temperature of 25 ° C (initial state of the reaction
  educts from combustion air and fuel).
</p>
<p>
  -&gt; Consideration of the chemical and thermal proportions of the
  enthalpy
</p>
<p>
  -&gt; Limited accuracy for diesel engine (non-premixed) processes
</p>
</html>"));
end GasolineEngineChp_EngineModel;
