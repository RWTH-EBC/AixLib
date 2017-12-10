within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.FluidCells;
model MovingBoundaryCellBackup
  "Model of a general moving boundary cell of the working fluid"
  extends BaseClasses.PartialMovingBoundaryCell;

  // Definition of records describing thermodynamic states
  //
public
  Medium.ThermodynamicState SC = Medium.setState_ph(p=p,h=hSC)
    "Thermodynamic state of the supercooled regime"
    annotation (Placement(transformation(extent={{-50,-8},{-30,12}})));
  Medium.SaturationProperties TP = Medium.setSat_p(p=p)
    "Thermodynamic state of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Medium.ThermodynamicState SH = Medium.setState_ph(p=p,h=hSH)
    "Thermodynamic state of the superheated regime"
    annotation (Placement(transformation(extent={{30,-8},{50,12}})));

  // Definition of variables describing thermodynamic states
  //
public
  Modelica.SIunits.AbsolutePressure p(stateSelect=StateSelect.prefer)
    "Pressure of the working fluid (assumed to be constant)";

  Modelica.SIunits.SpecificEnthalpy hInlDes(
     stateSelect=if appHX==Utilities.Types.ApplicationHX.Evaporator then
    StateSelect.avoid else StateSelect.prefer)
    "Specific enthalpy at the inlet of design direction";
  Modelica.SIunits.SpecificEnthalpy hSC
    "Specific enthalpy of the supercooled regime";
  Modelica.SIunits.SpecificEnthalpy hSCTP(stateSelect=StateSelect.prefer)
    "Specific enthalpy at the boundary between the supercooled and two-phase 
    regime";
  Modelica.SIunits.SpecificEnthalpy hTPSH(stateSelect=StateSelect.prefer)
    "Specific enthalpy at the boundary between the two-phase and superheated 
    regime";
  Modelica.SIunits.SpecificEnthalpy hSH
    "Specific enthalpy of the superheated regime";
  Modelica.SIunits.SpecificEnthalpy hOutDes(
     stateSelect=if appHX==Utilities.Types.ApplicationHX.Evaporator then
    StateSelect.prefer else StateSelect.avoid)
    "Specific enthalpy at the outlet of design direction";

  Modelica.SIunits.Density dLiq = Medium.bubbleDensity(sat=TP)
    "Density at bubble line";
  Modelica.SIunits.Density dVap = Medium.dewDensity(sat=TP)
    "Density at dew line";
  Modelica.SIunits.SpecificEnthalpy hLiq = Medium.bubbleEnthalpy(sat=TP)
    "Specific enthalpy at bubble line";
  Modelica.SIunits.SpecificEnthalpy hVap = Medium.dewEnthalpy(sat=TP)
    "Specific enthalpy at dew line";

  // Definition of variables describing the geometry of the control volumes
  //
public
  Real lenCV[3](
    stateSelect={StateSelect.prefer,StateSelect.prefer,StateSelect.never})
    "Length of the control volumes - SC - TP - SH";

  // Definition of variables describing mass and energy balances
  //
public
  Modelica.SIunits.MassFlowRate m_flow_inl
    "Mass flow rate flowing into the system";
  Modelica.SIunits.MassFlowRate m_flow_SCTP
    "Mass flow rate flowing out of the supercooled regime and into the two-phase
    regime";
  Modelica.SIunits.MassFlowRate m_flow_TPSH
    "Mass flow rate flowing out of the two-phase regime and into the superheated
    regime";
  Modelica.SIunits.MassFlowRate m_flow_out
    "Mass flow rate flowing out of the system";

  Real ddSCdp(unit="kg/(m3.Pa)") = Medium.density_derp_h(state=SC)
    "Derivative of average density of supercooled regime wrt. pressure";
  Real ddSCdh(unit="kg2/(m3.J)") = Medium.density_derh_p(state=SC)
    "Derivative of average density of supercooled regime wrt. specific enthalpy";
  Real ddSHdp(unit="kg/(m3.Pa)") = Medium.density_derp_h(state=SH)
    "Derivative of average density of superheated regime wrt. pressure";
  Real ddSHdh(unit="kg2/(m3.J)") = Medium.density_derh_p(state=SH)
    "Derivative of average density of superheated regime wrt. specific enthalpy";

  Real ddLiqdp(unit="kg/(m3.Pa)") = Medium.dBubbleDensity_dPressure(sat=TP)
    "Derivative of bubble density wrt. saturation pressure";
  Real ddVapdp(unit="kg/(m3.Pa)") = Medium.dDewDensity_dPressure(sat=TP)
    "Derivative of dew density wrt. saturation pressure";
  Real dhLiqdp(unit="J/(kg.Pa)") = Medium.dBubbleEnthalpy_dPressure(sat=TP)
    "Derivative of bubble enthalpy wrt. saturation pressure";
  Real dhVapdp(unit="J/(kg.Pa)") = Medium.dDewEnthalpy_dPressure(sat=TP)
    "Derivative of dew enthalpy wrt. saturation pressure";

  Real voiFra(unit="1")
    "Void fraction calculated by integration";

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
    p = p,
    hSCTP = hSCTP,
    hTPSH = hTPSH) if useVoiFraMod
    "Void fraction of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));

