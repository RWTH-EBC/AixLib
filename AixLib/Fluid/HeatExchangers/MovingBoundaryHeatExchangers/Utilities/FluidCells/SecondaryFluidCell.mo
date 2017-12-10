within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.FluidCells;
model SecondaryFluidCell
  "Model of a cell of a moving boundary heat exchanger's secondary fluid"
  extends BaseClasses.PartialSecondaryFluidCell;

  // Definition of records describing thermodynamic states
  //
public
  Medium.ThermodynamicState InlDes=
    Medium.setState_ph(p=p,h=inStream(port_a.h_outflow))
    "Thermodynamic state at the inlet of design direction"
    annotation (Placement(transformation(extent={{-80,-8},{-60,12}})));
  Medium.ThermodynamicState SC = Medium.setState_pT(p=p,T=TSC)
    "Thermodynamic state of the supercooled regime"
    annotation (Placement(transformation(extent={{-50,-8},{-30,12}})));
  Medium.ThermodynamicState TP = Medium.setState_pT(p=p,T=TTP)
    "Thermodynamic state of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  Medium.ThermodynamicState SH = Medium.setState_pT(p=p,T=TSH)
    "Thermodynamic state of the superheated regime"
    annotation (Placement(transformation(extent={{30,-8},{50,12}})));
  Medium.ThermodynamicState InlRev=
    Medium.setState_ph(p=p,h=inStream(port_b.h_outflow))
    "Thermodynamic state at the inlet of reverse direction"
    annotation (Placement(transformation(extent={{60,-8},{80,12}})));

  // Definition of variables describing thermodynamic states
  //
protected
  Modelica.SIunits.AbsolutePressure p
    "Pressure of the secondary fluid (assumed to be constant)";
  Modelica.SIunits.Temperature TInlDes = Medium.temperature(InlDes)
    "Temperature at the inlet of design direction";
  Modelica.SIunits.Temperature TSC
    "Temperature of the supercooled regime";
  Modelica.SIunits.Temperature TTP
    "Temperature of the two-phase regime";
  Modelica.SIunits.Temperature TSH
    "Temperature of the superheated regime";
  Modelica.SIunits.Temperature TInlRev = Medium.temperature(InlRev)
    "Temperature at the inlet of reverse direction";
  Modelica.SIunits.SpecificEnthalpy hSC = Medium.specificEnthalpy(SC)
    "Specific enthalpy of the supercooled regime";
  Modelica.SIunits.SpecificEnthalpy hTP = Medium.specificEnthalpy(TP)
    "Specific enthalpy of the two-phase regime";
  Modelica.SIunits.SpecificEnthalpy hSH = Medium.specificEnthalpy(SH)
    "Specific enthalpy of the superheated regime";
  Modelica.SIunits.Density dSC = Medium.density(SC)
    "Density of the supercooled regime";
  Modelica.SIunits.Density dTP = Medium.density(TP)
    "Density of the two-phase regime";
  Modelica.SIunits.Density dSH = Medium.density(SH)
    "Density of the superheated regime";

  // Definition of models describing the calculation of heat transfers
  //
public
  Modelica.SIunits.MassFlowRate m_flow
    "Mass flow rate flowing into and out of the system";
  Modelica.SIunits.MassFlowRate m_flow_SCTP
    "Mass flow rate flowing out of the supercooled regime and into the two-phase
    regime";
  Modelica.SIunits.MassFlowRate m_flow_TPSH
    "Mass flow rate flowing out of the two-phase regime and into the superheated
    regime";

  Modelica.SIunits.Mass mSC
    "Mass of the supercooled regime";
  Modelica.SIunits.Mass mTP
    "Mass of the two-phase regime";
  Modelica.SIunits.Mass mSH
    "Mass of the superheated regime";

  Modelica.SIunits.SpecificHeatCapacity cpSC = Medium.specificHeatCapacityCp(SC)
    "Density of the supercooled regime";
  Modelica.SIunits.SpecificHeatCapacity cpTP = Medium.specificHeatCapacityCp(TP)
    "Density of the two-phase regime";
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
  CoefficientOfHeatTransfer coefficientOfHeatTransferSC(
    geoCV=geoCV) if useHeaCoeMod
    "Coefficient of heat transfer of the supercooled regime"
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  CoefficientOfHeatTransfer coefficientOfHeatTransferTP(
    geoCV=geoCV) if useHeaCoeMod
    "Coefficient of heat transfer of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  CoefficientOfHeatTransfer coefficientOfHeatTransferSH(
    geoCV=geoCV) if useHeaCoeMod
    "Coefficient of heat transfer of the superheated regime"
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));


