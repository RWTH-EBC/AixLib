within AixLib.Utilities.HeatTransfer;
model HeatConvOutside "Model for heat transfer at outside surfaces. Choice between multiple models"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Integer calcMethod=2 "Calculation method for convective heat transfer coefficient" annotation (
    Evaluate=true,
    Dialog(
      group="Computational Models",
      compact=true,
      descriptionLabel=true),
    choices(
      choice=1 "DIN 6946",
      choice=2 "ASHRAE Fundamentals (convective + radiative)",
      choice=3 "Custom hCon (constant)",
      radioButtons=true));
  parameter Modelica.Units.SI.Area A(min=0) "Area of surface"
    annotation (Dialog(group="Surface properties", descriptionLabel=true));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hCon_const=25
    "Custom convective heat transfer coeffient" annotation (Dialog(
      group="Surface properties",
      descriptionLabel=true,
      enable=calcMethod == 3));
  parameter
    DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook         surfaceType = DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()
    "Surface type"                                                                                                     annotation(Dialog(group = "Surface properties", descriptionLabel = true, enable=
          calcMethod == 2),                                                                                                                                                                                           choicesAllMatching = true);
  // Variables
  Modelica.Units.SI.CoefficientOfHeatTransfer hCon
    "Convection heat transfer coeffient";
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort if calcMethod == 1 or calcMethod == 2              annotation(Placement(transformation(extent = {{-102, -82}, {-82, -62}}), iconTransformation(extent={{-100,-80},{-80,-60}})));

protected
  Modelica.Blocks.Interfaces.RealInput WindSpeed_internal(unit="m/s");
equation
  // Main equation of heat transfer
  port_a.Q_flow =hCon*A*(port_a.T - port_b.T);

  //Determine convection heat transfer coefficient hCon
  if calcMethod == 1 then
    hCon = (4 + 4*WindSpeed_internal);
  elseif calcMethod == 2 then
    hCon = surfaceType.D + surfaceType.E*WindSpeed_internal + surfaceType.F*(WindSpeed_internal^2);
  else
    hCon = hCon_const;
    WindSpeed_internal = 0;
  end if;

  connect(WindSpeedPort, WindSpeed_internal);
  annotation(Icon(graphics={  Rectangle(extent={{-80,80},{80,-80}},      lineColor = {0, 0, 0}), Rectangle(extent={{0,80},{20,-80}},      lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{20,80},{40,-80}},      lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {182, 182, 182},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{40,80},{60,-80}},      lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {207, 207, 207},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{60,80},{80,-80}},      lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {244, 244, 244},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{-80,80},{0,-80}},      lineColor = {255, 255, 255}, fillColor = {85, 85, 255},
            fillPattern =                                                                                                   FillPattern.Solid),                                                                    Polygon(points={{80,80},{80,80},{60,40},{60,80},{80,80}},            lineColor = {0, 0, 255},  pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, fillColor = {157, 166, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points={{60,80},{60,40},{40,0},{40,80},{60,80}},              lineColor = {0, 0, 255},  pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, fillColor = {102, 110, 139},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points={{40,80},{40,0},{20,-40},{20,80},{40,80}},              lineColor = {0, 0, 255},  pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, fillColor = {75, 82, 103},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points={{20,80},{20,-40},{0,-80},{0,80},{20,80}},            lineColor = {0, 0, 255},  pattern = LinePattern.None,
            lineThickness =                                                                                                   0.5, fillColor = {51, 56, 70},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points={{-20,36},{-20,-44}},      color = {255, 255, 255}, thickness = 0.5), Line(points={{-20,36},{-30,24}},      color = {255, 255, 255}, thickness = 0.5), Line(points={{-38,36},{-48,24}},      color = {255, 255, 255}, thickness = 0.5), Line(points={{
              -54,36},{-64,24}},                                                                                                                                                                                                        color = {255, 255, 255}, thickness = 0.5), Line(points={{
              -38,36},{-38,-44}},                                                                                                                                                                                                        color = {255, 255, 255}, thickness = 0.5), Line(points={{
              -54,36},{-54,-44}},                                                                                                                                                                                                        color = {255, 255, 255}, thickness = 0.5),
                                                                                                                                                Rectangle(extent={{-80,80},{80,-80}},      lineColor = {0, 0, 0})}),                                                                                                                                                                                                        Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  The <b>HeatTransferOutside</b> is a model for the convective heat
  transfer at outside walls
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  It allows the choice between three different models:
</p>
<ul>
  <li>after DIN 6946: <code><i>h</i> = 4+4<i>v</i></code> , where
  <i><code>h</code></i> <b>(hCon)</b> is the heat transfer coefficent
  and <i><b><code>v</code></b></i> is the wind speed
  </li>
  <li>after the ASHRAE Fundamentals Handbook from 1989, the way it is
  presented in EnergyPlus Engineering reference from 2011: <i><code>h =
  D+Ev+Fv^2</code></i> , where <i><code>h</code></i> <b>(hCon)</b> and
  <i><b><code>v</code></b></i> are as above and the coefficients <i><b>
    <code>D, E, F</code></b></i> depend on the surface of the outer
    wall.<br/>
    <b><span style=\"color: #ff0000;\">Attention:</span></b> This is a
    combined coefficient for convective and radiative heat exchange.
  </li>
  <li>with a custom constant <i><code>h</code></i> <b>(hCon)</b> value
  </li>
</ul>
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<ul>
  <li>DIN 6946 p.20
  </li>
  <li>ASHRAEHandbook1989, as cited in EnergyPlus Engineering Reference.
  : EnergyPlus Engineering Reference, 2011 p.56
  </li>
</ul>
<p>
  <b><span style=\"color: #008000;\">Example Results</span></b>
</p>
<p>
  <a href=
  \"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.Examples.HeatTransfer_test</a>
</p>
<p>
  <a href=
  \"AixLib.Utilities.Examples.HeatConv_outside\">AixLib.Utilities.Examples.HeatConv_outside</a>
</p>
<ul>
  <li>
    <i>November 16, 2016&#160;</i> by Ana Constantin:<br/>
    Conditioned input WindSpeedPort and introduced protected input
    WindSpeed_internal
  </li>
</ul>
<ul>
  <li>
    <i>April 1, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
</ul>
<ul>
  <li>
    <i>March 30, 2012&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end HeatConvOutside;
