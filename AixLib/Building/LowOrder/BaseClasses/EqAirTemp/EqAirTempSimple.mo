within AixLib.Building.LowOrder.BaseClasses.EqAirTemp;
model EqAirTempSimple
  extends EqAirTemp.partialEqAirTemp;
parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo=20
    "Outer wall's coefficient of heat transfer (outer side)";
protected
  parameter Real phiprivate=0.5;
  parameter Real unitvec[n]=ones(n);
public
  Modelica.SIunits.Temp_K T_eqLWs "equal long wave scalar";
equation

  T_earth=((-E_earth/(0.93*5.67))^0.25)*100;//-273.15
  T_sky=((E_sky/(0.93*5.67))^0.25)*100;//-273.15

  T_eqLWs=((T_earth-(T_air))*(1-phiprivate)+(T_sky-(T_air))*phiprivate)*((eowo*alpharad)/(alphaowo*0.93));
  T_eqLW=T_eqLWs*abs(sunblindsig-unitvec);

  T_eqSW=solarRad_in.I*aowo/alphaowo;

  T_eqWin=(T_air*unitvec)+T_eqLW;
  T_eqWall=(T_air+T_eqLWs)*unitvec+T_eqSW;

  equalAirTemp.T = T_eqWall*wf_wall + T_eqWin*wf_win + T_ground*wf_ground;
  annotation (Documentation(revisions="<html>
 <p><ul>
 <li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>extending Model</li>
 </ul></p>
 <p><ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul></p>
 </html>", info="<html>
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
 <li>Lauster, Moritz; Remmen, Peter; Fuchs, Marcus; Teichmann, Jens; Streblow, Rita; M&uuml;ller, Dirk (2014): Modelling long-wave radiation heat exchange for thermal network building simulations at urban scale using Modelica. In: the 10th International Modelica Conference, March 10-12, 2014, Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), p. 125&ndash;133. DOI: <a href=\"http://dx.doi.org/10.3384/ECP14096125\">10.3384/ECP14096125</a></p>.</li>
 <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a></p>.</li>
 </ul>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p>See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
 </html>"));
end EqAirTempSimple;
