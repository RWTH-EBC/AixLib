within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.BaseClasses;
partial model PartialCoefficientOfHeatTransfer
  "This model is a base class for all models describing methods of calculating
  coefficients of heat transfer"

  // Definition of inputs
  //
  inner replaceable parameter
    Utilities.Properties.GeometryHX geoCV
    "Record that contains geometric parameters of the heat exchanger";

  // Definition of outputs
  //
  Modelica.Blocks.Interfaces.RealOutput
    Alp(quantity="CoefficientOfHeatTransfer", unit="W/(m2.K)")
    "Effective coefficient of heat transfer";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(
          extent={{-90,90},{90,-90}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Sphere),
        Text(
          extent={{-100,100},{100,-70}},
          lineColor={0,0,0},
          fontName="SWGrekc",
          textString="a",
          textStyle={TextStyle.Bold}),
        Text(
          lineColor={0,0,255},
          extent={{-100,-130},{100,-90}},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
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
This model is the base class for all models describing
calculation methods of the coefficient of heat transfer.
Therefore, this base class defines basic parameters
required by all models of coefficient of heat transfers.<br />
These parameters are listed below:
</p>
<ul>
<li>
Parameters describing the cross-sectional geometry.
</li>
</ul>
<p>
Models that inherits from this base class are stored
in
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.HeatTransfers\">
AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.HeatTransfers.</a>
</p>
</html>"));
end PartialCoefficientOfHeatTransfer;
