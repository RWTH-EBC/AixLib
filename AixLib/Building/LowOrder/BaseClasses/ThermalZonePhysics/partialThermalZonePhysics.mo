within AixLib.Building.LowOrder.BaseClasses.ThermalZonePhysics;
partial model partialThermalZonePhysics
  parameter Modelica.SIunits.Area Aw[n] = {1, 1, 1, 1, 1} "Area of the windows"
                                                                                annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.TransmissionCoefficient gsunblind[n] = {1, 1, 1, 1, 1}
    "Total energy transmittances if sunblind is closed"                                                                              annotation(Dialog(tab = "Windows", group = "Shading", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.RadiantEnergyFluenceRate Imax = 100
    "Intensity at which the sunblind closes"                                                              annotation(Dialog(tab = "Windows", group = "Shading", enable = if withWindows and withOuterwalls then true else false));
  parameter Integer n = 5 "Number of orientations (without ground)" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  SolarRadWeightedSum solRadWeightedSum(n=n, weightfactors=Aw) annotation (Placement(transformation(extent={{4,56},{32,86}})));
  Components.Weather.Sunblinds.Sunblind sunblind(
    Imax=Imax,
    n=n,
    gsunblind=gsunblind) annotation (Placement(transformation(extent={{-50,59},{-30,79}})));
  Utilities.Interfaces.SolarRad_in solarRad_in[n] annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}}), iconTransformation(extent = {{-94, 50}, {-60, 80}})));
  Modelica.Blocks.Interfaces.RealInput weather[3]
    "[1]: Air temperature<br/>[2]: Horizontal radiation of sky<br/>[3]: Horizontal radiation of earth"
                                                                                                       annotation(Placement(transformation(extent = {{-120, -10}, {-80, 30}}), iconTransformation(extent = {{-90, 4}, {-60, 34}})));
  Modelica.Blocks.Interfaces.RealInput ventilationRate annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-28, -90}), iconTransformation(extent = {{-14, -14}, {14, 14}}, rotation = 90, origin = {-40, -86})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv annotation(Placement(transformation(extent = {{30, -100}, {50, -80}}), iconTransformation(extent = {{30, -100}, {50, -80}})));
  Utilities.Interfaces.Star internalGainsRad annotation(Placement(transformation(extent = {{70, -100}, {90, -80}}), iconTransformation(extent = {{70, -100}, {90, -80}})));
  Modelica.Blocks.Interfaces.RealInput ventilationTemperature annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, origin = {-100, -50}), iconTransformation(extent = {{-15, -15}, {15, 15}}, origin = {-76, -40})));
  SolarRadAdapter solarRadAdapter[n]
    annotation (Placement(transformation(extent={{-74,28},{-54,48}})));

  replaceable
    AixLib.Building.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorG_VDI6007
    corG(n=n) constrainedby
    Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
    annotation (Placement(transformation(extent={{-24,60},{-4,80}})),choicesAllMatching=true);
equation
  connect(solarRad_in, sunblind.Rad_In) annotation(Line(points={{-90,70},{-49,70}},                            color = {255, 128, 0}));
  connect(solarRadAdapter.solarRad_in, solarRad_in) annotation (Line(
      points={{-73,38},{-76,38},{-76,70},{-90,70}},
      color={255,128,0}));
  connect(sunblind.Rad_Out, corG.SR_input) annotation (Line(
      points={{-31,70},{-28,70},{-28,69.9},{-23.8,69.9}},
      color={255,128,0}));
  connect(corG.solarRadWinTrans, solRadWeightedSum.solarRad_in)
    annotation (Line(
      points={{-5,70},{0,70},{0,71},{5.4,71}},
      color={0,0,127}));
  annotation (Icon(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),                                                                                                    graphics={  Rectangle(extent={{
              -60,64},{98,-58}},                                                                                                    lineColor=
              {0,0,0},
            lineThickness=1,                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.HorizontalCylinder),                                                                             Rectangle(extent={{
              -60,80},{100,0}},
            lineThickness=1,                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{14,36},{100,-58}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),                                                                                                    Rectangle(extent = {{-60, -58}, {100, -70}}, lineColor=
              {0,127,0},
            lineThickness=1,                                                                                                    fillColor=
              {0,127,0},
            fillPattern=FillPattern.HorizontalCylinder),                                                                                         Rectangle(extent={{
              24,26},{100,-48}},                                                                                                    lineColor=
              {0,0,0},                                                                                                    fillColor=
              {230,230,230},
            fillPattern=FillPattern.Solid),                                                                                                    Polygon(points={{
              100,36},{-2,36},{100,68},{100,36}},
            lineThickness=1,                                                                                                    fillColor=
              {236,99,92},
            fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),                                                                                                    Rectangle(extent={{
              55,-2},{67,-10}},                                                                                                    lineColor=
              {0,0,0},                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid),                                                                                                    Ellipse(extent={{
              -58,78},{-16,36}},
            lineThickness=1,                                                                                                    fillColor=
              {255,221,0},
            fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-60,-64},{100,-70}},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fillColor={0,127,0},
          pattern=LinePattern.None),
        Line(
          points={{24,-48},{44,-32},{44,10},{24,26}}),
        Line(
          points={{44,10},{92,10},{100,18}}),
        Line(
          points={{44,-32},{92,-32},{100,-40}}),
        Line(
          points={{92,10},{92,-32}}),                                                                                                    Rectangle(extent={{
              67,-2},{79,-10}},                                                                                                    lineColor=
              {0,0,0},                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid),                                                                                                    Rectangle(extent={{
              67,-10},{79,-18}},                                                                                                    lineColor=
              {0,0,0},                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid),                                                                                                    Rectangle(extent={{
              55,-10},{67,-18}},                                                                                                    lineColor=
              {0,0,0},                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid),
        Text(
          extent={{-52,112},{94,76}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={236,99,92},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                                                                                    experiment(StopTime = 864000, Interval = 3599),Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>This model connects <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> with <a href=\"AixLib.Building.Components.Weather.Sunblind\">Sunblind</a> and <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>. All this models have been developed in the context of VDI 6007 to have the whole VDI 6007 model in Dymola. ThermalZonePhysics reflects all components described in the standard. </li>
 <li>Additionally some other parts are used, like <a href=\"AixLib.Building.LowOrder.BaseClasses.SolarRadWeightedSum\">SolarRadWeightedSum</a>. They are necessary for an easy handling of the complex model. </li>
 <li>Inputs: real weather vector, as defined in <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>; vectorial SolarRad_in, the solar radiation (diffuse and direct) for all n directions; real infiltration/ventilation as defined in <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a>; one thermal and one star input for inner loads, heating, etc. . </li>
 <li>Parameters: Most of the parameters are geometric and building pyhsic parameters and are used in the ReducedOrderModel or in the eqAirTemp component. See the documentation of the submodels or VDI 6007 for more information.</li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars5.png\" alt=\"stars: 5 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The concept is desrcibed in VDI 6007 and in the submodels. Basically, ThermalZonePhysics is thought for the easy computation of room temperatures and heat load profiles for thermal zones, e.g. buildings. To reduce computation time, number of parameters and work, some simplifications are implemented into the model (only one air node, ideal building technology, one outer wall, one inner wall). See VDI 6007 for more information.</p>
 <p><br/><b><font style=\"color: #008000; \">References</font></b></p>
 <ul>
 <li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
 <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>.</li>
 </ul>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p>See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul>
 </html>"));
end partialThermalZonePhysics;
