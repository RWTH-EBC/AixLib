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
  replaceable model CoefficientOfHeatTransferSC =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    constrainedby PartialCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer of the supercooled region"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = useHeaCoeMod),
                choicesAllMatching=true);
  replaceable model CoefficientOfHeatTransferTP =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    constrainedby PartialCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer of the two-phase region"
    annotation (Dialog(tab="Heat transfer",group="Heat transfer coefficient",
                enable = useHeaCoeMod),
                choicesAllMatching=true);
  replaceable model CoefficientOfHeatTransferSH =
    Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer
    constrainedby PartialCoefficientOfHeatTransfer
    "Model describing the calculation method of the coefficient of heat 
    transfer of the superheated region"
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
    redeclare replaceable package Medium = AixLib.Media.Water);

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
Models that inherits from this base class are stored
in
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.FluidCells\">
AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.GeometryHX.</a>
</p>
</html>"));
end PartialSecondaryFluidCell;