initial equation

  /*In the following, initial values are computed for state variables. 
    These variables are:

    lenCV[1]:         Length of supercooled regime
    lenCV[2]:         Length of two-phase regime
    hInlDes|hOutDes:  Specific enthalpy at inlet|outlet of design direction
    hSCTP:            Specific enthalpy at boundary between SC and TP
    hTPSH:            Specific enthalpy at boundary between TP and SH
    voiFra:           Mean void fraction
  */

  if appHX==Utilities.Types.ApplicationHX.Evaporator then
    /* Evaporator - Design direction */
    hOutDes = hInlDes + dhIni "Specific enthalpy at outlet of design direction";
  else
    /* Condenser - Reverse direction */
    hInlDes = hOutDes + dhIni "Specific enthalpy at inlet of design direction";
  end if;

  if modCV==Utilities.Types.ModeCV.SC then
    /* Supercooled */
    lenCV[1] = 1-2*lenMin "Length of supercooled regime";
    lenCV[2] = lenMin "Length of two-phase regime";
    hSCTP    = hSCTP "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hOutDes "Specific enthalpy at boundary between TP and SH";
    voiFra   = 0 "Mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.SCTP then
    /* Supercooled - Two-phase */
    lenCV[1] = (hLiq-hInlDes)/(hOutDes-hInlDes) "Length of supercooled regime";
    lenCV[2] = lenCV[1]-lenMin "Length of two-phase regime";
    hSCTP    = hLiq "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hOutDes "Specific enthalpy at boundary between TP and SH";
    voiFra   = VoiFraThr "Mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.TP then
    /* Two-phase */
    lenCV[1] = lenMin "Length of supercooled regime";
    lenCV[2] = 1-2*lenMin "Length of two-phase regime";
    hSCTP    = hInlDes "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hOutDes "Specific enthalpy at boundary between TP and SH";
    voiFra   = VoiFraThr "Mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.TPSH then
    /* Two-phase - Superheated */
    lenCV[1] = lenMin "Length of supercooled regime";
    lenCV[2] = (hVap-hInlDes)/(hOutDes-hInlDes) "Length of two-phase regime";
    hSCTP    = hInlDes "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hVap "Specific enthalpy at boundary between TP and SH";
    voiFra   = VoiFraThr "Mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.SH then
    /* Superheated */
    lenCV[1] = lenMin "Length of supercooled regime";
    lenCV[2] = lenMin "Length of two-phase regime";
    hSCTP    = hInlDes "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hSCTP "Specific enthalpy at boundary between TP and SH";
    voiFra   = 1 "Mean void fraction";
  else
    /* Supercooled - Two-phase - Superheated*/
    lenCV[1] = (hLiq-hInlDes)/(hOutDes-hInlDes) "Length of supercooled regime";
    lenCV[2] = (hVap-hLiq)/(hOutDes-hInlDes) "Length of two-phase regime";
    hSCTP    = hLiq "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hVap "Specific enthalpy at boundary between TP and SH";
    voiFra   = VoiFraThr "Mean void fraction";
  end if;

