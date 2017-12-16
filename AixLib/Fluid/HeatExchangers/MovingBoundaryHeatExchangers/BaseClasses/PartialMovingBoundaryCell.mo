within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.BaseClasses;
partial model PartialMovingBoundaryCell
  "This model is a base class for all models describing moving boundary cells"

  // Definitions of parameters describing the type of the heat exchanger
  //
  parameter Utilities.Types.ApplicationHX appHX=
    Utilities.Types.ApplicationHX.Evaporator
    "Application of the heat exchangver (e.g. evaporator or condenser)"
    annotation (Dialog(tab="General",group="Parameters"));

  // Definition of records describing the cross-sectional geometry
  //
  inner replaceable parameter
    Utilities.Properties.GeometryHX geoCV
    "Record that contains geometric parameters of the heat exchanger"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Parameters"),
                Placement(transformation(extent={{-90,72},{-70,92}})));

  // Definition of parameters describing the void fraction
  //
  parameter Boolean useVoiFra = true
    "= true, if properties of two-phase regime are computed by void fraction"
    annotation (Dialog(tab="General",group="Void fraction"));
  parameter Boolean useVoiFraMod = true
    "= true, if model is used to calculate void fraction"
    annotation (Dialog(tab="General",group="Void fraction",
                enable = useVoiFra));
  parameter Real voiFraPar = 0.85
    "Constant void fraction if not calculated by model"
    annotation (Dialog(tab="General",group="Void fraction",
                enable = (not useVoiFraMod) or (useVoiFra)));
  replaceable model VoidFractionModel =
    Utilities.VoidFractions.Sangi2015
    constrainedby BaseClasses.PartialVoidFraction
    "Model describing calculation of void fraction"
    annotation (Dialog(tab="General",group="Void fraction",
                enable = (not useVoiFraMod) or (useVoiFra)),
                choicesAllMatching=true);

  // Definition of parameters describing the heat transfer calculations
  //
  parameter Boolean useHeaCoeMod = false
    "= true, if model is used to calculate coefficients of heat transfers"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient"));
  replaceable model CoefficientOfHeatTransferSC =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    constrainedby PartialCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer of the supercooled regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = useHeaCoeMod),
                choicesAllMatching=true);
  replaceable model CoefficientOfHeatTransferTP =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    constrainedby PartialCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer of the two-phase regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = useHeaCoeMod),
                choicesAllMatching=true);
  replaceable model CoefficientOfHeatTransferSH =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    constrainedby PartialCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer of the superheated regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = useHeaCoeMod),
                choicesAllMatching=true);

  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSC = 2000
    "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = not useHeaCoeMod));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpTP = 7500
    "Effective coefficient of heat transfer between the wall and fluid of the
    two-phase regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = not useHeaCoeMod));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSH = 2500
    "Effective coefficient of heat transfer between the wall and fluid of the
    superheated regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = not useHeaCoeMod));

  parameter Utilities.Types.CalculationHeatFlow
    heaFloCal = Utilities.Types.CalculationHeatFlow.E_NTU_Graeber
    "Choose the way of calculating the heat flow between the wall and medium"
    annotation (Dialog(tab="Heat transfer",group="Heat flow calculation"));

  // Extensions and propagation of parameters
  //
  extends AixLib.Fluid.Interfaces.PartialTwoPort(
    redeclare replaceable package Medium = Modelica.Media.R134a.R134a_ph);

  // Definition of parameters describing advanced options
  //
  parameter Medium.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation(Dialog(tab="Advanced",group="Nominal conditions"));
  parameter Medium.MassFlowRate m_flow_small= 1e-6*m_flow_nominal
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab="Advanced",group="Nominal conditions"));

  parameter Modelica.SIunits.AbsolutePressure pIni = 2e5
    "Start value of absolute pressure"
    annotation (Dialog(tab="Advanced",group="Initialisation"));
  parameter Modelica.SIunits.SpecificEnthalpy dhIni = 10
    "Difference between inlet and outlet enthalpies 
    (hInl = hOut+dh0) at initialisation"
    annotation (Dialog(tab="Advanced",group="Initialisation"));

  parameter Boolean useFixStaVal = false
    "= true, if start values are fixed"
    annotation (Dialog(tab="Advanced",group="Start values iteration"));
  parameter Real dhSCTPdtIni(unit="J/(kg.s)") = 1e-5
    "Guess value of dhSCTPdt"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Real dhTPSHtIni(unit="J/(kg.s)") = 1e-5
    "Guess value of dhTPSHdt"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Real dhOutdtIni(unit="J/(kg.s)") = 1e-5
    "Guess value of dhOutDesdt"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Real dlenSCdtIni(unit="1/s") = 1e-5
    "Guess value of dtlenSCdt"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Real dlenTPdtIni(unit="1/s") = 1e-5
    "Guess value of dlenTPdt"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Real dlenSHdtIni(unit="1/s") = 1e-5
    "Guess value of dlenSHdt"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Medium.MassFlowRate m_flow_startInl = 0.5*m_flow_nominal
    "Guess value of m_flow_startInl"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Medium.MassFlowRate m_flow_startSCTP = 0.5*m_flow_nominal
    "Guess value of m_flow_startSCTP"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Medium.MassFlowRate m_flow_startTPSH = 0.5*m_flow_nominal
    "Guess value of m_flow_startTPSH"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Medium.MassFlowRate m_flow_startOut = 0.5*m_flow_nominal
    "Guess value of m_flow_startOut"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));

  parameter Real lenMin(unit="1") = 1e-5
    "Minimum length of a control volume required to keep it activated"
    annotation(Dialog(tab="Advanced",group="Convergence"));
  parameter Real tauVoiFra(unit="s") = 125
    "Time constant to describe convergence of void fraction if flow state 
    changes"
    annotation(Dialog(tab="Advanced",group="Convergence"));

  parameter Boolean calBalEqu = true
    "= true, if balance equations are computed"
    annotation (Dialog(tab="Advanced",group="Diagnostics"));

  // Definition of subcomponents and connectors
  //
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortSC
    "Heat port of the heat exchange with wall of the supercooled regime"
    annotation (Placement(transformation(extent={{-36,90},{-16,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortTP
    "Heat port of the heat exchange with wall of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortSH
    "Heat port of the heat exchange with wall of the superheated regime"
    annotation (Placement(transformation(extent={{16,90},{36,110}})));

  Modelica.Blocks.Interfaces.RealOutput lenOut[3]
    "Lengths of the different regimes"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,104}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,100})));
  Utilities.Interfaces.ModeCVInput modCV
    "Current mode of the control volumes"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,104}),  iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={70,100})));

  Modelica.Blocks.Interfaces.RealOutput AlpThrSC(unit = "W/(m2.K)")
    "Dummy block used for transmission of coefficient of heat transfer of the
    supercooled regime if its model is conditionally removed";
  Modelica.Blocks.Interfaces.RealOutput AlpThrTP(unit = "W/(m2.K)")
    "Dummy block used for transmission of coefficient of heat transfer of the
    two-phase regime if its model is conditionally removed";
  Modelica.Blocks.Interfaces.RealOutput AlpThrSH(unit = "W/(m2.K)")
    "Dummy block used for transmission of coefficient of heat transfer of the
    superheated regime if its model is conditionally removed";

  Modelica.Blocks.Interfaces.RealOutput VoiFraIntThr(unit = "1")
    "Dummy block used for transmission of total void fraction of the
    two-phase regime if its model is conditionally removed";

  Modelica.Blocks.Interfaces.RealOutput VoiFraThr(unit = "1")
    "Dummy block used for transmission of void fraction of the
    two-phase regime if its model is conditionally removed";
  Modelica.Blocks.Interfaces.RealOutput VoiFraDerThr(unit = "1/s")
    "Dummy block used for transmission of the derivative of void fraction of the
    two-phase regime if its model is conditionally removed";

  // Definition of records describing thermodynamic states
  //