initial equation
  if iniSteSta then
    /* Steady state initialisation */
    der(TSC) = 0;
    der(TTP) = 0;
    der(TSH) = 0;
  else
    /* Fixed temperature initisalisation */
    TSC = TSCIni;
    TTP = TTPIni;
    TSH = TSHIni;
  end if;


equation
  // Connect variables with connectors
  //
  port_a.p = p
    "Pressure at port_a - Assuming no pressure losses";
  port_b.p = p
    "Pressure at port_b - Assuming no pressure losses";
  port_a.m_flow = m_flow
    "Mass flow rate at port_a - Assuming no storage of mass";
  port_b.m_flow = -m_flow
    "Mass flow rate at port_b - Assuming no storage of mass";
  port_a.h_outflow = hSC
    "Specific enthalpy flowing out of the system at port_a";
  port_b.h_outflow = hSH
    "Specific enthalpy flowing out of the system at port_b";

  heatPortSC.Q_flow = Q_flow_SC
    "Heat flow rate between the wall and the supercooled regime";
  heatPortTP.Q_flow = Q_flow_TP
    "Heat flow rate between the wall and the two-phase regime";
  heatPortSH.Q_flow = Q_flow_SH
    "Heat flow rate between the wall and the superheated regime";

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

  // Calculationg of mass balances
  //
  mSC = dSC * geoCV.ACroSec*geoCV.l*lenInl[1]
    "Mass of the supercooled regime";
  mTP = dTP * geoCV.ACroSec*geoCV.l*lenInl[2]
    "Mass of the two-phase regime";
  mSH = dSH * geoCV.ACroSec*geoCV.l*lenInl[3]
    "Mass of the superheated regime";

  m_flow_SCTP = m_flow -
    dSC*geoCV.ACroSec*geoCV.l*der(lenInl[1])
    "Mass flow rate flowing out of the supercooled regime and into the two-phase
    regime";
  m_flow_TPSH = m_flow -
    dSH*geoCV.ACroSec*geoCV.l*(der(lenInl[1])+der(lenInl[2]))
    "Mass flow rate flowing out of the two-phase regime and into the superheated
    regime";

  // Calculation of energy balances
  //
  if m_flow>0 then
    /* Energy balance of design direction */
    mSC*cpSC * der(TSC) = m_flow*(inStream(port_a.h_outflow)-hSC) + Q_flow_SC
      "Energy balance of the supercooled regime";
    mTP*cpTP * der(TTP) = m_flow_SCTP*(hSC-hTP) + Q_flow_TP
      "Energy balance of the two-phase regime";
    mSH*cpSH * der(TSH) = m_flow_TPSH*(hTP-hSH) + Q_flow_SH
      "Energy balance of the superheated regime";
  else
    /* Energy balance of reverse direction */
    mSC*cpSC * der(TSC) = -m_flow_SCTP*(hTP-hSC) + Q_flow_SC
      "Energy balance of the supercooled regime";
    mTP*cpTP * der(TTP) = -m_flow_TPSH*(hSH-hTP) + Q_flow_TP
      "Energy balance of the two-phase regime";
    mSH*cpSH * der(TSH) = -m_flow*(inStream(port_b.h_outflow)-hSH) + Q_flow_SH
      "Energy balance of the superheated regime";
  end if;

  // Calculate heat flows
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

    kASC = AlpThrSC * geoCV.AHeaTra*lenInl[1]
      "Effective thermal conductance of th supercooled regime";
    kATP = AlpThrTP * geoCV.AHeaTra*lenInl[2]
      "Effective thermal conductance of th two-phase regime";
    kASH = AlpThrSH * geoCV.AHeaTra*lenInl[3]
      "Effective thermal conductance of th superheated regime";

    dTSC = heatPortSC.T-TSC
      "Temperature difference between the wall and the supercooled regime";
    dTTP = heatPortTP.T-TTP
      "Temperature difference between the wall and the two-phase regime";
    dTSH = heatPortSH.T-TSH
      "Temperature difference between the wall and the superheated regime";


  elseif heaFloCal==Utilities.Types.CalculationHeatFlow.E_NTU then
    /* Epsilon-NTU - Method of number of transfer units */

    kASC = abs(m_flow)*cpSC * (1 - exp(-AlpThrSC *
      geoCV.AHeaTra*lenInl[1]/(abs(m_flow)*cpSC)))
      "Effective thermal conductance of th supercooled regime";
    kATP = abs(m_flow)*cpTP * (1 - exp(-AlpThrTP *
      geoCV.AHeaTra*lenInl[2]/(abs(m_flow)*cpTP)))
      "Effective thermal conductance of th two-phase regime";
    kASH = abs(m_flow)*cpSH * (1 - exp(-AlpThrSH *
      geoCV.AHeaTra*lenInl[3]/(abs(m_flow)*cpSH)))
      "Effective thermal conductance of th superheated regime";

    if m_flow>0 then
      /* Mass balance of design direction */
      dTSC = heatPortSC.T-TInlDes
        "Temperature difference between the wall and the supercooled regime";
      dTTP = heatPortTP.T-TSC
        "Temperature difference between the wall and the two-phase regime";
      dTSH = heatPortSH.T-TTP
        "Temperature difference between the wall and the superheated regime";
    else
      /* Mass balance of reverse direction */
      dTSC = heatPortSC.T-TTP
        "Temperature difference between the wall and the supercooled regime";
      dTTP = heatPortTP.T-TSH
        "Temperature difference between the wall and the two-phase regime";
      dTSH = heatPortSH.T-TInlRev
        "Temperature difference between the wall and the superheated regime";
    end if;


  else
    /*Assert warning if currrent approach of calculating heat transfers is not
      implemented!
    */
    assert(false, "Current method of calculating the heat flow rates is not 
      supported! Please change calculation method!");

  end if;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-60,50},{60,50}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Line(
          points={{60,30},{-60,30}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=1),
        Text(
          extent={{-60,70},{60,50}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255},
          textString="Design direction - 'Direct-current' heat exchanger"),
        Text(
          extent={{-60,50},{60,30}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255},
          textString="Reverse direction - 'Counter-current' heat exchanger")}),
    Documentation(revisions="<html>
<ul>
  <li>
  December 08, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This is a model of the secondary fluid cell of a moving boundary heat exchanger.
It supports two types of heat exchanger, i.e. direct-current and counter-current
heat exchangers. A direct-current heat exchanger is modelled by using the fluid
ports in design direction and a counter-current heat exchanger is modelled by
usign the fluid poirt against design direction.<br/><br/>
Validation models are stored in
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.SecondaryFluidCells\">
AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.SecondaryFluidCells.</a>
</p>
<h4>Assumptions</h4>
<p>
Some assumptions are used while modelling the secondary fluid cell. These
assumptions are listed below:
</p>
<ul>
<li>
Neclecting the possibility of storing mass and energy.
</li>
<li>
Neglecting the momemtum accumulation.
</li>
<li>
Incompressible secondary fluid.
</li>
<li>
Assuming time-dependet but uniform pressure.
</li>
<li>
Average thermodynamic properties at each regime.
</li>
<li>
Thermodynamic properties leaving a regime are equal to the regime's average
thermodynamic properties.
</li>
</ul>
<p>
The general modelling approach is based on the PhD thesis presented by
Gr&auml;ber (2013). Thus, detailed information of the modelling assumptions
as well as the derivation of the equations of the model are given in
Gr&auml;ber&apos;s dissertation.
</p>
<h4>References</h4>
<p>
M. Gr&auml;ber (2013): 
<a href=\"https://www.deutsche-digitale-bibliothek.de/item/C6YBIFUYHBKXYQ3WO2VQDZ4XPEQPUYFK\">
Energieoptimale Regelung von Kälteprozessen (in German)</a>.
Dissertation. <i>Technische Universität Braunschweig.</i>
</p>
</html>"));
end SecondaryFluidCell;
