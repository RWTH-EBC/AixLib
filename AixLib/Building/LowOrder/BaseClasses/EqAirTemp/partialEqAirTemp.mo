within AixLib.Building.LowOrder.BaseClasses.EqAirTemp;
partial model partialEqAirTemp

parameter Real aowo=0.6 "Coefficient of absorption of the outer walls";
parameter Real eowo=0.9 "Coefficient of emission of the outer walls";
parameter Integer n=4 "Number of orientations (without ground)";
parameter Real wf_wall[n]={0.5,0.2,0.2,0.1} "Weight factors of the walls";
parameter Real wf_win[n]={0,0,0,0} "Weight factors of the windows";
parameter Real wf_ground=0 "Weight factor of the ground (0 if not considered)";
parameter Modelica.SIunits.Temp_K T_ground=284.15
    "Temperature of the ground in contact with ground slab";
parameter Boolean withLongwave=true
    "If longwave radiation exchange is considered"                                 annotation(choices(checkBox = true));

  Modelica.Blocks.Interfaces.RealInput weatherData[3]
    "[1]: Air temperature<br>[2]: Horizontal radiation of sky<br>[3]: Horizontal radiation of earth"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-100,-20},{-60,20}})));
  Utilities.Interfaces.SolarRad_in solarRad_in[n] annotation (Placement(
        transformation(extent={{-100,56},{-80,76}}), iconTransformation(
          extent={{-99,42},{-71,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalAirTemp annotation (
      Placement(transformation(extent={{98,-56},{118,-36}}),
                                                           iconTransformation(
          extent={{78,-76},{118,-36}})));
  Modelica.Blocks.Interfaces.RealInput sunblindsig[n]
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-10,100}),
        iconTransformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,80})));

  Modelica.SIunits.Temp_K T_earth "radiative temperature of the land surface";
  Modelica.SIunits.Temp_K T_sky "radiative temperature of the sky";

  Modelica.SIunits.Temp_K T_eqWall[n] "temperature equal wall";
  Modelica.SIunits.Temp_K T_eqWin[n] "temperature equal window";

protected
  Modelica.SIunits.RadiantEnergyFluenceRate E_earth
    "Iradiation from land surface";
  Modelica.SIunits.RadiantEnergyFluenceRate E_sky "Iradiation from sky";

  Modelica.SIunits.Temp_K T_air "outdoor air temperature";

  Modelica.SIunits.TemperatureDifference T_eqLW[n] "equal long wave";
  Modelica.SIunits.TemperatureDifference T_eqSW[n] "equal short wave";

  Modelica.SIunits.CoefficientOfHeatTransfer alpharad;

  parameter Real unitvec[n]=ones(n);

initial equation
  assert(noEvent(abs(sum(wf_wall) + sum(wf_win) + wf_ground) > 0.1), "The sum of the weightfactors (walls,windows and ground) in eqairtemp is close to 0. If there are no walls, windows and ground at all, this might be irrelevant.", level=AssertionLevel.warning);
equation

  T_air=weatherData[1];
  E_sky=weatherData[2];
  E_earth=weatherData[3];

  if (abs(E_sky+E_earth)<0.1) then
    alpharad=5.0;
  else
    alpharad=(E_sky+E_earth)/(T_sky-T_earth);
  end if;

annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                      graphics={
        Rectangle(
          extent={{-70,70},{78,-76}},
          lineColor={170,213,255},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={170,213,255}),
        Rectangle(
          extent={{-70,70},{78,0}},
          lineColor={170,213,255},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fillColor={170,213,255}),
        Rectangle(
          extent={{38,46},{78,-76}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{79,46},{21,46},{79,70},{79,70},{79,46}},
          smooth=Smooth.None,
          fillColor={236,99,92},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-70,70},{-16,18}},
          lineColor={255,221,0},
          fillColor={255,225,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,-76},{78,-90}},
          lineColor={0,127,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-70,-82},{78,-90}},
          lineColor={0,127,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Forward),
        Text(
          extent={{-70,-92},{76,-128}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={236,99,92},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Rectangle(
          extent={{38,46},{78,-14}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{52,28},{80,-12}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{78,32},{84,-18}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{52,8},{68,8},{78,8}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{72,28},{72,-12}},
          color={0,0,0},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>EqAirTemp is a component to compute the so called &QUOT;equivalent outdoor air temperature&QUOT;. Basically, this includes a correction for the longwave radiation for windows and walls and absorption of shortwave radiation only for walls.</p>
<p>To the air temperature is added (or substracted) a term for longwave radiation and one term for shortwave radiation. As the shortwave radiation is taken into account only for the walls and the windows can be equipped with a shading, the equal temperatures are computed separately for the windows and for the walls. Due to the different beams in different directions, the temperatures are also computed separately for each direction. You need one weightfactor per direction and wall or window, e.g. 4 directions means 8 weightfactors (4 windows, 4 walls). Additionally, one weightfactor for the ground (for the ground temperature) . </p>
<p>First, a temperature of the earth (not the ground temperature!) and temperature of the sky are computed. The difference is taken into account for the longwave radiance term. </p>
<p>For the windows, the shading input is considered on the longwave term. </p>
<p>For the walls, the shortwave radiance term is computed with the beam of the radiance input. </p>
<p>The n temperature of the walls, the n temperature of the windows and the ground temperature are weighted with the weightfactors and summed up.</p>
<h4>Main equations</h4>
<p>The concept is described in VDI 6007. All equations can be found in VDI 6007. </p>
<h4>Assumption and limitations</h4>
<ul>
<li>The computed temperature is the temperature near the wall surface. The radiant and convective heat transfer is considered in the model. The next component connected to the heat port should be the description of the heat conductance through the wall. </li>
<li>The heat transfer through the radiance is considered by an alpha. It is computed and is somewhere around 5. In cases of exorbitant high radiance values, this alpha could be not as accurate as a real T^4 equation.</li>
</ul>
<h4>Typical use and important parameters</h4>
<p>This component was written for usage in combination with the <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> (see <a href=\"AixLib.Building.LowOrder.BaseClasses.ThermalZonePhysics\">ThermalZonePhysics</a>).</p>
<p>Inputs: weather data, radiance (beam) by the radiance input and longwave sky radiation, longwave terrestric radiation and air temperature by the Real WeatherData input. There is the possibility to link a <a href=\"AixLib.Building.Components.Weather.Sunblind\">Sunblind</a> by the sunblindsig input. This takes the changes in radiation on the windows through a closed shading into account. </p>
<p>Parameters: </p>
<ul>
<li>Weightfactors: The different equivalent temperatures for the different directions (due to shortwave radiance and the ground) are weighted and summed up with the weightfactors. See VDI 6007 for more information about the weightfactors (equation: U_i*A_i/sum(U*A)). As the equivalent temperature is a weighted temperature for all surfaces and it was originally written for building zones, the temperature of the ground under the thermal zone can be considered (weightfactorgound &GT; 0). The sum of all weightfactors should be 1. </li>
<li>Additionally, you need the coefficient of heat transfer and the coefficient of absorption on the outer side of the walls and windows for all directions (weighted scalars) . The coefficient of absorption is different to the emissivity due to the spectrum of the sunlight (0.6 might be a good choice). </li>
</ul>
<h4>Options</h4>
<h4>Validation</h4>
<p>The model is verified with the VDI 6007, see <a href=\"AixLib.Building.LowOrder.Validation.VDI6007\">Validation.VDI6007</a>. A validation with the use of the standard ASHRAE 140 is in progress </p>
<h4>Implementation</h4>
<h4>References</h4>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: 10.1016/j.buildenv.2013.12.016.</li>
</ul>
</html>",
        revisions="<html>
<p><ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>Implemented.</li>
</ul></p>
</html>"));
end partialEqAirTemp;