public
  Medium.ThermodynamicState SC = Medium.setState_phX(p=p,h=hSC)
    "Thermodynamic state of the supercooled regime"
    annotation (Placement(transformation(extent={{-50,-8},{-30,12}})));
  Medium.ThermodynamicState TP=Medium.setState_phX(p=p, h=hTP)
    "Thermodynamic state of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Medium.ThermodynamicState SH = Medium.setState_phX(p=p,h=hSH)
    "Thermodynamic state of the superheated regime"
    annotation (Placement(transformation(extent={{30,-8},{50,12}})));
  Medium.SaturationProperties TPSat=Medium.setSat_p(p=p)
    "Thermodynamic state of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));

  // Definition of variables describing thermodynamic states
  //
public
  Modelica.SIunits.AbsolutePressure p(stateSelect=StateSelect.prefer)
    "Pressure of the working fluid (assumed to be constant)";

  Modelica.SIunits.Temperature TInl = Medium.temperature_ph(p=p,h=hInl)
    "Temperature at the inlet of design direction";
  Modelica.SIunits.Temperature TSC = Medium.temperature(state=SC)
    "Temperature of the supercooled regime";
  Modelica.SIunits.Temperature TSCTP = Medium.temperature_ph(p=p,h=hSCTP)
    "Temperature at the boundary between the supercooled and two-phase 
    regime";
  Modelica.SIunits.Temperature TTP = Medium.temperature(state=TP)
    "Temperature of the two-phase regime";
  Modelica.SIunits.Temperature TTPSH = Medium.temperature_ph(p=p,h=hTPSH)
    "Temperature at the boundary between the two-phase and superheated 
    regime";
  Modelica.SIunits.Temperature TSH = Medium.temperature(state=SH)
    "Temperature of the superheated regime";
  Modelica.SIunits.Temperature TOut = Medium.temperature_ph(p=p,h=hOut)
    "Temperature at the outlet of design direction";

  Modelica.SIunits.Density dInlDes = Medium.density_ph(p=p,h=hInl)
    "Density at the inlet of design direction";
  Modelica.SIunits.Density dSC = Medium.density(state=SC)
    "Density of the supercooled regime";
  Modelica.SIunits.Density dSCTP = Medium.density_ph(p=p,h=hSCTP)
    "Density at the boundary between the supercooled and two-phase 
    regime";
  Modelica.SIunits.Density dTP = Medium.density(state=TP)
    "Density of the two-phase regime";
  Modelica.SIunits.Density dTPSH = Medium.density_ph(p=p,h=hTPSH)
    "Density at the boundary between the two-phase and superheated 
    regime";
  Modelica.SIunits.Density dSH = Medium.density(state=SH)
    "Density of the superheated regime";
  Modelica.SIunits.Density dOutDes = Medium.density_ph(p=p,h=hOut)
    "Density at the outlet of design direction";

  Modelica.SIunits.SpecificEnthalpy hInl
    "Specific enthalpy at the inlet of design direction";
  Modelica.SIunits.SpecificEnthalpy hSC
    "Specific enthalpy of the supercooled regime";
  Modelica.SIunits.SpecificEnthalpy hSCTP(stateSelect=StateSelect.prefer)
    "Specific enthalpy at the boundary between the supercooled and two-phase 
    regime";
  Modelica.SIunits.SpecificEnthalpy hTP
    "Specific enthalpy of the two-phase regime";
  Modelica.SIunits.SpecificEnthalpy hTPSH(stateSelect=StateSelect.prefer)
    "Specific enthalpy at the boundary between the two-phase and superheated 
    regime";
  Modelica.SIunits.SpecificEnthalpy hSH
    "Specific enthalpy of the superheated regime";
  Modelica.SIunits.SpecificEnthalpy hOut(stateSelect=StateSelect.prefer)
    "Specific enthalpy at the outlet of design direction";

  Modelica.SIunits.Density dLiq = Medium.bubbleDensity(sat=TPSat)
    "Density at bubble line";
  Modelica.SIunits.Density dVap = Medium.dewDensity(sat=TPSat)
    "Density at dew line";
  Modelica.SIunits.SpecificEnthalpy hLiq = Medium.bubbleEnthalpy(sat=TPSat)
    "Specific enthalpy at bubble line";
  Modelica.SIunits.SpecificEnthalpy hVap = Medium.dewEnthalpy(sat=TPSat)
    "Specific enthalpy at dew line";

  // Definition of variables describing the geometry of the control volumes
  //
