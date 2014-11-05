within AixLib.Building.LowOrder.BaseClasses.EqAirTemp;
model EqAirTempVDI
  extends EqAirTemp.partialEqAirTemp;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo=20
    "Outer wall's coefficient of heat transfer (outer side)";
  parameter Real orientationswallshorizontal[n]={90,90,90,90}
    "orientations of the walls against the vertical (wall,roof)";

protected
  Real phiprivate[n];

equation
  T_earth=((-E_earth/(0.93*5.67))^0.25)*100;//-273.15
  T_sky=((E_sky/(0.93*5.67))^0.25)*100;//-273.15

  for i in 1:n loop

  phiprivate[i] = (1+Modelica.Math.cos((orientationswallshorizontal[i]*Modelica.Constants.pi/180)))/2;

  T_eqLW[i]=(((T_earth-(T_air))*(1-phiprivate[i])+(T_sky-(T_air))*phiprivate[i])*((eowo*alpharad)/(alphaowo)))*abs(sunblindsig[i]-1);
  T_eqSW[i]=solarRad_in[i].I*aowo/(alphaowo);

  T_eqWin[i]=T_air+T_eqLW[i];
  T_eqWall[i]=(T_air+T_eqLW[i])+T_eqSW[i];

  end for;
  equalAirTemp.T = T_eqWall*wf_wall + T_eqWin*wf_win + T_ground*wf_ground;
  annotation (Documentation(revisions="<html>
<p><ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>Implemented.</li>
</ul></p>
</html>"));
end EqAirTempVDI;
