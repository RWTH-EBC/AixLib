within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.FluidCells;
model MovingBoundaryCell
  "Model of a general moving boundary cell of the working fluid"
  extends BaseClasses.PartialMovingBoundaryCell;

  // Definition of records describing thermodynamic states
  //
public
  Medium.ThermodynamicState SC = Medium.setState_phX(p=p,h=hSC)
    "Thermodynamic state of the supercooled regime"
    annotation (Placement(transformation(extent={{-50,-8},{-30,12}})));
  Medium.SaturationProperties TP = Medium.setSat_p(p=p)
    "Thermodynamic state of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Medium.ThermodynamicState SH = Medium.setState_phX(p=p,h=hSH)
    "Thermodynamic state of the superheated regime"
    annotation (Placement(transformation(extent={{30,-8},{50,12}})));

  // Definition of variables describing thermodynamic states
  //
public
  Modelica.SIunits.AbsolutePressure p(stateSelect=StateSelect.prefer)
    "Pressure of the working fluid (assumed to be constant)";

  Modelica.SIunits.Temperature TInlDes = Medium.temperature_ph(p=p,h=hInlDes)
    "Temperature at the inlet of design direction";
  Modelica.SIunits.Temperature TSC = Medium.temperature(state=SC)
    "Temperature of the supercooled regime";
  Modelica.SIunits.Temperature TSCTP = Medium.temperature_ph(p=p,h=hSCTP)
    "Temperature at the boundary between the supercooled and two-phase 
    regime";
  Modelica.SIunits.Temperature TTP = Medium.saturationTemperature(p=p)
    "Temperature of the two-phase regime";
  Modelica.SIunits.Temperature TTPSH = Medium.temperature_ph(p=p,h=hTPSH)
    "Temperature at the boundary between the two-phase and superheated 
    regime";
  Modelica.SIunits.Temperature TSH = Medium.temperature(state=SH)
    "Temperature of the superheated regime";
  Modelica.SIunits.Temperature TOutDes = Medium.temperature_ph(p=p,h=hOutDes)
    "Temperature at the outlet of design direction";

  Modelica.SIunits.Density dInlDes = Medium.density_ph(p=p,h=hInlDes)
    "Density at the inlet of design direction";
  Modelica.SIunits.Density dSC = Medium.density(state=SC)
    "Density of the supercooled regime";
  Modelica.SIunits.Density dSCTP = Medium.density_ph(p=p,h=hSCTP)
    "Density at the boundary between the supercooled and two-phase 
    regime";
  Modelica.SIunits.Density dTP = VoiFraThr*dVap + (1-VoiFraThr)*dLiq
    "Density of the two-phase regime";
  Modelica.SIunits.Density dTPSH = Medium.density_ph(p=p,h=hTPSH)
    "Density at the boundary between the two-phase and superheated 
    regime";
  Modelica.SIunits.Density dSH = Medium.density(state=SH)
    "Density of the superheated regime";
  Modelica.SIunits.Density dOutDes = Medium.density_ph(p=p,h=hOutDes)
    "Density at the outlet of design direction";

  Modelica.SIunits.SpecificEnthalpy hInlDes(
     stateSelect=if appHX==Utilities.Types.ApplicationHX.Evaporator then
    StateSelect.avoid else StateSelect.prefer)
    "Specific enthalpy at the inlet of design direction";
  Modelica.SIunits.SpecificEnthalpy hSC
    "Specific enthalpy of the supercooled regime";
  Modelica.SIunits.SpecificEnthalpy hSCTP(stateSelect=StateSelect.prefer)
    "Specific enthalpy at the boundary between the supercooled and two-phase 
    regime";
  Modelica.SIunits.SpecificEnthalpy hTP = VoiFraThr*hVap + (1-VoiFraThr)*hLiq
    "Density of the two-phase regime";
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
  Real lenSC(stateSelect=StateSelect.prefer)
    "Length of the supercooled control volume";
  Real lenTP(stateSelect=StateSelect.prefer)
    "Length of the two-phase control volume";
  Real lenSH(stateSelect=StateSelect.never)
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

  Real dhInlDesdt(unit="J/(kg.s)",start=dhOutDesdtIni,fixed=useFixStaVal)
    "Derivative of specific enthalpy at inlet of design direction wrt. time";
  Real dhSCTPdt(unit="J/(kg.s)",start=dhSCTPdtIni,fixed=useFixStaVal)
    "Derivative of specific enthalpy at boundary between supercooled and 
    two-phase regime wrt. time";
  Real dhTPSHdt(unit="J/(kg.s)",start=dhTPSHtIni,fixed=useFixStaVal)
    "Derivative of specific enthalpy at boundary between two-phase and 
    superheated regime wrt. time";
  Real dhOutDesdt(unit="J/(kg.s)",start=dhOutDesdtIni,fixed=useFixStaVal)
    "Derivative of specific enthalpy at outlet of design direction wrt. time";

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
    tauVoiFra=tauVoiFra,
    modCV=modCV,
    p = p,
    hSCTP = hSCTP,
    hTPSH = hTPSH) if useVoiFraMod
    "Void fraction of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));


