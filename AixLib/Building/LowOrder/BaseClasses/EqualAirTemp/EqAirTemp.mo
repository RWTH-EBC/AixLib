within AixLib.Building.LowOrder.BaseClasses.EqualAirTemp;
model EqAirTemp
  extends partialEqAirTemp;
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
end EqAirTemp;
