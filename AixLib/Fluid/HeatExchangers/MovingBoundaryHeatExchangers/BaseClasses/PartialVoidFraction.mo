within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.BaseClasses;
partial model PartialVoidFraction
  "This model is a base class for all models describing the void fraction"

  // Definition of the medium
  //
  replaceable package Medium =
   Modelica.Media.R134a.R134a_ph
   constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
   "Current medium of the heat exchanger"
   annotation(Dialog(tab="General",group="General"),
              choicesAllMatching=true);

  // Definition of variables describing thermodynamic states
  //
  input Modelica.SIunits.AbsolutePressure p
    "Current pressure";
  input Modelica.SIunits.SpecificEnthalpy hSCTP
    "Current specific enthalpy at the boundary between the supercooled and
    two-phase regime";
  input Modelica.SIunits.SpecificEnthalpy hTPSH
    "Current specific enthalpy at the boundary between the two-phase and 
    superheated regime";

  // Definition of outputs
  //
  Modelica.Blocks.Interfaces.RealOutput voiFra(unit="1")
    "Current void fraction calculated by the model";
  Modelica.Blocks.Interfaces.RealOutput voiFra_der(unit="1/s")
    "Current derivative of the void fraction wrt. time calculated by the model";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(
          extent={{-90,90},{90,-90}},
          lineColor={175,175,175},
          fillColor={95,95,95},
          fillPattern=FillPattern.Sphere),
        Polygon(
          points={{-88,50},{-88,-50},{2,-100},{82,-52},{0,-78},{-16,-18},{-16,24},
              {0,80},{82,52},{2,100},{-88,50}},
          lineColor={28,108,200},
          smooth=Smooth.Bezier,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,58},{26,38}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{46,-28},{66,-48}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{2,-40},{22,-60}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{42,12},{62,-8}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{40,58},{60,38}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,-6},{16,-26}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,28},{26,8}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,80},{-10,-40}},
          lineColor={0,0,0},
          fontName="SWGrekc",
          textStyle={TextStyle.Bold},
          textString="g")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
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
This model is a base class for all void fraction models of a moving boundary 
heat exchanger. Therefore, this model defines some connectors, parameters and 
submodels that are required for all void fraction models. These basic 
definitions are listed below:
</p>
<ul>
<li>
The current medium of the heat exchanger.
</li>
<li>
Inputs describing the current saturation properties.
</li>
<li>
Inputs describing derivatives of state variables wrt. time.
</li>
</ul>
<p>
Models that inherits from this base class are stored in
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.VoidFractions\">
AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.VoidFractions.</a>
</p>
</html>"));
end PartialVoidFraction;
