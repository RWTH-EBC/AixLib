within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.SimpleHeatExchangers;
model OneVolumeHeatExchanger2

  // Extensions and propagation of parameters
  //
  extends AixLib.Fluid.Interfaces.PartialFourPort(
    redeclare replaceable package Medium1 = AixLib.Media.Water,
    redeclare replaceable package Medium2 = Modelica.Media.R134a.R134a_ph);

  // Parameters describing heat transfer
  //
  parameter Modelica.SIunits.Area APri = 0.5;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpPri = 2000
    "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient"));

  parameter Modelica.SIunits.Mass mWal = 0.5;
  parameter Modelica.SIunits.SpecificHeatCapacity cpWal = 485;

  parameter Modelica.SIunits.Area ASec = 0.5;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSec = 200
    "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient"));

  // Primary side
  //
  Medium2.ThermodynamicState staPri = Medium2.setState_ph(p=pPri,h=hPri)
    "Thermodynamic state of the supercooled regime";

  Modelica.SIunits.AbsolutePressure pPri(start=2e5) = port_a2.p
    "Pressure of the working fluid (assumed to be constant)";

  Modelica.SIunits.Temperature TInlPri = Medium2.temperature_ph(p=pPri,h=hInlPri)
    "Temperature at the inlet of design direction";
  Modelica.SIunits.Temperature TPri = (TInlPri+TOutPri)/2
    "Temperature of the two-phase regime";
  Modelica.SIunits.Temperature TOutPri = Medium2.temperature_ph(p=pPri,h=hOutPri)
    "Temperature at the outlet of design direction";

  Modelica.SIunits.SpecificEnthalpy hInlPri(start=300e3)
    "Specific enthalpy at the inlet of design direction";
  Modelica.SIunits.SpecificEnthalpy hPri = (hInlPri+hOutPri)/2
    "Specific enthalpy of the two-phase regime";
  Modelica.SIunits.SpecificEnthalpy hOutPri(start=400e3)
    "Specific enthalpy at the outlet of design direction";

 // Secondary side
 //
  Medium1.ThermodynamicState staSec = Medium1.setState_ph(p=pSec,h=hSec)
    "Thermodynamic state of the supercooled regime";

  Modelica.SIunits.AbsolutePressure pSec = port_a1.p
    "Pressure of the working fluid (assumed to be constant)";

  Modelica.SIunits.Temperature TInlSec = Medium1.temperature_ph(p=pSec,h=hInlSec)
    "Temperature at the inlet of design direction";
  Modelica.SIunits.Temperature TSec = (TInlSec+TOutSec)/2
    "Temperature of the two-phase regime";
  Modelica.SIunits.Temperature TOutSec = Medium1.temperature_ph(p=pSec,h=hOutSec)
    "Temperature at the outlet of design direction";

  Modelica.SIunits.SpecificEnthalpy hInlSec
    "Specific enthalpy at the inlet of design direction";
  Modelica.SIunits.SpecificEnthalpy hSec = (hInlSec+hOutSec)/2
    "Specific enthalpy of the two-phase regime";
  Modelica.SIunits.SpecificEnthalpy hOutSec
    "Specific enthalpy at the outlet of design direction";

  // Heat flow
  //
  Modelica.SIunits.MassFlowRate m_flow_Pri = port_a2.m_flow
    "Mass flow rate flowing into the system";
  Modelica.SIunits.MassFlowRate m_flow_Sec = port_a1.m_flow
    "Mass flow rate flowing into the system";

  Modelica.SIunits.SpecificHeatCapacity cpPri = Medium2.specificHeatCapacityCp(staPri)
    "Density of the supercooled regime";
  Modelica.SIunits.SpecificHeatCapacity cpSec = Medium1.specificHeatCapacityCp(staSec)
    "Density of the two-phase regime";

   Modelica.SIunits.ThermalConductance kAPri
     "Effective thermal conductance of th supercooled regime";
   Modelica.SIunits.ThermalConductance kASec
     "Effective thermal conductance of th two-phase regime";

  Modelica.SIunits.Temperature TWal(start=293.15);

  Modelica.SIunits.HeatFlowRate Q_flow_Pri
    "Heat flow rate from between the wall and the supercooled regime";
  Modelica.SIunits.HeatFlowRate Q_flow_Sec
    "Heat flow rate from between the wall and the two-pahse regime";

equation
  // Set boundary conditions
  //
  if m_flow_Pri > 0 then
    hInlPri = inStream(port_a2.h_outflow);
    port_a2.h_outflow = hInlPri;
    port_b2.h_outflow = hOutPri;
  else
    hInlPri = inStream(port_b2.h_outflow);
    port_b2.h_outflow = hInlPri;
    port_a2.h_outflow = hOutPri;
  end if;

  if m_flow_Sec > 0 then
    hInlSec = inStream(port_a1.h_outflow);
    port_a1.h_outflow = hInlSec;
    port_b1.h_outflow = hOutSec;
  else
    hInlSec = inStream(port_b1.h_outflow);
    port_b1.h_outflow = hInlSec;
    port_a1.h_outflow = hOutSec;
  end if;

  // Calculate momemtum balances
  //
  port_a1.p = port_b1.p;
  port_a2.p = port_b2.p;

  // Calculate mass balances
  //
  port_a1.m_flow + port_b1.m_flow = 0;
  port_a2.m_flow + port_b2.m_flow = 0;

  // Calculate energy balances
  //
  m_flow_Pri*(hOutPri-hInlPri) + Q_flow_Pri = 0;
  m_flow_Sec*(hOutSec-hInlSec) - Q_flow_Sec = 0;

  // Calculate heat flows
  //
  kAPri = abs(m_flow_Pri)*cpPri * (1 - exp(-APri*AlpPri/(abs(m_flow_Pri)*cpPri)));
  kASec = abs(m_flow_Sec)*cpSec * (1 - exp(-ASec*AlpSec/(abs(m_flow_Sec)*cpSec)));

  Q_flow_Pri = APri*AlpPri*max((TWal-TPri),1e-6);
  Q_flow_Sec = ASec*AlpSec*max((TSec-TWal),1e-6);

  mWal*cpWal*der(TWal) = Q_flow_Sec - Q_flow_Pri;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,80},{100,100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,-12},{100,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-100},{100,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,-12},{100,12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-100,80},{100,12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
                             Text(
                extent={{-80,80},{80,-80}},
                lineColor={28,108,200},
                textString="Eva")}),                             Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OneVolumeHeatExchanger2;
