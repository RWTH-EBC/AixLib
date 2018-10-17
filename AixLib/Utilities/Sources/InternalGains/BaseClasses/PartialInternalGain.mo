within AixLib.Utilities.Sources.InternalGains.BaseClasses;
partial model PartialInternalGain
  "Partial model to build a heat source with convective and radiative component"
  parameter Real ratioConv = 0.6 "Ratio convective to total heat release" annotation(Dialog(descriptionLabel = true));
  parameter Real emissivity = 0.95
    "emissivity of radiative heat source surface";
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(22)
    "Initial temperature";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeat(T_ref = T0) annotation(Placement(transformation(extent = {{20, 20}, {40, 40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow RadiativeHeat(T_ref = ratioConv) annotation(Placement(transformation(extent = {{20, -20}, {40, 0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvHeat
    "convective heat connector"                                                            annotation(Placement(transformation(extent = {{80, 50}, {100, 70}}), iconTransformation(extent = {{80, 50}, {100, 70}})));
  Utilities.Interfaces.Star RadHeat "radiative heat connector" annotation(Placement(transformation(extent = {{80, -70}, {100, -50}}), iconTransformation(extent = {{80, -68}, {100, -48}})));
  Modelica.Blocks.Interfaces.RealInput Schedule annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}), iconTransformation(extent = {{-100, -10}, {-80, 10}})));
  Modelica.Blocks.Math.Gain gain(k = ratioConv) annotation(Placement(transformation(extent = {{4, 26}, {12, 34}})));
  Modelica.Blocks.Math.Gain gain1(k = 1 - ratioConv) annotation(Placement(transformation(extent = {{4, -14}, {12, -6}})));
equation
  connect(ConvectiveHeat.port, ConvHeat) annotation(Line(points = {{40, 30}, {46, 30}, {46, 60}, {90, 60}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(gain.y, ConvectiveHeat.Q_flow) annotation(Line(points = {{12.4, 30}, {20, 30}}, color = {0, 0, 127}));
  connect(gain1.y, RadiativeHeat.Q_flow) annotation(Line(points = {{12.4, -10}, {20, -10}}, color = {0, 0, 127}));
  annotation (Documentation(revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>April 30, 2012</i> by Peter Matthes:<br/>implemented partial model for heat sources to work with Ana's models.</li>
 <li><i>August 10, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Partial model to build a heat source with convective and radiative components. The parameter <code>ratioConv</code> determines the percentage of convective heat.</p>
 </html>"));
end PartialInternalGain;
