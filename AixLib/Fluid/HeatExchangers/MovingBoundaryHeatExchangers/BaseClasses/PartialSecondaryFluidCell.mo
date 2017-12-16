within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.BaseClasses;
partial model PartialSecondaryFluidCell
  "This model is a base class for all models describing secondary fluid cells"

  // Definitions of parameters describing the type of the heat exchanger
  //
  parameter Utilities.Types.TypeHX typHX=
    Utilities.Types.TypeHX.CounterCurrent
    "Type of the heat exchangver (e.g. counter-current heat exchanger)"
    annotation (Dialog(tab="General",group="Parameters"));

  // Definition of records describing the cross-sectional geometry
  //
  inner replaceable parameter
    Utilities.Properties.GeometryHX geoCV
    "Record that contains geometric parameters of the heat exchanger"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Parameters"),
                Placement(transformation(extent={{-90,72},{-70,92}})));

  // Definition of parameters describing the heat transfer calculations
  //
  parameter Boolean useHeaCoeMod = false
    "= true, if model is used to calculate coefficients of heat transfers"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient"));
  replaceable model CoefficientOfHeatTransfer =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    constrainedby PartialCoefficientOfHeatTransfer
    "Model describing the calculation methods of the coefficients of heat 
    transfer"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = useHeaCoeMod),
                choicesAllMatching=true);

  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSC = 100
    "Effective coefficient of heat transfer between the wall and fluid of the
    supercooled regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = not useHeaCoeMod));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpTP = 100
    "Effective coefficient of heat transfer between the wall and fluid of the
    two-phase regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = not useHeaCoeMod));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpSH = 100
    "Effective coefficient of heat transfer between the wall and fluid of the
    superheated regime"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = not useHeaCoeMod));

  parameter Utilities.Types.CalculationHeatFlow
    heaFloCal = Utilities.Types.CalculationHeatFlow.E_NTU
    "Choose the way of calculating the heat flow between the wall and medium"
    annotation (Dialog(tab="Heat transfer",group="Heat flow calculation"));

  // Extensions and propagation of parameters
  //
  extends AixLib.Fluid.Interfaces.PartialTwoPort(
    redeclare replaceable package Medium = AixLib.Media.Water);

  // Definition of parameters describing advanced options
  //
  parameter Boolean iniSteSta = false
    "=true, if temperatures of different regimes are initialised steady state"
    annotation(Dialog(tab="Advanced",group="Initialisation"));

  parameter Modelica.SIunits.Temperature TSCIni = 293.15
    "Temperature of supercooled regime at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation",
               enable=not iniSteSta));
  parameter Modelica.SIunits.Temperature TTPIni = 293.15
    "Temperature of two-phase regime at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation",
               enable=not iniSteSta));
  parameter Modelica.SIunits.Temperature TSHIni = 293.15
    "Temperature of superheated regime at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation",
               enable=not iniSteSta));

  // Definition of subcomponents and connectors
  //
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortSC
    "Heat port of the heat exchange with wall of the supercooled regime"
    annotation (Placement(transformation(extent={{-36,-110},{-16,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortTP
    "Heat port of the heat exchange with wall of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortSH
    "Heat port of the heat exchange with wall of the superheated regime"
    annotation (Placement(transformation(extent={{16,-110},{36,-90}})));

  Modelica.Blocks.Interfaces.RealInput lenInl[3]
    "Lengths of the different regimes"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-104}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-100})));

  Modelica.Blocks.Interfaces.RealOutput AlpThrSC(unit = "W/(m2.K)")
    "Dummy block used for transmission of coefficient of heat transfer of the
    supercooled regime if its model is conditionally removed";
  Modelica.Blocks.Interfaces.RealOutput AlpThrTP(unit = "W/(m2.K)")
    "Dummy block used for transmission of coefficient of heat transfer of the
    two-phase regime if its model is conditionally removed";
  Modelica.Blocks.Interfaces.RealOutput AlpThrSH(unit = "W/(m2.K)")
    "Dummy block used for transmission of coefficient of heat transfer of the
    superheated regime if its model is conditionally removed";

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

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-80,-66},{80,-86}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(points={{80,-40},{-80,-40}}, color={0,127,255},
          arrow={Arrow.Filled,Arrow.None},
          thickness=0.5),
        Line(points={{80,40},{-80,40}},   color={0,127,255},
          arrow={Arrow.Filled,Arrow.None},
          thickness=0.5),
        Line(points={{80,0},{-80,0}},     color={0,127,255},
          arrow={Arrow.Filled,Arrow.None},
          thickness=0.5),
        Polygon(
          points={{-58,54},{-58,54}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(points={{-60,60},{-60,-60}}, color={255,0,0},
          arrow={Arrow.Filled,Arrow.Filled},
          thickness=0.5),
        Line(points={{-20,60},{-20,-60}}, color={255,0,0},
          arrow={Arrow.Filled,Arrow.Filled},
          thickness=0.5),
        Line(points={{20,60},{20,-60}},   color={255,0,0},
          arrow={Arrow.Filled,Arrow.Filled},
          thickness=0.5),
        Rectangle(
          extent={{-80,-66},{80,-86}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(points={{80,-40},{-80,-40}}, color={0,127,255},
          arrow={Arrow.Filled,Arrow.None},
          thickness=0.5),
        Line(points={{80,40},{-80,40}},   color={0,127,255},
          arrow={Arrow.Filled,Arrow.None},
          thickness=0.5),
        Line(points={{80,0},{-80,0}},     color={0,127,255},
          arrow={Arrow.Filled,Arrow.None},
          thickness=0.5),
        Polygon(
          points={{-58,54},{-58,54}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(points={{-60,60},{-60,-60}}, color={255,0,0},
          arrow={Arrow.Filled,Arrow.Filled},
          thickness=0.5),
        Line(points={{-20,60},{-20,-60}}, color={255,0,0},
          arrow={Arrow.Filled,Arrow.Filled},
          thickness=0.5),
        Line(points={{20,60},{20,-60}},   color={255,0,0},
          arrow={Arrow.Filled,Arrow.Filled},
          thickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
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
AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.FluidCells.</a>
</p>
</html>"));
end PartialSecondaryFluidCell;