public
  Real lenSC(stateSelect=if appHX==Utilities.Types.ApplicationHX.Evaporator then
    StateSelect.prefer else StateSelect.avoid)
    "Length of the supercooled control volume";
  Real lenTP(stateSelect=StateSelect.prefer)
    "Length of the two-phase control volume";
  Real lenSH(stateSelect=if appHX==Utilities.Types.ApplicationHX.Evaporator then
    StateSelect.never else StateSelect.prefer)
    "Length oft the superheated control volume";

  // Definition of variables describing mass and energy balances
  //
public
  Modelica.SIunits.MassFlowRate m_flow_inl(start=m_flow_startInl,
    fixed=useFixStaVal)
    "Mass flow rate flowing into the system";
  Modelica.SIunits.MassFlowRate m_flow_SCTP(start=m_flow_startSCTP,
    fixed=useFixStaVal)
    "Mass flow rate flowing out of the supercooled regime and into the two-phase
    regime";
  Modelica.SIunits.MassFlowRate m_flow_TPSH(start=m_flow_startTPSH,
    fixed=useFixStaVal)
    "Mass flow rate flowing out of the two-phase regime and into the superheated
    regime";
  Modelica.SIunits.MassFlowRate m_flow_out(start=m_flow_startOut,
    fixed=useFixStaVal)
    "Mass flow rate flowing out of the system";

  Real dlenSCdt(unit="1/s",start=dlenSCdtIni,fixed=useFixStaVal)
    "Derivative of length of control volume of supercooled regime wrt. time";
  Real dlenTPdt(unit="1/s",start=dlenTPdtIni,fixed=useFixStaVal)
    "Derivative of length of control volume of two-phase regime wrt. time";
  Real dlenSHdt(unit="1/s",start=dlenSHdtIni,fixed=useFixStaVal)
    "Derivative of length of control volume of superheated regime wrt. time";

  Real dhInldt(unit="J/(kg.s)",start=dhOutdtIni,fixed=useFixStaVal)
    "Derivative of specific enthalpy at inlet of design direction wrt. time";
  Real dhSCTPdt(unit="J/(kg.s)",start=dhSCTPdtIni,fixed=useFixStaVal)
    "Derivative of specific enthalpy at boundary between supercooled and 
    two-phase regime wrt. time";
  Real dhTPSHdt(unit="J/(kg.s)",start=dhTPSHtIni,fixed=useFixStaVal)
    "Derivative of specific enthalpy at boundary between two-phase and 
    superheated regime wrt. time";
  Real dhOutdt(unit="J/(kg.s)",start=dhOutdtIni,fixed=useFixStaVal)
    "Derivative of specific enthalpy at outlet of design direction wrt. time";

  Real ddSCdp(unit="kg/(m3.Pa)") = Medium.density_derp_h(state=SC)
    "Derivative of average density of supercooled regime wrt. pressure";
  Real ddSCdh(unit="kg2/(m3.J)") = Medium.density_derh_p(state=SC)
    "Derivative of average density of supercooled regime wrt. specific enthalpy";
  Real ddTPdp(unit="kg/(m3.Pa)") = Medium.density_derp_h(state=TP)
    "Derivative of average density of two-phase regime wrt. pressure";
  Real ddTPdh(unit="kg2/(m3.J)") = Medium.density_derh_p(state=TP)
    "Derivative of average density of two-phase regime wrt. specific enthalpy";
  Real ddSHdp(unit="kg/(m3.Pa)") = Medium.density_derp_h(state=SH)
    "Derivative of average density of superheated regime wrt. pressure";
  Real ddSHdh(unit="kg2/(m3.J)") = Medium.density_derh_p(state=SH)
    "Derivative of average density of superheated regime wrt. specific enthalpy";

  Real ddLiqdp(unit="kg/(m3.Pa)") = Medium.dBubbleDensity_dPressure(sat=TPSat)
    "Derivative of bubble density wrt. saturation pressure";
  Real ddVapdp(unit="kg/(m3.Pa)") = Medium.dDewDensity_dPressure(sat=TPSat)
    "Derivative of dew density wrt. saturation pressure";
  Real dhLiqdp(unit="J/(kg.Pa)") = Medium.dBubbleEnthalpy_dPressure(sat=TPSat)
    "Derivative of bubble enthalpy wrt. saturation pressure";
  Real dhVapdp(unit="J/(kg.Pa)") = Medium.dDewEnthalpy_dPressure(sat=TPSat)
    "Derivative of dew enthalpy wrt. saturation pressure";

  // Definition of variables describing the calculation of heat transfers
  //
