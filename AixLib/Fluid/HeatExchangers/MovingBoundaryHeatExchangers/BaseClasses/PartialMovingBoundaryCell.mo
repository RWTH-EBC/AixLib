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
  parameter Boolean useVoiFraMod = true
    "= true, if model is used to calculate void fraction"
    annotation (Dialog(tab="General",group="Void fraction"));
  parameter Real voiFraPar = 0.85
    "Constant void fraction if not calculated by model"
    annotation (Dialog(tab="General",group="Void fraction",
                enable = not useVoiFraMod));
  replaceable model VoidFractionModel =
    Utilities.VoidFractions.Sangi2015
    constrainedby BaseClasses.PartialVoidFraction
    "Model describing calculation of void fraction"
    annotation (Dialog(tab="General",group="Void fraction",
                enable = useVoiFraMod),
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
    heaFloCal = Utilities.Types.CalculationHeatFlow.E_NTU
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
    (hInl = hOut+dh0 | hOut=hInl+dh0) at initialisation"
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
  parameter Real dhOutDesdtIni(unit="J/(kg.s)") = 1e-5
    "Guess value of dhOutDesdt"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Real dlenSCdtIni(unit="1/s") = 1e-5
    "Guess value of dtlenSCdt"
    annotation(Dialog(tab="Advanced",group="Start values iteration"));
  parameter Real dlenTPdtIni(unit="1/s") = 1e-5
    "Guess value of dlenTPdt"
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
