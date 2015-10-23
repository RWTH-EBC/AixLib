within AixLib.Building.LowOrder.BaseClasses.ThermalZonePhysics;
model ThermalZonePhysicsRWin
  "All sub-models of VDI 6007 connected to one model"
  extends partialThermalZonePhysics;
  parameter Boolean withInnerwalls = true "If inner walls are existent" annotation(Dialog(tab = "Inner walls"));
  parameter Modelica.SIunits.ThermalResistance R1i = 0.000656956
    "Resistor 1 inner wall"                                                              annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.HeatCapacity C1i = 12049200
    "Capacity 1 inner wall"                                                      annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Area Ai = 60.5 "Inner wall area" annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Temp_K T0all = 295.15
    "Initial temperature for all components";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaiwi = 2.1
    "Coefficient of heat transfer for inner walls"                                                                   annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Boolean withOuterwalls = true
    "If outer walls (including windows) are existent"                                       annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.ThermalResistance RRest = 0.001717044
    "Resistor Rest outer wall"                                                                annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.ThermalResistance R1o = 0.02045808
    "Resistor 1 outer wall"                                                             annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.HeatCapacity C1o = 4896650 "Capacity 1 outer wall"
                                                                                annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Area Ao = 25.5 "Outer wall area" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowi = 2.7
    "Outer wall's coefficient of heat transfer (inner side)"                                                                   annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo = 20
    "Outer wall's coefficient of heat transfer (outer side) "                                                                  annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Emissivity epsi = 1
    "Emissivity of the inner walls"                                              annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Emissivity epso = 1
    "Emissivity of the outer walls"                                              annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Real aowo = 0.7 "Coefficient of absorption of the outer walls" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Boolean withWindows = true "If windows are existent" annotation(Dialog(tab = "Windows", enable = if withOuterwalls then true else false));
  parameter Real splitfac = 0 "Factor for conv. part of rad. through windows" annotation(Dialog(tab = "Windows", enable = if withOuterwalls then true else false));
  parameter Real weightfactorswall[n] = {0.5, 0.2, 0.1, 0.1}
    "Weight factors of the walls"                                                          annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Real weightfactorswindow[n] = {0, 0, 0, 0}
    "Weight factors of the windows"                                                    annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Real weightfactorground = 0
    "Weight factor of the earth (0 if not considered)"                                     annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Temp_K temperatureground = 284.15
    "Temperature of the earth"                                                            annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Emissivity epsw = 0.95 "Emissivity of the windows"
                                                                                annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.TransmissionCoefficient g = 0.7
    "Total energy transmittance"                                                          annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.Volume Vair = 52.5 "Volume of the air in the zone"
                                                                                annotation(Dialog(tab = "Room air"));
  parameter Modelica.SIunits.Density rhoair = 1.19 "Density of the air" annotation(Dialog(tab = "Room air"));
  parameter Modelica.SIunits.SpecificHeatCapacity cair = 1007
    "Heat capacity of the air"                                                           annotation(Dialog(tab = "Room air"));
  parameter Modelica.SIunits.ThermalResistance RWin=0.017727777777
    "Resistor Window"
   annotation(Dialog(tab="Windows",enable = if withWindows then true else false));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaConvWinInner=3.16
    "Coefficient of convective heat transfer of the window (inner side)"
   annotation(Dialog(tab="Windows",enable = if withWindows then true else false));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaConvWinOuter=16.37
    "Coefficient of convective heat transfer of the window (outer side)"
  annotation(Dialog(tab="Windows",enable = if withWindows then true else false));
  parameter Real awin=0.0 "Coefficient of absorption of the window"
  annotation(Dialog(tab="Windows",enable = if withWindows then true else false));
  AixLib.Building.LowOrder.BaseClasses.EqAirTemp.EqAirTempEBCMod eqAirTemp(
    aowo=aowo,
    wf_wall=weightfactorswall,
    wf_win=weightfactorswindow,
    wf_ground=weightfactorground,
    T_ground=temperatureground,
    n=n,
    alphaconv_wall=alphaowo,
    alphaconv_win=alphaConvWinOuter,
    awin=awin,
    orientationswallshorizontal={90,90,90,90}) if
            withOuterwalls
    annotation (Placement(transformation(extent={{-46,0},{-26,20}})));
  AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel.ReducedOrderModelEBCMod
                                                                               reducedOrderModel(
    epsw=epsw,
    g=g,
    RRest=RRest,
    R1o=R1o,
    C1o=C1o,
    Ao=Ao,
    R1i=R1i,
    C1i=C1i,
    Ai=Ai,
    T0all=T0all,
    Vair=Vair,
    alphaiwi=alphaiwi,
    alphaowi=alphaowi,
    rhoair=rhoair,
    cair=cair,
    epsi=epsi,
    epso=epso,
    Aw=sum(Aw),
    withInnerwalls=withInnerwalls,
    withWindows=withWindows,
    withOuterwalls=withOuterwalls,
    splitfac=splitfac,
    RWin=RWin,
    alphaWin=alphaConvWinInner)
    annotation (Placement(transformation(extent={{18,-10},{76,46}})));