public
  Modelica.SIunits.SpecificHeatCapacity cpSC = Medium.specificHeatCapacityCp(SC)
    "Density of the supercooled regime";
  Modelica.SIunits.SpecificHeatCapacity cpSH = Medium.specificHeatCapacityCp(SH)
    "Density of the superheated regime";

  Modelica.SIunits.ThermalConductance kASC
    "Effective thermal conductance of th supercooled regime";
  Modelica.SIunits.ThermalConductance kATP
    "Effective thermal conductance of th two-phase regime";
  Modelica.SIunits.ThermalConductance kASH
    "Effective thermal conductance of th superheated regime";

  Modelica.SIunits.TemperatureDifference dTSC
    "Temperature difference between the wall and the supercooled regime";
  Modelica.SIunits.TemperatureDifference dTTP
    "Temperature difference between the wall and the two-phase regime";
  Modelica.SIunits.TemperatureDifference dTSH
    "Temperature difference between the wall and the superheated regime";

protected
  Modelica.SIunits.HeatFlowRate Q_flow_SC
    "Heat flow rate from between the wall and the supercooled regime";
  Modelica.SIunits.HeatFlowRate Q_flow_TP
    "Heat flow rate from between the wall and the two-pahse regime";
  Modelica.SIunits.HeatFlowRate Q_flow_SH
    "Heat flow rate from between the wall and the superheated regime";

  // Definition of variables describing conservation of mass and energy
  //
