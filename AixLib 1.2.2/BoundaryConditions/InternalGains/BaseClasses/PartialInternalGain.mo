within AixLib.BoundaryConditions.InternalGains.BaseClasses;
partial model PartialInternalGain
  "Partial model to build a heat source with convective and radiative component"
  parameter Real ratioConv(final min=0, final max=1) = 0.6
    "Ratio convective to total heat release" annotation(Dialog(descriptionLabel = true));
  parameter Modelica.Units.SI.Emissivity emissivity(
    min=0,
    max=1) = 0.95 "Emissivity of radiative heat source surface";
  Modelica.Blocks.Interfaces.RealInput uRel(min=0, max=1) "Relative input related to max. value (might be a ratio related to number of people [-] or room area and specific heat flow [W/m2] or maximal heat flow [W]"
     annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow convectiveHeat(final T_ref=293.15, final alpha=0)
     annotation (Placement(transformation(extent={{24,10},{44,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow radiativeHeat(final T_ref=293.15, final alpha=0)
     annotation (Placement(transformation(extent={{24,-30},{44,-10}})));
  AixLib.Utilities.HeatTransfer.HeatToRad radConvertor(final eps=emissivity, final use_A_in=true)
    "Adaptor for approximative longwave radiation exchange with surface area"
    annotation (Placement(transformation(extent={{52,-70},{72,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convHeat
    "Convective heat flow connector"
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  AixLib.Utilities.Interfaces.RadPort radHeat
    "Radiative heat flow connector"
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  Modelica.Blocks.Math.Gain gain annotation (Placement(transformation(extent={{-60,-6},{-48,6}})));
  Modelica.Blocks.Math.Gain gainSurfaces annotation (Placement(transformation(extent={{-60,-66},{-48,-54}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=Modelica.Constants.inf, final uMin=Modelica.Constants.eps) annotation (Placement(transformation(extent={{-38,-66},{-26,-54}})));
protected
  Modelica.Blocks.Math.MultiProduct productHeatOutput(nu=1, y(final quantity="Power", final unit="W"))
    annotation (Placement(transformation(extent={{-20,-6},{-8,6}})));
  Modelica.Blocks.Math.Gain gainConv(final k=ratioConv) annotation (Placement(transformation(extent={{8,16},{16,24}})));
  Modelica.Blocks.Math.Gain gainRad(final k=1 - ratioConv) annotation (Placement(transformation(extent={{8,-24},{16,-16}})));
equation
  connect(convectiveHeat.port,convHeat)  annotation(Line(points={{44,20},{48,20},{48,60},{90,60}},          color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(gainConv.y, convectiveHeat.Q_flow) annotation (Line(points={{16.4,20},{24,20}}, color={0,0,127}));
  connect(gainRad.y, radiativeHeat.Q_flow) annotation (Line(points={{16.4,-20},{24,-20}}, color={0,0,127}));
  connect(productHeatOutput.y, gainConv.u) annotation (Line(points={{-6.98,0},{0,0},{0,20},{7.2,20}}, color={0,0,127}));
  connect(productHeatOutput.y, gainRad.u) annotation (Line(points={{-6.98,0},{0,0},{0,-20},{7.2,-20}}, color={0,0,127}));
  connect(radiativeHeat.port, radConvertor.convPort) annotation (Line(points={{44,-20},{48,-20},{48,-60},{52,-60}}, color={191,0,0}));
  connect(radConvertor.radPort, radHeat) annotation (Line(
      points={{72.1,-60},{90,-60}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(uRel, gain.u) annotation (Line(points={{-100,0},{-61.2,0}}, color={0,0,127}));
  connect(gain.y, productHeatOutput.u[1]) annotation (Line(points={{-47.4,0},{-20,0}}, color={0,0,127}));
  connect(gainSurfaces.y,limiter. u) annotation (Line(points={{-47.4,-60},{-39.2,-60}}, color={0,0,127}));
  connect(limiter.y, radConvertor.A_in) annotation (Line(points={{-25.4,-60},{20,-60},{20,-40},{62,-40},{62,-49}}, color={0,0,127}));
  connect(uRel, gainSurfaces.u) annotation (Line(points={{-100,0},{-80,0},{-80,-60},{-61.2,-60}}, color={0,0,127}));
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>March 26, 202020&#160;</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/886\">#886</a>
    refactor input schedule and other components.
  </li>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>May 02, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>April 30, 2012</i> by Peter Matthes:<br/>
    implemented partial model for heat sources to work with Ana's
    models.
  </li>
  <li>
    <i>August 10, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",  info="<html>
<p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Partial model to build a heat source with <i>convective</i> and
  <i>radiative</i> components. The parameter <span style=
  \"font-family: Courier New;\">ratioConv</span> determines the share of
  convective heat. The <i>input</i> is always a relativ input between
  0..1.
</p>
<p>
  <b><span style=\"color: #008000;\">Assumptions</span></b>
</p>
<p>
  The surface for radiation exchange is computed from the area of the
  emitting component. For more information see <span style=
  \"font-family: Courier New;\"><a href=
  \"modelica://AixLib.Utilities.HeatTransfer.HeatToRad\">AixLib.Utilities.HeatTransfer.HeatToRad</a></span>
</p>
<p>
  An input of 0 leads to a surface area of zero and, thus, to division
  by zero. For this reason a limitiation for the surface has been
  intoduced.
</p>
</html>"));
end PartialInternalGain;
