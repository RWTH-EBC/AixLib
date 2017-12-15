within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.FluidCells;
model EvaporatorCell
  "Model of a general evaporator boundary cell of the working fluid"
  extends BaseClasses.PartialMovingBoundaryCell;

equation
  // Calculation of geometric constraints
  //
  port_a.m_flow = m_flow_inl
    "Mass flow rate at port_a";
  port_b.m_flow = -m_flow_out
    "Mass flow rate at port_b (equations are written wrt. design direction)";

  port_a.h_outflow = hInl
    "Specific enthalpy flowing out of system at port_a - Condenser";
  port_b.h_outflow = hOut
    "Specific enthalpy flowing out of system at port_b - Evaporator";


  // Calculation of state variables
  //
  hInl = inStream(port_a.h_outflow)
    "Specific enthalpy at the outlet of design direction";

  hSC = (hInl+hSCTP)/2
    "Specific enthalpy of the supercooled regime";
  hTP = if useVoiFra then VoiFraThr*hVap + (1-VoiFraThr)*hLiq else
    (hSCTP+hTPSH)/2
    "Specific enthalpy of the two-phase regime";
  hSH = (hTPSH+hOut)/2
    "Specific enthalpy of the superheated regime";


  // Calculation of mass and energy balances as well as boundary conditions
  //
  if modCV==Utilities.Types.ModeCV.SC then
    /* Supercooled */

    // Boundary conditions
    //
    dlenTPdt = 0   "No change in length of TP regime";
    der(lenSH) = 0 "No change in length of TP regime";

    // Mass and energy balances of SC regime
    //
    m_flow_inl - m_flow_SCTP =
      geoCV.ACroSecFloCha*geoCV.l*((dSC-dSCTP)*dlenSCdt +
      lenSC*(ddSCdp*der(p) + 0.5*ddSCdh*(dhInldt+dhSCTPdt)))
      "Mass balance of supercooled regime";
    m_flow_inl*hInl - m_flow_SCTP*hSCTP + Q_flow_SC =
    geoCV.ACroSecFloCha*geoCV.l*((dSC*hSC-dSCTP*hSCTP)*dlenSCdt - lenSC*der(p) +
       0.5*lenSC*dSC*(dhInldt + dhSCTPdt) +
       lenSC*hSC*(ddSCdp*der(p) + 0.5*ddSCdh*(dhInldt+dhSCTPdt)))
       "Energy balance of supercooled regime";

    // Mass and energy balances of TP and SH regime
    //
    m_flow_SCTP = m_flow_TPSH
      "Mass valance of two-phase regime - no change";
    dhSCTPdt = dhTPSHdt
      "Energy balance of two-phase regime - no change";
    m_flow_TPSH = m_flow_out
      "Mass balance of superheated regime - no change";
    dhTPSHdt = dhOutdt
      "Energy balance of superheated regime - no change";

    // Calculation of heat flow rates
    //
    Q_flow_SC = homotopy(kASC*dTSC, AlpThrSC * geoCV.AHeaTra*lenSC * dTSC)
      "Heat flow rate between the wall and the supercooled regime";
    Q_flow_TP = 0
      "Heat flow rate between the wall and the two-phase regime";
    Q_flow_SH = 0
      "Heat flow rate between the wall and the superheated regime";

  elseif modCV==Utilities.Types.ModeCV.SCTP then
    /* Supercooled and two-phase*/

    // Boundary conditions
    //
    dhSCTPdt = dhLiqdp*der(p) "Bubble enthalpy";
    der(lenSH) = 0            "No change in length of SH regime";

    // Mass and energy balances of TP and SH regime"
    //
    m_flow_inl - m_flow_SCTP =
      geoCV.ACroSecFloCha*geoCV.l*((dSC-dSCTP)*dlenSCdt +
      lenSC*(ddSCdp*der(p) + 0.5*ddSCdh*(dhInldt+dhSCTPdt)))
      "Mass balance of supercooled regime";
    m_flow_inl*hInl - m_flow_SCTP*hSCTP + Q_flow_SC =
    geoCV.ACroSecFloCha*geoCV.l*((dSC*hSC-dSCTP*hSCTP)*dlenSCdt - lenSC*der(p) +
       0.5*lenSC*dSC*(dhInldt + dhSCTPdt) +
       lenSC*hSC*(ddSCdp*der(p) + 0.5*ddSCdh*(dhInldt+dhSCTPdt)))
       "Energy balance of supercooled regime";

    // Mass and energy balances of TP regime"
    //
    if useVoiFra then
      m_flow_SCTP - m_flow_TPSH =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*dlenSCdt-dTPSH*(dlenSCdt+dlenTPdt) +
        ((1-VoiFraThr)*dLiq + VoiFraThr*dVap)*dlenTPdt +
        lenTP*((dVap-dLiq)*VoiFraDerThr + (VoiFraThr*ddVapdp +
        (1-VoiFraThr)*ddLiqdp)*der(p)))
        "Mass balance of two-phase regime";
      m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH + Q_flow_TP =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*hSCTP*dlenSCdt -
        dTPSH*hTPSH*(dlenSCdt+dlenTPdt) - lenTP*der(p) +
        (VoiFraThr*dVap*hVap + (1-VoiFraThr)*dLiq*hLiq)*dlenTPdt +
        lenTP*((dVap*hVap-dLiq*hLiq)*VoiFraDerThr +
        VoiFraThr*hVap*ddVapdp*der(p) +
        (1-VoiFraThr)*hLiq*ddLiqdp*der(p) + VoiFraThr*dVap*dhVapdp*der(p) +
        (1-VoiFraThr)*dLiq*dhLiqdp*der(p)))
        "Energy balance of two-phase regime";
    else
      m_flow_SCTP - m_flow_TPSH =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*dlenSCdt-dTPSH*(dlenSCdt+dlenTPdt) +
        lenTP*(ddTPdp*der(p) + 0.5*ddTPdh*(dhSCTPdt+dhTPSHdt)) + dTP*dlenTPdt)
        "Mass balance of two-phase regime";
      m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH + Q_flow_TP =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*hSCTP*dlenSCdt-
        dTPSH*hTPSH*(dlenSCdt+dlenTPdt) - lenTP*der(p) +
        0.5*lenTP*dTP*(dhSCTPdt+dhTPSHdt) + lenTP*hTP*(ddTPdp*der(p) +
        0.5*ddTPdh*(dhSCTPdt+dhTPSHdt)) + hTP*dTP*dlenTPdt)
        "Energy balance of two-phase regime";
    end if;

    // Mass and energy balance of SH regime
    //
    m_flow_TPSH = m_flow_out
      "Mass balance of superheated regime - no change";
    dhTPSHdt = dhOutdt
      "Energy balance of superheated regime - no change";

    // Calculation of heat flow rates
    //
    Q_flow_SC = homotopy(kASC*dTSC, AlpThrSC * geoCV.AHeaTra*lenSC * dTSC)
      "Heat flow rate between the wall and the supercooled regime";
    Q_flow_TP = kATP*dTTP
      "Heat flow rate between the wall and the two-phase regime";
    Q_flow_SH = 0
      "Heat flow rate between the wall and the superheated regime";

  elseif modCV==Utilities.Types.ModeCV.SCTPSH then
    /* Supercooled and two-phase and superheated*/

    // Boundary conditions
    //
    dhSCTPdt = dhLiqdp*der(p) "Bubble enthalpy";
    dhTPSHdt = dhVapdp*der(p) "Dew enthalpy";

    // Mass and energy balances of SC regime"
    //
    m_flow_inl - m_flow_SCTP =
      geoCV.ACroSecFloCha*geoCV.l*((dSC-dSCTP)*dlenSCdt +
      lenSC*(ddSCdp*der(p) + 0.5*ddSCdh*(dhInldt+dhSCTPdt)))
      "Mass balance of supercooled regime";
    m_flow_inl*hInl - m_flow_SCTP*hSCTP + Q_flow_SC =
    geoCV.ACroSecFloCha*geoCV.l*((dSC*hSC-dSCTP*hSCTP)*dlenSCdt - lenSC*der(p) +
       0.5*lenSC*dSC*(dhInldt + dhSCTPdt) +
       lenSC*hSC*(ddSCdp*der(p) + 0.5*ddSCdh*(dhInldt+dhSCTPdt)))
       "Energy balance of supercooled regime";

    // Mass and energy balances of TP regime"
    //
    if useVoiFra then
      m_flow_SCTP - m_flow_TPSH =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*dlenSCdt-dTPSH*(dlenSCdt+dlenTPdt) +
        ((1-VoiFraThr)*dLiq + VoiFraThr*dVap)*dlenTPdt +
        lenTP*((dVap-dLiq)*VoiFraDerThr + (VoiFraThr*ddVapdp +
        (1-VoiFraThr)*ddLiqdp)*der(p)))
        "Mass balance of two-phase regime";
      m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH + Q_flow_TP =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*hSCTP*dlenSCdt -
        dTPSH*hTPSH*(dlenSCdt+dlenTPdt) - lenTP*der(p) +
        (VoiFraThr*dVap*hVap + (1-VoiFraThr)*dLiq*hLiq)*dlenTPdt +
        lenTP*((dVap*hVap-dLiq*hLiq)*VoiFraDerThr +
        VoiFraThr*hVap*ddVapdp*der(p) +
        (1-VoiFraThr)*hLiq*ddLiqdp*der(p) + VoiFraThr*dVap*dhVapdp*der(p) +
        (1-VoiFraThr)*dLiq*dhLiqdp*der(p)))
        "Energy balance of two-phase regime";
    else
      m_flow_SCTP - m_flow_TPSH =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*dlenSCdt-dTPSH*(dlenSCdt+dlenTPdt) +
        lenTP*(ddTPdp*der(p) + 0.5*ddTPdh*(dhSCTPdt+dhTPSHdt)) + dTP*dlenTPdt)
        "Mass balance of two-phase regime";
      m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH + Q_flow_TP =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*hSCTP*dlenSCdt-
        dTPSH*hTPSH*(dlenSCdt+dlenTPdt) - lenTP*der(p) +
        0.5*lenTP*dTP*(dhSCTPdt+dhTPSHdt) + lenTP*hTP*(ddTPdp*der(p) +
        0.5*ddTPdh*(dhSCTPdt+dhTPSHdt)) + hTP*dTP*dlenTPdt)
        "Energy balance of two-phase regime";
    end if;
    // Mass and energy balances of SH regime"
    //
    m_flow_TPSH - m_flow_out =
      geoCV.ACroSecFloCha*geoCV.l*((dTPSH-dSH)*(dlenSCdt+dlenTPdt) +
      lenSH*(ddSHdp*der(p) + 0.5*ddSHdh*(dhTPSHdt+dhOutdt)))
      "Mass balance of superheated regime";
    m_flow_TPSH*hTPSH - m_flow_out*hOut + Q_flow_SH =
      geoCV.ACroSecFloCha*geoCV.l*((dTPSH*hTPSH-dSH*hSH)*(dlenSCdt+dlenTPdt) -
      lenSH*der(p) + 0.5*dSH*lenSH*(dhTPSHdt + dhOutdt) +
      lenSH*hSH*(ddSHdp*der(p) + 0.5*ddSHdh*(dhTPSHdt+dhOutdt)))
      "Energy balance of superheated regime";

    // Calculation of heat flow rates
    //
    Q_flow_SC = homotopy(kASC*dTSC, AlpThrSC * geoCV.AHeaTra*lenSC * dTSC)
      "Heat flow rate between the wall and the supercooled regime";
    Q_flow_TP = kATP*dTTP
      "Heat flow rate between the wall and the two-phase regime";
    Q_flow_SH = homotopy(kASH*dTSH, AlpThrSH * geoCV.AHeaTra*lenSH * dTSH)
      "Heat flow rate between the wall and the superheated regime";

  elseif modCV==Utilities.Types.ModeCV.TPSH then
    /* Two-phase and Superheated*/

    // Boundary conditions
    //
    dlenSCdt = 0              "No change in length of supercooled regime";
    dhTPSHdt = dhVapdp*der(p) "Dew enthalpy";

    // Mass and energy balances of TP regime"
    //
    if useVoiFra then
      m_flow_SCTP - m_flow_TPSH =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*dlenSCdt-dTPSH*(dlenSCdt+dlenTPdt) +
        ((1-VoiFraThr)*dLiq + VoiFraThr*dVap)*dlenTPdt +
        lenTP*((dVap-dLiq)*VoiFraDerThr + (VoiFraThr*ddVapdp +
        (1-VoiFraThr)*ddLiqdp)*der(p)))
        "Mass balance of two-phase regime";
      m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH + Q_flow_TP =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*hSCTP*dlenSCdt -
        dTPSH*hTPSH*(dlenSCdt+dlenTPdt) - lenTP*der(p) +
        (VoiFraThr*dVap*hVap + (1-VoiFraThr)*dLiq*hLiq)*dlenTPdt +
        lenTP*((dVap*hVap-dLiq*hLiq)*VoiFraDerThr +
        VoiFraThr*hVap*ddVapdp*der(p) +
        (1-VoiFraThr)*hLiq*ddLiqdp*der(p) + VoiFraThr*dVap*dhVapdp*der(p) +
        (1-VoiFraThr)*dLiq*dhLiqdp*der(p)))
        "Energy balance of two-phase regime";
    else
      m_flow_SCTP - m_flow_TPSH =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*dlenSCdt-dTPSH*(dlenSCdt+dlenTPdt) +
        lenTP*(ddTPdp*der(p) + 0.5*ddTPdh*(dhSCTPdt+dhTPSHdt)) + dTP*dlenTPdt)
        "Mass balance of two-phase regime";
      m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH + Q_flow_TP =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*hSCTP*dlenSCdt-
        dTPSH*hTPSH*(dlenSCdt+dlenTPdt) - lenTP*der(p) +
        0.5*lenTP*dTP*(dhSCTPdt+dhTPSHdt) + lenTP*hTP*(ddTPdp*der(p) +
        0.5*ddTPdh*(dhSCTPdt+dhTPSHdt)) + hTP*dTP*dlenTPdt)
        "Energy balance of two-phase regime";
    end if;

    // Mass and energy balances of SH regime"
    //
    m_flow_TPSH - m_flow_out =
      geoCV.ACroSecFloCha*geoCV.l*((dTPSH-dSH)*(dlenSCdt+dlenTPdt) +
      lenSH*(ddSHdp*der(p) + 0.5*ddSHdh*(dhTPSHdt+dhOutdt)))
      "Mass balance of superheated regime";
    m_flow_TPSH*hTPSH - m_flow_out*hOut + Q_flow_SH =
      geoCV.ACroSecFloCha*geoCV.l*((dTPSH*hTPSH-dSH*hSH)*(dlenSCdt+dlenTPdt) -
      lenSH*der(p) + 0.5*dSH*lenSH*(dhTPSHdt + dhOutdt) +
      lenSH*hSH*(ddSHdp*der(p) + 0.5*ddSHdh*(dhTPSHdt+dhOutdt)))
      "Energy balance of superheated regime";

    // Mass and energy balances of SC and TP regimes"
    //
    m_flow_inl = m_flow_SCTP
      "Mass balance of supercooled regime - no chance";
    dhInldt = dhSCTPdt
      "Energy balance of supercooled regime - no change";

    // Calculation of heat flow rates
    //
    Q_flow_SC = 0
      "Heat flow rate between the wall and the supercooled regime";
    Q_flow_TP = kATP*dTTP
      "Heat flow rate between the wall and the two-phase regime";
    Q_flow_SH = homotopy(kASH*dTSH, AlpThrSH * geoCV.AHeaTra*lenSH * dTSH)
      "Heat flow rate between the wall and the superheated regime";

  elseif modCV==Utilities.Types.ModeCV.SH then
    /* Superheated*/

    // Boundary conditions
    //
    dlenSCdt = 0 "No change in length of supercooled regime";
    dlenTPdt = 0 "No change in length of two-phase regime";

    // Mass and energy balances of SH regime"
    //
    m_flow_TPSH - m_flow_out =
      geoCV.ACroSecFloCha*geoCV.l*((dTPSH-dSH)*(dlenSCdt+dlenTPdt) +
      lenSH*(ddSHdp*der(p) + 0.5*ddSHdh*(dhTPSHdt+dhOutdt)))
      "Mass balance of superheated regime";
    m_flow_TPSH*hTPSH - m_flow_out*hOut + Q_flow_SH =
      geoCV.ACroSecFloCha*geoCV.l*((dTPSH*hTPSH-dSH*hSH)*(dlenSCdt+dlenTPdt) -
      lenSH*der(p) + 0.5*dSH*lenSH*(dhTPSHdt + dhOutdt) +
      lenSH*hSH*(ddSHdp*der(p) + 0.5*ddSHdh*(dhTPSHdt+dhOutdt)))
      "Energy balance of superheated regime";

    // Mass and energy balances of SC and TP regimes"
    //
    m_flow_inl = m_flow_SCTP
      "Mass balance of supercooled regime - no chance";
    dhInldt = dhSCTPdt
      "Energy balance of supercooled regime - no change";
    m_flow_SCTP = m_flow_TPSH
      "Mass valance of two-phase regime - no change";
    dhSCTPdt = dhTPSHdt
      "Energy balance of two-phase regime - no change";

    // Calculation of heat flow rates
    //
    Q_flow_SC = 0
      "Heat flow rate between the wall and the supercooled regime";
    Q_flow_TP = 0
      "Heat flow rate between the wall and the two-phase regime";
    Q_flow_SH = homotopy(kASH*dTSH, AlpThrSH * geoCV.AHeaTra*lenSH * dTSH)
      "Heat flow rate between the wall and the superheated regime";

  else
    /* Two-phase */

    // Boundary conditions
    //
    dlenSCdt = 0   "No change in length of supercooled regime";
    der(lenSH) = 0 "No change in length of superheated regime";

    // Mass and energy balances of TP regime"
    //
    if useVoiFra then
      m_flow_SCTP - m_flow_TPSH =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*dlenSCdt-dTPSH*(dlenSCdt+dlenTPdt) +
        ((1-VoiFraThr)*dLiq + VoiFraThr*dVap)*dlenTPdt +
        lenTP*((dVap-dLiq)*VoiFraDerThr + (VoiFraThr*ddVapdp +
        (1-VoiFraThr)*ddLiqdp)*der(p)))
        "Mass balance of two-phase regime";
      m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH + Q_flow_TP =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*hSCTP*dlenSCdt -
        dTPSH*hTPSH*(dlenSCdt+dlenTPdt) - lenTP*der(p) +
        (VoiFraThr*dVap*hVap + (1-VoiFraThr)*dLiq*hLiq)*dlenTPdt +
        lenTP*((dVap*hVap-dLiq*hLiq)*VoiFraDerThr +
        VoiFraThr*hVap*ddVapdp*der(p) +
        (1-VoiFraThr)*hLiq*ddLiqdp*der(p) + VoiFraThr*dVap*dhVapdp*der(p) +
        (1-VoiFraThr)*dLiq*dhLiqdp*der(p)))
        "Energy balance of two-phase regime";
    else
      m_flow_SCTP - m_flow_TPSH =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*dlenSCdt-dTPSH*(dlenSCdt+dlenTPdt) +
        lenTP*(ddTPdp*der(p) + 0.5*ddTPdh*(dhSCTPdt+dhTPSHdt)) + dTP*dlenTPdt)
        "Mass balance of two-phase regime";
      m_flow_SCTP*hSCTP - m_flow_TPSH*hTPSH + Q_flow_TP =
        geoCV.ACroSecFloCha*geoCV.l*(dSCTP*hSCTP*dlenSCdt-
        dTPSH*hTPSH*(dlenSCdt+dlenTPdt) - lenTP*der(p) +
        0.5*lenTP*dTP*(dhSCTPdt+dhTPSHdt) + lenTP*hTP*(ddTPdp*der(p) +
        0.5*ddTPdh*(dhSCTPdt+dhTPSHdt)) + hTP*dTP*dlenTPdt)
        "Energy balance of two-phase regime";
    end if;

    // Mass and energy balances of SC and SH regimes"
    //
    m_flow_inl = m_flow_SCTP
      "Mass balance of supercooled regime - no chance";
    dhInldt = dhSCTPdt
      "Energy balance of supercooled regime - no change";
    m_flow_TPSH = m_flow_out
      "Mass balance of superheated regime - no change";
    dhTPSHdt = dhOutdt
      "Energy balance of superheated regime - no change";

    // Calculation of heat flow rates
    //
    Q_flow_SC = 0
      "Heat flow rate between the wall and the supercooled regime";
    Q_flow_TP = kATP*dTTP
      "Heat flow rate between the wall and the two-phase regime";
    Q_flow_SH = 0
      "Heat flow rate between the wall and the superheated regime";

  end if;


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

    kASC = AlpThrSC * geoCV.AHeaTra*lenSC
      "Effective thermal conductance of th supercooled regime";
    kATP = AlpThrTP * geoCV.AHeaTra*lenTP
      "Effective thermal conductance of th two-phase regime";
    kASH = max(abs(m_flow_out)*cpSH,1e-8) * (1 - exp(-AlpThrSH *
      geoCV.AHeaTra*lenSH/max(abs(m_flow_out)*cpSH,1e-8)))
      "Effective thermal conductance of th superheated regime";

    dTSC = heatPortSC.T-TSCTP
      "Temperature difference between the wall and the supercooled regime";
    dTTP = heatPortTP.T-TTP
      "Temperature difference between the wall and the two-phase regime";
    dTSH = heatPortSH.T-TOut
      "Temperature difference between the wall and the superheated regime";

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
          smooth=Smooth.Bezier),
        Line(
          points={{-78,0},{60,0}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Text(
          extent={{-100,-26},{-40,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag,
          textString="SC"),
        Text(
          extent={{44,-26},{100,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag,
          textString="SH")}));
end EvaporatorCell;