public
  Utilities.Balances.MovingBoundaryConservation balEqu(
    mSC=geoCV.ACroSec*lenSC*dSC,
    mTP=geoCV.ACroSec*lenTP*dTP,
    mSH=geoCV.ACroSec*lenSH*dSH,
    dmSCdt=m_flow_inl - m_flow_SCTP,
    dmTPdt=m_flow_SCTP - m_flow_TPSH,
    dmSHdt=m_flow_TPSH - m_flow_out,
    USC=geoCV.ACroSec*lenSC*(dSC*hSC - p),
    UTP=geoCV.ACroSec*lenTP*(dTP*hTP - p),
    USH=geoCV.ACroSec*lenSH*(dSH*hSH - p),
    dUSCdt=m_flow_inl*hInl - m_flow_SCTP*hSCTP + Q_flow_SC + der(p)*geoCV.ACroSec
        *lenSC + p*geoCV.ACroSec*der(lenSC),
    dUTPdt=m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH + Q_flow_TP + der(p)*geoCV.ACroSec
        *lenTP + p*geoCV.ACroSec*der(lenTP),
    dUSHdt=m_flow_TPSH*hTPSH - m_flow_out*hOut + Q_flow_SH + der(p)*geoCV.ACroSec
        *lenSH - p*geoCV.ACroSec*(der(lenSC) + der(lenTP))) if
       calBalEqu
    "Model that computes mass and energy balances of the working fluid";

  // Definition of models calculating the coefficients of heat transfer
  //
