within AixLib.Building.LowOrder.Validation.VDI6007.VDIComponents;


model EqAirTemp_TestCase_8
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo = 20
    "Outer wall's coefficient of heat transfer (outer side)";
  parameter Real aowo = 0.6 "Coefficient of absorption of the outer walls";
  parameter Real eowo = 0.9 "Coefficientasdission of the outer walls";
  parameter Integer n = 5 "Number of orientations (without ground)";
  //parameter Real orientationswallsvertical[n]={0,90,180,270,0} "orientations of the walls against the horizontal (n,e,s,w)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
  //parameter Real orientationswallshorizontal[n]={90,90,90,90,0} "orientations of the walls against the vertical (wall,roof)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
  parameter Real wf_wall[n] = {0.5, 0.2, 0.2, 0.1, 0}
    "Weight factors of the walls";
  //parameter Integer m=4 "Number of window orientations";
  //parameter Real orientationswindowsvertical[m]={0,90,180,270,0} "orientations of the windows against the horizontal (n,e,s,w)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
  //parameter Real orientationswindowshorizontal[m]={90,90,90,90,0} "orientations of the windows against the vertical (wall,roof)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
  parameter Real wf_win[n] = {0, 0, 0, 0, 0} "Weight factors of the windows";
  parameter Real wf_ground = 0
    "Weight factor of the ground (0 if not considered)";
  parameter Modelica.SIunits.Temp_K T_ground = 284.15
    "Temperature of the ground in contact with ground slab";
  Modelica.Blocks.Interfaces.RealInput WeatherDataVector[3]
    "[1]: Air temperature<br>[2]: Horizontal radiation of sky<br>[3]: Horizontal radiation of earth"
                                                                                                        annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}), iconTransformation(extent = {{-100, -20}, {-60, 20}})));
  //Muss noch auf neues Modell von Ana angepasst werden
  Utilities.Interfaces.SolarRad_in Rad_In[n] annotation(Placement(transformation(extent = {{-100, 56}, {-80, 76}}), iconTransformation(extent = {{-99, 42}, {-71, 70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalairtemp annotation(Placement(transformation(extent = {{80, -6}, {100, 14}}), iconTransformation(extent = {{60, -20}, {100, 20}})));
  Modelica.SIunits.TemperatureDifference T_earth
    "radiative temperature of the land surface";
  Modelica.SIunits.TemperatureDifference T_sky
    "radiative temperature of the sky";
  Modelica.SIunits.Temp_K T_eqWall[n] "temperature equal wall";
  Modelica.SIunits.Temp_K T_eqWin[n] "temperature equal window";
  Modelica.Blocks.Interfaces.RealInput sunblindsig[n] annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = -90, origin = {-10, 100}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = -90, origin = {0, 80})));
protected
  parameter Real phiprivate = 0.5;
  //Phi muss f�r horizontal geneigte Flaechen agepasst werden
  parameter Real unitvec[n] = ones(n);
  // parameter Real unitvecwindow[m]=ones(m);
protected
  Modelica.SIunits.RadiantEnergyFluenceRate E_earth
    "Iradiation from land surface";
  Modelica.SIunits.RadiantEnergyFluenceRate E_sky "Iradiation from sky";
  Modelica.SIunits.Temp_K T_air "outdoor air temperature";
  Modelica.SIunits.TemperatureDifference T_eqLWs "equal long wave scalar";
  Modelica.SIunits.TemperatureDifference T_eqLW[n] "equal long wave";
  Modelica.SIunits.TemperatureDifference T_eqSW[n] "equal short wave";
  Modelica.SIunits.CoefficientOfHeatTransfer alpharad;
initial equation
  assert(n == size(wf_wall, 1), "weightfactorswall has to have n elements");
  assert(n == size(wf_win, 1), "weightfactorswall has to have n elements");
  if not sum(wf_wall) + sum(wf_win) + wf_ground <> 0.00001 then
    Modelica.Utilities.Streams.print("WARNING!:The sum of the weightfactors (walls,windows and ground) in eqairtemp is 0. This means, that eqairtemp is 0 �C. If there are no walls, windows and ground at all, this might be irrelevant.");
  end if;
  if abs(sum(wf_wall) + sum(wf_win) + wf_ground - 1) > 0.1 then
    Modelica.Utilities.Streams.print("WARNING!:The sum of the weightfactors (walls,windows and ground) in eqairtemp is <0.9 or >1.1. Normally, the sum should be 1, as the influence of all weightfactors should the whole influence on the temperature.");
  end if;
equation
  if cardinality(sunblindsig) < 1 then
    sunblindsig = fill(0, n);
  end if;
  T_air = WeatherDataVector[1];
  E_sky = WeatherDataVector[2];
  E_earth = WeatherDataVector[3];
  if abs(E_sky + E_earth) < 0.1 then
    alpharad = 5.0;
  else
    alpharad = (E_sky + E_earth) / (T_sky - T_earth);
  end if;
  T_earth = (-E_earth / (0.93 * 5.67)) ^ 0.25 * 100;
  //-273.15
  T_sky = (E_sky / (0.93 * 5.67)) ^ 0.25 * 100;
  //-273.15
  T_eqLWs = 0;
  T_eqLW = {0, 0, 0, 0, 0};
  T_eqSW = Rad_In.I * aowo / alphaowo;
  T_eqWin = T_air * unitvec + T_eqLW;
  T_eqWall = (T_air + T_eqLWs) * unitvec + T_eqSW;
  //  T_ground is currently a parameter
  //temperatureequalwindowcelsius = Modelica.SIunits.Conversions.to_degC(temperatureequalwindow);
  //temperatureequalwallcelsius = Modelica.SIunits.Conversions.to_degC(temperatureequalwall);
  //temperaturegroundcelsius = Modelica.SIunits.Conversions.to_degC(temperatureground);
  equalairtemp.T = T_eqWall * wf_wall + T_eqWin * wf_win + T_ground * wf_ground;
  annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent=  {{-70, -76}, {78, 76}}, lineColor=  {0, 128, 255}, lineThickness=  1, fillColor=  {0, 128, 255}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{20, 46}, {60, -76}}, lineColor=  {0, 0, 0}, fillColor=  {0, 0, 0}, fillPattern=  FillPattern.Solid), Polygon(points=  {{60, 46}, {2, 46}, {60, 74}, {60, 70}, {60, 46}}, lineColor=  {0, 0, 0}, smooth=  Smooth.None, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid), Ellipse(extent=  {{-60, 72}, {-28, 40}}, lineColor=  {255, 255, 0}, fillColor=  {255, 255, 0}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-70, -76}, {78, -90}}, lineColor=  {0, 127, 0}, fillColor=  {0, 127, 0}, fillPattern=  FillPattern.Forward), Line(points=  {{-54, -74}, {-58, -66}, {-50, -62}, {-56, -54}, {-52, -50}, {-54, -44}}, color=  {0, 0, 0}, smooth=  Smooth.Bezier, thickness=  1), Line(points=  {{-58, -48}, {-54, -40}, {-50, -46}}, color=  {0, 0, 0}, thickness=  1, smooth=  Smooth.Bezier), Line(points=  {{-40, -74}, {-44, -66}, {-36, -62}, {-42, -54}, {-38, -50}, {-40, -44}}, color=  {0, 0, 0}, smooth=  Smooth.Bezier, thickness=  1), Line(points=  {{-44, -48}, {-40, -40}, {-36, -46}}, color=  {0, 0, 0}, thickness=  1, smooth=  Smooth.Bezier), Line(points=  {{-50, 34}, {-50, 10}}, color=  {255, 255, 0}, thickness=  1, smooth=  Smooth.Bezier), Line(points=  {{-36, 36}, {-24, 14}}, color=  {255, 255, 0}, thickness=  1, smooth=  Smooth.Bezier), Line(points=  {{-24, 46}, {-6, 32}}, color=  {255, 255, 0}, thickness=  1, smooth=  Smooth.Bezier), Line(points=  {{12, -30}, {12, -68}, {6, -70}, {4, -60}, {4, -30}, {10, -22}, {12, -30}}, color=  {0, 0, 0}, thickness=  1, smooth=  Smooth.Bezier), Line(points=  {{10, -48}, {12, -38}, {14, -48}}, color=  {0, 0, 0}, thickness=  1, smooth=  Smooth.Bezier)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>This component computes the so called &QUOT;equivalent outdoor air temperature&QUOT;. Basically, this includes a correction for the longwave and shortwave radiance (not on windows!). </li>
 <li>The computed temperature is the temperature near the wall surface. The radiant and convective heat transfer is considered in the model. The next component connected to the heat port should be the description of the heat conductance through the wall.</li>
 <li>This component was written for usage in combination with the <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> (see <a href=\"AixLib.Building.LowOrder.BaseClasses.ThermalZonePhysics\">ThermalZonePhysics</a>). As input it needs weather data, radiance (beam) by the radiance input and longwave sky radiation, longwave terrestric radiation and air temperature by the Real WeatherData input. There is the possibility to link a <a href=\"AixLib.Building.Components.Weather.Sunblind\">Sunblind</a> by the sunblindsig input. This takes the changes in radiation on the windows through a closed shading into account.</li>
 <li>Weightfactors: The different equivalent temperatures for the different directions (due to shortwave radiance and the ground) are weighted and summed up with the weightfactors. See VDI 6007 for more information about the weightfactors (equation: U_i*A_i/sum(U*A)). As the equivalent temperature is a weighted temperature for all surfaces and it was originally written for building zones, the temperature of the ground under the thermal zone can be considered (weightfactorgound &GT; 0). The sum of all weightfactors should be 1.</li>
 <li>Additionally, you need the coefficient of heat transfer and the coefficient of absorption on the outer side of the walls and windows for all directions (weighted scalars) . The coefficient of absorption is different to the emissivity due to the spectrum of the sunlight (0.6 might be a good choice).</li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
 <h4><span style=\"color:#008000\">Known Limitations</span></h4>
 <p>The heat transfer through the radiance is considered by an alpha. It is computed and is somewhere around 5. In cases of exorbitant high radiance values, this alpha could be not as accurate as a real T^4 equation.</p>
 <p>The longwave radiation is normally also considered for each direction separately, but this means that you need the angles for each direction. As the longwave term has no great impact on the equivalent temperature, the improvement is not worth the costs. Phiprivate is set to 0.5. Nonetheless, the parameters are prepared, but the equations for phiprivate ( in which the angles have an effect) are not yet implemented.</p>
 <p>In addition, the convective heat transfer coefficient alpha is weighted over the areas per each direction. In VDI 6007, alpha is considered for each element and not averaged per direction. This may cause deviations if the alphas of the single elements are considerabely different. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>To the air temperature is added (or substracted) a term for longwave radiation and one term for shortwave radiation. As the shortwave radiation is taken into account only for the walls and the windows can be equipped with a shading, the equal temperatures are computed separately for the windows and for the walls. Due to the different beams in different directions, the temperatures are also computed separately for each direction. You need one weightfactor per direction and wall or window, e.g. 4 directions means 8 weightfactors (4 windows, 4 walls). Additionally, one weightfactor for the ground (for the ground temperature) .</p>
 <p><br>First, a temperature of the earth (not the ground temperature!) and temperature of the sky are computed. The difference is taken into account for the longwave radiance term. </p>
 <p>For the windows, the shading input is considered on the longwave term.</p>
 <p>For the walls, the shortwave radiance term is computed with the beam of the radiance input.</p>
 <p>The n temperature of the walls, the n temperature of the windows and the ground temperature are weighted with the weightfactors and summed up. As this equations only works in &deg;C, the unit is changed and rechanged to use Kelvin for the heat port again.</p>
 <p><br><br><b><font style=\"color: #008000; \">References</font></b></p>
 <ul>
 <li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
 <li>Lauster, Moritz; Remmen, Peter; Fuchs, Marcus; Teichmann, Jens; Streblow, Rita; M&uuml;ller, Dirk (2014): Modelling long-wave radiation heat exchange for thermal network building simulations at urban scale using Modelica. In: the 10th International Modelica Conference, March 10-12, 2014, Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), p. 125&ndash;133. DOI: <a href=\"http://dx.doi.org/10.3384/ECP14096125\">10.3384/ECP14096125</a>.</li>
 <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>.</li>
 </ul>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p>See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
 </html>", revisions = "<html>
 <p><ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 <li><i>February 2014</i>, by Peter Remmen: No calculation of longwave radiation heat exchange</li>
 </ul></p>
 </html>"));
end EqAirTemp_TestCase_8;