equation
  if withWindows and withOuterwalls then
  end if;
  if withOuterwalls then
    connect(eqAirTemp.equalAirTemp, reducedOrderModel.equalAirTemp) annotation(Line(points={{-26.2,
            4.4},{-2,4.4},{-2,19.12},{23.8,19.12}},                                                                                             color = {191, 0, 0}, smooth = Smooth.None));
  end if;
  connect(eqAirTemp.equalAirTempWindow, reducedOrderModel.equalAirTempWindow)
    annotation (Line(
      points={{-26.2,12.6},{-6,12.6},{-6,33.12},{23.8,33.12}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solarRadAdapter.solarRad_out, eqAirTemp.solarRad_in) annotation (Line(
        points={{-54,38},{-54,38},{-54,15.6},{-44.5,15.6}}, color={0,0,127}));
  connect(sunblind.sunblindonoff, eqAirTemp.sunblindsig) annotation (Line(
        points={{-40,60},{-40,60},{-40,28},{-36,28},{-36,18}}, color={0,0,127}));
  connect(weather, eqAirTemp.weatherData)
    annotation (Line(points={{-100,10},{-44,10},{-44,10}}, color={0,0,127}));
  connect(ventilationTemperature, reducedOrderModel.ventilationTemperature)
    annotation (Line(points={{-100,-50},{-48,-50},{10,-50},{10,4.56},{23.8,4.56}},
        color={0,0,127}));
  connect(solRadWeightedSum.solarRad_out, reducedOrderModel.solarRad_in)
    annotation (Line(points={{30.6,71},{38,71},{38,58},{33.66,58},{33.66,44.32}},
        color={0,0,127}));
  connect(ventilationRate, reducedOrderModel.ventilationRate) annotation (Line(
        points={{-28,-90},{-28,-58},{35.98,-58},{35.98,-7.2}}, color={0,0,127}));
  connect(internalGainsConv, reducedOrderModel.internalGainsConv) annotation (
      Line(points={{40,-90},{40,-90},{40,-66},{40,-64},{52.8,-64},{52.8,-7.2}},
        color={191,0,0}));
  connect(internalGainsRad, reducedOrderModel.internalGainsRad) annotation (
      Line(points={{80,-90},{80,-90},{80,-28},{80,-26},{68.75,-26},{68.75,-7.2}},
        color={95,95,95}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}})),                                                                                     Icon(
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
            lineThickness=1,                                                                                                    smooth=
              Smooth.None,                                                                                                    fillColor=
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
          points={{24,-48},{44,-32},{44,10},{24,26}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{44,10},{92,10},{100,18}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{44,-32},{92,-32},{100,-40}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{92,10},{92,-32}},
          color={0,0,0},
          smooth=Smooth.None),                                                                                                    Rectangle(extent={{
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
          textString="%name")}),                                                                                                    experiment(StopTime = 864000, Interval = 3599), experimentSetupOutput, Documentation(info = "<html>
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
 </html>", revisions="<html>
<ul>
<li><i>June 2015,&nbsp;</i> by Moritz Lauster:<br>Implemented. </li>
</ul>
</html>"));
end ThermalZonePhysicsRWin;