public
  CoefficientOfHeatTransferSC coefficientOfHeatTransferSC(
    geoCV=geoCV) if useHeaCoeMod
    "Coefficient of heat transfer of the supercooled regime"
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  CoefficientOfHeatTransferTP coefficientOfHeatTransferTP(
    geoCV=geoCV) if useHeaCoeMod
    "Coefficient of heat transfer of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  CoefficientOfHeatTransferSH coefficientOfHeatTransferSH(
    geoCV=geoCV) if useHeaCoeMod
    "Coefficient of heat transfer of the superheated regime"
    annotation (Placement(transformation(extent={{30,20},{50,40}})));

  // Definition of model calculating the voidFraction
  //
public
  VoidFractionModel voidFractionModel(
    redeclare replaceable package Medium = Medium,
    tauVoiFra = tauVoiFra,
    modCV = modCV,
    p = p,
    hSCTP = hSCTP,
    hTPSH = hTPSH) if useVoiFraMod
    "Void fraction of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));


initial equation

  /*In the following, initial values are computed for state variables. 
    These variables are:

    lenSC:      Length of supercooled regime
    lenTP:      Length of two-phase regime
    lenSH:      Length of superheated regime
    hOut:       Specific enthalpy at inlet|outlet of design direction
    hSCTP:      Specific enthalpy at boundary between SC and TP
    hTPSH:      Specific enthalpy at boundary between TP and SH
    voiFra:     Mean void fraction
  */

  hOut = hInl + dhIni "Specific enthalpy at outlet of design direction";

  if modCV==Utilities.Types.ModeCV.SC then
    /* Supercooled */
    if appHX==Utilities.Types.ApplicationHX.Evaporator then
      lenSC = 1-2*lenMin "Length of supercooled regime";
      lenTP = lenMin "Length of two-phase regime";
      hSCTP = hTPSH "Specific enthalpy at boundary between SC and TP";
      hTPSH = hOut "Specific enthalpy at boundary between TP and SH";
    else
      lenTP = lenMin "Length of two-phase regime";
      lenSH = lenMin "Length of superheated regime";
      hSCTP = hTPSH "Specific enthalpy at boundary between SC and TP";
      hTPSH = hInl "Specific enthalpy at boundary between TP and SH";
    end if;
    if useVoiFraMod then
      VoiFraThr   = 0 "Mean void fraction";
    end if;

  elseif modCV==Utilities.Types.ModeCV.SCTP then
    /* Supercooled - Two-phase */
    if appHX==Utilities.Types.ApplicationHX.Evaporator then
      lenSC = (hLiq-hInl)/(hOut-hInl) "Length of supercooled regime";
      lenTP = 1-lenSC-lenMin "Length of two-phase regime";
      hSCTP = hLiq "Specific enthalpy at boundary between SC and TP";
      hTPSH = hOut "Specific enthalpy at boundary between TP and SH";
    else
      lenTP = 1-lenSH-lenMin "Length of two-phase regime";
      lenSH = lenMin "Length of superheated regime";
      hSCTP = hLiq "Specific enthalpy at boundary between SC and TP";
      hTPSH = hInl "Specific enthalpy at boundary between TP and SH";
    end if;
    if useVoiFraMod then
      VoiFraThr = VoiFraIntThr "Mean void fraction";
    end if;

  elseif modCV==Utilities.Types.ModeCV.TP then
    /* Two-phase */
    if appHX==Utilities.Types.ApplicationHX.Evaporator then
      lenSC = lenMin "Length of supercooled regime";
      lenTP = 1-2*lenMin "Length of two-phase regime";
      hSCTP = hInl "Specific enthalpy at boundary between SC and TP";
      hTPSH = hOut "Specific enthalpy at boundary between TP and SH";
    else
      lenTP = 1-2*lenMin "Length of two-phase regime";
      lenSH = lenMin "Length of superheated regime";
      hSCTP = hOut "Specific enthalpy at boundary between SC and TP";
      hTPSH = hInl "Specific enthalpy at boundary between TP and SH";
    end if;
    if useVoiFraMod then
      VoiFraThr = VoiFraIntThr "Mean void fraction";
    end if;

  elseif modCV==Utilities.Types.ModeCV.TPSH then
    /* Two-phase - Superheated */
    if appHX==Utilities.Types.ApplicationHX.Evaporator then
      lenSC = lenMin "Length of supercooled regime";
      lenTP = (hVap-hSCTP)/(hOut-hInl) "Length of two-phase regime";
      hSCTP = hInl "Specific enthalpy at boundary between SC and TP";
      hTPSH = hVap "Specific enthalpy at boundary between TP and SH";
    else
      lenTP = (hVap-hSCTP)/(hOut-hInl) "Length of two-phase regime";
      lenSH = 1-lenTP-lenMin "Length of superheated regime";
      hSCTP = hOut "Specific enthalpy at boundary between SC and TP";
      hTPSH = hVap "Specific enthalpy at boundary between TP and SH";
    end if;
    if useVoiFraMod then
      VoiFraThr = VoiFraIntThr "Mean void fraction";
    end if;

  elseif modCV==Utilities.Types.ModeCV.SH then
    /* Superheated */
    if appHX==Utilities.Types.ApplicationHX.Evaporator then
      lenSC = lenMin "Length of supercooled regime";
      lenTP = lenMin "Length of two-phase regime";
      hSCTP = hInl "Specific enthalpy at boundary between SC and TP";
      hTPSH = hSCTP "Specific enthalpy at boundary between TP and SH";
    else
      lenTP = lenMin "Length of two-phase regime";
      lenSH = 1-2*lenMin "Length of superheated regime";
      hSCTP = hOut "Specific enthalpy at boundary between SC and TP";
      hTPSH = hSCTP "Specific enthalpy at boundary between TP and SH";
    end if;
    if useVoiFraMod then
      VoiFraThr   = 1 "Mean void fraction";
    end if;

  else
    /* Supercooled - Two-phase - Superheated*/
    if appHX==Utilities.Types.ApplicationHX.Evaporator then
      lenSC = (hLiq-hInl)/(hOut-hInl) "Length of supercooled regime";
      lenTP = (hVap-hLiq)/(hOut-hInl) "Length of two-phase regime";
      hSCTP = hLiq "Specific enthalpy at boundary between SC and TP";
      hTPSH = hVap "Specific enthalpy at boundary between TP and SH";
    else
      lenSH = (hInl-hVap)/(hInl-hOut) "Length of superheated regime";
      lenTP = (hVap-hLiq)/(hInl-hOut) "Length of two-phase regime";
      hSCTP = hLiq "Specific enthalpy at boundary between SC and TP";
      hTPSH = hVap "Specific enthalpy at boundary between TP and SH";
    end if;
    if useVoiFraMod then
      VoiFraThr = VoiFraIntThr "Mean void fraction";
    end if;
  end if;


