within AixLib.Fluid.HeatExchangers.Radiators.BaseClasses;
function calcHeaterExcessTemp
  input Real dT_V;
  input Real dT_R;
  input Real Tair;
  input Real n;
  output Real delta_T;
  output Integer isheating;
//  output Real Tlin;

 // Real dT_V;
 // Real dT_R;
  // Real Tair;
  // Real Tlin;
algorithm

if abs(abs(dT_V) - abs(dT_R)) < 1e-5 then
delta_T:=(dT_V+dT_R)/2;

if delta_T<0 then
isheating:=-1;
else
isheating:=1;
end if;

else
if dT_V < 1e-6 then

if dT_R < 1e-6 then
delta_T:=-((n-1)*(abs(dT_R)-abs(dT_V))/(abs(dT_V)^(1-n)-abs(dT_R)^(1-n)))^(1/n);
isheating:=-1;
else
 delta_T:=0;
end if;

else

if dT_R < 1e-6 then
 delta_T:=0;
else
delta_T:=((n-1)*(dT_V-dT_R)/(dT_R^(1-n)-(dT_V)^(1-n)))^(1/n);
isheating:=1;
end if;

end if;
end if;

end calcHeaterExcessTemp;
