within AixLib.Building.LowOrder.ThermalZone;
partial model partialThermalZone
  "partial for ready-to-use Low Order building model"
  parameter DataBase.Buildings.ZoneBaseRecord zoneParam = DataBase.Buildings.OfficePassiveHouse.OPH_1_Meeting()
    "choose setup for this zone"                                                                                                     annotation(choicesAllMatching = true);
  Modelica.Blocks.Interfaces.RealInput infiltrationRate annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-40, -100}), iconTransformation(extent = {{-12, -12}, {12, 12}}, rotation = 90, origin = {-40, -88})));
  Modelica.Blocks.Interfaces.RealInput weather[3] if zoneParam.withOuterwalls
    "[1]: Air temperature<br/>[2]: Horizontal radiation of sky<br/>[3]: Horizontal radiation of earth"
                                                                                                        annotation(Placement(transformation(extent = {{-120, 0}, {-80, 40}}), iconTransformation(extent = {{-86, -12}, {-62, 12}})));
  Utilities.Interfaces.SolarRad_in solarRad_in[zoneParam.n] if zoneParam.withOuterwalls annotation(Placement(transformation(extent = {{-100, 70}, {-80, 90}}), iconTransformation(extent = {{-100, 40}, {-60, 80}})));
  Modelica.Blocks.Interfaces.RealInput internalGains[3]
    "persons, machines, lighting"                                                     annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {80, -100}), iconTransformation(extent = {{-12, -12}, {12, 12}}, rotation = 90, origin = {80, -88})));
  replaceable BaseClasses.ThermalZonePhysics.ThermalZonePhysicsEBCMod thermalZonePhysics(RRest = zoneParam.RRest, R1o = zoneParam.R1o, C1o = zoneParam.C1o, Ao = zoneParam.Ao, T0all = zoneParam.T0all, alphaowi = zoneParam.alphaowi, alphaowo = zoneParam.alphaowo, epso = zoneParam.epso, R1i = zoneParam.R1i, C1i = zoneParam.C1i, Ai = zoneParam.Ai, Vair = zoneParam.Vair, alphaiwi = zoneParam.alphaiwi, rhoair = zoneParam.rhoair, cair = zoneParam.cair, epsi = zoneParam.epsi, aowo = zoneParam.aowo, epsw = zoneParam.epsw, g = zoneParam.g, Imax = zoneParam.Imax, n = zoneParam.n, weightfactorswall = zoneParam.weightfactorswall, weightfactorswindow = zoneParam.weightfactorswindow, weightfactorground = zoneParam.weightfactorground, temperatureground = zoneParam.temperatureground, Aw = zoneParam.Aw, gsunblind = zoneParam.gsunblind, withInnerwalls = zoneParam.withInnerwalls, withWindows = zoneParam.withWindows, withOuterwalls = zoneParam.withOuterwalls, splitfac = zoneParam.splitfac) constrainedby
    AixLib.Building.LowOrder.BaseClasses.ThermalZonePhysics.partialThermalZonePhysics
                                                                                      annotation(Placement(transformation(extent = {{-20, 0}, {20, 40}})),choicesAllMatching=true);
  Modelica.Blocks.Interfaces.RealInput infiltrationTemperature annotation(Placement(transformation(extent = {{-100, -60}, {-60, -20}}), iconTransformation(extent = {{-88, -52}, {-62, -26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv annotation(Placement(transformation(extent = {{-10, -100}, {10, -80}}), iconTransformation(extent = {{-10, -100}, {10, -80}})));
  Utilities.Interfaces.Star internalGainsRad annotation(Placement(transformation(extent = {{30, -100}, {50, -80}})));
equation
  if zoneParam.withOuterwalls then
  end if;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,  extent={{-100,
            -100},{100,100}}),                                                                                                    graphics={  Rectangle(extent={{
              -60,62},{100,-58}},
            lineThickness=1,                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.HorizontalCylinder,
           pattern = LinePattern.None,
          lineColor={0,0,0}),                                                                                                    Rectangle(extent={{
              -60,80},{100,6}},
            lineThickness=1,                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid,
           pattern = LinePattern.None),                                                                                                    Rectangle(extent = {{-60, -58}, {100, -70}},
            lineThickness=1,                                                                                                    fillColor=
              {0,127,0},
            fillPattern=FillPattern.HorizontalCylinder,
           pattern = LinePattern.None,
          lineColor={0,0,0}),                                                                                                    Rectangle(extent = {{14, 36}, {100, -58}}, lineColor=
              {0,0,0},                                                                                                    fillColor=
              {215,215,215},
            fillPattern=FillPattern.Forward),                                                                                                    Polygon(points = {{100, 36}, {-2, 36}, {100, 60}, {100, 36}}, lineColor=
              {236,99,92},
            lineThickness=1,                                                                                                    fillColor=
              {236,99,92},
            fillPattern=FillPattern.Solid),                                                                                                    Rectangle(extent={{
              22,28},{100,-50}},                                                                                                    fillColor=
              {230,230,230},
            fillPattern=FillPattern.Solid,                                                                                                    lineColor=
              {0,0,0}),                                                                                                    Rectangle(extent={{
              54,-6},{64,-12}},                                                                                                    lineColor=
              {0,0,0},                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid),                                                                                                    Polygon(points={{
              64,-40},{68,-36},{78,-36},{82,-40},{64,-40}},                                                                                                    pattern = LinePattern.Solid, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points={{
              68,-39},{70,-37},{76,-37},{78,-39},{68,-39}},                                                                                                    pattern = LinePattern.Solid, fillColor = {95, 95, 95},
            fillPattern =                                                                                                   FillPattern.Solid, lineColor = {0, 0, 0}),      Text(extent = {{-90, 134}, {98, 76}}, lineColor=
              {0,0,255},
          textString="%name"),                                                                      Ellipse(extent={{
              -58,78},{-16,36}},
            lineThickness=1,                                                                                                    fillColor=
              {255,221,0},
            fillPattern=FillPattern.Solid,
           pattern = LinePattern.None),                                                                                                    Rectangle(extent={{
              -60,-64},{100,-70}},
            lineThickness=1,                                                                                                    fillColor=
              {0,127,0},
            fillPattern=FillPattern.Solid,
           pattern = LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{22,-50},{42,-28},{42,14},{22,28}}),
        Line(
          points={{42,-28},{86,-28},{100,-42}}),
        Line(
          points={{86,-28},{86,14},{100,24}}),
        Line(
          points={{42,14},{86,14}}),                                                                                                    Ellipse(extent = {{4, -4}, {-4, 4}},                            fillColor=
              {255,221,0},
            fillPattern=FillPattern.Solid,                                                                                                    origin={65,
              14},                                                                                                    rotation = 180,
           pattern = LinePattern.None),                                                                                                    Rectangle(extent={{
              62,22},{68,18}},                                                                                                    pattern = LinePattern.Solid,
            lineThickness =                                                                                                   1, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, lineColor = {0, 0, 0}),
                                                                                                  Rectangle(extent={{
              54,0},{64,-6}},                                                                                                    lineColor=
              {0,0,0},                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid),                                                                                                    Rectangle(extent={{
              64,0},{74,-6}},                                                                                                    lineColor=
              {0,0,0},                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid),                                                                                                    Rectangle(extent={{
              64,-6},{74,-12}},                                                                                                    lineColor=
              {0,0,0},                                                                                                    fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid),                                                                                                    Ellipse(extent={{
              49,-26},{53,-30}},                                                                                                    lineColor=
              {0,0,0},                                                                                                    fillColor=
              {0,0,0},
            fillPattern=FillPattern.Solid),
        Line(
          points={{51,-30},{51,-38}},
          thickness=0.5),
        Line(
          points={{51,-38},{47,-42}},
          thickness=0.5),
        Line(
          points={{51,-32},{47,-36}},
          thickness=0.5),
        Line(
          points={{51,-32},{55,-36}},
          thickness=0.5),
        Line(
          points={{51,-38},{55,-42}},
          thickness=0.5),                                                                                                    Rectangle(extent={{
              65,-24},{81,-34}},                                                                                                    pattern = LinePattern.Solid,
            lineThickness =                                                                                                   1, fillColor = {95, 95, 95},
            fillPattern =                                                                                                   FillPattern.Solid, lineColor = {0, 0, 0}), Rectangle(extent={{
              67,-26},{79,-32}},                                                                                                    pattern = LinePattern.Solid,
            lineThickness =                                                                                                   1, fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, lineColor = {0, 0, 0})}),
                                                                                                  Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>The ThermalZone reflects the VDI 6007 components (in ThermalZonePhysics) and adds some standards parts of the EBC library for easy simulation with persons, lights and maschines.</li>
 <li>Inputs: real weather vector, as defined in <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>; vectorial solarRad_in, the solar radiation (diffuse and direct) for all n directions; real infiltration/ventilation as defined in <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> and real inner loads input for profiles. </li>
 <li>Parameters: All parameters are collected in a ZoneRecord (see <a href=\"AixLib.DataBase.Buildings.ZoneBaseRecord\">ZoneBaseRecord</a>). </li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars5.png\" alt=\"stars: 5 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>ThermalZone is thought for easy computations to get information about air temperatures and heating profiles. Therefore, some simplifications have been implemented (one air node, one inner wall, one outer wall). </p>
 <p>All theory is documented in VDI 6007. How to gather the physical parameters for the thermal zone is documented in this standard. It is possible to get this information out of the normal information of a building. Various data can be used, depending on the abilities of the preprocessing tools. </p>
 <p><br/><b><font style=\"color: #008000; \">References</font></b></p>
 <ul>
 <li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
 <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>.</li>
 </ul>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p>See <a href=\"Examples\">Examples</a> for some results. </p>
 </html>", revisions = "<html>
 <ul>
   <li><i>March, 2012&nbsp;</i>
          by Moritz Lauster:<br/>
          Implemented</li>
 </ul>
 </html>"));
end partialThermalZone;