equation
  // Calculation of geometric constraints
  //
  1 = lenSC + lenTP + lenSH
    "Geometric constraint";

  // Connect variables with connectors
  //
  port_a.p = p
    "Pressure at port_a - Assuming no pressure losses";
  port_b.p = p
    "Pressure at port_b - Assuming no pressure losses";

  heatPortSC.Q_flow = Q_flow_SC
    "Heat flow rate between the wall and the supercooled regime";
  heatPortTP.Q_flow = Q_flow_TP
    "Heat flow rate between the wall and the two-phase regime";
  heatPortSH.Q_flow = Q_flow_SH
    "Heat flow rate between the wall and the superheated regime";

  lenOut = {lenSC,lenTP,lenSH}
    "Lengths of the control volumes";

  // Connect coefficients of heat transfers
  //
  if not useHeaCoeMod then
    AlpThrSC = AlpSC
      "Connect coefficient of heat transfer of supercooled regime given by
      parameter";
    AlpThrTP = AlpTP
      "Connect coefficient of heat transfer of two-phase regime given by
      parameter";
    AlpThrSH = AlpSH
      "Connect coefficient of heat transfer of superheated regime given by
      parameter";
  end if;

  connect(AlpThrSC,coefficientOfHeatTransferSC.Alp)
    "Connect coefficient of heat transfer of supercooled regime calculated by
    model";
  connect(AlpThrTP,coefficientOfHeatTransferTP.Alp)
    "Connect coefficient of heat transfer of two-phase regime calculated by
    model";
  connect(AlpThrSH,coefficientOfHeatTransferSH.Alp)
    "Connect coefficient of heat transfer of superheated regime calculated by
    model";

  // Connect void fraction
  //
  if not useVoiFraMod then
    VoiFraIntThr = voiFraPar
      "Connect total void fraction of two-phase regime given by parameter";
    VoiFraThr = voiFraPar
      "Connect void fraction of two-phase regime given by parameter";
    VoiFraDerThr = Modelica.Constants.small
      "Connect derivative of void fraction of two-phase regime given by 
      parameter";
  end if;

  connect(VoiFraIntThr,voidFractionModel.voiFraInt)
    "Connect total void fraction of two-phase regime given by model";
  connect(VoiFraThr,voidFractionModel.voiFra)
    "Connect void fraction of two-phase regime given by model";
  connect(VoiFraDerThr,voidFractionModel.voiFra_der)
    "Connect derivative of void fraction of two-phase regime given by model";

  // Calculation of state variables
  //
  der(hInl) = dhInldt
    "Derivative of specific enthalpy at inlet at design dircetion wrt. time";
  der(hSCTP) = dhSCTPdt
    "Derivative of specific enthalpy at boundary between supercooled and
    two-phase regime wrt. time";
  der(hTPSH) = dhTPSHdt
    "Derivative of specific enthalpy at boundary between two-phase and
    superheated regime wrt. time";
  der(hOut) = dhOutdt
    "Derivative of specific enthalpy at outlet at design dircetion wrt. time";

  dlenSCdt = der(lenSC)
    "Derivative of length of control volume of supercooled regime wrt. time";
  dlenTPdt = der(lenTP)
    "Derivative of length of control volume of two-phase regime wrt. time";
  dlenSHdt = der(lenSH)
    "Derivative of length of control volume of superheated regime wrt. time";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,70},{100,100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,70},{100,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-100},{100,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
  December 09, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This model is a base class for all secondary fluid cells
of a moving boundary heat exchanger. Therefore, this
models defines some connectors, parameters and submodels
that are required for all secondary fluid cells.
These basic definitions are listed below:
</p>
<ul>
<li>
Parameters describing the kind of heat exchanger.
</li>
<li>
Parameters describing the cross-sectional geometry.
</li>
<li>
Parameters describing the heat transfer calculations.
</li>
<li>
Definition of fluid and heat ports.
</li>
</ul>
<p>
Models that inherits from this base class are stored in
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.FluidCells\">
AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.GeometryHX.</a>
</p>
</html>"));
end PartialMovingBoundaryCell;