initial equation

  /*In the following, initial values are computed for state variables. 
    These variables are:

    lenSC:         Length of supercooled regime
    lenTP:         Length of two-phase regime
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
    lenSC = 1-2*lenMin "Length of supercooled regime";
    lenTP = lenMin "Length of two-phase regime";
    hSCTP    = hTPSH "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hOutDes "Specific enthalpy at boundary between TP and SH";
    if useVoiFraMod then
      VoiFraThr   = 0 "Mean void fraction";
    end if;
  elseif modCV==Utilities.Types.ModeCV.SCTP then
    /* Supercooled - Two-phase */
    lenSC = (hLiq-hInlDes)/(hOutDes-hInlDes) "Length of supercooled regime";
    lenTP = lenSC-lenMin "Length of two-phase regime";
    hSCTP    = hLiq "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hOutDes "Specific enthalpy at boundary between TP and SH";
    if useVoiFraMod then
      VoiFraThr   = 0.85;//VoiFraIntThr "Mean void fraction";
    end if;
  elseif modCV==Utilities.Types.ModeCV.TP then
    /* Two-phase */
    lenSC = lenMin "Length of supercooled regime";
    lenTP = 1-2*lenMin "Length of two-phase regime";
    hSCTP    = hInlDes "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hOutDes "Specific enthalpy at boundary between TP and SH";
    if useVoiFraMod then
      VoiFraThr   = 0.85;//VoiFraIntThr "Mean void fraction";
    end if;
  elseif modCV==Utilities.Types.ModeCV.TPSH then
    /* Two-phase - Superheated */
    lenSC = lenMin "Length of supercooled regime";
    lenTP = (hVap-hInlDes)/(hOutDes-hInlDes) "Length of two-phase regime";
    hSCTP    = hInlDes "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hVap "Specific enthalpy at boundary between TP and SH";
    if useVoiFraMod then
      VoiFraThr   = 0.85;//VoiFraIntThr "Mean void fraction";
    end if;
  elseif modCV==Utilities.Types.ModeCV.SH then
    /* Superheated */
    lenSC = lenMin "Length of supercooled regime";
    lenTP = lenMin "Length of two-phase regime";
    hSCTP    = hInlDes "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hSCTP "Specific enthalpy at boundary between TP and SH";
    if useVoiFraMod then
      VoiFraThr   = 1 "Mean void fraction";
    end if;
  else
    /* Supercooled - Two-phase - Superheated*/
    lenSC = (hLiq-hInlDes)/(hOutDes-hInlDes) "Length of supercooled regime";
    lenTP = (hVap-hLiq)/(hOutDes-hInlDes) "Length of two-phase regime";
    hSCTP    = hLiq "Specific enthalpy at boundary between SC and TP";
    hTPSH    = hVap "Specific enthalpy at boundary between TP and SH";
    if useVoiFraMod then
      VoiFraThr   = 0.85;//VoiFraIntThr "Mean void fraction";
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

  port_a.m_flow = m_flow_inl
    "Mass flow rate at port_a";
  port_b.m_flow = -m_flow_out
    "Mass flow rate at port_b (equations are written wrt. design direction)";

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
  if appHX==Utilities.Types.ApplicationHX.Evaporator then
    /* Evaporator - Design direction */
    hInlDes = inStream(port_a.h_outflow)
      "Specific enthalpy at the inlet of design direction";
  else
    /* Condenser - Reverse direction */
    hOutDes = inStream(port_b.h_outflow)
      "Specific enthalpy at the outlet of design direction";
  end if;

  hSC = (hInlDes+hSCTP)/2
    "Specific enthalpy of the supercooled regime";
  hSH = (hTPSH+hOutDes)/2
    "Specific enthalpy of the superheated regime";

  der(hInlDes) = dhInlDesdt
    "Derivative of specific enthalpy at inlet at design dircetion wrt. time";
  der(hSCTP) = dhSCTPdt
    "Derivative of specific enthalpy at boundary between supercooled and
    two-phase regime wrt. time";
  der(hTPSH) = dhTPSHdt
    "Derivative of specific enthalpy at boundary between two-phase and
    superheated regime wrt. time";
  der(hOutDes) = dhOutDesdt
    "Derivative of specific enthalpy at outlet at design dircetion wrt. time";

  dlenSCdt = der(lenSC)
    "Derivative of length of control volume of supercooled regime wrt. time";
  dlenTPdt = der(lenTP)
    "Derivative of length of control volume of two-phase regime wrt. time";

  // Calculation of mass and energy balances as well as boundary conditions
  //
  if modCV==Utilities.Types.ModeCV.SC then
    /* Supercooled */

     // Boundary conditions
     //
     dlenTPdt = 0 "No change in length of TP regime";
     der(lenSH) = 0 "No change in length of TP regime";

     // Mass and energy balances of SC regime
     //
     m_flow_inl-m_flow_SCTP = geoCV.ACroSec*geoCV.l*((dSC-dSCTP)*dlenSCdt +
       lenSC*(ddSCdp*der(p) + 0.5*ddSCdh*(dhInlDesdt+dhSCTPdt)))
       "Mass balance of supercooled regime";
     m_flow_inl*hInlDes-m_flow_SCTP*hSCTP+Q_flow_SC =
       geoCV.ACroSec*geoCV.l*((0.5*dSC*(hInlDes+hSCTP)-dSCTP*hSCTP)*dlenSCdt - lenSC*der(p) +
       0.5*dSC*lenSC*dhInlDesdt + 0.5*dSC*lenSC*dhSCTPdt +
       0.5*lenSC*(hInlDes+hSCTP)*(ddSCdp*der(p)+0.5*ddSCdh*(dhInlDesdt+dhSCTPdt)))
       "Energy balance of supercooled regime";

     // Mass and energy balances of TP and SH regime
     //
     m_flow_SCTP = m_flow_TPSH "Mass valance of two-phase regime - no change";
     dhSCTPdt = dhTPSHdt "Energy balance of two-phase regime - no change";
     m_flow_TPSH = m_flow_out "Mass balance of superheated regime - no change";
     dhTPSHdt = dhOutDesdt "Energy balance of superheated regime - no change";

  elseif modCV==Utilities.Types.ModeCV.SCTP then
     /* Supercooled and two-phase*/

     // Boundary conditions
     //
     dhSCTPdt = dhLiqdp*der(p) "Bubble enthalpy";
     der(lenSH) = 0 "No change in length of SH regime";

     // Mass and energy balances of TP and SH regime - outlet at bubble line"
     //
     m_flow_inl-m_flow_SCTP = geoCV.ACroSec*geoCV.l*((dSC-dLiq)*dlenSCdt +
       lenSC*(ddSCdp*der(p) + 0.5*ddSCdh*(dhInlDesdt+dhSCTPdt)))
       "Mass balance of supercooled regime";
     m_flow_inl*hInlDes-m_flow_SCTP*hLiq+Q_flow_SC =
       geoCV.ACroSec*geoCV.l*((0.5*dSC*(hInlDes+hSCTP)-dLiq*hLiq)*dlenSCdt - lenSC*der(p) +
       0.5*dSC*lenSC*dhInlDesdt + 0.5*dSC*lenSC*dhSCTPdt +
       0.5*lenSC*(hInlDes+hSCTP)*(ddSCdp*der(p)+0.5*ddSCdh*(dhInlDesdt+dhSCTPdt)))
       "Energy balance of supercooled regime";

     // Mass and energy balances of TP regime - inlet at bubble line"
     //
     m_flow_SCTP-m_flow_TPSH = geoCV.ACroSec*geoCV.l*((dLiq-dTPSH)*dlenSCdt +
       ((1-VoiFraThr)*dLiq+VoiFraThr*dVap-dTPSH)*dlenTPdt +
       lenTP*((dVap-dLiq)*VoiFraDerThr + (VoiFraThr*ddVapdp +
       (1-VoiFraThr)*ddLiqdp)*der(p)))
       "Mass balance of two-phase regime";
     m_flow_SCTP*hLiq-m_flow_TPSH*hTPSH+Q_flow_TP =
       geoCV.ACroSec*geoCV.l*(dLiq*hLiq*dlenSCdt - dTPSH*hTPSH*(dlenSCdt+dlenTPdt) -
       lenTP*der(p) +(VoiFraThr*dVap*hVap+(1-VoiFraThr)*dLiq*hLiq)*dlenTPdt +
       lenTP*((dVap*hVap-dLiq*hLiq)*VoiFraDerThr + VoiFraThr*hVap*ddVapdp*der(p) +
       (1-VoiFraThr)*hLiq*ddLiqdp*der(p) + VoiFraThr*dVap*dhVapdp*der(p) +
       (1-VoiFraThr)*dLiq*dhLiqdp*der(p)))
       "Energy balance of two-phase regime";

     // Mass and energy balance of SH regime
     //
     m_flow_TPSH = m_flow_out "Mass balance of superheated regime - no change";
     dhTPSHdt = dhOutDesdt "Energy balance of superheated regime - no change";

  elseif modCV==Utilities.Types.ModeCV.SCTPSH then
     /* Supercooled and two-phase and superheated*/

     // Boundary conditions
     //
     dhSCTPdt = dhLiqdp*der(p) "Bubble enthalpy";
     dhTPSHdt = dhVapdp*der(p) "Dew enthalpy";

     // Mass and energy balances of SC regime - outlet at bubble line"
     //
     m_flow_inl-m_flow_SCTP = geoCV.ACroSec*geoCV.l*((dSC-dLiq)*dlenSCdt +
       lenSC*(ddSCdp*der(p) + 0.5*ddSCdh*(dhInlDesdt+dhSCTPdt)))
       "Mass balance of supercooled regime";
     m_flow_inl*hInlDes-m_flow_SCTP*hLiq+Q_flow_SC =
       geoCV.ACroSec*geoCV.l*((0.5*dSC*(hInlDes+hSCTP)-dLiq*hLiq)*dlenSCdt - lenSC*der(p) +
       0.5*dSC*lenSC*dhInlDesdt + 0.5*dSC*lenSC*dhSCTPdt +
       0.5*lenSC*(hInlDes+hSCTP)*(ddSCdp*der(p)+0.5*ddSCdh*(dhInlDesdt+dhSCTPdt)))
       "Energy balance of supercooled regime";

     // Mass and energy balances of TP regime - inlet at bubble line - outlet at dew line"
     //
     m_flow_SCTP-m_flow_TPSH = geoCV.ACroSec*geoCV.l*((dLiq-dVap)*dlenSCdt +
       ((1-VoiFraThr)*dLiq+VoiFraThr*dVap-dVap)*dlenTPdt +
       lenTP*((dVap-dLiq)*VoiFraDerThr + (VoiFraThr*ddVapdp +
       (1-VoiFraThr)*ddLiqdp)*der(p)))
       "Mass balance of two-phase regime";
     m_flow_SCTP*hLiq-m_flow_TPSH*hVap+Q_flow_TP =
       geoCV.ACroSec*geoCV.l*(dLiq*hLiq*dlenSCdt - dVap*hVap*(dlenSCdt+dlenTPdt) -
       lenTP*der(p) +(VoiFraThr*dVap*hVap+(1-VoiFraThr)*dLiq*hLiq)*dlenTPdt +
       lenTP*((dVap*hVap-dLiq*hLiq)*VoiFraDerThr + VoiFraThr*hVap*ddVapdp*der(p) +
       (1-VoiFraThr)*hLiq*ddLiqdp*der(p) + VoiFraThr*dVap*dhVapdp*der(p) +
       (1-VoiFraThr)*dLiq*dhLiqdp*der(p)))
       "Energy balance of two-phase regime";

     // Mass and energy balances of SH regime - inlet at dew line"
     //
     m_flow_TPSH-m_flow_out = geoCV.ACroSec*geoCV.l*((dVap-dSH)*(dlenSCdt+dlenTPdt) +
       lenSH*(ddSHdp*der(p) + 0.5*ddSHdh*(dhTPSHdt+dhOutDesdt)))
       "Mass balance of superheated regime";
     m_flow_TPSH*hVap-m_flow_out*hOutDes+Q_flow_SH =
       geoCV.ACroSec*geoCV.l*((dVap*hVap-0.5*dSH*(hTPSH+hOutDes))*(dlenSCdt+dlenTPdt) -
       lenSH*der(p) + 0.5*dSH*lenSH*dhTPSHdt + 0.5*dSH*lenSH*dhOutDesdt +
       0.5*lenSH*(hTPSH+hOutDes)*(ddSHdp*der(p)+0.5*ddSHdh*(dhTPSHdt+dhOutDesdt)))
       "Energy balance of superheated regime";

  elseif modCV==Utilities.Types.ModeCV.TPSH then
     /* Two-phase and Superheated*/

     // Boundary conditions
     //
     dlenSCdt = 0 "No change in length of supercooled regime";
     dhTPSHdt = dhVapdp*der(p) "Dew enthalpy";

     // Mass and energy balances of TP regime - ioutlet at dew line"
     //
     m_flow_SCTP-m_flow_TPSH = geoCV.ACroSec*geoCV.l*((dSCTP-dVap)*dlenSCdt +
       ((1-VoiFraThr)*dLiq+VoiFraThr*dVap-dVap)*dlenTPdt +
       lenTP*((dVap-dLiq)*VoiFraDerThr + (VoiFraThr*ddVapdp +
       (1-VoiFraThr)*ddLiqdp)*der(p)))
       "Mass balance of two-phase regime";
     m_flow_SCTP*hSCTP-m_flow_TPSH*hVap+Q_flow_TP =
       geoCV.ACroSec*geoCV.l*(dSCTP*hSCTP*dlenSCdt - dVap*hVap*(dlenSCdt+dlenTPdt) -
       lenTP*der(p) +(VoiFraThr*dVap*hVap+(1-VoiFraThr)*dLiq*hLiq)*dlenTPdt +
       lenTP*((dVap*hVap-dLiq*hLiq)*VoiFraDerThr + VoiFraThr*hVap*ddVapdp*der(p) +
       (1-VoiFraThr)*hLiq*ddLiqdp*der(p) + VoiFraThr*dVap*dhVapdp*der(p) +
       (1-VoiFraThr)*dLiq*dhLiqdp*der(p)))
       "Energy balance of two-phase regime";

     // Mass and energy balances of SH regime - inlet at dew line"
     //
     m_flow_TPSH-m_flow_out = geoCV.ACroSec*geoCV.l*((dVap-dSH)*(dlenSCdt+dlenTPdt) +
       lenSH*(ddSHdp*der(p) + 0.5*ddSHdh*(dhTPSHdt+dhOutDesdt)))
       "Mass balance of superheated regime";
     m_flow_TPSH*hVap-m_flow_out*hOutDes+Q_flow_SH =
       geoCV.ACroSec*geoCV.l*((dVap*hVap-0.5*dSH*(hTPSH+hOutDes))*(dlenSCdt+dlenTPdt) -
       lenSH*der(p) + 0.5*dSH*lenSH*dhTPSHdt + 0.5*dSH*lenSH*dhOutDesdt +
       0.5*lenSH*(hTPSH+hOutDes)*(ddSHdp*der(p)+0.5*ddSHdh*(dhTPSHdt+dhOutDesdt)))
       "Energy balance of superheated regime";

     // Mass and energy balances of SC and TP regimes"
     //
     m_flow_inl = m_flow_SCTP "Mass balance of supercooled regime - no chance";
     dhInlDesdt = dhSCTPdt "Energy balance of supercooled regime - no change";

  elseif modCV==Utilities.Types.ModeCV.SH then
     /* Superheated*/

     // Boundary conditions
     //
     dlenSCdt = 0 "No change in length of supercooled regime";
     dlenTPdt = 0 "No change in length of two-phase regime";

     // Mass and energy balances of SH regime"
     //
     m_flow_TPSH-m_flow_out = geoCV.ACroSec*geoCV.l*((dTPSH-dSH)*(dlenSCdt+dlenTPdt) +
       lenSH*(ddSHdp*der(p) + 0.5*ddSHdh*(dhTPSHdt+dhOutDesdt)))
       "Mass balance of superheated regime";
     m_flow_TPSH*hTPSH-m_flow_out*hOutDes+Q_flow_SH =
       geoCV.ACroSec*geoCV.l*((dTPSH*hTPSH-0.5*dSH*(hTPSH+hOutDes))*(dlenSCdt+dlenTPdt) -
       lenSH*der(p) + 0.5*dSH*lenSH*dhTPSHdt + 0.5*dSH*lenSH*dhOutDesdt +
       0.5*lenSH*(hTPSH+hOutDes)*(ddSHdp*der(p)+0.5*ddSHdh*(dhTPSHdt+dhOutDesdt)))
       "Energy balance of superheated regime";

     // Mass and energy balances of SC and TP regimes"
     //
     m_flow_inl = m_flow_SCTP "Mass balance of supercooled regime - no chance";
     dhInlDesdt = dhSCTPdt "Energy balance of supercooled regime - no change";
     m_flow_SCTP = m_flow_TPSH "Mass valance of two-phase regime - no change";
     dhSCTPdt = dhTPSHdt "Energy balance of two-phase regime - no change";

  else
    /* Two-phase */

    // Boundary conditions
    //
    dlenSCdt = 0 "No change in length of supercooled regime";
    der(lenSH) = 0 "No change in length of superheated regime";

    // Mass and energy balances of TP regime"
    //
    m_flow_SCTP-m_flow_TPSH = geoCV.ACroSec*geoCV.l*((dSCTP-dTPSH)*dlenSCdt +
      ((1-VoiFraThr)*dLiq+VoiFraThr*dVap-dTPSH)*dlenTPdt +
      lenTP*((dVap-dLiq)*VoiFraDerThr + (VoiFraThr*ddVapdp +
      (1-VoiFraThr)*ddLiqdp)*der(p)))
      "Mass balance of two-phase regime";
    m_flow_SCTP*hSCTP-m_flow_TPSH*hTPSH+Q_flow_TP =
      geoCV.ACroSec*geoCV.l*(dSCTP*hSCTP*dlenSCdt - dTPSH*hTPSH*(dlenSCdt+dlenTPdt) -
      lenTP*der(p) +(VoiFraThr*dVap*hVap+(1-VoiFraThr)*dLiq*hLiq)*dlenTPdt +
      lenTP*((dVap*hVap-dLiq*hLiq)*VoiFraDerThr + VoiFraThr*hVap*ddVapdp*der(p) +
      (1-VoiFraThr)*hLiq*ddLiqdp*der(p) + VoiFraThr*dVap*dhVapdp*der(p) +
      (1-VoiFraThr)*dLiq*dhLiqdp*der(p)))
      "Energy balance of two-phase regime";

    // Mass and energy balances of SC and SH regimes"
    //
    m_flow_inl = m_flow_SCTP "Mass balance of supercooled regime - no chance";
    dhInlDesdt = dhSCTPdt "Energy balance of supercooled regime - no change";
    m_flow_TPSH = m_flow_out "Mass balance of superheated regime - no change";
    dhTPSHdt = dhOutDesdt "Energy balance of superheated regime - no change";

  end if;


  // Calculation of heat flow rates
  //
  Q_flow_SC = homotopy(kASC*dTSC, AlpThrSC * geoCV.AHeaTra*lenSC * dTSC)
    "Heat flow rate between the wall and the supercooled regime";
  Q_flow_TP = kATP*dTTP
    "Heat flow rate between the wall and the two-phase regime";
  Q_flow_SH = homotopy(kASH*dTSH, AlpThrSH * geoCV.AHeaTra*lenSH * dTSH)
    "Heat flow rate between the wall and the superheated regime";


  // Calculation of effective coefficients of heat transfer
  //
  if heaFloCal==Utilities.Types.CalculationHeatFlow.Simplified then
    /* Simplified - Mean temperature differece */

    kASC = AlpThrSC * geoCV.AHeaTra*lenSC
      "Effective thermal conductance of th supercooled regime";
    kATP = AlpThrTP * geoCV.AHeaTra*lenTP
      "Effective thermal conductance of th two-phase regime";
    kASH = AlpThrSH * geoCV.AHeaTra*lenSH
      "Effective thermal conductance of th superheated regime";

    dTSC = heatPortSC.T-TSC
      "Temperature difference between the wall and the supercooled regime";
    dTTP = heatPortTP.T-TTP
      "Temperature difference between the wall and the two-phase regime";
    dTSH = heatPortSH.T-TSH
      "Temperature difference between the wall and the superheated regime";

  elseif heaFloCal==Utilities.Types.CalculationHeatFlow.E_NTU then
    /* Epsilon-NTU - Method of number of transfer units */

    kATP = AlpThrTP * geoCV.AHeaTra*lenTP
      "Effective thermal conductance of th two-phase regime";
    dTTP = heatPortTP.T-TTP
      "Temperature difference between the wall and the two-phase regime";

    if appHX==Utilities.Types.ApplicationHX.Evaporator then
      /* Evaporator - Design direction */

      kASC = AlpThrSC * geoCV.AHeaTra*lenSC
        "Effective thermal conductance of th supercooled regime";
      kASH = max(abs(m_flow_out)*cpSH,1e-8) * (1 - exp(-AlpThrSH *
        geoCV.AHeaTra*lenSH/max(abs(m_flow_out)*cpSH,1e-8)))
        "Effective thermal conductance of th superheated regime";
      dTSC = heatPortSC.T-TSCTP
        "Temperature difference between the wall and the supercooled regime";
      dTSH = heatPortSH.T-TOutDes
        "Temperature difference between the wall and the superheated regime";

    else
      /* Condenser - Reverse direction */

      kASC = max(abs(m_flow_inl)*cpSC,1e-8) * (1 - exp(-AlpThrSC *
        geoCV.AHeaTra*lenSC/max(abs(m_flow_inl)*cpSC,1e-8)))
        "Effective thermal conductance of th supercooled regime";
      kASH = AlpThrSH * geoCV.AHeaTra*lenSH
        "Effective thermal conductance of th superheated regime";
      dTSC = heatPortSC.T-TInlDes
        "Temperature difference between the wall and the supercooled regime";
      dTSH = heatPortSH.T-TTPSH
        "Temperature difference between the wall and the superheated regime";

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
end MovingBoundaryCell;
