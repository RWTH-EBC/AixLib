within AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses;
model ExhaustHeatExchanger
  "Exhaust gas heat exchanger for engine combustion and its heat transfer to a cooling circle"

  extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
    m1_flow_nominal=0.023,
    m2_flow_nominal=0.5556,
    m1_flow_small=0.0001,
    m2_flow_small=0.0001,
    show_T=true,
    redeclare package Medium1 = Medium3,
    redeclare package Medium2 = Medium4);

  replaceable package Medium3 =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Exhaust gas medium model used in the CHP plant"  annotation (
      __Dymola_choicesAllMatching=true);
  replaceable package Medium4 =
      DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                      property_T=356, X_a=0.50) constrainedby
    Modelica.Media.Interfaces.PartialMedium
    "Coolant medium model used in the CHP plant" annotation (
      __Dymola_choicesAllMatching=true);

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "Needed engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  parameter Modelica.Units.SI.Time tau=1
    "Time constant of the temperature sensors at nominal flow rate"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Units.SI.Temperature T1_start=T_Amb
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Units.SI.Temperature T2_start=T_Amb
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p1_start=p_Amb
    "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p2_start=p_Amb
    "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Boolean transferHeat=false
    "If true, temperature T converges towards TAmb when no flow"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Boolean ConTec=false
    "Is condensing technology used and should latent heat be considered?"
    annotation (Dialog(tab="Advanced", group="Condensing technology"));
  parameter Modelica.Units.SI.Temperature T_Amb=298.15
    "Fixed ambient temperature for heat transfer"
    annotation (Dialog(group="Ambient Properties"));
  parameter Modelica.Units.SI.Area A_surExhHea=50
    "Surface for exhaust heat transfer"
    annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.Units.SI.Length d_iExh=CHPEngData.dExh
    "Inner diameter of exhaust pipe"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.ThermalConductance GAmb=5
    "Constant thermal conductance of material"
    annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.Units.SI.ThermalConductance GCoo=850
    "Constant thermal conductance of material"
    annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.Units.SI.HeatCapacity CExhHex=4000
    "Heat capacity of exhaust heat exchanger(default= 4000 J/K)"
    annotation (Dialog(tab="Calibration parameters"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_Amb=101325
    "Start value of pressure"
    annotation (Dialog(group="Ambient Properties"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=
      CHPEngData.dp_Coo
    "Guess value of dp = port_a.p - port_b.p"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Units.SI.Time tauHeaTra=1200
    "Time constant for heat transfer, default 20 minutes"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
    "Guess value of m_flow = port_a.m_flow"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  constant Modelica.Units.SI.MolarMass M_H2O=0.01802 "Molar mass of water";

    //Antoine-Parameters needed for the calculation of the saturation vapor pressure xSat_H2OExhDry
  constant Real A=11.7621;
  constant Real B=3874.61;
  constant Real C=229.73;

  parameter Modelica.Units.SI.Length l_ExhHex=1
    "Length of the exhaust pipe inside the exhaust heat exchanger" annotation (
      Dialog(tab="Calibration parameters", group="Engine parameters"));
  parameter Modelica.Units.SI.PressureDifference dp_CooExhHex=CHPEngData.dp_Coo
    "Pressure drop at nominal mass flow rate inside the coolant circle "
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.MolarMass M_Exh=1200
    "Molar mass of the exhaust gas" annotation (Dialog(group="Thermal"));

  Real QuoT_ExhInOut=senTExhHot.T/senTExhCold.T
  "Quotient of exhaust gas in and outgoing temperature";

   //Variables for water condensation and its usable latent heat calculation
  Real x_H2OExhDry
    "Water load of the exhaust gas";
  Real xSat_H2OExhDry
    "Saturation water load of the exhaust gas";
  Modelica.Units.SI.MassFlowRate m_H2OExh
    "Mass flow of water in the exhaust gas";
  Modelica.Units.SI.MassFlowRate m_ExhDry "Mass flow of dry exhaust gas";
  Modelica.Units.SI.MassFlowRate m_ConH2OExh "Mass flow of condensing water";
  Modelica.Units.SI.AbsolutePressure pExh
    "Pressure in the exhaust gas stream (assuming ambient conditions)";
  Modelica.Units.SI.AbsolutePressure pSatH2OExh
    "Saturation vapor pressure of the exhaust gas water";
  Modelica.Units.SI.SpecificEnthalpy deltaH_Vap
    "Specific enthalpy of vaporization (empirical formula based on table data)";
  Modelica.Units.SI.SpecificHeatCapacity meanCpExh=cHPExhHexBus.calMeaCpExh
    "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature"
    annotation (Dialog(group="Thermal"));
  Modelica.Units.SI.HeatFlowRate Q_Gen=cHPExhHexBus.calThePowGen
    "Calculated loss heat from the induction machine"
    annotation (Dialog(group="Thermal"));
  Modelica.Units.SI.Temperature T_LogMeanExh
    "Mean logarithmic temperature of exhaust gas";

    //Calculation of the thermodynamic state of the exhaust gas inlet used by the convective heat transfer model
  Medium1.ThermodynamicState state1 = Medium1.setState_pTX(senTExhHot.port_b.p,T_LogMeanExh,senTExhHot.port_b.Xi_outflow);
  Modelica.Units.SI.SpecificEnthalpy h1_in=Medium1.specificEnthalpy(state1);
  Modelica.Units.SI.DynamicViscosity eta1_in=Medium1.dynamicViscosity(state1);
  Modelica.Units.SI.Density rho1_in=Medium1.density_phX(
      state1.p,
      h1_in,
      state1.X);
  Modelica.Units.SI.Velocity v1_in=senMasFloExh.m_flow/(Modelica.Constants.pi*
      rho1_in*d_iExh^2/4);
  Modelica.Units.SI.ThermalConductivity lambda1_in=Medium1.thermalConductivity(
      state1);
  Modelica.Units.SI.ReynoldsNumber Re1_in=
      Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(
      v1_in,
      rho1_in,
      eta1_in,
      d_iExh);

  Modelica.Blocks.Sources.RealExpression machineIsOff(y=0)
    "Calculated heat from generator losses"
    annotation (Placement(transformation(extent={{142,-34},{98,-14}})));
  AixLib.Controls.Interfaces.CHPControlBus cHPExhHexBus
    "Signal bus of the exhaust gas heat exchanger"
                               annotation (Placement(transformation(extent={{
            -28,72},{28,126}}), iconTransformation(extent={{-28,72},{28,126}})));
  AixLib.Utilities.Logical.SmoothSwitch switch2 annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={76,-12})));
  Modelica.Blocks.Sources.RealExpression heatToCooling(y=pipeCoolant.heatPort_outside.Q_flow)
    annotation (Placement(transformation(extent={{-42,76},{-22,96}})));
  Modelica.Blocks.Sources.RealExpression condensingWater(y=m_ConH2OExh)
    annotation (Placement(transformation(extent={{-42,62},{-22,82}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTExhHot(
    redeclare final package Medium = Medium1,
    final tau=tau,
    final m_flow_nominal=m1_flow_nominal,
    final initType=initType,
    final T_start=T1_start,
    final transferHeat=transferHeat,
    final TAmb=T_Amb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_small=m1_flow_small)
    "Temperature sensor of hot side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTExhCold(
    redeclare final package Medium = Medium1,
    final tau=tau,
    final m_flow_nominal=m1_flow_nominal,
    final initType=initType,
    final T_start=T1_start,
    final transferHeat=transferHeat,
    final TAmb=T_Amb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_small=m1_flow_small)
    "Temperature sensor of cold side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{28,50},{48,70}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFloExh(redeclare final package Medium =
        Medium1, final allowFlowReversal=allowFlowReversal1)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{60,70},{80,50}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTCooCold(
    redeclare final package Medium = Medium2,
    final tau=tau,
    final m_flow_nominal=m2_flow_nominal,
    final initType=initType,
    final T_start=T2_start,
    final transferHeat=transferHeat,
    final TAmb=T_Amb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal2,
    final m_flow_small=m2_flow_small)
    "Temperature sensor of coolant cold side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTCooHot(
    redeclare final package Medium = Medium2,
    final tau=tau,
    final m_flow_nominal=m2_flow_nominal,
    final initType=initType,
    final T_start=T2_start,
    final transferHeat=transferHeat,
    final TAmb=T_Amb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal2,
    final m_flow_small=m2_flow_small)
    "Temperature sensor of coolant hot side of exhaust heat exchanger"
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFloCool(redeclare final package Medium =
               Medium2, final allowFlowReversal=allowFlowReversal2)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
  AixLib.Fluid.FixedResistances.Pipe pipeCoolant(
    redeclare package Medium = Medium2,
    isEmbedded=true,
    Heat_Loss_To_Ambient=true,
    withInsulation=false,
    use_HeatTransferConvective=false,
    eps=0,
    hCon_i=GCoo/(pipeCoolant.perimeter*pipeCoolant.length),
    diameter=0.03175,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          m_flow_nominal=m2_flow_nominal, dp_nominal=10))
    "Pipe model for heat transfer to the cooling circuit"
    annotation (Placement(transformation(extent={{32,-70},{12,-50}})));
  Modelica.Fluid.Vessels.ClosedVolume volExhaust(
    redeclare final package Medium = Medium1,
    final m_flow_nominal=m1_flow_nominal,
    final p_start=p1_start,
    final T_start=T1_start,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
    use_portsData=false,
    final m_flow_small=m1_flow_small,
    V=VExhHex,
    nPorts=2) "Fluid volume of the exhaust gas inside the heat exchanger"
    annotation (Placement(transformation(extent={{-20,60},{-40,40}})));
  AixLib.Fluid.FixedResistances.HydraulicDiameter
                                pressureDropExhaust(
    redeclare final package Medium = Medium1,
    final show_T=false,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    dh=d_iExh,
    rho_default=1.18,
    mu_default=1.82*10^(-5),
    length=l_ExhHex) "Pressure drop of the exhaust gas"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  AixLib.Utilities.HeatTransfer.HeatConvPipeInsideDynamic
    heatConvExhaustPipeInside(
    d_i=d_iExh,
    A_sur=A_surExhHea,
    rho=rho1_in,
    lambda=lambda1_in,
    eta=eta1_in,
    c=cHPExhHexBus.calMeaCpExh,
    m_flow=cHPExhHexBus.meaMasFloFueEng + cHPExhHexBus.meaMasFloAirEng)
    "Heat transfer model using convection calculation"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,20})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow additionalHeat
    "Heat flow from water condensation in the exhaust gas and generator losses"
    annotation (Placement(transformation(extent={{60,-22},{40,-2}})));
  Modelica.Blocks.Sources.RealExpression latentAndGeneratorHeat(y=m_ConH2OExh*
        deltaH_Vap + Q_Gen)
    "Calculated latent exhaust heat from water condensation"
    annotation (Placement(transformation(extent={{142,-8},{98,12}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=
        CExhHex, T(start=T_Amb, fixed=true))
    "Thermal capacity of the exhaust gas heat exchanger"
    annotation (Placement(transformation(extent={{10,-12},{30,8}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ambientLoss(G=
        GAmb)
    annotation (Placement(transformation(extent={{-46,-22},{-66,-2}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_amb
    "Heat port to ambient"                                     annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));

protected
  parameter Modelica.Units.SI.Volume VExhHex=l_ExhHex/4*Modelica.Constants.pi*
      d_iExh^2 "Exhaust gas volume inside the exhaust heat exchanger"
    annotation (Dialog(tab="Calibration parameters", group="Engine parameters"));

equation
//Calculation of water condensation and its usable latent heat
  if ConTec then
  x_H2OExhDry=senTExhHot.port_a.Xi_outflow[3]/(1 - senTExhHot.port_a.Xi_outflow[3]);
  xSat_H2OExhDry=if noEvent(M_H2O*pSatH2OExh/((pExh-pSatH2OExh)*M_Exh)>=0) then M_H2O*pSatH2OExh/((pExh-pSatH2OExh)*M_Exh) else x_H2OExhDry;
  m_H2OExh=senMasFloExh.m_flow*senTExhHot.port_a.Xi_outflow[3];
  m_ExhDry=senMasFloExh.m_flow-m_H2OExh;
  m_ConH2OExh=if (x_H2OExhDry>xSat_H2OExhDry) then m_ExhDry*(x_H2OExhDry-xSat_H2OExhDry) else 0;
  pExh=senTExhHot.port_a.p;
  pSatH2OExh=100000*Modelica.Math.exp(A-B/(senTExhCold.T-273.15+C));
  deltaH_Vap=2697400+446.25*senTExhCold.T-4.357*(senTExhCold.T)^2;
  else
  x_H2OExhDry=0;
  xSat_H2OExhDry=0;
  m_H2OExh=0;
  m_ExhDry=0;
  m_ConH2OExh=0;
  pExh=0;
  pSatH2OExh=0;
  deltaH_Vap=0;
  end if;

  if (QuoT_ExhInOut-1)>0.0001 then
  T_LogMeanExh=(senTExhHot.T-senTExhCold.T)/Modelica.Math.log(QuoT_ExhInOut);
  else
  T_LogMeanExh=senTExhHot.T;
  end if;

  connect(senTExhCold.port_b, senMasFloExh.port_a)
    annotation (Line(points={{48,60},{60,60}}, color={0,127,255}));
  connect(port_a1, senTExhHot.port_a)
    annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
  connect(senMasFloExh.port_b, port_b1)
    annotation (Line(points={{80,60},{100,60}}, color={0,127,255}));
  connect(port_a2, senTCooCold.port_b)
    annotation (Line(points={{100,-60},{80,-60}}, color={0,127,255}));
  connect(senTCooHot.port_a, senMasFloCool.port_a)
    annotation (Line(points={{-40,-60},{-60,-60}}, color={0,127,255}));
  connect(senMasFloCool.port_b, port_b2)
    annotation (Line(points={{-80,-60},{-100,-60}}, color={0,127,255}));
  connect(port_amb, ambientLoss.port_b) annotation (Line(points={{-100,0},{-90,
          0},{-90,-12},{-66,-12}}, color={191,0,0}));
  connect(senTCooCold.port_a, pipeCoolant.port_a)
    annotation (Line(points={{60,-60},{32,-60}},   color={0,127,255}));
  connect(senTCooHot.port_b, pipeCoolant.port_b)
    annotation (Line(points={{-20,-60},{12,-60}},   color={0,127,255}));
  connect(ambientLoss.port_a, heatCapacitor.port)
    annotation (Line(points={{-46,-12},{20,-12}},color={191,0,0}));
  connect(heatCapacitor.port, pipeCoolant.heatPort_outside) annotation (Line(
        points={{20,-12},{20.4,-12},{20.4,-54.4}},color={191,0,0}));
  connect(volExhaust.heatPort, heatConvExhaustPipeInside.port_a)
    annotation (Line(points={{-20,50},{-20,30}}, color={191,0,0}));
  connect(heatConvExhaustPipeInside.port_b, heatCapacitor.port)
    annotation (Line(points={{-20,10},{-20,-12},{20,-12}},color={191,0,0}));
  connect(pressureDropExhaust.port_b, senTExhCold.port_a)
    annotation (Line(points={{20,60},{28,60}}, color={0,127,255}));
  connect(additionalHeat.port, heatCapacitor.port)
    annotation (Line(points={{40,-12},{20,-12}}, color={191,0,0}));
  connect(senTExhHot.port_b, volExhaust.ports[1])
    annotation (Line(points={{-60,60},{-28,60}}, color={0,127,255}));
  connect(pressureDropExhaust.port_a, volExhaust.ports[2])
    annotation (Line(points={{0,60},{-32,60}}, color={0,127,255}));
  connect(switch2.y, additionalHeat.Q_flow)
    annotation (Line(points={{69.4,-12},{60,-12}}, color={0,0,127}));
  connect(cHPExhHexBus.isOn, switch2.u2) annotation (Line(
      points={{0.14,99.135},{150,99.135},{150,-12},{83.2,-12}},
      color={255,204,51},
      thickness=0.5));
  connect(latentAndGeneratorHeat.y, switch2.u1) annotation (Line(points={{95.8,2},
          {90,2},{90,-7.2},{83.2,-7.2}},    color={0,0,127}));
  connect(machineIsOff.y, switch2.u3) annotation (Line(points={{95.8,-24},{90,
          -24},{90,-16.8},{83.2,-16.8}}, color={0,0,127}));
  connect(senTCooHot.T, cHPExhHexBus.meaTemOutHex) annotation (Line(points={{
          -30,-49},{-30,-32},{-120,-32},{-120,99.135},{0.14,99.135}}, color={0,
          0,127}));
  connect(senTCooCold.T, cHPExhHexBus.meaTemInHex) annotation (Line(points={{70,
          -49},{70,-34},{150,-34},{150,99.135},{0.14,99.135}}, color={0,0,127}));
  connect(senTExhHot.T, cHPExhHexBus.meaTemExhHexIn) annotation (Line(points={{
          -70,71},{-70,99.135},{0.14,99.135}}, color={0,0,127}));
  connect(senTExhCold.T, cHPExhHexBus.meaTemExhHexOut) annotation (Line(points=
          {{38,71},{38,99.135},{0.14,99.135}}, color={0,0,127}));
  connect(heatToCooling.y, cHPExhHexBus.meaThePowOutHex) annotation (Line(
        points={{-21,86},{0.14,86},{0.14,99.135}}, color={0,0,127}));
  connect(condensingWater.y, cHPExhHexBus.meaMasFloConHex) annotation (Line(
        points={{-21,72},{0.14,72},{0.14,99.135}}, color={0,0,127}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-70,80},{70,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-99,64},{102,54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-99,-56},{102,-66}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Exhaust gas heat exchanger for engine combustion and its heat
  transfer to a cooling circle.
</p>
<p>
  <b>Assumptions</b>
</p>
<p>
  The convective heat transfer between exhaust gas and heat exchanger
  is calculated as a cylindrical exhaust pipe. For the pipe
  cross-section, the connection cross-section of the power unit is
  used; the heat transfer area and the capacity of the heat exchanger
  can be calibrated.
</p>
<p>
  Known variables are the combustion air ratio and the heat flow to the
  cooling water circuit at nominal operation. These are used to
  estimate the pipe diameters if unknown.
</p>
<p>
  The heat transfer to the environment (G_Amb) and the cooling water
  circuit (G_Cool) is calculated by means of heat conduction.
</p>
<p>
  There is the option of considering the heat output from the
  condensation of water in the flue gas. This is determined from the
  determination of the precipitating water via the saturation vapour
  pressure and the critical loading in the flue gas for the critical
  state (at outlet temperature). The evaporation enthalpy is
  approximated using an empirical formula based on table data for
  ambient pressure.
</p>
<p>
  Simplifying it is assumed that the latent heat flux in addition to
  the convective heat flux is transferred to the capacity of the
  exhaust gas heat exchanger.
</p>
<ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
end ExhaustHeatExchanger;
