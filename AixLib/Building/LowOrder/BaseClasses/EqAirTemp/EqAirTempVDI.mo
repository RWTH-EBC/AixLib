within AixLib.Building.LowOrder.BaseClasses.EqAirTemp;
model EqAirTempVDI
  extends EqAirTemp.partialEqAirTemp;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo=20
    "Outer wall's coefficient of heat transfer (outer side)";
  parameter Real orientationswallshorizontal[n]={90,90,90,90}
    "orientations of the walls against the vertical (wall,roof)";

protected
  Real phiprivate[n];
initial equation
  assert(noEvent(abs(sum(wf_wall) + sum(wf_win) + wf_ground - 1) < 0.1), "The sum of the weightfactors (walls,windows and ground) in eqairtemp is <0.9 or >1.1. Normally, the sum should be 1.", level=AssertionLevel.warning);
equation
  T_earth=((-E_earth/(0.93*5.67))^0.25)*100;//-273.15
  T_sky=((E_sky/(0.93*5.67))^0.25)*100;//-273.15

  phiprivate = (unitvec+Modelica.Math.cos(orientationswallshorizontal*Modelica.Constants.pi/180))/2;

  T_eqLW=((T_earth-T_air)*(unitvec-phiprivate)+(T_sky-T_air)*phiprivate)*(eowo*alpharad/alphaowo);
  T_eqSW=solarRad_in.I*aowo/(alphaowo);

  if withLongwave then
    T_eqWin=T_air*unitvec+T_eqLW.*abs(sunblindsig-unitvec);
    T_eqWall=T_air*unitvec+T_eqLW+T_eqSW;
  else
    T_eqWin=T_air*unitvec;
    T_eqWall=T_air*unitvec+T_eqSW;
  end if;

  equalAirTemp.T = T_eqWall*wf_wall + T_eqWin*wf_win + T_ground*wf_ground;
  annotation (Documentation(revisions="<html>
<p><ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>Implemented.</li>
</ul></p>
</html>", info="<html>
<p>EqAirTempVDI extends from partianEqAirTemp</p>
<p>The longwave radiation is considered for each direction seperately.</p>
<h4>Main equations</h4>
<p>The concept is described in VDI 6007. All equations can be found in VDI 6007. </p>
<h4>Assumption and limitations</h4>
<ul>
<li>The convective heat transfer coefficient alpha is weighted over the areas per each direction. In VDI 6007, alpha is considered for each element and not averaged per direction. This may cause deviations if the alphas of the single elements are considerabely different. </li>
</ul>
<h4>Typical use and important parameters</h4>
<p>This component was written for usage in combination with the <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> (see <a href=\"AixLib.Building.LowOrder.BaseClasses.ThermalZonePhysics\">ThermalZonePhysics</a>).</p>
<h4>Options</h4>
<h4>Validation</h4>
<p>The model is verified with the VDI 6007, see <a href=\"AixLib.Building.LowOrder.Validation.VDI6007\">Validation.VDI6007</a>. A validation with the use of the standard ASHRAE 140 is in progress </p>
<h4>Implementation</h4>
<h4>References</h4>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: 10.1016/j.buildenv.2013.12.016.</li>
</ul>
</html>"));
end EqAirTempVDI;