equation
  // Connect variables with connectors
  //
  port_a.p = p
    "Pressure at port_a - Assuming no pressure losses";
  port_b.p = p
    "Pressure at port_b - Assuming no pressure losses";
  port_a.m_flow = m_flow_inl
    "Mass flow rate at port_a";
  port_b.m_flow = -m_flow_out
    "Mass flow rate at port_b";
  port_a.h_outflow = hInlDes
    "Specific enthalpy flowing out of system at port_a - Condenser";
  port_b.h_outflow = hOutDes
    "Specific enthalpy flowing out of system at port_b - Evaporator";

  heatPortSC.Q_flow = Q_flow_SC
    "Heat flow rate between the wall and the supercooled regime";
  heatPortTP.Q_flow = Q_flow_TP
    "Heat flow rate between the wall and the two-phase regime";
  heatPortSH.Q_flow = Q_flow_SH
    "Heat flow rate between the wall and the superheated regime";

  lenOut = lenCV
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
    VoiFraThr = voiFraPar
      "Connect void fraction of two-phase regime given by parameter";
    VoiFraDerThr = Modelica.Constants.small
      "Connect derivative of void fraction of two-phase regime given by 
      parameter";
  end if;

  connect(VoiFraThr,voidFractionModel.voiFra)
    "Connect void fraction of two-phase regime given by model";
  connect(VoiFraDerThr,voidFractionModel.voiFra_der)
    "Connect derivative of void fraction of two-phase regime given by model";

  // Calculation of geometric constraints and state variables
  //
  1 = lenCV[1] + lenCV[2] + lenCV[3]
    "Geometric constraint";

  hSC = (hInlDes+hSCTP)/2
    "Specific enthalpy of the supercooled regime";
  hSH = (hTPSH+hOutDes)/2
    "Specific enthalpy of the superheated regime";

  if appHX==Utilities.Types.ApplicationHX.Evaporator then
    /* Evaporator - Design direction */
    hInlDes = inStream(port_a.h_outflow)
      "Specific enthalpy at the inlet of design direction";
  else
    /* Condenser - Reverse direction */
    hOutDes = inStream(port_b.h_outflow)
      "Specific enthalpy at the outlet of design direction";
  end if;

  if modCV==Utilities.Types.ModeCV.SC then
    /* Supercooled */
    der(hSCTP) = der(hTPSH)
      "Derivative of specific enthalpy at boundary between supercooled and 
      two-phase regime wrt. time";
    der(hTPSH) = der(hOutDes)
      "Derivative of specific enthalpy at boundary between two-phase and 
      superheated regime wrt. time";

  elseif modCV==Utilities.Types.ModeCV.SCTP then
    /* Supercooled - Two-phase */
    der(hSCTP) = dhLiqdp*der(p)
      "Derivative of specific enthalpy at boundary between supercooled and 
      two-phase regime wrt. time";
    der(hTPSH) = der(hOutDes)
      "Derivative of specific enthalpy at boundary between two-phase and 
      superheated regime wrt. time";

  elseif modCV==Utilities.Types.ModeCV.TP then
    /* Two-phase */
    der(hSCTP) = der(hInlDes)
      "Derivative of specific enthalpy at boundary between supercooled and 
      two-phase regime wrt. time";
    der(hTPSH) = der(hOutDes)
      "Derivative of specific enthalpy at boundary between two-phase and 
      superheated regime wrt. time";

  elseif modCV==Utilities.Types.ModeCV.TPSH then
    /* Two-phase - Superheated */
    der(hSCTP) = der(hTPSH)
      "Derivative of specific enthalpy at boundary between supercooled and 
      two-phase regime wrt. time";
    der(hTPSH) = dhVapdp*der(p)
      "Derivative of specific enthalpy at boundary between two-phase and 
      superheated regime wrt. time";

  elseif modCV==Utilities.Types.ModeCV.SH then
    /* Superheated */
    der(hSCTP) = der(hInlDes)
      "Derivative of specific enthalpy at boundary between supercooled and 
      two-phase regime wrt. time";
    der(hTPSH) = der(hSCTP)
      "Derivative of specific enthalpy at boundary between two-phase and 
      superheated regime wrt. time";

  else
    /* Supercooled - Two-phase - Superheated*/
    der(hSCTP) = dhLiqdp*der(p)
      "Derivative of specific enthalpy at boundary between supercooled and 
      two-phase regime wrt. time";
    der(hTPSH) = dhVapdp*der(p)
      "Derivative of specific enthalpy at boundary between two-phase and 
      superheated regime wrt. time";

  end if;

  // Calculation of mass balances
  //
  if modCV==Utilities.Types.ModeCV.SC then
    /* Supercooled */
    m_flow_inl - m_flow_SCTP = geoCV.ACroSec*geoCV.l *
      (lenCV[1]*(ddSCdp*der(p) +  1/2*ddSCdh*(der(hInlDes)+der(hSCTP))) +
      SC.d*der(lenCV[1]) -
      Medium.density_ph(p=p,h=hSCTP)*der(lenCV[1]))
      "Mass balance of supercooled regime";

    m_flow_SCTP - m_flow_TPSH = 0
      "Mass balance of supercooled regime";

    m_flow_TPSH - m_flow_out = 0
      "Mass balance of supercooled regime";

  elseif modCV==Utilities.Types.ModeCV.SCTP then
    /* Supercooled - Two-phase */
    m_flow_inl - m_flow_SCTP = geoCV.ACroSec*geoCV.l *
      (lenCV[1]*(ddSCdp*der(p) +  1/2*ddSCdh*(der(hInlDes)+der(hSCTP))) +
      SC.d*der(lenCV[1]) -
      Medium.bubbleDensity(TP)*der(lenCV[1]))
      "Mass balance of supercooled regime";

    m_flow_SCTP - m_flow_TPSH = geoCV.ACroSec*geoCV.l *
      ((voiFra*dVap+(1-voiFra)*dLiq)*der(lenCV[2]) +
      der(lenCV[2])*((dVap-dLiq)*der(voiFra) + voiFra*ddVapdp*der(p) +
      (1-voiFra)*ddLiqdp*der(p)) +
      Medium.bubbleDensity(TP)*der(lenCV[1]) -
      Medium.density_ph(p=p,h=hTPSH)*(der(lenCV[1])+der(lenCV[2])))
      "Mass balance of two-phase regime";

    m_flow_TPSH - m_flow_out = 0
      "Mass balance of superheated regime";

  elseif modCV==Utilities.Types.ModeCV.TP then
    /* Two-phase */
    m_flow_inl - m_flow_SCTP = 0
      "Mass balance of supercooled regime";

    m_flow_SCTP - m_flow_TPSH = geoCV.ACroSec*geoCV.l *
      ((voiFra*dVap+(1-voiFra)*dLiq)*der(lenCV[2]) +
      der(lenCV[2])*((dVap-dLiq)*der(voiFra) + voiFra*ddVapdp*der(p) +
      (1-voiFra)*ddLiqdp*der(p)) +
      Medium.density_ph(p=p,h=hSCTP)*der(lenCV[1]) -
      Medium.density_ph(p=p,h=hTPSH)*(der(lenCV[1])+der(lenCV[2])))
      "Mass balance of two-phase regime";

    m_flow_TPSH - m_flow_out = 0
      "Mass balance of superheated regime";

  elseif modCV==Utilities.Types.ModeCV.TPSH then
    /* Two-phase - Superheated */
    m_flow_inl - m_flow_SCTP = 0
      "Mass balance of supercooled regime";

    m_flow_SCTP - m_flow_TPSH = geoCV.ACroSec*geoCV.l *
      ((voiFra*dVap+(1-voiFra)*dLiq)*der(lenCV[2]) +
      der(lenCV[2])*((dVap-dLiq)*der(voiFra) + voiFra*ddVapdp*der(p) +
      (1-voiFra)*ddLiqdp*der(p)) +
      Medium.density_ph(p=p,h=hSCTP)*der(lenCV[1]) -
      Medium.dewDensity(TP)*(der(lenCV[1])+der(lenCV[2])))
      "Mass balance of two-phase regime";

    m_flow_TPSH - m_flow_out = geoCV.ACroSec*geoCV.l *
      (lenCV[3]*(ddSHdp*der(p) +  1/2*ddSHdh*(der(hTPSH)+der(hOutDes))) -
      SH.d*(der(lenCV[1])+der(lenCV[2])) +
      Medium.dewDensity(TP)*(der(lenCV[1])+der(lenCV[2])))
      "Mass balance of superheated regime";

  elseif modCV==Utilities.Types.ModeCV.SH then
    /* Superheated */
    m_flow_inl - m_flow_SCTP = 0
      "Mass balance of supercooled regime";

    m_flow_SCTP - m_flow_TPSH = 0
      "Mass balance of two-phase regime";

    m_flow_TPSH - m_flow_out = geoCV.ACroSec*geoCV.l *
      (lenCV[3]*(ddSHdp*der(p) +  1/2*ddSHdh*(der(hTPSH)+der(hOutDes))) -
      SH.d*(der(lenCV[1])+der(lenCV[2])) +
      Medium.density_ph(p=p,h=hTPSH)*(der(lenCV[1])+der(lenCV[2])))
      "Mass balance of superheated regime";

  else
    /* Supercooled - Two-phase - Superheated*/
    m_flow_inl - m_flow_SCTP = geoCV.ACroSec*geoCV.l *
      (lenCV[1]*(ddSCdp*der(p) +  1/2*ddSCdh*(der(hInlDes)+der(hSCTP))) +
      SC.d*der(lenCV[1]) -
      Medium.bubbleDensity(TP)*der(lenCV[1]))
      "Mass balance of supercooled regime";

    m_flow_SCTP - m_flow_TPSH = geoCV.ACroSec*geoCV.l *
      ((voiFra*dVap+(1-voiFra)*dLiq)*der(lenCV[2]) +
      der(lenCV[2])*((dVap-dLiq)*der(voiFra) + voiFra*ddVapdp*der(p) +
      (1-voiFra)*ddLiqdp*der(p)) +
      Medium.bubbleDensity(TP)*der(lenCV[1]) -
      Medium.dewDensity(TP)*(der(lenCV[1])+der(lenCV[2])))
      "Mass balance of two-phase regime";

    m_flow_TPSH - m_flow_out = geoCV.ACroSec*geoCV.l *
      (lenCV[3]*(ddSHdp*der(p) +  1/2*ddSHdh*(der(hTPSH)+der(hOutDes))) -
      SH.d*(der(lenCV[1])+der(lenCV[2])) +
      Medium.dewDensity(TP)*(der(lenCV[1])+der(lenCV[2])))
      "Mass balance of superheated regime";

  end if;

  // Calculation of energy balances
  //
  if modCV==Utilities.Types.ModeCV.SC then
    /* Supercooled */
    m_flow_inl*hInlDes - m_flow_SCTP*hSCTP + Q_flow_SC = geoCV.ACroSec*geoCV.l *
      (SC.d*SC.h*der(lenCV[1]) +
      SC.d*lenCV[1]*1/2*(der(hInlDes)+der(hSCTP)) +
      SC.h*lenCV[1]*(ddSCdp*der(p) + 1/2*ddSCdh*(der(hInlDes)+der(hSCTP))) -
      lenCV[1]*der(p) -
      Medium.density_ph(p=p,h=hSCTP)*hSCTP*der(lenCV[1]))
      "Energy balance of supercooled regime";

    der(lenCV[2]) = 0
      "Energy balance of two-phase regime";

    der(lenCV[1])+der(lenCV[2]) = 0
      "Energy balance of superheated regime";

  elseif modCV==Utilities.Types.ModeCV.SCTP then
    /* Supercooled - Two-phase */
    m_flow_inl*hInlDes - m_flow_SCTP*hSCTP + Q_flow_SC = geoCV.ACroSec*geoCV.l *
      (SC.d*SC.h*der(lenCV[1]) +
      SC.d*lenCV[1]*1/2*(der(hInlDes)+der(hSCTP)) +
      SC.h*lenCV[1]*(ddSCdp*der(p) + 1/2*ddSCdh*(der(hInlDes)+der(hSCTP))) -
      lenCV[1]*der(p) -
      Medium.bubbleDensity(TP)*hSCTP*der(lenCV[1]))
      "Energy balance of supercooled regime";

    m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH  + Q_flow_TP = geoCV.ACroSec*geoCV.l *
      ((voiFra*dVap*hVap+(1-voiFra)*dLiq*hLiq)*der(lenCV[2]) +
      der(lenCV[2])*((dVap*hVap-dLiq*hLiq)*der(voiFra) +
      voiFra*hVap*ddVapdp*der(p) + (1-voiFra)*hLiq*ddLiqdp*der(p) +
      voiFra*dVap*dhVapdp*der(p) + (1-voiFra)*dLiq*dhLiqdp*der(p)) -
      lenCV[2]*der(p) +
      Medium.bubbleDensity(TP)*hSCTP*der(lenCV[1]) -
      Medium.density_ph(p=p,h=hTPSH)*hTPSH*(der(lenCV[1])+der(lenCV[2])))
      "Energy balance of two-phase regime";

    der(lenCV[1])+der(lenCV[2]) = 0
      "Energy balance of superheated regime";

  elseif modCV==Utilities.Types.ModeCV.TP then
    /* Two-phase */
    der(lenCV[1]) = 0
      "Energy balance of supercooled regime";

    m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH  + Q_flow_TP = geoCV.ACroSec*geoCV.l *
      ((voiFra*dVap*hVap+(1-voiFra)*dLiq*hLiq)*der(lenCV[2]) +
      der(lenCV[2])*((dVap*hVap-dLiq*hLiq)*der(voiFra) +
      voiFra*hVap*ddVapdp*der(p) + (1-voiFra)*hLiq*ddLiqdp*der(p) +
      voiFra*dVap*dhVapdp*der(p) + (1-voiFra)*dLiq*dhLiqdp*der(p)) -
      lenCV[2]*der(p) +
      Medium.density_ph(p=p,h=hSCTP)*hSCTP*der(lenCV[1]) -
      Medium.density_ph(p=p,h=hTPSH)*hTPSH*(der(lenCV[1])+der(lenCV[2])))
      "Energy balance of two-phase regime";

    der(lenCV[1])+der(lenCV[2]) = 0
      "Energy balance of superheated regime";

  elseif modCV==Utilities.Types.ModeCV.TPSH then
    /* Two-phase - Superheated */
    der(lenCV[1]) = 0
      "Energy balance of supercooled regime";

    m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH  + Q_flow_TP = geoCV.ACroSec*geoCV.l *
      ((voiFra*dVap*hVap+(1-voiFra)*dLiq*hLiq)*der(lenCV[2]) +
      der(lenCV[2])*((dVap*hVap-dLiq*hLiq)*der(voiFra) +
      voiFra*hVap*ddVapdp*der(p) + (1-voiFra)*hLiq*ddLiqdp*der(p) +
      voiFra*dVap*dhVapdp*der(p) + (1-voiFra)*dLiq*dhLiqdp*der(p)) -
      lenCV[2]*der(p) +
      Medium.density_ph(p=p,h=hSCTP)*hSCTP*der(lenCV[1]) -
      Medium.dewDensity(TP)*hTPSH*(der(lenCV[1])+der(lenCV[2])))
      "Energy balance of two-phase regime";

    m_flow_TPSH*hTPSH - m_flow_out*hOutDes + Q_flow_SH = geoCV.ACroSec*geoCV.l *
      (-SH.d*SH.h*(der(lenCV[1])+der(lenCV[2])) +
      SH.d*lenCV[3]*1/2*(der(hTPSH)+ der(hOutDes)) +
      SH.h*lenCV[3]*(ddSHdp*der(p) + 1/2*ddSHdh*(der(hTPSH) + der(hOutDes))) -
      lenCV[3]*der(p) +
      Medium.dewDensity(TP)*hTPSH*(der(lenCV[1])+der(lenCV[2])))
      "Energy balance of superheated regime";

  elseif modCV==Utilities.Types.ModeCV.SH then
    /* Superheated */
    der(lenCV[1]) = 0
      "Energy balance of supercooled regime";

    der(lenCV[2]) = 0
      "Energy balance of two-phase regime";

    m_flow_TPSH*hTPSH - m_flow_out*hOutDes + Q_flow_SH = geoCV.ACroSec*geoCV.l *
      (-SH.d*SH.h*(der(lenCV[1])+der(lenCV[2])) +
      SH.d*lenCV[3]*1/2*(der(hTPSH)+ der(hOutDes)) +
      SH.h*lenCV[3]*(ddSHdp*der(p) + 1/2*ddSHdh*(der(hTPSH) + der(hOutDes))) -
      lenCV[3]*der(p) +
      Medium.density_ph(p=p,h=hTPSH)*hTPSH*(der(lenCV[1])+der(lenCV[2])))
      "Energy balance of superheated regime";

  else
    /* Supercooled - Two-phase - Superheated*/
    m_flow_inl*hInlDes - m_flow_SCTP*hSCTP + Q_flow_SC = geoCV.ACroSec*geoCV.l *
      (SC.d*SC.h*der(lenCV[1]) +
      SC.d*lenCV[1]*1/2*(der(hInlDes)+der(hSCTP)) +
      SC.h*lenCV[1]*(ddSCdp*der(p) + 1/2*ddSCdh*(der(hInlDes)+der(hSCTP))) -
      lenCV[1]*der(p) -
      Medium.bubbleDensity(TP)*hSCTP*der(lenCV[1]))
      "Energy balance of supercooled regime";

    m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH  + Q_flow_TP = geoCV.ACroSec*geoCV.l *
      ((voiFra*dVap*hVap+(1-voiFra)*dLiq*hLiq)*der(lenCV[2]) +
      der(lenCV[2])*((dVap*hVap-dLiq*hLiq)*der(voiFra) +
      voiFra*hVap*ddVapdp*der(p) + (1-voiFra)*hLiq*ddLiqdp*der(p) +
      voiFra*dVap*dhVapdp*der(p) + (1-voiFra)*dLiq*dhLiqdp*der(p)) -
      lenCV[2]*der(p) +
      Medium.bubbleDensity(TP)*hSCTP*der(lenCV[1]) -
      Medium.dewDensity(TP)*hTPSH*(der(lenCV[1])+der(lenCV[2])))
      "Energy balance of two-phase regime";

    m_flow_TPSH*hTPSH - m_flow_out*hOutDes + Q_flow_SH = geoCV.ACroSec*geoCV.l *
      (-SH.d*SH.h*(der(lenCV[1])+der(lenCV[2])) +
      SH.d*lenCV[3]*1/2*(der(hTPSH)+ der(hOutDes)) +
      SH.h*lenCV[3]*(ddSHdp*der(p) + 1/2*ddSHdh*(der(hTPSH) + der(hOutDes))) -
      lenCV[3]*der(p) +
      Medium.dewDensity(TP)*hTPSH*(der(lenCV[1])+der(lenCV[2])))
      "Energy balance of superheated regime";

  end if;

  // Calculation of heat flow rates
  //
  Q_flow_SC = kASC*dTSC
    "Heat flow rate between the wall and the supercooled regime";
  Q_flow_TP = kATP*dTTP
    "Heat flow rate between the wall and the two-phase regime";
  Q_flow_SH = kASH*dTSH
    "Heat flow rate between the wall and the superheated regime";

  // Calculation of effective coefficients of heat transfer
  //
  if heaFloCal==Utilities.Types.CalculationHeatFlow.Simplified then
    /* Simplified - Mean temperature differece */

    kASC = AlpThrSC * geoCV.AHeaTra*lenCV[1]
      "Effective thermal conductance of th supercooled regime";
    kATP = AlpThrTP * geoCV.AHeaTra*lenCV[2]
      "Effective thermal conductance of th two-phase regime";
    kASH = AlpThrSH * geoCV.AHeaTra*lenCV[3]
      "Effective thermal conductance of th superheated regime";

    dTSC = heatPortSC.T-SC.T
      "Temperature difference between the wall and the supercooled regime";
    dTTP = heatPortTP.T-TP.Tsat
      "Temperature difference between the wall and the two-phase regime";
    dTSH = heatPortSH.T-SH.T
      "Temperature difference between the wall and the superheated regime";

  elseif heaFloCal==Utilities.Types.CalculationHeatFlow.E_NTU then
    /* Epsilon-NTU - Method of number of transfer units */

    kATP = AlpThrTP * geoCV.AHeaTra*lenCV[2]
      "Effective thermal conductance of th two-phase regime";
    dTTP = heatPortTP.T-TP.Tsat
      "Temperature difference between the wall and the two-phase regime";

    if appHX==Utilities.Types.ApplicationHX.Evaporator then
      /* Evaporator - Design direction */

      kASC = AlpThrSC * geoCV.AHeaTra*lenCV[1]
        "Effective thermal conductance of th supercooled regime";
      kASH = max(abs(m_flow_out)*cpSH,1e-8) * (1 - exp(-AlpThrSH *
        geoCV.AHeaTra*lenCV[3]/max(abs(m_flow_out)*cpSH,1e-8)))
        "Effective thermal conductance of th superheated regime";
      dTSC = heatPortSC.T-Medium.temperature_ph(p=p,h=hSCTP)
        "Temperature difference between the wall and the supercooled regime";
                                                            //SC.T
      dTSH = heatPortSH.T-Medium.temperature_ph(p=p,h=hOutDes)
        "Temperature difference between the wall and the superheated regime";
                                                              //TP.Tsat

    else
      /* Condenser - Reverse direction */

      kASC = max(abs(m_flow_inl)*cpSC,1e-8) * (1 - exp(-AlpThrSC *
        geoCV.AHeaTra*lenCV[1]/max(abs(m_flow_inl)*cpSC,1e-8)))
        "Effective thermal conductance of th supercooled regime";
      kASH = AlpThrSH * geoCV.AHeaTra*lenCV[3]
        "Effective thermal conductance of th superheated regime";
      dTSC = heatPortSC.T-Medium.temperature_ph(p=p,h=hInlDes)
        "Temperature difference between the wall and the supercooled regime";
                                                              //TP.Tsat
      dTSH = heatPortSH.T-Medium.temperature_ph(p=p,h=hTPSH)
        "Temperature difference between the wall and the superheated regime";
                                                            //SH.T
    end if;

    /*The Epsilon-NTU approach is just implemented for one regime in order to
      reduce model complexity. This approach is proposed by Gräber (2013).
    */

  else
    /*Assert warning if currrent approach of calculating heat transfers is not
      implemented!
    */
    assert(false, "Current method of calculating the heat flow rates is not 
      supported! Please change calculation method!");

  end if;

  // Calculation of void fraction
  //
  if modCV==Utilities.Types.ModeCV.SC then
    /* Supercooled */
    der(voiFra) = (0-voiFra)/tauVoiFra "Mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.SCTP then
    /* Supercooled - Two-phase */
    der(voiFra) = (VoiFraThr-voiFra)/tauVoiFra "Mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.TP then
    /* Two-phase */
    der(voiFra) = (1-voiFra)/tauVoiFra "Mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.TPSH then
    /* Two-phase - Superheated */
    der(voiFra) = (VoiFraThr-voiFra)/tauVoiFra "Mean void fraction";
  elseif modCV==Utilities.Types.ModeCV.SH then
    /* Superheated */
    der(voiFra) = (1-voiFra)/tauVoiFra "Mean void fraction";
  else
    /* Supercooled - Two-phase - Superheated*/
    der(voiFra) = (VoiFraThr-voiFra)/tauVoiFra "Mean void fraction";
  end if;

  annotation (Diagram(graphics={
        Line(
          points={{-60,-62},{60,-62}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{60,-82},{-60,-82}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Text(
          extent={{-60,-42},{60,-62}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255},
          textString="Design direction - Heat exchanger works as evaporator"),
        Text(
          extent={{-60,-62},{60,-82}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255},
          textString="Reverse direction - Heat exchanger works as condenser")}),
      Documentation(revisions="<html>
<ul>
  <li>
  December 09, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>"),
    Icon(graphics={
        Line(
          points={{-38,70},{-56,52},{-32,28},{-50,4},{-26,-26},{-48,-52},{-40,-70}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Text(
          extent={{-32,-26},{36,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag,
          textString="TP"),
        Line(
          points={{38,70},{20,52},{44,28},{26,4},{50,-26},{28,-52},{36,-70}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier)}));
end MovingBoundaryCellBackup;
