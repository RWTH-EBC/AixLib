within AixLib.Building.LowOrder.BaseClasses;
model WindowEqAirTemp
  extends PartialClasses.partialEqAirTemp;
parameter Real orientationswallshorizontal[n]={90,90,90,90}
    "orientations of the walls against the vertical (wall,roof)";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaconv_wall=24.67
    "Outer walls coefficient of heat transfer (outerside)";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaconv_win=16.37
    "Outer walls coefficient of heat transfer (outerside)";
parameter Real awin=0.0 "Coefficient of absorption of the window";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalAirTempWindow
    annotation (Placement(transformation(extent={{80,58},{100,78}}),
        iconTransformation(extent={{60,6},{100,46}})));

protected
    Modelica.SIunits.TemperatureDifference T_eqLW_win[n] "equal long wave";
    Modelica.SIunits.TemperatureDifference T_eqSW_win[n]
    "equal short wave window";
  Real phiprivate[n];
equation

  T_earth=((-E_earth/(0.93*5.67))^0.25)*100;//-273.15
  T_sky=((E_sky/(5.67))^0.25)*100;//-273.15

  for i in 1:n loop

  phiprivate[i] = (1+Modelica.Math.cos((orientationswallshorizontal[i]*Modelica.Constants.pi/180)))/2;

  T_eqLW[i]=(((T_earth-(T_air))*(1-phiprivate[i])+(T_sky-(T_air))*phiprivate[i])*((eowo*alpharad)/(alpharad+alphaconv_wall)))*abs(sunblindsig[i]-1);

  T_eqLW_win[i]=(((T_earth-(T_air))*(1-phiprivate[i])+(T_sky-(T_air))*phiprivate[i])*((eowo*alpharad)/(alpharad+alphaconv_win)))*abs(sunblindsig[i]-1);

  T_eqSW[i]=solarRad_in[i].I*aowo/(alpharad+alphaconv_wall);

  T_eqSW_win[i]=solarRad_in[i].I*awin/(alpharad+alphaconv_win);

  T_eqWin[i]=T_air+T_eqLW_win[i]+T_eqSW_win[i];
  T_eqWall[i]=(T_air+T_eqLW[i])+T_eqSW[i];

  end for;

  equalAirTemp.T = T_eqWall*wf_wall + T_ground*wf_ground;
  equalAirTempWindow.T = T_eqWin*wf_win;
  annotation (Documentation(revisions="<html>
<p><ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>Implemented.</li>
</ul></p>
</html>", info="<html>
<p>For use with ImprovedReducedOrderModel only</p>
</html>"));
end WindowEqAirTemp;
